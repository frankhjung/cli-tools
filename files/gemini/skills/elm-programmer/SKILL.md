---
name: elm-programmer
description: >-
  Develop, refactor, test, and review Elm codebases (.elm, elm.json,
  review/src/ReviewConfig.elm). Use this skill when developing, refactoring,
  testing, linting, or reviewing Elm applications and packages. Enforces
  idiomatic Elm, The Elm Architecture (TEA), impossible-state elimination,
  opaque types, pipeline dataflow, elm-format conventions, elm-test fuzz
  testing, elm-review, and Makefile workflow orchestration.
---

# Elm Programmer

Guide Elm development emphasising idiomatic Elm conventions: The Elm
Architecture (TEA), impossible-state elimination, opaque types with smart
constructors, readable pipelines (`|>`) without point-free composition,
boundary safety via JSON decoders, generative fuzz testing with `elm-test`,
static analysis with `elm-review`, and compiler-driven refactoring orchestrated
via `Makefile`.

## Core Conventions & Formatting

- **Formatting & Style (`elm-format`):** Adhere strictly to `elm-format`
  standards (4-space indentation, leading commas in multi-line lists, records,
  and type declarations). Hard-wrap prose and docstrings at 80 columns. Use
  `camelCase` for values and functions, and `PascalCase` for types, custom type
  constructors, and module names.
- **Explicit Signatures & Import Hygiene:**
  - Provide explicit top-level type annotations for all functions and values.
  - Avoid unqualified wildcard imports (`exposing (..)`), except for standard
    HTML DSL modules (`Html exposing (Html, div, text)`, `Html.Attributes`
    `exposing (class, href)`) when agreed by project convention.
  - Prefer qualified module imports (`import Dict exposing (Dict)`, `import Set`
    `exposing (Set)`, `import Json.Decode as Decode exposing (Decoder)`).

## Idiomatic Elm & Type Design

- **The Elm Architecture (TEA):**
  - **Single Source of Truth:** Keep `Model` as the minimal source of truth.
    Never store derived or cached state in the `Model` (such as formatted
    strings, filtered lists, or calculated totals). Compute derived views on
    the fly in helper functions or in `view`.
  - **Avoid Nested Components:** Do not break user interfaces into component
    triplets (`Model`/`Msg`/`update`). In Elm, components introduce state
    synchronisation friction. Instead, scale views using stateless functions:
    `viewHeader : User -> Html Msg` or `viewButton : ButtonConfig -> Html Msg`.
  - **Update Simplicity:** Keep `update : Msg -> Model -> ( Model, Cmd Msg )`
    focused, deterministic, and total. Side effects are expressed purely as
    data (`Cmd Msg`), executed exclusively by the Elm runtime.
- **Making Impossible States Impossible:**
  - Model mutually exclusive states with custom types rather than boolean flags
    or paired `Maybe` fields.
  - Bad: `{ isLoading : Bool, error : Maybe String, data : Maybe User }`
  - Idiomatic: `type UserStatus = Loading | Failure Http.Error | Success User`
  - Avoid wildcard catches (`_`) in business logic pattern matches so the
    compiler alerts you whenever a variant is added or changed.
- **Opaque Types & Smart Constructors:**
  - Prevent primitive obsession by wrapping domain identifiers and validated
    values in single-variant custom types (`type Email = Email String`).
  - Keep the data constructor private: export the type, but not the constructor
    (`exposing (Email, fromString, toString)`).
  - Use smart constructors returning `Maybe` or `Result` to validate invariants
    at the boundary: `fromString : String -> Maybe Email`.
  - Provide explicit unwrap helpers: `toString : Email -> String`.
- **Parse, Don't Validate:**
  - Validate and transform raw external data into strong domain types at the
    system boundary (JSON decoders, URL route parsers, user form submissions).
  - Once parsed into a domain type, downstream functions accept the validated
    type directly without defensive re-validation.
- **Totality & Purity:**
  - Forbid `Debug.todo`, `Debug.log`, and `Debug.toString` in production code.
    `elm make --optimize` disallows `Debug` usage.
  - Handle all possibilities explicitly. Avoid partial runtime expectations;
    propagate uncertainty with `Maybe` or `Result`.

## Pipelines, Chaining & Combinators

- **Forward Pipelines (`|>`):**
  - Use the forward pipe operator `|>` to write readable transformations that
    flow naturally from top to bottom:
    `rawString |> String.trim |> Email.fromString`
  - Design functions with the primary data argument last to facilitate piping:
    `List.filter : (a -> Bool) -> List a -> List a`
    `Dict.insert : comparable -> v -> Dict comparable v -> Dict comparable v`
  - When a function takes several arguments of the same type, group them into a
    descriptive record rather than a long list of positional arguments to
    prevent accidental transposition bugs.
- **Avoid Point-Free Style and Composition (`>>` / `<<`):**
  - Elm style guidelines strongly discourage function composition operators
    (`>>` and `<<`) and point-free acrobatics.
  - Write explicit pipelines with `|>` or use clean anonymous functions
    (`\x -> ...`). Explicit code is easier to read, refactor, and debug.
