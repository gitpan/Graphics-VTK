#!/usr/local/bin/perl -w
#
use Graphics::VTK;



use Tk;
use Graphics::VTK::Tk;
$MW = Tk::MainWindow->new;

# This example demonstrate the use of VTK data arrays as attribute
# data as well as field data. It creates geometry (vtkPolyData) as
# well as attribute data explicitly.

$VTK_DATA_ROOT = 0;
$VTK_DATA_ROOT = $ENV{VTK_DATA_ROOT};
use Graphics::VTK::Tk::vtkInt;

# Create a float array which represents the points.
$pcoords = Graphics::VTK::FloatArray->new;
# Note that by default, an array has 1 component.
# We have to change it to 3 for points
$pcoords->SetNumberOfComponents(3);
# We ask pcoords to allocate room for at least 4 tuples
# and set the number of tuples to 4.
$pcoords->SetNumberOfTuples(4);
# Assign each tuple. There are 5 specialized versions of SetTuple:
# SetTuple1 SetTuple2 SetTuple3 SetTuple4 SetTuple9
# These take 1, 2, 3, 4 and 9 components respectively.
$pcoords->SetTuple3(0,0.0,0.0,0.0);
$pcoords->SetTuple3(1,0.0,1.0,0.0);
$pcoords->SetTuple3(2,1.0,0.0,0.0);
$pcoords->SetTuple3(3,1.0,1.0,0.0);

# Create vtkPoints and assign pcoords as the internal data array.
$points = Graphics::VTK::Points->new;
$points->SetData($pcoords);

# Create the cells. In this case, a triangle strip with 2 triangles
# (which can be represented by 4 points)
$strips = Graphics::VTK::CellArray->new;
$strips->InsertNextCell(4);
$strips->InsertCellPoint(0);
$strips->InsertCellPoint(1);
$strips->InsertCellPoint(2);
$strips->InsertCellPoint(3);

# Create an integer array with 4 tuples. Note that when using
# InsertNextValue (or InsertNextTuple1 which is equivalent in
# this situation), the array will expand automatically
$temperature = Graphics::VTK::IntArray->new;
$temperature->SetName("Temperature");
$temperature->InsertNextValue(10);
$temperature->InsertNextValue(20);
$temperature->InsertNextValue(30);
$temperature->InsertNextValue(40);

# Create a double array.
$vorticity = Graphics::VTK::DoubleArray->new;
$vorticity->SetName("Vorticity");
$vorticity->InsertNextValue(2.7);
$vorticity->InsertNextValue(4.1);
$vorticity->InsertNextValue(5.3);
$vorticity->InsertNextValue(3.4);

# Create the dataset. In this case, we create a vtkPolyData
$polydata = Graphics::VTK::PolyData->new;
# Assign points and cells
$polydata->SetPoints($points);
$polydata->SetStrips($strips);
# Assign scalars
$polydata->GetPointData->SetScalars($temperature);
# Add the vorticity array. In this example, this field
# is not used.
$polydata->GetPointData->AddArray($vorticity);

# Create the mapper and set the appropriate scalar range
# (default is (0,1)
$mapper = Graphics::VTK::PolyDataMapper->new;
$mapper->SetInput($polydata);
$mapper->SetScalarRange(0,40);

# Create an actor.
$actor = Graphics::VTK::Actor->new;
$actor->SetMapper($mapper);

# Create the rendering objects.
$ren = Graphics::VTK::Renderer->new;
$ren->AddActor($actor);

$renWin = Graphics::VTK::RenderWindow->new;
$renWin->AddRenderer($ren);

$iren = Graphics::VTK::RenderWindowInteractor->new;
$iren->SetRenderWindow($renWin);
$iren->AddObserver('UserEvent',
 sub
  {
   $MW->{'.vtkInteract'}->deiconify;
  }
);
$iren->Initialize;

$MW->withdraw;
Graphics::VTK::Tk::vtkInt::vtkInteract($MW);

Tk->MainLoop;
