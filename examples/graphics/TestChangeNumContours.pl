#!/usr/local/bin/perl -w
#
use Graphics::VTK;



use Tk;
use Graphics::VTK::Tk;
$MW = Tk::MainWindow->new;

$VTK_DATA = 0;
$VTK_DATA = $ENV{VTK_DATA};
# get the interactor ui
use Graphics::VTK::Tk::vtkInt;
use Graphics::VTK::Colors;
# Create the RenderWindow, Renderer and both Actors
$ren1 = Graphics::VTK::Renderer->new;
$renWin = Graphics::VTK::RenderWindow->new;
$renWin->AddRenderer($ren1);
$iren = Graphics::VTK::RenderWindowInteractor->new;
$iren->SetRenderWindow($renWin);
# create pipeline
$v16 = Graphics::VTK::Volume16Reader->new;
$v16->SetDataDimensions(128,128);
$v16->GetOutput->SetOrigin(0.0,0.0,0.0);
$v16->SetDataByteOrderToLittleEndian;
$v16->SetFilePrefix("$VTK_DATA/headsq/half");
$v16->SetImageRange(45,45);
$v16->SetDataSpacing(1.6,1.6,1.5);
$iso = Graphics::VTK::ContourFilter->new;
$iso->SetInput($v16->GetOutput);
$iso->SetNumberOfContours(50);
$val = 100;
for ($i = 0; $i < 50; $i += 1)
 {
  $iso->SetValue($i,$val);
  $val += 20;
 }
$isoMapper = Graphics::VTK::PolyDataMapper->new;
$isoMapper->SetInput($iso->GetOutput);
$isoMapper->ScalarVisibilityOff;
$isoActor = Graphics::VTK::Actor->new;
$isoActor->SetMapper($isoMapper);
$isoActor->GetProperty->SetColor(@Graphics::VTK::Colors::black);
$outline = Graphics::VTK::OutlineFilter->new;
$outline->SetInput($v16->GetOutput);
$outlineMapper = Graphics::VTK::PolyDataMapper->new;
$outlineMapper->SetInput($outline->GetOutput);
$outlineActor = Graphics::VTK::Actor->new;
$outlineActor->SetMapper($outlineMapper);
# Add the actors to the renderer, set the background and size
$ren1->AddActor($outlineActor);
$ren1->AddActor($isoActor);
$renWin->SetSize(500,500);
$ren1->SetBackground(0.1,0.2,0.4);
# prevent the tk window from showing up then start the event loop
$MW->withdraw;
$renWin->Render;
$iso->SetNumberOfContours(60);
for ((); $i < 60; $i += 1)
 {
  $iso->SetValue($i,$val);
  $val += 20;
 }
$renWin->Render;
$iso->SetNumberOfContours(70);
for ((); $i < 70; $i += 1)
 {
  $iso->SetValue($i,$val);
  $val += 20;
 }
$renWin->Render;
#renWin SetFileName "TestChangeNumContours.tcl.ppm"
#renWin SaveImageAsPPM
$iren->SetUserMethod(
 sub
  {
   $MW->{'.vtkInteract'}->deiconify;
  }
);
Graphics::VTK::Tk::vtkInt::vtkInteract($MW);

Tk->MainLoop;
