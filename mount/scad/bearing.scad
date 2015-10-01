// Z-Bracket - Simple with Nut Holes

// højde af ekstra stykke til montering af plader
mount_height = 4;
// afstand fra center(z-aksen) til midten af monteringshuller
plate_mount_x_offset = 15;

hole_widen=0.0;
// hole_widen=1.0;
// 608 Bearing Dimensions
bearing_608_od=22.0+hole_widen;
bearing_608_id=8.0;
bearing_608_h=7.0;
// ISO Metric Hardware
m3_d=3.0+hole_widen;
m3_scs_head_h=3.0;
m3_scs_head_d=5.5+hole_widen;
m3_scs_head_hex_w=2.5;
m3_nut_din934_w=5.5+hole_widen;
m3_nut_din934_h=2.4;

m4_d=4.2+hole_widen;

// MakerBot Cupcake Z-Bracket Critical Dimensions
z_bracket_w = 40.0; // Z Bracket Width
z_bracket_l = 40.0; // Z Bracket Length
z_bracket_h = 5.0+2*m3_nut_din934_h;
z_bracket_h_ext = z_bracket_h + mount_height;
z_bracket_corner_r = 2.0; // Z Bracket Corner Radius

module Nut_Hole_2D(w=1.0) {
    intersection_for(i=[0:2]) {
        rotate([0,0,360*i/3]) square(size=[2*w,w],center=true);
    }
}


module TearDrop_Truncated_2D(diameter=1.0) {
    $fa=15.0;
    $fs=0.1;
    difference() {
        union() {
            circle(r=diameter/2);
            rotate(45) square(size=diameter/2,center=false);
        }
        translate([-diameter/2,diameter/2]) square(size=diameter);
    }
}

module Z_Bracket_Holes_2D() {
    $fa=15.0;
    $fs=0.1;
    union() {

    }
}


module Z_Bracket_ext() {
    $fa=15.0;
    $fs=0.1;
    difference() {
        union() {
            square(size=[z_bracket_w-2*z_bracket_corner_r,z_bracket_l],center=true);
            square(size=[z_bracket_w,z_bracket_l-2*z_bracket_corner_r],center=true);
            translate([z_bracket_w/2-z_bracket_corner_r,z_bracket_w/2-z_bracket_corner_r])
                circle(r=z_bracket_corner_r,center=true);
            translate([z_bracket_w/2-z_bracket_corner_r,-(z_bracket_w/2-z_bracket_corner_r)])
                circle(r=z_bracket_corner_r,center=true);
            translate([-(z_bracket_w/2-z_bracket_corner_r),-(z_bracket_w/2-z_bracket_corner_r)])
                circle(r=z_bracket_corner_r,center=true);
            translate([-(z_bracket_w/2-z_bracket_corner_r),z_bracket_w/2-z_bracket_corner_r])
                circle(r=z_bracket_corner_r,center=true);
        }
        // gennemgående hul til akse
        circle(r=bearing_608_od/2-3,center=true);
    }
}


module Z_Bracket_2D() {
    $fa=15.0;
    $fs=0.1;
    difference() {
        union() {
            square(size=[z_bracket_w-2*z_bracket_corner_r,z_bracket_l],center=true);
            square(size=[z_bracket_w,z_bracket_l-2*z_bracket_corner_r],center=true);
            translate([z_bracket_w/2-z_bracket_corner_r,z_bracket_w/2-z_bracket_corner_r])
                circle(r=z_bracket_corner_r,center=true);
            translate([z_bracket_w/2-z_bracket_corner_r,-(z_bracket_w/2-z_bracket_corner_r)])
                circle(r=z_bracket_corner_r,center=true);
            translate([-(z_bracket_w/2-z_bracket_corner_r),-(z_bracket_w/2-z_bracket_corner_r)])
                circle(r=z_bracket_corner_r,center=true);
            translate([-(z_bracket_w/2-z_bracket_corner_r),z_bracket_w/2-z_bracket_corner_r])
                circle(r=z_bracket_corner_r,center=true);
        }
        // gennemgående hul til akse
        circle(r=bearing_608_od/2,center=true);
    }
}

module Z_Bracket_Simple_Nut(extension=0.1) {
    $fa=15.0;
    $fs=0.1;
    difference() {
        union(){
            translate([0,0,mount_height])
                linear_extrude(height=z_bracket_h_ext, center=false, convexity=10)
                Z_Bracket_2D();
            linear_extrude(height=mount_height, center=false, convexity=10)
                Z_Bracket_ext();
        }
        // konveks udskæring i toppen
        translate([0,0,z_bracket_h_ext-m3_nut_din934_h+mount_height])
            cylinder(r1=bearing_608_od/2
                     , r2=bearing_608_od/2+m3_nut_din934_h
                     , h=2*m3_nut_din934_h
                     , center=false);
        for(i=[0:1]) {
            translate([0,0,z_bracket_h/2+mount_height]) rotate([90,0,360*i/2]) {
                // møtrikhul til fastmontering af leje
                linear_extrude(height=bearing_608_od/2+m3_nut_din934_h+0.1, center=false, convexity=10)
                    Nut_Hole_2D(w=m3_nut_din934_w);
                // gennemgående hul til fastmomtering af leje
                linear_extrude(height=z_bracket_w,center=false, convexity=10)
                    circle(r=m3_d/2+0.1);
                // hul til bolthoved til fastmontering af leje
                translate([0,0,z_bracket_w/2-m3_scs_head_h])
                    linear_extrude(height=m3_scs_head_h+0.1,center=false,convexity=10)
                    TearDrop_Truncated_2D(diameter=m3_scs_head_d);
            }
        }
        // huller til montering af plader
        translate([plate_mount_x_offset,0,z_bracket_h/2+mount_height]) rotate([90,0,0]) {
            linear_extrude(height=z_bracket_w,center=true, convexity=10)
                circle(r=m4_d/2+0.1);
        }
        translate([-plate_mount_x_offset,0,z_bracket_h/2+mount_height]) rotate([90,0,0]) {
            linear_extrude(height=z_bracket_w,center=true, convexity=10)
                circle(r=m4_d/2+0.1);
        }
    }
}

Z_Bracket_Simple_Nut();
