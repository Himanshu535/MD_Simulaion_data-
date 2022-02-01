# It selects the required domain of protein in this case selecting the P4 domain of cheA protein and finds the distance between centerof mass of two proteins#
source angle_function.tcl

mol new WM_NA.pdb
mol addfile WM_NA.trr first 0 last 400 step 1 waitfor all molid 0

mol new NM_NA.pdb
mol addfile NM_NA.trr first 0 last 400 step 1 waitfor all molid 1

set firstFrame 1
set lastFrame 400
set chew0 [atomselect 0 "serial 8529 to 10359 and not hydrogen"]
set chew1 [atomselect 1 "serial 8529 to 10359 and not hydrogen"]
set p30 [atomselect 0 "serial 2779 to 3413 and not hydrogen"]
set p31 [atomselect 1 "serial 2779 to 3413 and not hydrogen"]
set p40 [atomselect 0 "serial 3414 to 5243 and not hydrogen"]
set p41 [atomselect 1 "serial 3414 to 5243 and not hydrogen"]

set fid [open "angle_P4P4_NATP.dat" w+]
for {set f $firstFrame} {$f<=$lastFrame} {incr f} {
    $chew0 frame $f
    $chew0 update
    $p30 frame $f
    $p30 update
    $p40 frame $f
    $p40 update

    $chew1 frame $f
    $chew1 update
    $p31 frame $f
    $p31 update
    $p41 frame $f
    $p41 update

    set D0 [measure center $chew0]
    set H0 [measure center $p30]
    set A0 [measure center $p40]
 
    set D1 [measure center $chew1]
    set H1 [measure center $p31]
    set A1 [measure center $p41]

    puts $fid "$f  [angle $D0 $H0 $A0] [angle $D1 $H1 $A1]"


    }
close $fid
