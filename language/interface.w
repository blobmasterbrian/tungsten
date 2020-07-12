// This file will discuss the language implementation of interfaces

// Problem: With the mutability guarantees in parameters, interfaces must declare
// mutability for restrictions on how they're passed to parameters.

type Collection interface{
  Exists(const target int)
  mutable Apply(const pred fn(int)=>int)
}

// Here the compiler should throw an error if a method marked mutable in the
// interface is called on a paramter of the left hand side. If possible, the
// compiler should prevent the struct from implementing an interface if the
// methods with the matching signatures do not match the mutability desired
// by the interface.
