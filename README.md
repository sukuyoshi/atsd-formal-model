# Canonical Adelic Topos Self-Duality (ATSD) - Lean 4 Formalization

This repository contains the machine-checked formal verification in Lean 4 accompanying the paper:

**"On Canonical Adelic Topos Self-Duality: A Condensed Program, Concrete Models, and Formalized Fiberwise Rigidity"**  
Author: Reiji Yoshikai (Individual Researcher)

## Overview

The file `ATSD_Foundational_Model.lean` provides a rigorous, machine-checked certification of local fiberwise algebraic spectral rigidity and non-negative autocorrelation under boundary defect cancellation on one-dimensional Hermitian fibers.

It certifies the fiberwise algebraic mechanism underlying the ATSD working hypothesis, establishing that local defect cancellation unconditionally forces eigenvalues onto the imaginary axis. It does not construct the global adelic sheaf category, which is formulated as an open research program.

Google Gemini was actively employed as an interactive AI reasoning partner throughout the proof discovery and formalization process. All formal statements and deductive steps are machine-checked by the Lean 4 kernel with:
- 0 sorry placeholders
- 0 external axioms
- 0 errors
- 0 warnings

## Main Theorems

1. `adelic_fiber_defect_identity`: Defect decomposition on one-dimensional local arithmetic fibers:
   `Defect(d, z, w) = (starRingEnd ℂ d + d) * (starRingEnd ℂ z * w)`
2. `adelic_topos_skew_adjoint_spectral_rigidity`: Fiberwise spectral rigidity theorem:
   `adelic_fiber_defect d z w = 0 -> val.re = 0`
3. `adelic_fiber_autocorrelation_nonnegative`: Fiberwise autocorrelation positivity:
   `0 ≤ (adelic_fiber_inner (t * z) (t * z)).re`

## Verification Instructions

To build and check the formal proofs locally:

```bash
lake exe cache get
lake build
```

Alternatively, to check the single file directly with Lean 4:

```bash
lake env lean ATSD_Foundational_Model.lean
```
