#!/usr/local/bin/perl -w
#
use Graphics::VTK;



use Tk;
use Graphics::VTK::Tk;
$MW = Tk::MainWindow->new;

$VTK_DATA = 0;
$VTK_DATA = $ENV{VTK_DATA};
# Demonstrates all cell types
# NOTE: the use of MakeObject is included to increase regression coverage.
# It is not required in most applications.
# get the interactor ui
use Graphics::VTK::Tk::vtkInt;
use Graphics::VTK::Colors;
$ren1 = Graphics::VTK::Renderer->new;
$renWin = Graphics::VTK::RenderWindow->new;
$renWin->AddRenderer($ren1);
$iren = Graphics::VTK::RenderWindowInteractor->new;
$iren->SetRenderWindow($renWin);
# create a scene with one of each cell type
$voxelPoints = Graphics::VTK::Points->new;
$voxelPoints->SetNumberOfPoints(8);
$voxelPoints->InsertPoint(0,0,0,0);
$voxelPoints->InsertPoint(1,1,0,0);
$voxelPoints->InsertPoint(2,0,1,0);
$voxelPoints->InsertPoint(3,1,1,0);
$voxelPoints->InsertPoint(4,0,0,1);
$voxelPoints->InsertPoint(5,1,0,1);
$voxelPoints->InsertPoint(6,0,1,1);
$voxelPoints->InsertPoint(7,1,1,1);
$aVoxel = Graphics::VTK::Voxel->new;
$aVoxel->GetPointIds->SetId(0,0);
$aVoxel->GetPointIds->SetId(1,1);
$aVoxel->GetPointIds->SetId(2,2);
$aVoxel->GetPointIds->SetId(3,3);
$aVoxel->GetPointIds->SetId(4,4);
$aVoxel->GetPointIds->SetId(5,5);
$aVoxel->GetPointIds->SetId(6,6);
$aVoxel->GetPointIds->SetId(7,7);
$Grid{'aVoxel'} = Graphics::VTK::UnstructuredGrid->new;
$Grid{'aVoxel'}->Allocate(1,1);
$Grid{'aVoxel'}->InsertNextCell($aVoxel->GetCellType,$aVoxel->GetPointIds);
$Grid{'aVoxel'}->SetPoints($voxelPoints);
$aVoxelMapper = Graphics::VTK::DataSetMapper->new;
$aVoxelMapper->SetInput($Grid{'aVoxel'});
$Actor{'aVoxel'} = Graphics::VTK::Actor->new;
$Actor{'aVoxel'}->SetMapper($aVoxelMapper);
$Actor{'aVoxel'}->GetProperty->BackfaceCullingOn;
$hexahedronPoints = Graphics::VTK::Points->new;
$hexahedronPoints->SetNumberOfPoints(8);
$hexahedronPoints->InsertPoint(0,0,0,0);
$hexahedronPoints->InsertPoint(1,1,0,0);
$hexahedronPoints->InsertPoint(2,1,1,0);
$hexahedronPoints->InsertPoint(3,0,1,0);
$hexahedronPoints->InsertPoint(4,0,0,1);
$hexahedronPoints->InsertPoint(5,1,0,1);
$hexahedronPoints->InsertPoint(6,1,1,1);
$hexahedronPoints->InsertPoint(7,0,1,1);
$aHexahedron = Graphics::VTK::Hexahedron->new;
$aHexahedron->GetPointIds->SetId(0,0);
$aHexahedron->GetPointIds->SetId(1,1);
$aHexahedron->GetPointIds->SetId(2,2);
$aHexahedron->GetPointIds->SetId(3,3);
$aHexahedron->GetPointIds->SetId(4,4);
$aHexahedron->GetPointIds->SetId(5,5);
$aHexahedron->GetPointIds->SetId(6,6);
$aHexahedron->GetPointIds->SetId(7,7);
$Grid{'aHexahedron'} = Graphics::VTK::UnstructuredGrid->new;
$Grid{'aHexahedron'}->Allocate(1,1);
$Grid{'aHexahedron'}->InsertNextCell($aHexahedron->GetCellType,$aHexahedron->GetPointIds);
$Grid{'aHexahedron'}->SetPoints($hexahedronPoints);
$aHexahedronMapper = Graphics::VTK::DataSetMapper->new;
$aHexahedronMapper->SetInput($Grid{'aHexahedron'});
$Actor{'aHexahedron'} = Graphics::VTK::Actor->new;
$Actor{'aHexahedron'}->SetMapper($aHexahedronMapper);
$Actor{'aHexahedron'}->AddPosition(2,0,0);
$Actor{'aHexahedron'}->GetProperty->BackfaceCullingOn;
$tetraPoints = Graphics::VTK::Points->new;
$tetraPoints->SetNumberOfPoints(4);
$tetraPoints->InsertPoint(0,0,0,0);
$tetraPoints->InsertPoint(1,1,0,0);
$tetraPoints->InsertPoint(2,'.5',1,0);
$tetraPoints->InsertPoint(3,'.5','.5',1);
$aTetra = Graphics::VTK::Tetra->new;
$aTetra->GetPointIds->SetId(0,0);
$aTetra->GetPointIds->SetId(1,1);
$aTetra->GetPointIds->SetId(2,2);
$aTetra->GetPointIds->SetId(3,3);
$Grid{'aTetra'} = Graphics::VTK::UnstructuredGrid->new;
$Grid{'aTetra'}->Allocate(1,1);
$Grid{'aTetra'}->InsertNextCell($aTetra->GetCellType,$aTetra->GetPointIds);
$Grid{'aTetra'}->SetPoints($tetraPoints);
$aTetraMapper = Graphics::VTK::DataSetMapper->new;
$aTetraMapper->SetInput($Grid{'aTetra'});
$Actor{'aTetra'} = Graphics::VTK::Actor->new;
$Actor{'aTetra'}->SetMapper($aTetraMapper);
$Actor{'aTetra'}->AddPosition(4,0,0);
$Actor{'aTetra'}->GetProperty->BackfaceCullingOn;
$wedgePoints = Graphics::VTK::Points->new;
$wedgePoints->SetNumberOfPoints(6);
$wedgePoints->InsertPoint(0,0,1,0);
$wedgePoints->InsertPoint(1,0,0,0);
$wedgePoints->InsertPoint(2,0,'.5','.5');
$wedgePoints->InsertPoint(3,1,1,0);
$wedgePoints->InsertPoint(4,1,0,0);
$wedgePoints->InsertPoint(5,1,'.5','.5');
$aWedge = Graphics::VTK::Wedge->new;
$aWedge->GetPointIds->SetId(0,0);
$aWedge->GetPointIds->SetId(1,1);
$aWedge->GetPointIds->SetId(2,2);
$aWedge->GetPointIds->SetId(3,3);
$aWedge->GetPointIds->SetId(4,4);
$aWedge->GetPointIds->SetId(5,5);
$Grid{'aWedge'} = Graphics::VTK::UnstructuredGrid->new;
$Grid{'aWedge'}->Allocate(1,1);
$Grid{'aWedge'}->InsertNextCell($aWedge->GetCellType,$aWedge->GetPointIds);
$Grid{'aWedge'}->SetPoints($wedgePoints);
$aWedgeMapper = Graphics::VTK::DataSetMapper->new;
$aWedgeMapper->SetInput($Grid{'aWedge'});
$Actor{'aWedge'} = Graphics::VTK::Actor->new;
$Actor{'aWedge'}->SetMapper($aWedgeMapper);
$Actor{'aWedge'}->AddPosition(6,0,0);
$Actor{'aWedge'}->GetProperty->BackfaceCullingOn;
$pyramidPoints = Graphics::VTK::Points->new;
$pyramidPoints->SetNumberOfPoints(5);
$pyramidPoints->InsertPoint(0,0,0,0);
$pyramidPoints->InsertPoint(1,1,0,0);
$pyramidPoints->InsertPoint(2,1,1,0);
$pyramidPoints->InsertPoint(3,0,1,0);
$pyramidPoints->InsertPoint(4,'.5','.5',1);
$aPyramid = Graphics::VTK::Pyramid->new;
$aPyramid->GetPointIds->SetId(0,0);
$aPyramid->GetPointIds->SetId(1,1);
$aPyramid->GetPointIds->SetId(2,2);
$aPyramid->GetPointIds->SetId(3,3);
$aPyramid->GetPointIds->SetId(4,4);
$Grid{'aPyramid'} = Graphics::VTK::UnstructuredGrid->new;
$Grid{'aPyramid'}->Allocate(1,1);
$Grid{'aPyramid'}->InsertNextCell($aPyramid->GetCellType,$aPyramid->GetPointIds);
$Grid{'aPyramid'}->SetPoints($pyramidPoints);
$aPyramidMapper = Graphics::VTK::DataSetMapper->new;
$aPyramidMapper->SetInput($Grid{'aPyramid'});
$Actor{'aPyramid'} = Graphics::VTK::Actor->new;
$Actor{'aPyramid'}->SetMapper($aPyramidMapper);
$Actor{'aPyramid'}->AddPosition(8,0,0);
$Actor{'aPyramid'}->GetProperty->BackfaceCullingOn;
$pixelPoints = Graphics::VTK::Points->new;
$pixelPoints->SetNumberOfPoints(4);
$pixelPoints->InsertPoint(0,0,0,0);
$pixelPoints->InsertPoint(1,1,0,0);
$pixelPoints->InsertPoint(2,0,1,0);
$pixelPoints->InsertPoint(3,1,1,0);
$aPixel = Graphics::VTK::Pixel->new;
$aPixel->GetPointIds->SetId(0,0);
$aPixel->GetPointIds->SetId(1,1);
$aPixel->GetPointIds->SetId(2,2);
$aPixel->GetPointIds->SetId(3,3);
$Grid{'aPixel'} = Graphics::VTK::UnstructuredGrid->new;
$Grid{'aPixel'}->Allocate(1,1);
$Grid{'aPixel'}->InsertNextCell($aPixel->GetCellType,$aPixel->GetPointIds);
$Grid{'aPixel'}->SetPoints($pixelPoints);
$aPixelMapper = Graphics::VTK::DataSetMapper->new;
$aPixelMapper->SetInput($Grid{'aPixel'});
$Actor{'aPixel'} = Graphics::VTK::Actor->new;
$Actor{'aPixel'}->SetMapper($aPixelMapper);
$Actor{'aPixel'}->AddPosition(0,0,2);
$Actor{'aPixel'}->GetProperty->BackfaceCullingOn;
$quadPoints = Graphics::VTK::Points->new;
$quadPoints->SetNumberOfPoints(4);
$quadPoints->InsertPoint(0,0,0,0);
$quadPoints->InsertPoint(1,1,0,0);
$quadPoints->InsertPoint(2,1,1,0);
$quadPoints->InsertPoint(3,0,1,0);
$aQuad = Graphics::VTK::Quad->new;
$aQuad->GetPointIds->SetId(0,0);
$aQuad->GetPointIds->SetId(1,1);
$aQuad->GetPointIds->SetId(2,2);
$aQuad->GetPointIds->SetId(3,3);
$Grid{'aQuad'} = Graphics::VTK::UnstructuredGrid->new;
$Grid{'aQuad'}->Allocate(1,1);
$Grid{'aQuad'}->InsertNextCell($aQuad->GetCellType,$aQuad->GetPointIds);
$Grid{'aQuad'}->SetPoints($quadPoints);
$aQuadMapper = Graphics::VTK::DataSetMapper->new;
$aQuadMapper->SetInput($Grid{'aQuad'});
$Actor{'aQuad'} = Graphics::VTK::Actor->new;
$Actor{'aQuad'}->SetMapper($aQuadMapper);
$Actor{'aQuad'}->AddPosition(2,0,2);
$Actor{'aQuad'}->GetProperty->BackfaceCullingOn;
$trianglePoints = Graphics::VTK::Points->new;
$trianglePoints->SetNumberOfPoints(3);
$trianglePoints->InsertPoint(0,0,0,0);
$trianglePoints->InsertPoint(1,1,0,0);
$trianglePoints->InsertPoint(2,'.5','.5',0);
$triangleTCoords = Graphics::VTK::TCoords->new;
$triangleTCoords->SetNumberOfTCoords(3);
$triangleTCoords->InsertTCoord(0,1,1,1);
$triangleTCoords->InsertTCoord(1,2,2,2);
$triangleTCoords->InsertTCoord(2,3,3,3);
$aTriangle = Graphics::VTK::Triangle->new;
$aTriangle->GetPointIds->SetId(0,0);
$aTriangle->GetPointIds->SetId(1,1);
$aTriangle->GetPointIds->SetId(2,2);
$Grid{'aTriangle'} = Graphics::VTK::UnstructuredGrid->new;
$Grid{'aTriangle'}->Allocate(1,1);
$Grid{'aTriangle'}->InsertNextCell($aTriangle->GetCellType,$aTriangle->GetPointIds);
$Grid{'aTriangle'}->SetPoints($trianglePoints);
$Grid{'aTriangle'}->GetPointData->SetTCoords($triangleTCoords);
$aTriangleMapper = Graphics::VTK::DataSetMapper->new;
$aTriangleMapper->SetInput($Grid{'aTriangle'});
$Actor{'aTriangle'} = Graphics::VTK::Actor->new;
$Actor{'aTriangle'}->SetMapper($aTriangleMapper);
$Actor{'aTriangle'}->AddPosition(4,0,2);
$Actor{'aTriangle'}->GetProperty->BackfaceCullingOn;
$polygonPoints = Graphics::VTK::Points->new;
$polygonPoints->SetNumberOfPoints(4);
$polygonPoints->InsertPoint(0,0,0,0);
$polygonPoints->InsertPoint(1,1,0,0);
$polygonPoints->InsertPoint(2,1,1,0);
$polygonPoints->InsertPoint(3,0,1,0);
$aPolygon = Graphics::VTK::Polygon->new;
$aPolygon->GetPointIds->SetNumberOfIds(4);
$aPolygon->GetPointIds->SetId(0,0);
$aPolygon->GetPointIds->SetId(1,1);
$aPolygon->GetPointIds->SetId(2,2);
$aPolygon->GetPointIds->SetId(3,3);
$Grid{'aPolygon'} = Graphics::VTK::UnstructuredGrid->new;
$Grid{'aPolygon'}->Allocate(1,1);
$Grid{'aPolygon'}->InsertNextCell($aPolygon->GetCellType,$aPolygon->GetPointIds);
$Grid{'aPolygon'}->SetPoints($polygonPoints);
$aPolygonMapper = Graphics::VTK::DataSetMapper->new;
$aPolygonMapper->SetInput($Grid{'aPolygon'});
$Actor{'aPolygon'} = Graphics::VTK::Actor->new;
$Actor{'aPolygon'}->SetMapper($aPolygonMapper);
$Actor{'aPolygon'}->AddPosition(6,0,2);
$Actor{'aPolygon'}->GetProperty->BackfaceCullingOn;
$triangleStripPoints = Graphics::VTK::Points->new;
$triangleStripPoints->SetNumberOfPoints(5);
$triangleStripPoints->InsertPoint(0,0,1,0);
$triangleStripPoints->InsertPoint(1,0,0,0);
$triangleStripPoints->InsertPoint(2,1,1,0);
$triangleStripPoints->InsertPoint(3,1,0,0);
$triangleStripPoints->InsertPoint(4,2,1,0);
$triangleStripTCoords = Graphics::VTK::TCoords->new;
$triangleStripTCoords->SetNumberOfTCoords(3);
$triangleStripTCoords->InsertTCoord(0,1,1,1);
$triangleStripTCoords->InsertTCoord(1,2,2,2);
$triangleStripTCoords->InsertTCoord(2,3,3,3);
$triangleStripTCoords->InsertTCoord(3,4,4,4);
$triangleStripTCoords->InsertTCoord(4,5,5,5);
$aTriangleStrip = Graphics::VTK::TriangleStrip->new;
$aTriangleStrip->GetPointIds->SetNumberOfIds(5);
$aTriangleStrip->GetPointIds->SetId(0,0);
$aTriangleStrip->GetPointIds->SetId(1,1);
$aTriangleStrip->GetPointIds->SetId(2,2);
$aTriangleStrip->GetPointIds->SetId(3,3);
$aTriangleStrip->GetPointIds->SetId(4,4);
$Grid{'aTriangleStrip'} = Graphics::VTK::UnstructuredGrid->new;
$Grid{'aTriangleStrip'}->Allocate(1,1);
$Grid{'aTriangleStrip'}->InsertNextCell($aTriangleStrip->GetCellType,$aTriangleStrip->GetPointIds);
$Grid{'aTriangleStrip'}->SetPoints($triangleStripPoints);
$Grid{'aTriangleStrip'}->GetPointData->SetTCoords($triangleStripTCoords);
$aTriangleStripMapper = Graphics::VTK::DataSetMapper->new;
$aTriangleStripMapper->SetInput($Grid{'aTriangleStrip'});
$Actor{'aTriangleStrip'} = Graphics::VTK::Actor->new;
$Actor{'aTriangleStrip'}->SetMapper($aTriangleStripMapper);
$Actor{'aTriangleStrip'}->AddPosition(8,0,2);
$Actor{'aTriangleStrip'}->GetProperty->BackfaceCullingOn;
$linePoints = Graphics::VTK::Points->new;
$linePoints->SetNumberOfPoints(2);
$linePoints->InsertPoint(0,0,0,0);
$linePoints->InsertPoint(1,1,1,0);
$aLine = Graphics::VTK::Line->new;
$aLine->GetPointIds->SetId(0,0);
$aLine->GetPointIds->SetId(1,1);
$Grid{'aLine'} = Graphics::VTK::UnstructuredGrid->new;
$Grid{'aLine'}->Allocate(1,1);
$Grid{'aLine'}->InsertNextCell($aLine->GetCellType,$aLine->GetPointIds);
$Grid{'aLine'}->SetPoints($linePoints);
$aLineMapper = Graphics::VTK::DataSetMapper->new;
$aLineMapper->SetInput($Grid{'aLine'});
$Actor{'aLine'} = Graphics::VTK::Actor->new;
$Actor{'aLine'}->SetMapper($aLineMapper);
$Actor{'aLine'}->AddPosition(0,0,4);
$Actor{'aLine'}->GetProperty->BackfaceCullingOn;
$polyLinePoints = Graphics::VTK::Points->new;
$polyLinePoints->SetNumberOfPoints(3);
$polyLinePoints->InsertPoint(0,0,0,0);
$polyLinePoints->InsertPoint(1,1,1,0);
$polyLinePoints->InsertPoint(2,1,0,0);
$aPolyLine = Graphics::VTK::PolyLine->new;
$aPolyLine->GetPointIds->SetNumberOfIds(3);
$aPolyLine->GetPointIds->SetId(0,0);
$aPolyLine->GetPointIds->SetId(1,1);
$aPolyLine->GetPointIds->SetId(2,2);
$Grid{'aPolyLine'} = Graphics::VTK::UnstructuredGrid->new;
$Grid{'aPolyLine'}->Allocate(1,1);
$Grid{'aPolyLine'}->InsertNextCell($aPolyLine->GetCellType,$aPolyLine->GetPointIds);
$Grid{'aPolyLine'}->SetPoints($polyLinePoints);
$aPolyLineMapper = Graphics::VTK::DataSetMapper->new;
$aPolyLineMapper->SetInput($Grid{'aPolyLine'});
$Actor{'aPolyLine'} = Graphics::VTK::Actor->new;
$Actor{'aPolyLine'}->SetMapper($aPolyLineMapper);
$Actor{'aPolyLine'}->AddPosition(2,0,4);
$Actor{'aPolyLine'}->GetProperty->BackfaceCullingOn;
$vertexPoints = Graphics::VTK::Points->new;
$vertexPoints->SetNumberOfPoints(1);
$vertexPoints->InsertPoint(0,0,0,0);
$aVertex = Graphics::VTK::Vertex->new;
$aVertex->GetPointIds->SetId(0,0);
$Grid{'aVertex'} = Graphics::VTK::UnstructuredGrid->new;
$Grid{'aVertex'}->Allocate(1,1);
$Grid{'aVertex'}->InsertNextCell($aVertex->GetCellType,$aVertex->GetPointIds);
$Grid{'aVertex'}->SetPoints($vertexPoints);
$aVertexMapper = Graphics::VTK::DataSetMapper->new;
$aVertexMapper->SetInput($Grid{'aVertex'});
$Actor{'aVertex'} = Graphics::VTK::Actor->new;
$Actor{'aVertex'}->SetMapper($aVertexMapper);
$Actor{'aVertex'}->AddPosition(0,0,6);
$Actor{'aVertex'}->GetProperty->BackfaceCullingOn;
$polyVertexPoints = Graphics::VTK::Points->new;
$polyVertexPoints->SetNumberOfPoints(3);
$polyVertexPoints->InsertPoint(0,0,0,0);
$polyVertexPoints->InsertPoint(1,1,0,0);
$polyVertexPoints->InsertPoint(2,1,1,0);
$aPolyVertex = Graphics::VTK::PolyVertex->new;
$aPolyVertex->GetPointIds->SetNumberOfIds(3);
$aPolyVertex->GetPointIds->SetId(0,0);
$aPolyVertex->GetPointIds->SetId(1,1);
$aPolyVertex->GetPointIds->SetId(2,2);
$Grid{'aPolyVertex'} = Graphics::VTK::UnstructuredGrid->new;
$Grid{'aPolyVertex'}->Allocate(1,1);
$Grid{'aPolyVertex'}->InsertNextCell($aPolyVertex->GetCellType,$aPolyVertex->GetPointIds);
$Grid{'aPolyVertex'}->SetPoints($polyVertexPoints);
$aPolyVertexMapper = Graphics::VTK::DataSetMapper->new;
$aPolyVertexMapper->SetInput($Grid{'aPolyVertex'});
$Actor{'aPolyVertex'} = Graphics::VTK::Actor->new;
$Actor{'aPolyVertex'}->SetMapper($aPolyVertexMapper);
$Actor{'aPolyVertex'}->AddPosition(2,0,6);
$Actor{'aPolyVertex'}->GetProperty->BackfaceCullingOn;
$ren1->SetBackground('.1','.2','.4');
$ren1->AddActor($Actor{'aVoxel'});
$Actor{'aVoxel'}->GetProperty->SetDiffuseColor(1,0,0);
$ren1->AddActor($Actor{'aHexahedron'});
$Actor{'aHexahedron'}->GetProperty->SetDiffuseColor(1,1,0);
$ren1->AddActor($Actor{'aTetra'});
$Actor{'aTetra'}->GetProperty->SetDiffuseColor(0,1,0);
$ren1->AddActor($Actor{'aWedge'});
$Actor{'aWedge'}->GetProperty->SetDiffuseColor(0,1,1);
$ren1->AddActor($Actor{'aPyramid'});
$Actor{'aPyramid'}->GetProperty->SetDiffuseColor(1,0,1);
$ren1->AddActor($Actor{'aPixel'});
$Actor{'aPixel'}->GetProperty->SetDiffuseColor(0,1,1);
$ren1->AddActor($Actor{'aQuad'});
$Actor{'aQuad'}->GetProperty->SetDiffuseColor(1,0,1);
$ren1->AddActor($Actor{'aTriangle'});
$Actor{'aTriangle'}->GetProperty->SetDiffuseColor('.3',1,'.5');
$ren1->AddActor($Actor{'aPolygon'});
$Actor{'aPolygon'}->GetProperty->SetDiffuseColor(1,'.4','.5');
$ren1->AddActor($Actor{'aTriangleStrip'});
$Actor{'aTriangleStrip'}->GetProperty->SetDiffuseColor('.3','.7',1);
$ren1->AddActor($Actor{'aLine'});
$Actor{'aLine'}->GetProperty->SetDiffuseColor('.2',1,1);
$ren1->AddActor($Actor{'aPolyLine'});
$Actor{'aPolyLine'}->GetProperty->SetDiffuseColor(1,1,1);
$ren1->AddActor($Actor{'aVertex'});
$Actor{'aVertex'}->GetProperty->SetDiffuseColor(1,1,1);
$ren1->AddActor($Actor{'aPolyVertex'});
$Actor{'aPolyVertex'}->GetProperty->SetDiffuseColor(1,1,1);
# get the cell center of each type and put a glyph there
$ball = Graphics::VTK::SphereSource->new;
$ball->SetRadius('.2');
foreach $cell ( qw/aVoxel aHexahedron aWedge aPyramid aTetra aPixel aQuad aTriangle aPolygon aTriangleStrip aLine aPolyLine aVertex aPolyVertex/)
 {
  $Centers{$cell} = Graphics::VTK::CellCenters->new;
  $Centers{$cell}->SetInput($Grid{$cell});
  $Centers{$cell}->VertexCellsOn;
  $Glyph3D{$cell} = Graphics::VTK::Glyph3D->new;
  $Glyph3D{$cell}->SetInput($Centers{$cell}->GetOutput);
  $Glyph3D{$cell}->SetSource($ball->GetOutput);
  $CentersMapper{$cell} = Graphics::VTK::PolyDataMapper->new;
  $CentersMapper{$cell}->SetInput($Glyph3D{$cell}->GetOutput);
  $CentersActor{$cell} = Graphics::VTK::Actor->new;
  $CentersActor{$cell}->SetMapper($CentersMapper{$cell});
  $CentersActor{$cell}->SetPosition($Actor{$cell}->GetPosition);
  $ren1->AddActor($CentersActor{$cell});
  $Actor{$cell}->GetProperty->SetRepresentationToWireframe;
 }
$ren1->GetActiveCamera->Azimuth(30);
$ren1->GetActiveCamera->Elevation(20);
$ren1->GetActiveCamera->Dolly(1.25);
$ren1->ResetCameraClippingRange;
$renWin->Render;
# render the image
$iren->SetUserMethod(
 sub
  {
   $MW->{'.vtkInteract'}->deiconify;
  }
);
$iren->Initialize;
$MW->withdraw;
#renWin SetFileName "cellCenters.tcl.ppm"
#renWin SaveImageAsPPM
Graphics::VTK::Tk::vtkInt::vtkInteract($MW);

Tk->MainLoop;
