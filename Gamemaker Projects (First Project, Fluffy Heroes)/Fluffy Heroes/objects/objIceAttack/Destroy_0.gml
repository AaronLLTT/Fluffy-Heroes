/// @description Create Shatter
var dir = -1;
if (direction == 0) {
	dir = 1;
}
instance_create_depth(x + (dir * 10), y, depth - 1, objIceShatter);