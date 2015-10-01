$fa=15.0;
$fs=0.1;

Diag = 300; 			// triangle diagonal mm
hD = 3.5;			// hole diameter mm
plate_thk = 10;

// afstand fra center(z-aksen) til midten af monteringshuller
plate_mount_z_offset = 15;
// afstand fra enden af pladen til midten af monteringshuller(eg. den halve
// højde af bearing-beslaget). Det er ikke mig der har valgt af beregne midten
// således
plate_mount_x_offset = (5+2*3)/2+4;


bracket_W = 40;				// bracket width mm
bracket_H = 40;				// bracket height mm
bracket_dV = 30;			// dist between holes vertical
bracket_dH = 30;			// dist between holes horizon tal
bracket_thk = 20;			// bracket thickness

difference() {
    // create 2d plate
    square([Diag,bracket_W], center = true);

    // holes for mounting the bearing brackets
    for(i=[0,1]){
        translate([Diag/2-plate_mount_x_offset,pow(-1,i)*plate_mount_z_offset,0]) {
            circle(r=hD/2+0.1);
        }
    }
    for(i=[0,1]){
        translate([-Diag/2+plate_mount_x_offset,pow(-1,i)*plate_mount_z_offset,0]) {
            circle(r=hD/2+0.1);
        }
    }
    /*
     * skal måske bruges?
    // azimuth shaft mount
    union() {
	translate([B*2/3-bracket_dH/2,bracket_thk/2,0]) circle(r=hD/2.0, $fn=50);
	translate([B*2/3+bracket_dH/2,bracket_thk/2,0]) circle(r=hD/2.0, $fn=50);
    }
    
    // Ra shaft mount
    union() {
	translate([Ra1x,Ra1y,0]) circle(r=hD/2.0, $fn=50);
	translate([Ra2x,Ra2y,0]) circle(r=hD/2.0, $fn=50);
    }
    */
}
