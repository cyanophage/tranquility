
kw=13.92; // size of hole for switch x
kd=14.42; // size of hole for switch y
sepx=19; // x spacing between the switches
sepy=20.6; // y spacing between the switches
th=1.5; // thickness of top
bth=1; // bottom thickness
gap=1.5; // x width of bits between keys

fingers = [0,0,15,24,19,19,19]; // controls y adjustment of columns
thumbs = [0,0,0,0,0,0,0]; 
dips = [0,0,0,1,1,0,0]; // controls z adjustment of columns
fronty=-33.5;  // y position of front
reary=76;      // y position of rear
supports = [fronty,-10,10,30,76];
edgex=2;


module rotate_about_xy(x, y, pt) {
  translate(pt)
    rotate([x, y, 0])
      translate(-pt)
        children();
}  

module rotate_about_z(z, pt) {
  translate(pt)
    rotate([0, 0, z])
      translate(-pt)
        children();
}  
module rotate_about_xy_off(x, y, pt,off) {
  translate(pt+off)
    rotate([x, y, 0])
      translate(-pt)
        children();
}  

bigR = 77;  // controls the radius of the curvature of the top. higher is less curve
rx = 2*asin(sepy/(2*bigR));
ry = 2*asin(sepx/(2*bigR));

// top plate

cubex=0.01;
cube2=cubex/2;
cubey=0.1;
vth=0.8;
baseline = -5; // controls where the bottom is and therefore overall height
frontdip=5; // height of bit at the front. higher numbers makes it lower
reardip=4;  // same at back
screw=6.1;

rotation_point = [0,0,bigR];
rot2 = 5; // how much the top is tilted forward
rot_point2 = [0,-30,2.7]; // the point forward tilt is around


module elitec() {
  color("green")cube([18.5,33.25,1.00],true);
//  color("silver")translate([0,(33.25/2)-(7.35/2)+0.65,1.65+0.5]) cube([9,7.35,3.3],true);
  color("silver") translate([0,(33.25/2)+0.65,1.65+0.5])
  difference() {
    hull() {
      translate([2.85,0,0]) rotate([90,0,0]) cylinder(d1=3.3,d2=3.3,h=7.35,$fn=32);
      translate([-2.85,0,0]) rotate([90,0,0]) cylinder(d1=3.3,d2=3.3,h=7.35,$fn=32);
    }
    hull() {
      translate([2.85,1,0]) rotate([90,0,0]) cylinder(d1=2.9,d2=2.9,h=7.35,$fn=32);
      translate([-2.85,1,0]) rotate([90,0,0]) cylinder(d1=2.9,d2=2.9,h=7.35,$fn=32);
    }
  }
  color("gray") translate([0,-2,1]) cube([8,8,1],true);
}

module elitec4() {
  difference() {
    color("green")translate([0,0,0.33]) cube([18.5,33.25,1.66],true);
    translate([0,13.13,0]) cube([9,7,1.67],true);
    
  }
//  color("silver")translate([0,(33.25/2)-(7.35/2)+0.65,1.65+0.5]) cube([9,7.35,3.3],true);
  color("silver") translate([0,(33.25/2)+0.65,1.16])
  difference() {
    hull() {
      translate([2.85,0,0]) rotate([90,0,0]) cylinder(d1=3.3,d2=3.3,h=7.35,$fn=32);
      translate([-2.85,0,0]) rotate([90,0,0]) cylinder(d1=3.3,d2=3.3,h=7.35,$fn=32);
    }
    hull() {
      translate([2.85,1,0]) rotate([90,0,0]) cylinder(d1=2.9,d2=2.9,h=7.35,$fn=32);
      translate([-2.85,1,0]) rotate([90,0,0]) cylinder(d1=2.9,d2=2.9,h=7.35,$fn=32);
    }
  }
  color("gray") translate([0,-2,1]) cube([8,8,1],true);
  
}

