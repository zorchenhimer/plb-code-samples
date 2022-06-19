. Common data between all the programs
counter form *3

. Local data that's not passed to other programs
otherCounter form 3

. Menu answer
answer dim 1

. Program to chain
chainprg dim 50

    display "Main"
.   This counter is incremented in each CHAIN'd program
    display "counter: ",counter

.   This counter is not a "common" data variable, and is
.   only incremented here.
    display "othercounter: ",othercounter
    add "1" to othercounter

.   Display a menu
    display "1) second"
    display "2) third"
    display "3) fail"

    loop
.       Figure out what the choice was
        keyin answer
        uppercase answer
        switch answer
            case "1"
                move "second" to chainprg
                break
            case "2"
                move "third" to chainprg
                break
            case "3"
.               This choice will trigger an error on the CHAIN command
                move "fail" to chainprg
                break
            case "Q"
                stop
        endswitch
    repeat

.   TRAP any errors CHAINing
    trap chainfail if cfail
    chain chainprg
    trapclr cfail
    stop

chainfail
    display "Failed to chain to program '",*ll,chainprg,"'"
    display S$ERROR$
    stop
