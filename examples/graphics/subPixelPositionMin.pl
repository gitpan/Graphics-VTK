#!/usr/local/bin/perl -w
#
use Graphics::VTK;



use Tk;
use Graphics::VTK::Tk;
$MW = Tk::MainWindow->new;

# Test sub pixel positioning (A round about way of getting an iso surface.)
# See cubed sphere for the surface before sub pixel poisitioning.
$VTK_DATA = 0;
$VTK_DATA = $ENV{VTK_DATA};
use Graphics::VTK::Tk::vtkInt;
$sphere = Graphics::VTK::Sphere->new;
$sphere->SetCenter(1,1,1);
$sphere->SetRadius(0.9);
$sample = Graphics::VTK::SampleFunction->new;
$sample->SetImplicitFunction($sphere);
$sample->SetModelBounds(0,2,0,2,0,2);
$sample->SetSampleDimensions(30,30,30);
$sample->ComputeNormalsOff;
$threshold = Graphics::VTK::Threshold->new;
$threshold->SetInput($sample->GetOutput);
$threshold->ThresholdByLower(0.001);
$geometry = Graphics::VTK::GeometryFilter->new;
$geometry->SetInput($threshold->GetOutput);
$grad = Graphics::VTK::ImageGradient->new;
$grad->SetDimensionality(3);
$grad->SetInput($sample->GetOutput);
$mult = Graphics::VTK::ImageMathematics->new;
$mult->SetOperationToMultiply;
$mult->SetInput1($sample->GetOutput);
$mult->SetInput2($sample->GetOutput);
$itosp = Graphics::VTK::ImageToStructuredPoints->new;
$itosp->SetInput($mult->GetOutput);
$itosp->SetVectorInput($grad->GetOutput);
$sub = Graphics::VTK::SubPixelPositionEdgels->new;
$sub->SetInput($geometry->GetOutput);
$sub->SetGradMaps($itosp->GetOutput);
$mapper = Graphics::VTK::DataSetMapper->new;
$mapper->SetInput($sub->GetOutput);
$actor = Graphics::VTK::Actor->new;
$actor->SetMapper($mapper);
# Create renderer stuff
$ren1 = Graphics::VTK::Renderer->new;
$renWin = Graphics::VTK::RenderWindow->new;
$renWin->AddRenderer($ren1);
$iren = Graphics::VTK::RenderWindowInteractor->new;
$iren->SetRenderWindow($renWin);
# Add the actors to the renderer, set the background and size
$ren1->AddActor($actor);
$ren1->GetActiveCamera->Azimuth(20);
$ren1->GetActiveCamera->Elevation(30);
$ren1->SetBackground(0.1,0.2,0.4);
$renWin->SetSize(450,450);
# render the image
$iren->SetUserMethod(
 sub
  {
   $MW->{'.vtkInteract'}->deiconify;
  }
);
$cam1 = $ren1->GetActiveCamera;
$cam1->Zoom(1.4);
$iren->Initialize;
#renWin SetFileName "valid/imageWarp.tcl.ppm"
#renWin SaveImageAsPPM
# prevent the tk window from showing up then start the event loop
$MW->withdraw;
Graphics::VTK::Tk::vtkInt::vtkInteract($MW);

Tk->MainLoop;
