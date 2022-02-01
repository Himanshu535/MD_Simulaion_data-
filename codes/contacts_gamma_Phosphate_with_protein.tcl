# This is to find and get the distance of nearest neibour distance of gamma phosphate of ATP.

mol new NM_WA.pdb 
mol addfile NM_WA.trr first 0 last 400 step 1 waitfor all molid 0

mol new WM_WA.pdb
mol addfile WM_WA.trr first 0 last 400 step 1 waitfor all molid 1

set firstFrame 1
set lastFrame 400
set atpnm [atomselect 0 "(protein and within 2 of (resname ATP and name O1PG O2PG O3PG H3PG)) and chain C"]
set atpwm [atomselect 1 "(protein and within 2 of (resname ATP and name O1PG O2PG O3PG H3PG)) and chain C"]

set fid [open "contacts_gamma.dat" w+]
for {set f $firstFrame} {$f<=$lastFrame} {incr f} {

    $atpnm frame $f
    $atpwm frame $f

    $atpnm update
    $atpwm update

    set n_nm [$atpnm num]
    set n_wm [$atpwm num]

    puts $fid "$f  $n_nm  $n_wm "

    }
close $fid
