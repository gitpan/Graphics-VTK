#!/usr/local/bin/perl -w
#
use Graphics::VTK;



use Tk;
use Graphics::VTK::Tk;
$MW = Tk::MainWindow->new;

## Display a rectilinear grid and some common visualization techniques
##
$VTK_DATA = 0;
$VTK_DATA = $ENV{VTK_DATA};
# get the interactor ui
use Graphics::VTK::Tk::vtkInt;
use Graphics::VTK::Colors;
#source $VTK_TCL/vtkInclude.tcl
# create pipeline
$reader = Graphics::VTK::DataSetReader->new;
$reader->SetFileName("$VTK_DATA/RectGrid.vtk");
$reader->Update;
$toRectilinearGrid = Graphics::VTK::CastToConcrete->new;
$toRectilinearGrid->SetInput($reader->GetOutput);
$plane = Graphics::VTK::RectilinearGridGeometryFilter->new;
$plane->SetInput($toRectilinearGrid->GetRectilinearGridOutput);
$plane->SetExtent(0,100,0,100,15,15);
$warper = Graphics::VTK::WarpVector->new;
$warper->SetInput($plane->GetOutput);
$warper->SetScaleFactor(0.05);
$planeMapper = Graphics::VTK::DataSetMapper->new;
$planeMapper->SetInput($warper->GetOutput);
$planeMapper->SetScalarRange(0.197813,0.710419);
$planeActor = Graphics::VTK::Actor->new;
$planeActor->SetMapper($planeMapper);
$cutPlane = Graphics::VTK::Plane->new;
$cutPlane->SetOrigin($reader->GetOutput->GetCenter);
$cutPlane->SetNormal(1,0,0);
$planeCut = Graphics::VTK::Cutter->new;
$planeCut->SetInput($toRectilinearGrid->GetRectilinearGridOutput);
$planeCut->SetCutFunction($cutPlane);
$cutMapper = Graphics::VTK::DataSetMapper->new;
$cutMapper->SetInput($planeCut->GetOutput);
$cutMapper->SetScalarRange($reader->GetOutput->GetPointData->GetScalars->GetRange);
$cutActor = Graphics::VTK::Actor->new;
$cutActor->SetMapper($cutMapper);
$iso = Graphics::VTK::ContourFilter->new;
$iso->SetInput($toRectilinearGrid->GetRectilinearGridOutput);
$iso->SetValue(0,0.7);
$normals = Graphics::VTK::PolyDataNormals->new;
$normals->SetInput($iso->GetOutput);
$normals->SetFeatureAngle(45);
$isoMapper = Graphics::VTK::PolyDataMapper->new;
$isoMapper->SetInput($normals->GetOutput);
$isoMapper->ScalarVisibilityOff;
$isoActor = Graphics::VTK::Actor->new;
$isoActor->SetMapper($isoMapper);
$isoActor->GetProperty->SetColor(@Graphics::VTK::Colors::bisque);
$isoActor->GetProperty->SetRepresentationToWireframe;
$streamer = Graphics::VTK::StreamLine->new;
$streamer->SetInput($reader->GetOutput);
$streamer->SetStartPosition(-1.2,-0.1,1.3);
$streamer->SetMaximumPropagationTime(500);
$streamer->SetStepLength(0.05);
$streamer->SetIntegrationStepLength(0.05);
$streamer->SetIntegrationDirectionToIntegrateBothDirections;
$streamer->Update;
$streamTube = Graphics::VTK::TubeFilter->new;
$streamTube->SetInput($streamer->GetOutput);
$streamTube->SetRadius(0.025);
$streamTube->SetNumberOfSides(6);
$streamTube->SetVaryRadius($Graphics::VTK::VARY_RADIUS_BY_VECTOR);
$mapStreamTube = Graphics::VTK::PolyDataMapper->new;
$mapStreamTube->SetInput($streamTube->GetOutput);
$mapStreamTube->SetScalarRange($reader->GetOutput->GetPointData->GetScalars->GetRange);
$streamTubeActor = Graphics::VTK::Actor->new;
$streamTubeActor->SetMapper($mapStreamTube);
$streamTubeActor->GetProperty->BackfaceCullingOn;
$outline = Graphics::VTK::OutlineFilter->new;
$outline->SetInput($toRectilinearGrid->GetRectilinearGridOutput);
$outlineMapper = Graphics::VTK::PolyDataMapper->new;
$outlineMapper->SetInput($outline->GetOutput);
$outlineActor = Graphics::VTK::Actor->new;
$outlineActor->SetMapper($outlineMapper);
$outlineActor->GetProperty->SetColor(@Graphics::VTK::Colors::black);
# Graphics stuff
# Create the RenderWindow, Renderer and both Actors
$ren1 = Graphics::VTK::Renderer->new;
$renWin = Graphics::VTK::RenderWindow->new;
$renWin->AddRenderer($ren1);
$iren = Graphics::VTK::RenderWindowInteractor->new;
$iren->SetRenderWindow($renWin);
# Add the actors to the renderer, set the background and size
$ren1->AddActor($outlineActor);
$ren1->AddActor($planeActor);
$ren1->AddActor($cutActor);
$ren1->AddActor($isoActor);
$ren1->AddActor($streamTubeActor);
$ren1->SetBackground(1,1,1);
$renWin->SetSize(400,400);
$cam1 = $ren1->GetActiveCamera;
$cam1->SetClippingRange(1.04427,52.2137);
$cam1->SetFocalPoint(0.106213,0.0196539,2.10569);
$cam1->SetPosition(-7.34153,4.54201,7.86157);
$cam1->ComputeViewPlaneNormal;
$cam1->SetViewUp(0.113046,0.847094,-0.519281);
$iren->Initialize;
# render the image
$iren->SetUserMethod(
 sub
  {
   $MW->{'.vtkInteract'}->deiconify;
  }
);
#renWin SetFileName "valid/rectGrid.tcl.ppm"
#renWin SaveImageAsPPM
# prevent the tk window from showing up then start the event loop
$MW->withdraw;
Graphics::VTK::Tk::vtkInt::vtkInteract($MW);

Tk->MainLoop;