- **Chaining with `andThen`:**
  - Use `Maybe.andThen` to chain operations where any step might return
    `Nothing`:
    `findUser id |> Maybe.andThen getProfile |> Maybe.andThen .avatarUrl`
  - Use `Result.andThen` to sequence operations that can fail with an error,
    stopping at the first failure.
- **Transforming with `map` and `mapError`:**
  - Use `Maybe.map` and `Result.map` to transform successful values inside
    containers without manually unpacking them.
  - Use `Result.mapError` to convert low-level errors (such as `Http.Error`)
    into high-level domain errors.
- **Combining Multiple Values:**
  - Combine independent `Maybe` or `Result` values using `map2`, `map3`, etc.:
    `Result.map2 makeUser (validateName rawName) (validateAge rawAge)`

## Boundary Safety & JSON Interop

- **Boundary Safety:** Treat all data crossing into Elm (`flags`, HTTP response
  payloads, `ports`) as untrusted. Decode raw `Json.Decode.Value` into
  validated domain types immediately.
- **Composable Decoders:** Build decoders incrementally using primitives and
  combinators (`Decode.map2`, `Decode.andThen`, `Decode.oneOf`).
- **Port Discipline:**
  - Send and receive `Json.Decode.Value` through ports rather than loose JS
    objects.
  - Decode port messages inside Elm so decoding failures surface as explicit
    `Msg` variants rather than silent JavaScript runtime crashes.

## Documentation Standards (`elm-doc`)

- **Module Documentation:** Every module must begin with an explicit `exposing`
  list (never `exposing (..)`) and a doc comment (`{-| ... -}`) containing
  `@docs` tags grouped under Markdown headers.
- **Top-Level Definitions:** Every exported type, smart constructor, and
  function must have an `elm-doc` comment detailing parameter contracts, domain
  invariants, and runnable examples.

### Annotated Module Example

```elm
module Domain.CompoundInterest exposing
    ( Principal
    , Terms
    , fromFloat
    , toFloat
    , calculate
    )

{-| Financial domain logic for calculating compound interest with validated
monetary amounts.

# Types
@docs Principal, Terms

# Conversion
@docs fromFloat, toFloat

# Calculations
@docs calculate
-}


{-| An opaque type representing a validated, non-negative principal balance.
-}
type Principal
    = Principal Float


{-| Investment terms for compound interest calculation.

Grouped into a record to prevent accidental argument transposition.
-}
type alias Terms =
    { rate : Float
    , periodsPerYear : Int
    , years : Float
    }


{-| Construct a `Principal` from a raw `Float`.

Follows "Parse, don't validate", returning `Nothing` if the amount is negative,
`NaN`, or infinite.

    fromFloat 1000.0 == Just (Principal 1000.0)
    fromFloat -50.0 == Nothing
-}
fromFloat : Float -> Maybe Principal
fromFloat amount =
    if isNaN amount || isInfinite amount || amount < 0 then
        Nothing

    else
        Just (Principal amount)


{-| Extract the raw `Float` value from a `Principal`.
-}
toFloat : Principal -> Float
toFloat (Principal amount) =
    amount


{-| Calculate compound interest over a specified investment term.

    terms =
        { rate = 0.05
        , periodsPerYear = 12
        , years = 5.0
        }

    fromFloat 1000.0
        |> Maybe.map (calculate terms)
-}
calculate : Terms -> Principal -> Float
calculate terms (Principal p) =
    let
        n =
            Basics.toFloat (max 1 terms.periodsPerYear)
    in
    p * ((1 + (terms.rate / n)) ^ (n * terms.years))
```

## Testing with `elm-test`

- **Unit Testing:** Write deterministic example-based tests using `Test` and
  `Expect` (`Expect.equal`, `Expect.within`, `Expect.err`).
- **Generative Fuzz Testing:**
  - Implement property-based tests using `Test.fuzz`, `Test.fuzz2`, and
    `Test.fuzz3` to verify invariants across hundreds of generated inputs.
  - Test codec symmetry / round-trips:
    `Decode.decodeValue decoder (encode value) == Ok value`
  - Test smart constructor invariants: Every value returned by a smart
    constructor satisfies domain predicates.
  - Test idempotence: `format (format text) == format text`.
- **Fuzzer Composition:** Build domain fuzzers using `Fuzz.map`, `Fuzz.andThen`,
  `Fuzz.int`, `Fuzz.floatRange`, and `Fuzz.oneOf`. Avoid `Fuzz.filter` to
  prevent test runner exhaustion.

### Fuzz Property Test Example

