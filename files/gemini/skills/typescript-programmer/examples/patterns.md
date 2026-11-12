# TypeScript Reference Patterns & Examples

## Annotated Function Example

```typescript
/**
 * Calculates compound interest for an investment balance.
 * Pure function with referential transparency.
 *
 * @template T - Numeric subtype for branded monetary amounts.
 * @param principal - Initial investment balance; must be non-negative.
 * @param rate - Annual interest rate expressed as a decimal (e.g. 0.05).
 * @param periods - Compounding frequency per annum; must exceed zero.
 * @param timeYears - Duration of the investment term in years.
 * @returns Resulting total balance compounded over the term.
 *
 * @example
 * ```ts
 * const total = calculateCompoundInterest(1000, 0.05, 12, 5);
 * ```
 */
export function calculateCompoundInterest<T extends number>(
  principal: T,
  rate: number,
  periods: number,
  timeYears: number,
): number {
  return principal * (1 + rate / periods) ** (periods * timeYears);
}
```

## Property Test Example

```typescript
import { describe, it } from 'vitest';
import * as fc from 'fast-check';

describe('formatCurrency property tests', () => {
  it('preserves sign and always contains currency code', () => {
    fc.assert(
      fc.property(
        fc.double({ noNaN: true, min: -1e9, max: 1e9 }),
        fc.constantFrom('AUD', 'USD', 'EUR'),
        (amount, currency) => {
          const result = formatCurrency(amount, currency);
          return result.includes(currency);
        },
      ),
    );
  });
});
```

## Reference Makefile

```makefile
.DEFAULT_GOAL := help
.PHONY: help format lint check test build clean

SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c

help: ## Display available targets
	@awk 'BEGIN {FS = ":.*?## "}; \
		/^[a-zA-Z_-]+:.*?## / \
		{printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' \
		$(MAKEFILE_LIST)

format: ## Format all TypeScript source files
	npx prettier --write "src/**/*.ts" "tests/**/*.ts"

lint: ## Run ESLint across codebase
	npx eslint "src/**/*.ts" "tests/**/*.ts"

check: ## Perform static type checking without emitting files
	npx tsc --noEmit

test: ## Execute unit and fast-check property tests
	npx vitest run

build: check ## Compile TypeScript to JavaScript distribution
	npx tsc -p tsconfig.build.json

clean: ## Remove compiled artefacts
	rm -rf dist tsconfig.build.tsbuildinfo
```
