// This file will discuss the syntax and guarantees of a function
// Key concept: mutability

// Proposal: Immutable parameters live on the left hand side.
// Mutable parameters live on the right hand side. Right hand side parameters
// can be marked immutable by using the const keyword as a prefix. Left hand
// side parameters can never be mutable and therefore cannot be declared with
// a mutable keyword. Return values live on the right of the signature.

// Example:
func (target int)Exists(numbers []int) => bool {}
// Usage
[]int{1,2,3} -> nums
(5)Exists(nums) -> ok
// or
5 -> Exists(nums) -> ok