// caddy to hold the elite c v3
module caddy1() {
  difference() {
    intersection() {
      color("limegreen")hull() {
       // top left 
       translate([-10,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*3-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
       // top right
       translate([30,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*3-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
       // bottom left
       translate([-10,reary,baseline]) cube([cubex, 1, th],true);
       // bottom right
       translate([30,reary,baseline]) cube([cubex, 1, th],true);
     }
     translate([10,17.2+58+1,-3.5+1.75-0.2]) cube([20.7,5,10],true); // back plate
   }
   // hole for usb cable plug
    translate([10,78,-1.95]) hull() {
      translate([2.85,0,0]) rotate([90,0,0]) cylinder(d1=3.7,d2=3.7,h=7.35,$fn=32);
      translate([-2.85,0,0]) rotate([90,0,0]) cylinder(d1=3.7,d2=3.7,h=7.35,$fn=32);
    }
    // spacing for usb cable around the plug
    color("teal")translate([10,79,-1.95])rotate([90,90,0]) hull() {
      translate([0,2.95,0])cylinder(d1=7.3,d2=7.3,h=3,$fn=64);
      translate([0,-2.95,0])cylinder(d1=7.3,d2=7.3,h=3,$fn=64);
    }
  }
  
  // bit to glue caddy to case
  difference() {
    union() {
      hull() {
        translate([-4,75,-5.25]) cube([9,2,1],true);
        translate([-4,74,2.55]) cube([9,2,1],true);
      }
      hull() {
        translate([24,75,-5.25]) cube([9,2,1],true);
        translate([24,74,2.55]) cube([9,2,1],true);
      }
      translate([10,58,0.25]) {
        difference() {
          union() {
            translate([0,-0.4,1])color("lightblue")cube([21,34.8,1.00],true); // base
            translate([0,-0.4,2])color("lightcoral")cube([21,34.8,1.6],true); // base
          }
          translate([8,-0.4,0]) cube([3,32.8,3], true);
          translate([-8,-0.4,0]) cube([3,32.8,3], true);
          translate([0,-15.3,0]) cube([13.1,3,3], true);
        }
        
        // short walls
        color("orange")translate([10,0,-1]) cube([1,34,3],true);
        color("orange")translate([-10,0,-1]) cube([1,34,3],true);
        color("orange")translate([0,-17.3,-1]) cube([21,1,3],true);
      }
    }
    hull() {
       // top left 
       translate([-10,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*3-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
       // top right
       translate([30,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*3-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
       // bottom left
       translate([-10,reary,baseline]) cube([cubex, 1, th],true);
       // bottom right
       translate([30,reary,baseline]) cube([cubex, 1, th],true);
     }
  }
}

// caddy to hold the elite c v4
module caddy1_v4() {
  difference() {
    intersection() {
      color("limegreen")hull() {
       // top left 
       translate([-10,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*3-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
       // top right
       translate([30,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*3-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
       // bottom left
       translate([-10,reary,baseline]) cube([cubex, 1, th],true);
       // bottom right
       translate([30,reary,baseline]) cube([cubex, 1, th],true);
     }
     translate([10,17.2+58+1,-3.5+1.75-0.2]) cube([20.7,5,10],true); // back plate
   }
   // hole for usb cable plug
    translate([10,78,-1.95]) hull() {
      translate([2.85,0,0]) rotate([90,0,0]) cylinder(d1=3.7,d2=3.7,h=7.35,$fn=32);
      translate([-2.85,0,0]) rotate([90,0,0]) cylinder(d1=3.7,d2=3.7,h=7.35,$fn=32);
    }
    color("teal")translate([10,79,-1.95])rotate([90,90,0]) hull() {
      translate([0,2.95,0])cylinder(d1=7.3,d2=7.3,h=3,$fn=64);
      translate([0,-2.95,0])cylinder(d1=7.3,d2=7.3,h=3,$fn=64);
    }
  }
  
  // bit to glue caddy to case
  difference() {
    union() {
      //translate([24.5,74.6,-1.35]) rotate([5,0,0]) cube([10,2,9],true);
      //translate([-4,74.6,-1.35]) rotate([5,0,0]) cube([9,2,9],true);
      hull() {
        translate([-4,75,-5.25]) cube([9,2,1],true);
        translate([-4,74,2.55]) cube([9,2,1],true);
      }
      hull() {
        translate([24,75,-5.25]) cube([9,2,1],true);
        translate([24,74,2.55]) cube([9,2,1],true);
      }
      translate([10,58,-0.75]) {
        difference() {
          union() {
            translate([0,-0.4,1])color("lightblue")cube([21,34.8,1.00],true); // base
            translate([0,-0.4,2.65])color("lightcoral")cube([21,34.8,2.3],true); // base
          }
          translate([8,-0.4,0]) cube([3,32.8,3], true);
          translate([-8,-0.4,0]) cube([3,32.8,3], true);
          translate([0,-15.3,0]) cube([13.1,3,3], true);
        }
        // short walls
        color("orange")translate([10,0,-1]) cube([1,34,3],true);
        color("orange")translate([-10,0,-1]) cube([1,34,3],true);
        color("orange")translate([0,-17.3,-1]) cube([21,1,3],true);
      }
    }
    // backplate 
    hull() {
       // top left 
       translate([-10,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*3-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
       // top right
       translate([30,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*3-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
       // bottom left
       translate([-10,reary,baseline]) cube([cubex, 1, th],true);
       // bottom right
       translate([30,reary,baseline]) cube([cubex, 1, th],true);
     }
    
  }
}

// caddy for the trrs jack 
module caddy2() {
  holex = 4.75*sepx;
  difference() {
    intersection() {
      color("seagreen")
      hull() {
        // top left 
        translate([holex-8,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*3-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
        // top right
        translate([holex+8,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*3-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
        // bottom left
        translate([holex-8,reary,baseline]) cube([cubex, 1, th],true);
        // bottom right
        translate([holex+8,reary,baseline]) cube([cubex, 1, th],true);
      }
      translate([holex,17.2+58+1,-3.5+1.75-0.7]) cube([10.6,5,11],true); // back plate
    }
    translate([holex,78,-1.7]) rotate([90,0,0]) cylinder(d1=5.1,d2=5.1,h=4,$fn=64);
  }

  translate([holex,68,1.33]) {
    union(){
      color("orange") cube([8.4,15,1],true);
      color("skyblue") translate([0,0,1.1])cube([8.4,15,1.24],true);
      translate([-3.7,0,-1.5])cube([1,15,4],true);
      translate([3.7,0,-1.5])cube([1,15,4],true);
      translate([0,-6.9,-1.5])cube([8,1.2,4],true);
    }
  }
  difference(){
    union(){
      translate([holex,68,1.33]) {
        hull() {
          translate([8,6.2,-2.78+4]) cube([8,2,1],true);
          translate([8,7,baseline-1.58]) cube([8,2,1],true);
        }
        hull() {
          translate([-8,6.2,-2.78+4]) cube([8,2,1],true);
          translate([-8,7,baseline-1.58]) cube([8,2,1],true);
        }
      }
    }
    hull() {
      // top left 
      translate([holex-16,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*3-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
      // top right
      translate([holex+16,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*3-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
      // bottom left
      translate([holex-16,reary,baseline]) cube([cubex, 1, th],true);
      // bottom right
      translate([holex+16,reary,baseline]) cube([cubex, 1, th],true);
    }
  }
  
}

// TRRS jack
module jack() {
  color("darkgray")
  translate([4.75*sepx,68,-1.7]) {
    rotate([-90,0,0]){
      difference() {
        union(){
          translate([0,0,6])cylinder(d1=5,d2=5,h=2,$fn=64);
          cube([6.25, 5.1, 12.2],true);
        }
        translate([0,0,-6]) cylinder(d1=3.5,d2=3.5,h=19,$fn=64);
      }
    }
  }
  
}


module usbc() {
  color("gray")hull() {
    // 12.6mm x 6.7
    translate([0,2.95,0])cylinder(d1=6.7,d2=6.7,h=24.5,$fn=64);
    translate([0,-2.95,0])cylinder(d1=6.7,d2=6.7,h=24.5,$fn=64);
  }
  color("silver")
  difference(){
    hull() {
    //2.5 x 8.3
      translate([0,2.9,24.5])cylinder(d1=2.5,d2=2.5,h=6.5,$fn=32);
      translate([0,-2.9,24.5])cylinder(d1=2.5,d2=2.5,h=6.5,$fn=32);
    }
    hull() {
      translate([0,2.9,24.5])cylinder(d1=2.2,d2=2.2,h=6.7,$fn=32);
      translate([0,-2.9,24.5])cylinder(d1=2.2,d2=2.2,h=6.7,$fn=32);
    }
  }
}
//translate([0,43.3,2]) rotate([90,90,0]) usbc();

module bolt(x,y) {
  boltx = 5.55;
  difference() {
    translate([x,y,baseline+1.5]) cube([8,7,4.5],true);
    //translate([x,y,baseline+4.8]) rotate([0,0,30]) color("red")import("C:/Users/Chris/Downloads/Metric_nuts_and_screws/files/hex_negative_m3.stl");
    for(i = [0:2]) {
      translate([x,y,baseline+4.8]) rotate([0,0,60*i+30])cube([boltx, tan(30)*boltx, 5],true);
    }
    
    translate([x,y,baseline-th]) cylinder(d1=3.2,d2=3.2,h=10,$fn=64);
  }

}

module m3screw(x,y) {
  translate([x,y,-6.9])
  difference() {
    union() {
      cylinder(d1=3, d2=3, h=6,$fn=64);
      cylinder(d1=5.9,d2=3,h=2,$fn=64);
    }
    cylinder(d1=2,d2=2,h=1,$fn=6);
  }
}
module m3screws() {
  m3screw(-sepx+4.9,fronty+4.2);
  //bolt(6*sepx-4.9,fronty+4.2); 
  
  m3screw(-sepx+4.9,reary-4.2);
  m3screw(6*sepx-4.9,reary-4.2);
  
  m3screw(1.5*sepx,fronty+4.3);
  m3screw(3.5*sepx,reary-4.2);
  m3screw(6*sepx-4.9,-5);
  
  m3screw(-sepx+4.9,27);
  
}

module bolts() {
  bolt(-sepx+4.9,fronty+4.2);
  //bolt(6*sepx-4.9,fronty+4.2); 
  
  bolt(-sepx+4.9,reary-4.2);
  bolt(6*sepx-4.9,reary-4.2);
  
  bolt(1.5*sepx,fronty+4.3);
  bolt(3.5*sepx,reary-4.2);
  bolt(6*sepx-4.9,-5);
  
  bolt(-sepx+4.9,27);
}


module keycaps() {
  
  union() {
    
    for(n = [-1:2]) {
      for(m = [0:5]) {
        translate([m*sepx-sepx/2,fingers[m],-dips[m]])
           rotate_about_xy(rot2,0,rot_point2)
           rotate_about_xy(n*rx,0,[0,0,bigR])
             translate([0,0,10])rotate([90,0,0])import("C:/Users/Chris/Documents/DSA 1u.stl");
      }
    }
    for(m = [3:6]){
      translate([m*sepx-sepx/2,-2*sepy+thumbs[m],0])
        rotate_about_xy(rx,0,rotation_point)
          translate([0,0,10])rotate([90,0,0])import("C:/Users/Chris/Documents/DSA 1u.stl");
    }
  }
}

module top() {
//mirror(v=[1,0,0])
difference() {
union() {
  // 4 x 6 finger keys
  for (m = [0:6]) { // across the fingers 
    p = m-1;
    for(n = [-1:2]){ // keyboard rows
      difference() {
        color("orange")hull() {
          left=m==0?-edgex:0;
          right=m==6?edgex:0;
          // back right
          translate([m*sepx-gap+right,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n+rx/2,0,rotation_point) cube([cubex, cubey, th],true);
          // front right
          translate([m*sepx-gap+right,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2)rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
          // back left
          translate([(m-1)*sepx+gap+left,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2)rotate_about_xy(rx*n+rx/2,0,rotation_point) cube([cubex, cubey, th],true);
          // front left
          translate([(m-1)*sepx+gap+left,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2)rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
        }
        if(m<6) { // cut out hole for keycap
          translate([m*sepx-sepx/2,fingers[m],-dips[m]])rotate_about_xy(rot2,0,rot_point2)rotate_about_xy(n*rx,0,rotation_point) cube([kw,kd,5],true);
        }
      }
      // vertical supports that go in the Y direction
      // that sit on the right side of the key plates
      if(m>5)
      color("wheat")hull() {
        // two bits on the underside of the keyboard plate
        translate([m*sepx-gap-vth+edgex,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy_off(rx*n+rx/2,0,rotation_point,[0,0,-1]) cube([2*vth, cubey, th],true);
        translate([m*sepx-gap-vth+edgex,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy_off(rx*n-rx/2,0,rotation_point,[0,0,-1]) cube([2*vth, cubey, th],true);
        // two vertices on the floor                for thicker walls vvvvv
        translate([m*sepx-gap-vth+edgex,supports[n+1],baseline])cube([2*vth, cubey, th],true); 
        translate([m*sepx-gap-vth+edgex,supports[n+2],baseline])cube([2*vth, cubey, th],true);
      }
      // that sit on the left side of the key plates
      if (m<1)
      color("wheat") hull() { //
        // two bits on the underside of the keyboard plate
        translate([(m-1)*sepx+gap+vth-edgex,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2)rotate_about_xy_off(rx*n+rx/2,0,rotation_point,[0,0,-1]) cube([2*vth, cubey, th],true);
        translate([(m-1)*sepx+gap+vth-edgex,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2)rotate_about_xy_off(rx*n-rx/2,0,rotation_point,[0,0,-1]) cube([2*vth, cubey, th],true);
        // two vertices on the floor
        translate([(m-1)*sepx+gap+vth-edgex,supports[n+1],baseline])cube([2*vth, cubey, th],true); 
        translate([(m-1)*sepx+gap+vth-edgex,supports[n+2],baseline])cube([2*vth, cubey, th],true);
      }


    }
  }

  
  for (m = [3:6]) {
    // thumb keys
    difference(){
     color("plum")hull() {
       left=m==0?-edgex:0;
       right=m==6?edgex:0;
       // top right
       translate([m*sepx-gap+right,-2*sepy+thumbs[m],0]) rotate_about_xy(rx+rx/2,0,rotation_point) cube([cubex, cubey, th],true);
       // bottom right
       translate([m*sepx-gap+right,-2*sepy+thumbs[m],0]) rotate_about_xy(rx-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
       // top left
       translate([(m-1)*sepx+gap+left,-2*sepy+thumbs[m],0]) rotate_about_xy(rx+rx/2,0,rotation_point) cube([cubex, cubey, th],true);
       // bottom left
       translate([(m-1)*sepx+gap+left,-2*sepy+thumbs[m],0]) rotate_about_xy(rx-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     } 
     // key hole
     translate([m*sepx-sepx/2,-2*sepy+thumbs[m],0]) rotate_about_xy(rx,0,rotation_point) cube([kw,kd,5],true); 
    }
    // bits to join front of thumb keys to front line
    color("salmon")hull() {
       left=m==0?-edgex:0;
       right=m==6?edgex:0;
    // from plate
    // bottom right
    translate([m*sepx-gap+right,-2*sepy+thumbs[m],0]) rotate_about_xy(rx-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
    // bottom left
    translate([(m-1)*sepx+gap+left,-2*sepy+thumbs[m],0]) rotate_about_xy(rx-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
    // to line
    translate([(m-1)*sepx+gap+left,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, 1, th],true);
    translate([m*sepx-gap+right,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, 1, th],true);
   }
  }
  // bit to join left most thumb key to front bit of middle finger column
  for(m=[3:3]) {
   color("red")hull() {
      // back right
      translate([(m-1)*sepx+gap-cube2,-2*sepy+thumbs[m],0]) rotate_about_xy(rx+rx/2,0,rotation_point) cube([cubex, cubey, th],true);
      // front right
      translate([(m-1)*sepx+gap-cube2,-2*sepy+thumbs[m],0]) rotate_about_xy(rx-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
      // mid left
      translate([(m-1)*sepx-gap+cube2,fingers[m-1],-dips[m-1]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
      // front left
      translate([(m-1)*sepx-gap+cube2,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, 1, th],true);
   }
   
   color("firebrick")hull() {
      // front left
      translate([(m-1)*sepx-gap+cube2,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, 1, th],true);
     // front right
     translate([(m-1)*sepx+gap-cube2,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, 1, th],true);
     // mid right
      translate([(m-1)*sepx+gap,-2*sepy+thumbs[m],0]) rotate_about_xy(rx-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
   }
    // bit to fill a triangle hole between leftmost thumb, bottom row middle finger, & bottom row ring finger
   color("maroon")hull(){
     // back right
     translate([(m-1)*sepx+gap,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2)rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, cubey, th],true);      
     // front left
      translate([(m-1)*sepx-gap,fingers[m-1],-dips[m-1]])rotate_about_xy(rot2,0,rot_point2)rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     // mid right
      translate([(m-1)*sepx+gap,-2*sepy+thumbs[m],0]) rotate_about_xy(rx+rx/2,0,rotation_point) cube([cubex, cubey, th],true);
   }
  }
  for(m=[3:6]){
    // thumb vertical supports
    if(m>5)
     color("limegreen")hull() {
         left=m==0?-edgex:0;
         right=m==6?edgex:0;
       // top                                                                           2*vth for thicker walls vvvvv
       translate([m*sepx-gap-vth+right,-2*sepy+thumbs[m],-0.3]) rotate_about_xy(rx+rx/2,0,rotation_point) cube([2*vth, cubey, 0.1],true);
       translate([m*sepx-gap-vth+right,-2*sepy+thumbs[m],-0.3]) rotate_about_xy(rx-rx/2,0,rotation_point) cube([2*vth, cubey, 0.1],true);
       // floor
       translate([m*sepx-gap-vth+right,fronty,baseline])cube([2*vth, cubey, th],true);
       translate([m*sepx-gap-vth+right,-5,baseline])cube([2*vth, cubey, th],true);
       // front
       translate([m*sepx-gap-vth+right,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([2*vth, 1, 0.1],true);
     }

  }
  // connecting front line to baseline
  for(m=[0:6]) {
    color("lightpink")hull() {
     left=m==0?-edgex:0;
     right=m==6?edgex:0;
      // left
      translate([(m-1)*sepx+gap+left,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, 1, th],true);
      translate([(m-1)*sepx+gap+left,fronty,baseline]) cube([cubex, 1, th],true); // floor
      // right
      translate([m*sepx-gap+right,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, 1, th],true);
      translate([m*sepx-gap+right,fronty,baseline]) cube([cubex, 1, th],true); // floor
    }
    if(m<6) {
      color("PaleVioletRed")hull() {
      // left
      translate([m*sepx+gap,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, 1, th],true);
      translate([m*sepx+gap,fronty,baseline]) cube([cubex, 1, th],true); // floor
      // right
      translate([m*sepx-gap,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, 1, th],true);
      translate([m*sepx-gap,fronty,baseline]) cube([cubex, 1, th],true); // floor
      }
    }

    // vertical supports that go in the Y direction
    // that sit on the right side of the key plates
    // this bit joins the wheat vertical supports to the lightpink and palevioletred bit at the front
    for(n=[-1:-1]) {
      if(m>6)
      color("springgreen")hull() {
        right=m==6?edgex:0;
        // two bits on the underside of the keyboard plate
        // translate([(m-1)*sepx+gap+vth/2,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2)rotate_about_xy_off(rx*n+rx/2,0,rotation_point,[0,0,-1]) cube([vth, cubey, th],true);
        translate([m*sepx-gap-vth/2+right,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2)rotate_about_xy_off(rx*n-rx/2,0,rotation_point,[0,0,-1]) cube([vth, cubey, th],true);
        // two vertices on the floor
        translate([m*sepx-gap-vth/2+right,supports[n+1],baseline])cube([vth, cubey, th],true); 
        // to line
        translate([m*sepx-gap-vth/2+right,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([vth, cubey, th],true);
      }
      // that sit on the left side of the key plates
      if(m<1)
      color("springgreen")hull() {
         left=m==0?-edgex:0;
        // two bits on the underside of the keyboard plate
        // translate([(m-1)*sepx+gap+vth/2,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2)rotate_about_xy_off(rx*n+rx/2,0,rotation_point,[0,0,-1]) cube([vth, cubey, th],true);
        translate([(m-1)*sepx+gap+vth+left,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2)rotate_about_xy_off(rx*n-rx/2,0,rotation_point,[0,0,-1]) cube([2*vth, cubey, th],true);
        // two vertices on the floor
        translate([(m-1)*sepx+gap+vth+left,fronty,baseline])cube([2*vth, cubey, th],true); 
        // to line
        translate([(m-1)*sepx+gap+vth+left,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([2*vth, cubey, th],true);
      }
    }
  }
  
  //  bits between thumb keys
  for (m = [3:5]) {
   color("mediumorchid")hull() {
     // top left
     translate([m*sepx-gap+cube2,-2*sepy+thumbs[m],0]) rotate_about_xy(rx+rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     // bottom left
     translate([m*sepx-gap+cube2,-2*sepy+thumbs[m],0]) rotate_about_xy(rx-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     // top right
     translate([m*sepx+gap-cube2,-2*sepy+thumbs[m],0]) rotate_about_xy(rx+rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     // bottom right
     translate([m*sepx+gap-cube2,-2*sepy+thumbs[m],0]) rotate_about_xy(rx-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     //
   }
   hull() {
     // bottom right
     translate([m*sepx+gap-cube2,-2*sepy+thumbs[m],0]) rotate_about_xy(rx-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     // bottom left
     translate([m*sepx-gap+cube2,-2*sepy+thumbs[m],0]) rotate_about_xy(rx-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     // front right
     translate([m*sepx+gap-cube2,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, 1, th],true);
     // front left
     translate([m*sepx-gap+cube2,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, 1, th],true);
   }
  }
  
  // tiny little bit to join thumb inbetween bits with key inbetween bits
  n3=-1;
  for (m = [3:5]) {
    p = m+1;
   color("coral")hull() {
     // thumb
     translate([m*sepx-gap+cube2,-2*sepy+thumbs[m],0]) rotate_about_xy(rx+rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     translate([m*sepx+gap-cube2,-2*sepy+thumbs[m],0]) rotate_about_xy(rx+rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     // finger keys
     translate([m*sepx-gap+cube2,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2)rotate_about_xy(rx*n3-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     translate([m*sepx+gap-cube2,fingers[p],-dips[p]]) rotate_about_xy(rot2,0,rot_point2)rotate_about_xy(rx*n3-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
   }
  }
  
  
  // joiners between keys
  for (m = [0:5]) { // across the fingers 
    //m = 2;
    p = m+1;
    for(n = [-1:2]){ // keyboard rows
     color("hotpink")hull() {
       // top right
      translate([m*sepx-gap+cube2,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n+rx/2,0,rotation_point) cube([cubex, cubey, th],true);
       // bottom right
      translate([m*sepx-gap+cube2,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
       // top left
      translate([m*sepx+gap-cube2,fingers[p],-dips[p]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n+rx/2,0,rotation_point) cube([cubex, cubey, th],true);
       // bottom left
      translate([m*sepx+gap-cube2,fingers[p],-dips[p]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     }
    }
  }
  
  // join front of keys to front line 
  n = -1;
  left = 0;
  for(m = [0:2]) {
    p = m + 1;
   color("lightblue")hull() {
     left=m==0?-edgex:0;
     right=m==6?edgex:0;
   // from plate
     translate([(m-1)*sepx+gap+left,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     translate([m*sepx-gap,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
   // to add thickness front to back with an added 0.5 here --------------------v
     translate([(m-1)*sepx+gap+left,fingers[m],-dips[m]]) rotate_about_xy(rx*n-rx/2+0.5,0,rotation_point) cube([cubex, cubey, th],true);
     translate([m*sepx-gap,fingers[m],-dips[m]]) rotate_about_xy(rx*n-rx/2+0.5,0,rotation_point) cube([cubex, cubey, th],true);
     // to line
     //left
     translate([(m-1)*sepx+gap+left,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, 1, th],true);
     // right
     translate([m*sepx-gap,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, 1, th],true);
     
   }
  // joiners between front bit  
    if(m<2){
   color("deepskyblue")hull() {
     // from plate
     translate([m*sepx-gap+cube2,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     translate([m*sepx+gap-cube2,fingers[p],-dips[p]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     // to add thickness front to back
     translate([m*sepx-gap+cube2,fingers[m],-dips[m]]) rotate_about_xy(rx*n-rx/2+0.5,0,rotation_point) cube([cubex, cubey, th],true);
     translate([m*sepx+gap-cube2,fingers[p],-dips[p]]) rotate_about_xy(rx*n-rx/2+0.5,0,rotation_point) cube([cubex, cubey, th],true);
     
     // to line
     translate([m*sepx-gap+cube2,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, 1, th],true);
     translate([m*sepx+gap-cube2,fingers[0]-3,-dips[3]-frontdip]) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, 1, th],true);
   }
    }
  }
  
  // join front of keys to back of thumb keys
  for(m = [3:6]) {
   color("dodgerblue")hull() {
   // from keys plate
     translate([m*sepx-gap,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     translate([(m-1)*sepx+gap,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
   // to thumb
     translate([m*sepx-gap,-2*sepy+thumbs[m],0]) rotate_about_xy(rx+rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     translate([(m-1)*sepx+gap,-2*sepy+thumbs[m],0]) rotate_about_xy(rx+rx/2,0,rotation_point) cube([cubex, cubey, th],true); 
   }
  }
  
  // rear edge joining number row keys to rear border
  n2 = 3;
  for(m = [0:6]) {
   color("tomato")hull() {
     left=m==0?-edgex:0;
     right=m==6?edgex:0;
   // from plate
     translate([m*sepx-gap+right,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2)rotate_about_xy(rx*n2-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     translate([(m-1)*sepx+gap+left,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2)rotate_about_xy(rx*n2-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
//   // to add thickness
     translate([m*sepx-gap+right,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2)rotate_about_xy(rx*n2-rx/2-0.5,0,rotation_point) cube([cubex, cubey, th],true);
     translate([(m-1)*sepx+gap+left,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2)rotate_about_xy(rx*n2-rx/2-0.5,0,rotation_point) cube([cubex, cubey, th],true);
   // to line
     translate([(m-1)*sepx+gap+left,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n2-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     translate([m*sepx-gap+right,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n2-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     
   }
    // extra rear bit that goes down to fixed baseline
   color("palegreen")hull() {
     left=m==0?-edgex:0;
     right=m==6?edgex:0;
     // top left 
     translate([(m-1)*sepx+gap+left,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n2-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     // top right
     translate([m*sepx-gap+right,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n2-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     // bottom left
     translate([(m-1)*sepx+gap+left,reary,baseline]) cube([cubex, 1, th],true);
     // bottom right
     translate([m*sepx-gap+right,reary,baseline]) cube([cubex, 1, th],true);
   }
   if (m<6){
     // joiners between palegreen bits at the back
     color("darkseagreen")hull() {
     // top left 
     translate([m*sepx+gap-cube2,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n2-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     // top right
     translate([m*sepx-gap+cube2,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n2-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     // bottom left
     translate([m*sepx+gap-cube2,reary,baseline]) cube([cubex, 1, th],true);
     // bottom right
     translate([m*sepx-gap+cube2,reary,baseline]) cube([cubex, 1, th],true);
     }
   }
  }
    
  // joiners between rear edge tomato bits
  for(m = [0:5]) {
    p = m + 1;
   color("teal")hull() {
     // right corner of plate
     translate([m*sepx-gap+cube2,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n2-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     // left side of front
     translate([m*sepx+gap-cube2,fingers[p],-dips[p]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n2-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     // right side of front
     translate([m*sepx-gap+cube2,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n2-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
     translate([m*sepx+gap-cube2,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n2-rx/2,0,rotation_point) cube([cubex, cubey, th],true);
   }
  }
  for(m = [0:6]){
    // that sit on the left side of the key plates
    for(n=[2:2]) {
     left=m==0?-edgex:0;
     right=m==6?edgex:0;
      if(m>5)
      color("burlywood")hull() {
        // two bits on the underside of the keyboard plate
        translate([m*sepx-gap-vth+right,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy_off(rx*n+rx/2,0,rotation_point,[0,0,-1]) cube([2*vth, cubey, th],true);
        // two vertices on the floor
        translate([m*sepx-gap-vth+right,supports[n+2],baseline])cube([2*vth, cubey, th],true);
        //
        translate([m*sepx-gap-vth+right,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n2-rx/2,0,rotation_point) cube([2*vth, cubey, th],true);
      }
      if(m<1)
      color("burlywood")hull() {
        // two bits on the underside of the keyboard plate
        translate([(m-1)*sepx+gap+vth+left,fingers[m],-dips[m]]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy_off(rx*n+rx/2,0,rotation_point,[0,0,-1]) cube([2*vth, cubey, th],true);
        // two vertices on the floor
        translate([(m-1)*sepx+gap+vth+left,supports[n+2],baseline])cube([2*vth, cubey, th],true);
        //
        translate([(m-1)*sepx+gap+vth+left,fingers[3]+3,-dips[3]-reardip]) rotate_about_xy(rot2,0,rot_point2) rotate_about_xy(rx*n2-rx/2,0,rotation_point) cube([2*vth, cubey, th],true);
      }
    }
  }

} // end of union

  // take this stuff away from the rest
    union() {
      // square gap for caddy
      translate([10,17.2+58+1,-3.5+1.75-0.5]) cube([21,5,11],true); // elite-c
      // square gap for trrs jack
      translate([4.75*sepx,17.2+58+1,-3.5+1.75-0.5]) cube([11,5,11],true); // trrs jack
    }

  }
  // central support pillar
  hull() {
    translate([40,13.5,1])cube([2, 2, th],true);
    translate([40,13.5,baseline])cube([2, 2, th],true);
  }
  hull() {
    translate([55,13.5,1])cube([2, 2, th],true);
    translate([55,13.5,baseline])cube([2, 2, th],true);
  }
} // end of module

// bottom panel
//
module bottom() {
  difference() {
    color("lime")hull() {
      translate([-1*sepx+gap-edgex,fronty,baseline-bth/2-th/2]) cube([cubex, 1, bth],true);
      translate([6*sepx-gap+edgex,fronty,baseline-bth/2-th/2]) cube([cubex, 1, bth],true);
      translate([6*sepx-gap+edgex,reary,baseline-bth/2-th/2]) cube([cubex, 1, bth],true);
      translate([-1*sepx+gap-edgex,reary,baseline-bth/2-th/2]) cube([cubex, 1, bth],true);
    }
    translate([-sepx+4.9,fronty+4.2,baseline-bth-th/2]) cylinder(d1=screw,d2=3.1, h=bth,$fn=64);
//    translate([6*sepx-4.9,fronty+4.2,baseline-bth-th/2]) cylinder(d1=screw,d2=3.1, h=bth,$fn=64);
    
    translate([-sepx+4.9,reary-4.2,baseline-bth-th/2]) cylinder(d1=screw,d2=3.1, h=bth,$fn=64);
    translate([6*sepx-4.9,reary-4.2,baseline-bth-th/2]) cylinder(d1=screw,d2=3.1, h=bth,$fn=64);
    
    translate([1.5*sepx,fronty+4.3,baseline-bth-th/2]) cylinder(d1=screw,d2=3.1, h=bth,$fn=64);
    translate([3.5*sepx,reary-4.2,baseline-bth-th/2]) cylinder(d1=screw,d2=3.1, h=bth,$fn=64);
    translate([6*sepx-4.9,-5,baseline-bth-th/2]) cylinder(d1=screw,d2=3.1, h=bth,$fn=64);
    translate([-sepx+4.9,27,baseline-bth-th/2]) cylinder(d1=screw,d2=3.1, h=bth,$fn=64);
  }
  
}

module wristrest() {
  wth = 10;
  wdepth=100;
  cornerd=8;
  difference() {
    color("MediumVioletRed") hull() {
      translate([-1*sepx+gap-edgex,fronty,baseline+wth/2-bth-th/2]) cube([cubex, 1, wth],true);
      translate([6*sepx-gap+edgex,fronty,baseline+wth/2-bth-th/2]) cube([cubex, 1, wth],true);
      translate([6*sepx-gap+edgex,fronty-wdepth,baseline-bth]) cube([cubex, 1, th],true);
      translate([-1*sepx+gap-edgex,fronty-wdepth,baseline-bth]) cube([cubex, 1, th],true);
      translate([-1*sepx+gap-edgex+cornerd/2,fronty-wdepth+cornerd/2,baseline+wth-bth-th/2-cornerd/2]) sphere(d=cornerd,$fn=64);
      translate([6*sepx-gap+edgex-cornerd/2,fronty-wdepth+cornerd/2,baseline+wth-bth-th/2-cornerd/2]) sphere(d=cornerd,$fn=64);
    }
    
    top();
  }
}

// add mirror for right hand
//mirror(v=[1,0,0])
union() {
  union() {
    top();
    bolts();
  }
  //bottom();
  //m3screws();
  //wristrest();
    
  //translate([10,58,0.2]) rotate([0,180,0]) elitec();
  //caddy1();
  
  //translate([10,58,-0.8]) rotate([0,180,0]) elitec4();
  caddy1_v4();
  
  caddy2();
  //jack();
}