```elm
module Domain.CompoundInterestTest exposing (suite)

import Domain.CompoundInterest as Interest
import Expect
import Fuzz
import Test exposing (Test, describe, fuzz2)


suite : Test
suite =
    describe "Domain.CompoundInterest"
        [ fuzz2
            (Fuzz.floatRange 0 1000000)
            (Fuzz.floatRange 0 1)
            "non-negative principal and rate yield final balance >= principal"
            (\rawPrincipal rate ->
                case Interest.fromFloat rawPrincipal of
                    Just principal ->
                        let
                            terms =
                                { rate = rate
                                , periodsPerYear = 12
                                , years = 5.0
                                }
                        in
                        Interest.calculate terms principal
                            |> Expect.atLeast (Interest.toFloat principal)

                    Nothing ->
                        Expect.fail
                            "Expected valid principal from non-negative range"
            )
        ]
```

## Tooling & Makefile Orchestration

- **Static Analysis (`elm-review`):** Configure rules in `review/` to eliminate
  dead code, prevent unused variables, and enforce architectural guidelines.
- **Standard Workflow Targets:**
  - `make format`: Format all `.elm` files with `elm-format --yes`.
  - `make lint`: Run `elm-review` across source and test directories.
  - `make check`: Type-check code and validate formatting (`elm make` to
    `/dev/null` and `elm-format --validate`).
  - `make test`: Run unit and fuzz tests via `elm-test`.
  - `make build`: Compile optimised production bundle (`elm make --optimize`).
  - `make clean`: Clean build artefacts and compiler caches.

### Reference Makefile

```makefile
.DEFAULT_GOAL := help
.PHONY: help format lint check test build clean

SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c

ELM_MAIN := src/Main.elm
DIST_DIR := dist

help: ## Display available targets
	@awk 'BEGIN {FS = ":.*?## "}; \
		/^[a-zA-Z_-]+:.*?## / \
		{printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' \
		$(MAKEFILE_LIST)

format: ## Format all Elm source and test files
	npx elm-format src/ tests/ --yes

lint: ## Run elm-review static analysis
	npx elm-review

check: ## Type-check Elm sources and validate documentation
	npx elm-format src/ tests/ --validate
	npx elm make $(ELM_MAIN) --output=/dev/null

test: ## Execute unit and fuzz property tests
	npx elm-test

build: check ## Compile optimised Elm bundle
	mkdir -p $(DIST_DIR)
	npx elm make $(ELM_MAIN) --optimize --output=$(DIST_DIR)/elm.js

clean: ## Remove build artefacts and compiler caches
	rm -rf $(DIST_DIR) elm-stuff review/elm-stuff
```

## Agent Development & Validation Workflow

1. **Understand & Model:** Inspect domain specifications. Design custom types
   to make invalid states unrepresentable before writing logic.
2. **Interactive Type Design:** When designing custom types or TEA state models
   with trade-offs, consult the user (`ask_question` when available). Prefix
   the recommended option with `(Recommended)`.
3. **Compiler-Driven Refactoring:** Work iteratively with the Elm compiler.
   Modify types first, then run `make check` to systematically address compiler
   errors across pattern matches and call sites.
4. **Pure Logic & Fuzz Testing:** Implement pure functions and smart
   constructors. Run `make test` to verify unit tests and fuzz properties.
5. **Static Analysis & Linting:** Run `make lint` and `make format` before
   finalising code changes.

## Review & Output Contract

When reviewing or refactoring Elm code, structure findings into:

1. **Summary & Architecture:** TEA structure, separation of view and update,
   avoidance of nested components, and minimal `Model` state.
2. **Type Design & Impossible States:** Custom types, opaque types, smart
   constructors, and elimination of boolean/Maybe blindness.
3. **Pipelines & Chaining:** Clear forward pipelines (`|>`), proper `andThen` /
   `map` usage, and avoidance of composition operators (`>>` / `<<`).
4. **Boundary Safety & Decoders:** Robust JSON decoders, port validation, and
   "Parse, don't validate".
5. **Testing & Fuzzing:** `elm-test` coverage, fuzz properties, and codec
   symmetry.
6. **Tooling & Formatting:** `elm-format`, `elm-review`, and `Makefile` target
   cleanliness.
7. **Suggested Code / Diff:** Clean, idiomatic, fully documented Elm
   implementation.

## Cross-Skill References

- **`architecture-review`** — Pure core / effectful shell, TEA scaling, and
  modularity.
- **`requirements-review`** — Stress-test domain invariants and custom type
  models.
- **`typescript-programmer`** — Type-safe Elm ports and custom elements
  interop.
- **`makefile-programmer`** — Coordinate `Makefile` targets for builds and
  tests.
- **`markdown-editor`** — Format docstrings and design records.

## Resources

- Language: [Elm Official Guide](https://guide.elm-lang.org/)
- Package Index & Docs: [Elm Packages](https://package.elm-lang.org/)
- Design Guidelines: [Elm Package Design Guidelines](https://package.elm-lang.org/help/design-guidelines)
- Elm Architecture: [How to Use The Elm Architecture](https://guide.elm-lang.org/architecture/)
- Linter: [elm-review](https://package.elm-lang.org/packages/jfmengels/elm-review/latest/)
- Test Framework: [elm-test](https://package.elm-lang.org/packages/elm-explorations/test/latest/)
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/)
