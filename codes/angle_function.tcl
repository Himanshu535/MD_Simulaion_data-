# compute angle between three arbitrary points in space
# (initially has been written for hydrogen bond angles,
# notation has been kept: D-H...A)
# usage: angle {x1 y1 z1} {x2 y2 z2} {x3 y3 z3}

proc angle {D H A} {
  # cosine of the angle between three points
  # cos = ( v1 * v2 ) / |v1| * |v2|, where v1 and v2 are vectors

  # get Pi 3.14159265358979323846
  global M_PI

  # initialize arrays
  set d() 0; set h() 0; set a() 0; set hd() 0; set ha() 0;

  # split coordinates
  set d(x) [lindex $D 0]; set d(y) [lindex $D 1]; set d(z) [lindex $D 2];
  set h(x) [lindex $H 0]; set h(y) [lindex $H 1]; set h(z) [lindex $H 2];
  set a(x) [lindex $A 0]; set a(y) [lindex $A 1]; set a(z) [lindex $A 2];

  # setup vectors hd and ha
  set hd(x) [expr $d(x) - $h(x)];
  set hd(y) [expr $d(y) - $h(y)];
  set hd(z) [expr $d(z) - $h(z)];

  set ha(x) [expr $a(x) - $h(x)];
  set ha(y) [expr $a(y) - $h(y)];
  set ha(z) [expr $a(z) - $h(z)];

  # compute cosine
  set cosine [expr \
    ($hd(x)*$ha(x) + $hd(y)*$ha(y) + $hd(z)*$ha(z)) / \
    (sqrt(pow($hd(x),2) + pow($hd(y),2) + pow($hd(z),2)) * \
     sqrt(pow($ha(x),2) + pow($ha(y),2) + pow($ha(z),2)))];

  # convert cosine to angle in degrees
  set angle [expr acos($cosine)*(180.0/$M_PI)]

  return $angle;
} 
