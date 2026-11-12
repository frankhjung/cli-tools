# Elm Reference Patterns & Examples

## Annotated Module Example

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

## Fuzz Property Test Example

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

## Reference Makefile

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
