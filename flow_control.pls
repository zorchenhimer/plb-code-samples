. This file demonstrates some of the flow control available in PL/B.

A form "1"
B form "2"
X form 2

.   Equality is checked with a single equals sign.
    if (A = B)
        display "equal"

    else if (A > B)
        display "greater than"

.   Not equal takes inspiration form the BASIC family of languages (or
.   maybe the other way around?
    else if (A <> B)
        display "not equal"

    else
        display "less than"
    endif

.   NOT takes the inversion of the test result.  This can be used wherever
.   a conditional expression is used.
    if (not A = B)
        display "not equal"
    endif

.   A LOOP loop does not have the exit condition in the declaration.
.   "WHILE" is not a loop type, it is an exit condition check.
    loop
        incr X
        display "LOOP ",X

.       Exit conditions are spread throughout the loop
        break if (X > "10")

.       These are the same as the above BREAK statement.
.       UNTIL simply inverts the behavior of WHILE.
        while (X <= "10")
        until (X > "10")

.   WHILE and UNTIL can be appended to REPEAT here as well.
    repeat

.   The C/C++ equivalent of this would be:
.   for (x = 1; i < 10; x += 2)
    for X from "1" to "10" by "2"
        display "FOR ",X
    repeat

.   While technically acting as a loop, this isn't considered a
.   traditional loop.
    move "1" to X
Some_Label
    incr X
    display "GOTO ",X

.   GOTO can optionally take a conditional.
    goto Some_Label if (x < 10)

.   There are a few syntaxes for calling routines and functions.
.   First is a simple call
    call A_Routine

.   Next is a conditional call
    call A_Routine if (A = B)

.   And last is a function call with parameters.  Multiple parameters are
.   separated by a comma.
    call A_Function using A

.   If the function returns a value, it will be lost unless assigned to
.   a variable with the keyword GIVING.
    call A_Function giving B using A

rogue_destination

.   Branch uses the first argument as an index into a list of labels.  It
.   will execute a GOTO to the appropriate label.
    move "2" to X
    branch X of Label_1,Label_2,Label_3

.   PERFORM is like BRANCH, only it expects the label to RETURN eventually.
    perform X of A_Routine,Another_Routine

.   SWITCH works similarly to modern languages.
    switch X
        case "1"
            display "case 1"
        case "2"
            display "case 2"
        default
            display "other case"
    endswitch

The_End
    display "all done"

.   STOP is automatically added to the end of a source file.  If we want
.   to end before that, we must specify STOP.
.   STOP can also have a conditional, just to add to the confusion.
    stop if (A = B)
    stop

Label_1
    display "label 1"
    goto The_End

Label_2
    display "label 2"
    goto The_End

Label_3
    display "label 3"
    goto The_End

A_Routine
    display "In a routine"
    return

Another_Routine
    display "In another routine"
    return

Rouge_Routine
.   NORETURN removes a return address from the call stack.  Using RETURN
.   will either return to the next return address, if the program
.   execution is more than one level of CALLs deep, or thorw an error.
    noreturn
    display "i'm going somewhere else"
    goto rogue_destination

. Functions are a Sunbelt addition to PL/B.  They are defined by appending
. "FUNCTION" after a label.
A_Function function
. Immediately following the function declaration is the list of
. parameters.  All of these are optional and will be empty if not provided.
value dim 4
.   Entry signifies the start of the function body
    entry

. This is a local variable.  It can only be accessed from within this
. function.  Because it shares a name with a global variable, that global
. variable is not accessible here.
X dim 5

    move value to x
    replace " 0" in x
    display "function ",x

.   RETURN can take a few forms.  If returning a value, the USING keyword
.   is required.  RETURN can also have a conditional appended.
    return using X

.   Function scopes are closed with FUNCTIONEND.
    functionend
