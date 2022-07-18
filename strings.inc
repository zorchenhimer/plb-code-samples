. Common test data for strings.pls and strings_routines.pls

TestCase list
tPath dim 100
tDir dim 100
tFile dim 100
tExtension dim 10
    listend
TestFile file
seq form "-1"
FileWritten init "N"

CreateTestFile function
    entry

PathsLen equ 11
Paths dim 100(PathsLen):
    ("C:\one\two\three\file.txt"):
    ("/one/two/three/file.rpt"):
    ("file.png"):
    ("/file.dat"):
    ("\file.txt"):
    ("C:\one\two\three\file.txt.pgp"):
    ("/one/two/three/file.rpt.pgp"):
    ("/one/two.yes/three/filename"):
    ("./from/current/dir.lst"):
    ("/no/files/here/"):
    ("/one/letter/a")

Dirs dim 100(PathsLen):
    ("C:\one\two\three\"):
    ("/one/two/three/"):
    (""):
    ("/"):
    ("\"):
    ("C:\one\two\three\"):
    ("/one/two/three/"):
    ("/one/two.yes/three/"):
    ("./from/current/"):
    ("/no/files/here/"):
    ("/one/letter/")

Files dim 100(PathsLen):
    ("file.txt"):
    ("file.rpt"):
    ("file.png"):
    ("file.dat"):
    ("file.txt"):
    ("file.txt.pgp"):
    ("file.rpt.pgp"):
    ("filename"):
    ("dir.lst"):
    (""):
    ("a")

Extensions dim 10(PathsLen):
    (".txt"):
    (".rpt"):
    (".png"):
    (".dat"):
    (".txt"):
    (".pgp"):
    (".pgp"):
    (""):
    (".lst"):
    (""):
    ("")

FH file
seq form "-1"
X form 2

    prep FH,"strings_tests.csv"
    for x from "1" to PathsLen by "1"
        move Paths(x) to tPath
        move Dirs(x) to tDir
        move Files(x) to tFile
        move Extensions(x) to tExtension
        chop tPath
        chop tDir
        chop tFile
        chop tExtension

        write FH,seq;*cdfon,*ll,TestCase
    repeat
    weof FH,seq
    close FH

    functionend
