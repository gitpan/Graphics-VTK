#!/usr/local/bin/perl -w
#
use Graphics::VTK;

# this file replicates definitions in classes for tcl.
$VTK_VOID = 0;
$VTK_BIT = 1;
$VTK_CHAR = 2;
$Graphics::VTK::UNSIGNED_CHAR = 3;
$VTK_SHORT = 4;
$VTK_UNSIGNED_SHORT = 5;
$VTK_INT = 6;
$VTK_UNSIGNED_INT = 7;
$VTK_LONG = 8;
$VTK_UNSIGNED_LONG = 9;
$Graphics::VTK::FLOAT = 10;
$VTK_DOUBLE = 11;
$VTK_IMAGE_X_AXIS = 0;
$VTK_IMAGE_Y_AXIS = 1;
$VTK_IMAGE_Z_AXIS = 2;
$VTK_CLAW_NEAREST_NETWORK = 0;
$VTK_CLAW_NEAREST_MINIMUM = 1;
$VTK_CLAW_NEAREST_GLOBAL = 2;
$VTK_CLAW_PIONEER_LOCAL = 3;
$VTK_CLAW_PIONEER_GLOBAL = 4;
$VTK_CLAW_WELL_NOISE = 6;
$VTK_CLAW_WELL_DIRECTED_NOISE = 7;
$VTK_CLAW_MINIMUM_WELL = 8;
$VTK_CLAW_INSERT = 9;
$VTK_CLAW_NARROW_WEL = 10;