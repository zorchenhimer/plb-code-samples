
. Print the first 20 Fibonacci numbers

A form 5
B form 5
C form 5
X form 5

    splopen "fibonacci.spl"
    move "0" to A
    move "1" to B
    display A
    display B

    print "FOR loop"
    print A
    print B

.   Using FOR and CALC
    for x from "1" to "20" by "1"
        calc C = A + B
        display C
        print C
        move B to A
        move C to B
    repeat
    print "FOR loop done",*n

.   Using GOTO and ADD
    move "0" to A
    move "1" to B
    display A
    display B

    print "GOTO loop"
    print A
    print B
    move "1" to X
FIB
    add B to A
    display A
    print A
    add A to B
    display B
    print B

    add "2" to X
    goto FIB if (X <= "20")
    print "GOTO loop done",*n
    splclose
