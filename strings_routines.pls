
. Given values in Paths, get:
.   - Directory without filename
.   - Filename without directory
.   - Extension without filename

.   Include the test data and expected results.
    include "strings.inc"

X form 2
Y form 2
Result dim 100
Pass dim 1
Input dim 100

    trap NoTests if io
    open TestFile,"strings_tests.csv"
    trapclr io

Start
.   Loop through each Path test case and compare the result to the expected
.   values.
    loop
        read TestFile,seq;*cdfon,TestCase
        break if over
        display *n,*ll,tPath

        move "y" to pass
        call ResetVars
        call GetDirectory
        if (tDir <> Result)
            display "GetDirectory failed"
            display "Expected: #"",*ll,tDir,"#"" // "
            display "Recieved: #"",*ll,Result,"#"" // "
            move "n" to Pass
        endif

        call ResetVars
        call GetFile
        if (tFile <> Result)
            display "GetFile failed"
            display "Expected: #"",*ll,tFile,"#"" // "
            display "Recieved: #"",*ll,Result,"#"" // "
            move "n" to Pass
        endif

        call ResetVars

        call GetExtension
        if (tExtension <> Result)
            display "GetExtension failed"
            display "Expected: #"",*ll,tExtension,"#"" // "
            display "Recieved: #"",*ll,Result,"#"" // "
            move "n" to Pass
        endif

        if (pass = "y")
            display " Passed"
        else
            display " Failed"
        endif
    repeat
    stop


. Routines don't have any local variables, so we need to clean up any
. previous value these may have.
ResetVars
    fill " " in Input
    fill " " in Result
    clear Input
    clear Result
    move tPath to Input
    return

. Extract the directory without the filename.
GetDirectory
.   WHEREISLAST works like WHEREIS, but in reverse.
    whereislast "/" in Input giving Y

.   If we didn't find anything, try the other slash.
    if (Y = "0")
        whereislast "\" in Input giving Y
    endif

.   If we still didn't find anything, there is no directory.
    if zero
        return
    endif

.   Set the end of the string to the last slash.
    setlptr Input to Y

.   Reset the beginning of the string to 1
    reset Input

.   Move the result into a clean variable.
    move Input to Result
    return

. Extract the filename without the directory.
GetFile
.   Find the last slash.
    whereislast "/" in Input giving Y
    if (Y = "0")
        whereislast "\" in Input giving Y
    endif

.   We don't want the slash included, so add one to the index.
    add "1" to Y

.   RESET the Form Pointer to the start of the filename.
    reset Input to Y

.   The Length Pointer didn't change, so we don't need to move it back to
.   the end.
    move Input to Result

.   Check for an empty string
    count Y in Result
    if (Y = 0)
        setlptr Result to 0
    endif
    return

. Extract the filename's extension.
GetExtension
.   Don't do this work twice.  Just call the other function.  We extract the
.   filename first to not get confused by any other periods in the input.
    call GetFile
    move result to input

.   Find the last period.
    whereislast "." in Input giving Y

.   Reset the start of the string to the index and include the period (ie,
.   don't add 1).
    reset input to y

.   Move the result to a clean variable
    move input to result
    return

NoTests
    if (FileWritten = "Y")
        display "Unable to open strings_tests.txt"
        display S$ERROR$
    endif
    call CreateTestFile
    move "Y" to FileWritten
    return
    stop
