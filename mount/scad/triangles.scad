angle = 45;
Diag = 200; 			// Diagonal mm
B = cos(angle)*Diag;
H = sin(angle)*Diag;
echo("H",H,"B",B);

hD = 3.5;				// hole diameter mm
rEdges = 10;			// rounded edges

plate_thk = 10;

bracket_W = 80;				// bracket width mm
bracket_H = 80;				// bracket height mm
bracket_dV = 60;				// dist between holes vertical
bracket_dH = 60;				// dist between holes horizon tal
bracket_thk = 20;				// bracket thickness

p1 = [0+rEdges, 0+rEdges];
p2 = [B-rEdges, 0+rEdges];
p3 = [B-rEdges, H-rEdges];

rot = -angle;			// rotation of tilded coordinate system
// points in tilded coords
Ra1x_tilde = plate_thk*3;
Ra1y_tilde = -plate_thk/2;
Ra2x_tilde = Diag-3*plate_thk;
Ra2y_tilde = -plate_thk/2;
// transform
Ra1x = cos(rot)*Ra1x_tilde+sin(rot)*Ra1y_tilde;
Ra1y = -sin(rot)*Ra1x_tilde+cos(rot)*Ra1y_tilde;
Ra2x = cos(rot)*Ra2x_tilde+sin(rot)*Ra2y_tilde;
Ra2y = -sin(rot)*Ra2x_tilde+cos(rot)*Ra2y_tilde;

echo("Ra1",Ra1x,Ra1y);
echo("Ra2",Ra2x,Ra2y);


    difference() {
	// create 2d triangles
	minkowski() {
	    polygon(points = [ p1, p2, p3 ]);
	    circle(r=rEdges);
	    }
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
}
