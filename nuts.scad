// Nuts
// A 3D Printable T-Bar Nut Driver

// P A R A M E T E R S
// - - - - - - - - - -

// nut deets
nut_diagonal = 11; // mm
nut_sides = 6;

// tool props (mm)
bar_length = 60;
height = 30;
wall = 5;
diagonal_addon = 0.25; // geo-lubricant


// B U I L D
// - - - - -

$fn = 100; // resolution
diagonal = nut_diagonal + diagonal_addon;
width = diagonal + wall;
radius = width/2;

difference() {

  union() {
      rotate(a=90, v=[0,1,0]) {
        translate([0,0,bar_length/2-radius]) {
          sphere(r=radius);
        };
        translate([0,0,-(bar_length/2-radius)]) {
          sphere(r=radius);
        };
        cylinder(r=radius, h=bar_length-width, center=true);
      };
 
      translate([0,0,height/2]) {
        cylinder(r=radius, h=height, center=true);
      };
  };
  
  translate([0,0,-wall*1.5]) {
      cube([bar_length, width, wall], center=true);
  }
  
  translate([0,0,height]) {
    rotate(1*180/nut_sides) {
      // cosine converts across-flats to cylinder diameter
      // Thanks to Ed Nisley who showed me this trick in his wrench:
      // https://softsolder.com/2017/09/21/tour-easy-headset-wrench/
      cylinder(d=diagonal/cos(180/nut_sides),h=height*2, $fn=nut_sides, center=true);
    };
  };

};
