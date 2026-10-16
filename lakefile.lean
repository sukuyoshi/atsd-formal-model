import Lake
open Lake DSL

package "atsd" where
  version := v!"0.1.0"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.35.0"

@[default_target]
lean_lib «ATSD» where
  roots := #[`ATSD_Foundational_Model]
