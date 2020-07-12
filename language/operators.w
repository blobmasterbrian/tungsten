// This file will discuss the different language operators and their functionality

// TODO The addition operator: +
// TODO The subtraction operator: -
// TODO The multiplication operator: *
// TODO The division operator: /
// TODO The modulus operator: %
// TODO The equivalence operator: ==
// TODO The bitshift operators: << and >>
// TODO The bitwise AND operator: &
// TODO The bitwise OR operator: |
// TODO The logical AND operator: &&
// TODO The logical OR operator: ||

// TODO pointer operators: * symbols undetermined

// TODO The scope operator: . or :: symbol/use unconfirmed

// TODO The ternary operator: ?

// The return operator: =>
// The return operator provides clarity between the ultimate return value and piping


// The pipe operator: ->

// Background: Piping has become an iconic trait of functional programming that
// greatly increases readability by showing a clear flow of data.

// Proposal: The pipe operator will only work on left hand side parameters, unless
// all right hand side parameters are marked const AND there are no left hand side
// parameters. Most importantly, piping will be the only way to assign variables.
// By doing so, this will enforce left to right reading syntax.

// On an error, functions will act as a no-op and the error will be piped into
// the output variable if one exists.

// Example:
func ()main {
  5 -> target
  []int{1,2,3} -> nums

  target -> Exists(nums) -> ok
}


// The pattern match operator: =

// Background: Pattern matching is another staple of functional programming that
// increases readability.

// Proposal: The pattern matching operator will explicitly only check matches and never
// do assignment. It can be chained like and with the pipe operator.

// Example:
func ()main {
  5 -> target
  []int{2,4,6} -> evens
  []int{1,3,5} -> odds

  target -> Exists(evens)
            = error {"unexpected error" => return}
            = false {
              target -> Exists(odds)
                        = error {"unexpected_error" => return}
                        = _ => return
            }
            = _ => return
}
