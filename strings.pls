
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
Result dim 100
Pass init "y"

Start
    for x from "1" to PathsLen by "1"
        display *n,*ll,Paths(x)
        call GetDirectory giving Result using Paths(x)
        if (Dirs(x) <> Result)
            display "GetDirectory failed"
            display "Expected: #"",*ll,Dirs(x),"#"" // "
            display "Recieved: #"",*ll,Result,"#"" // "
            move "n" to Pass
        endif

        call GetFile giving Result using Paths(x)
        if (Files(x) <> Result)
            display "GetFile failed"
            display "Expected: #"",*ll,Files(x),"#"" // "
            display "Recieved: #"",*ll,Result,"#"" // "
            move "n" to Pass
        endif

        call GetExtension giving Result using Paths(x)
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

GetDirectory function
Input dim 100
    entry
Y form 2
Result dim 100
    whereislast "/" in Input giving Y
    if (Y = "0")
        whereislast "\" in Input giving Y
    endif
    if zero
        return using ""
    endif
    setlptr Input to Y
    reset Input
    move Input to Result
    return using Result
    functionend

GetFile function
Input dim 100
    entry
Y form 2
Z form 2
Result dim 100
    movelptr Input to Z
    whereislast "/" in Input giving Y
    if (Y = "0")
        whereislast "\" in Input giving Y
    endif
    add "1" to Y
    reset Input to Y
    setlptr Input to Z
    move Input to Result
    return using Result
    functionend

GetExtension function
Input dim 100
    entry
Y form 2
Result dim 100
    call GetFile giving Input using Input
    whereislast "." in Input giving Y
    reset input to y
    move input to result
    return using result
    functionend
