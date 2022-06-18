. Common test data for strings.pls and strings_routines.pls

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
