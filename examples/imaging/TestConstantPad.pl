#!/usr/local/bin/perl -w
#
use Graphics::VTK;

$VTK_DATA = 0;
$VTK_DATA = $ENV{VTK_DATA};
# Make an image larger by repeating the data.  Tile.
#source vtkImageInclude.tcl
$reader = Graphics::VTK::ImageReader->new;
$reader->SetDataByteOrderToLittleEndian;
$reader->SetDataExtent(0,255,0,255,1,93);
$reader->SetFilePrefix("$VTK_DATA/fullHead/headsq");
$reader->SetDataMask(0x7fff);
#reader ReleaseDataFlagOff
#reader DebugOn
$pad = Graphics::VTK::ImageConstantPad->new;
$pad->SetInput($reader->GetOutput);
$pad->SetOutputWholeExtent(-100,355,-100,370,0,92);
$pad->SetConstant(800);
$pad->SetNumberOfThreads(1);
$pad->ReleaseDataFlagOff;
$viewer = Graphics::VTK::ImageViewer->new;
$viewer->SetInput($pad->GetOutput);
$viewer->SetZSlice(22);
$viewer->SetColorWindow(1200);
$viewer->SetColorLevel(600);
$viewer->GetActor2D->SetDisplayPosition(100,100);
#viewer DebugOn
# make interface
do 'WindowLevelInterface.pl';
