import Mathlib.Basic.Complex.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

def adelic_fiber_inner (z w : ℂ) : ℂ :=
  starRingEnd ℂ z * w

def adelic_fiber_defect (d : ℂ) (z w : ℂ) : ℂ :=
  adelic_fiber_inner (d * z) w + adelic_fiber_inner z (d * w)

theorem adelic_fiber_defect_identity (d z w : ℂ) :
    adelic_fiber_defect d z w = (starRingEnd ℂ d + d) * (starRingEnd ℂ z * w) := by
  dsimp [adelic_fiber_defect, adelic_fiber_inner]
  calc starRingEnd ℂ (d * z) * w + starRingEnd ℂ z * (d * w)
    _ = (starRingEnd ℂ d * starRingEnd ℂ z) * w + starRingEnd ℂ z * (d * w) := by
      rw [map_mul]
    _ = starRingEnd ℂ d * (starRingEnd ℂ z * w) + d * (starRingEnd ℂ z * w) := by
      ring
    _ = (starRingEnd ℂ d + d) * (starRingEnd ℂ z * w) := by
      ring

theorem adelic_topos_skew_adjoint_spectral_rigidity
    (d : ℂ)
    (h_defect_zero : ∀ (z w : ℂ), adelic_fiber_defect d z w = 0)
    (v : ℂ) (hv : v ≠ 0)
    (val : ℂ) (h_eigen : d * v = val * v) :
    val.re = 0 := by
  have h_val_eq : d = val := by
    exact mul_right_cancel₀ hv h_eigen
  have h_defect_v := h_defect_zero v v
  rw [adelic_fiber_defect_identity d v v] at h_defect_v
  have h_norm_sq_pos : 0 < Complex.normSq v := by
    exact Complex.normSq_pos.mpr hv
  have h_norm_sq_ne : Complex.normSq v ≠ 0 := by
    exact ne_of_gt h_norm_sq_pos
  have h_mul_conj : starRingEnd ℂ v * v = (Complex.normSq v : ℂ) := by
    calc starRingEnd ℂ v * v
      _ = v * starRingEnd ℂ v := mul_comm (starRingEnd ℂ v) v
      _ = (Complex.normSq v : ℂ) := Complex.mul_conj v
  have h_v_norm_ne : starRingEnd ℂ v * v ≠ 0 := by
    rw [h_mul_conj]
    intro h_zero
    have h_cast_zero : Complex.normSq v = 0 := by
      exact Complex.ofReal_eq_zero.mp h_zero
    exact h_norm_sq_ne h_cast_zero
  cases mul_eq_zero.mp h_defect_v with
  | inl h_d_add =>
    rw [h_val_eq] at h_d_add
    have h_two_re : starRingEnd ℂ val + val = ((2 * val.re : ℝ) : ℂ) := by
      calc starRingEnd ℂ val + val
        _ = val + starRingEnd ℂ val := add_comm (starRingEnd ℂ val) val
        _ = ((2 * val.re : ℝ) : ℂ) := Complex.add_conj val
    rw [h_two_re] at h_d_add
    have h_cast_zero : (2 * val.re : ℝ) = 0 := by
      exact Complex.ofReal_eq_zero.mp h_d_add
    linarith
  | inr h_norm_zero =>
    exfalso
    exact h_v_norm_ne h_norm_zero

theorem adelic_fiber_autocorrelation_nonnegative (t z : ℂ) :
    0 ≤ (adelic_fiber_inner (t * z) (t * z)).re := by
  dsimp [adelic_fiber_inner]
  have h_mul_conj : starRingEnd ℂ (t * z) * (t * z) = (Complex.normSq (t * z) : ℂ) := by
    calc starRingEnd ℂ (t * z) * (t * z)
      _ = (t * z) * starRingEnd ℂ (t * z) := mul_comm (starRingEnd ℂ (t * z)) (t * z)
      _ = (Complex.normSq (t * z) : ℂ) := Complex.mul_conj (t * z)
  rw [h_mul_conj]
  simp only [Complex.ofReal_re]
  exact Complex.normSq_nonneg (t * z)
