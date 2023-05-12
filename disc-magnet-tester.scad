include <BOSL2/std.scad>
include <BOSL2/strings.scad>

// so far only tested with 6x2mm

$fn=100;

module magnet_holder_testing_grid_with_plate(diameter, depth, step_size, rows, cols) {
    difference() {
        down(depth/2)
        fwd(diameter/2)
        magnet_holder_plate(diameter, depth, step_size, rows, cols);
        magnet_holder_testing_grid(diameter, depth, step_size, rows, cols);
    }
}

module magnet_holder_plate(diameter, depth, step_size, rows, cols) {
        down(step_size)
        cube([diameter * rows * 3, diameter * cols * 3, depth * 2], anchor=([0,0,0]));
}

module magnet_holder_testing_grid(diameter, depth, step_size, rows, cols) {
    num_copies = rows*cols;
    even_rows = (rows % 2) == 0;
    even_cols = (cols % 2) == 0;

    height_delta = (rows / 2) * step_size - (even_rows ?  step_size/2 : 0);
    diameter_delta = (cols / 2) * step_size - (even_cols ?  step_size/2 : 0);

    _hs = -height_delta;
    _ds = -diameter_delta;

    grid_copies(n=[rows, cols], spacing=[diameter * 3, diameter * 3])
            magnet_holder(_ds + diameter + (step_size * $col),
            _hs + depth + (step_size * $row));
}

module magnet_holder(diameter, depth) {
    cylinder(r=diameter/2, h=depth, center=true)
        position(FRONT)
            fwd(diameter)
            left(diameter + diameter/2)
            up(depth/4)
                text3d(str(format_fixed(diameter,2),"x",format_fixed(depth,2)), size=diameter/2.2, h=depth);
}

magnet_holder_testing_grid_with_plate(6, 2, .1, 5, 5);
