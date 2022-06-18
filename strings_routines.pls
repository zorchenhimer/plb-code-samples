
. Given values in Paths, get:
.   - Directory without filename
.   - Filename without directory
.   - Extension without filename

PathsLen equ 8
Paths dim 100(PathsLen):
    ("C:\one\two\three\file.txt"):
    ("/one/two/three/file.txt"):
    ("file.txt"):
    ("/file.txt"):
    ("\file.txt"):
    ("C:\one\two\three\file.txt.pgp"):
    ("/one/two/three/file.txt.pgp"):
    ("/one/two.yes/three/filename")

Dirs dim 100(PathsLen):
    ("C:\one\two\three\"):
    ("/one/two/three/"):
    (""):
    ("/"):
    ("\"):
    ("C:\one\two\three\"):
    ("/one/two/three/"):
    ("/one/two.yes/three/")

Files dim 100(PathsLen):
    ("file.txt"):
    ("file.txt"):
    ("file.txt"):
    ("file.txt"):
    ("file.txt"):
    ("file.txt.pgp"):
    ("file.txt.pgp"):
    ("filename")

Extensions dim 100(PathsLen):
    (".txt"):
    (".txt"):
    (".txt"):
    (".txt"):
    (".txt"):
    (".pgp"):
    (".pgp"):
    ("")

X form 2
Y form 2
Z form 2
Result dim 100
Pass dim 1
Input dim 100

Start
    for x from "1" to PathsLen by "1"
        move "y" to pass
        display *n,*ll,Paths(x)
        call GetDirectory
        if (Dirs(x) <> Result)
            display "GetDirectory failed"
            display "Expected: #"",*ll,Dirs(x),"#"" // "
            display "Recieved: #"",*ll,Result,"#"" // "
            move "n" to Pass
        endif

        call GetFile
        if (Files(x) <> Result)
            display "GetFile failed"
            display "Expected: #"",*ll,Files(x),"#"" // "
            display "Recieved: #"",*ll,Result,"#"" // "
            move "n" to Pass
        endif

        call GetExtension
        if (Extensions(x) <> Result)
            display "GetExtension failed"
            display "Expected: #"",*ll,Extensions(x),"#"" // "
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

GetDirectory
    clear input
    clear result
    move Paths(x) to Input
    whereislast "/" in Input giving Y
    if (Y = "0")
        whereislast "\" in Input giving Y
    endif
    if zero
        return
    endif
    setlptr Input to Y
    reset Input
    move Input to Result
    return

GetFile
    clear input
    clear result
    move Paths(x) to Input
    movelptr Input to Z
    whereislast "/" in Input giving Y
    if (Y = "0")
        whereislast "\" in Input giving Y
    endif
    add "1" to Y
    reset Input to Y
    setlptr Input to Z
    move Input to Result
    return

GetExtension
    clear input
    clear result
    move Paths(x) to Input
    call GetFile
    move result to input
    whereislast "." in Input giving Y
    reset input to y
    move input to result
    return
