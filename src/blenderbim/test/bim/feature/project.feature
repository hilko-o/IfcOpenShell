@project
Feature: Project

Scenario: Create project
    Given an empty Blender session
    When I press "bim.create_project"
    Then an IFC file exists
    And the object "IfcProject/My Project" is an "IfcProject"
    And the object "IfcSite/My Site" is an "IfcSite"
    And the object "IfcBuilding/My Building" is an "IfcBuilding"
    And the object "IfcBuildingStorey/My Storey" is an "IfcBuildingStorey"
    And the object "IfcProject/My Project" is in the collection "IfcProject/My Project"
    And the object "IfcSite/My Site" is in the collection "IfcSite/My Site"
    And the object "IfcBuilding/My Building" is in the collection "IfcBuilding/My Building"
    And the object "IfcBuildingStorey/My Storey" is in the collection "IfcBuildingStorey/My Storey"

Scenario: Create project - IFC2X3
    Given an empty Blender session
    And I set "scene.BIMProjectProperties.export_schema" to "IFC2X3"
    When I press "bim.create_project"
    Then an IFC file exists
    And the object "IfcProject/My Project" is an "IfcProject"
    And the object "IfcSite/My Site" is an "IfcSite"
    And the object "IfcBuilding/My Building" is an "IfcBuilding"
    And the object "IfcBuildingStorey/My Storey" is an "IfcBuildingStorey"
    And the object "IfcProject/My Project" is in the collection "IfcProject/My Project"
    And the object "IfcSite/My Site" is in the collection "IfcSite/My Site"
    And the object "IfcBuilding/My Building" is in the collection "IfcBuilding/My Building"
    And the object "IfcBuildingStorey/My Storey" is in the collection "IfcBuildingStorey/My Storey"

Scenario: Append library element
    Given an empty IFC project
    When I press "bim.select_library_file(filepath='{cwd}/test/files/basic.ifc')"
    And I press "bim.change_library_element(element_name='IfcTypeProduct')"
    And I press "bim.change_library_element(element_name='IfcSlabType')"
    And I press "bim.append_library_element(definition=242, prop_index=0)"
    Then the object "IfcSlabType/Slab" is an "IfcSlabType"
    And the object "IfcSlabType/Slab" is in the collection "IfcTypeProduct"

Scenario: Append library element - append two elements sharing a material
    Given an empty IFC project
    And I press "bim.select_library_file(filepath='{cwd}/test/files/basic.ifc')"
    And I press "bim.change_library_element(element_name='IfcTypeProduct')"
    And I press "bim.change_library_element(element_name='IfcSlabType')"
    And I press "bim.append_library_element(definition=242, prop_index=0)"
    When I press "bim.rewind_library"
    And I press "bim.change_library_element(element_name='IfcWallType')"
    And I press "bim.append_library_element(definition=291, prop_index=0)"
    Then the object "IfcSlabType/Slab" is an "IfcSlabType"
    And the object "IfcSlabType/Slab" is in the collection "IfcTypeProduct"
    And the object "IfcWallType/Wall" is an "IfcWallType"
    And the object "IfcWallType/Wall" is in the collection "IfcTypeProduct"
    And the object "IfcSlabType/Slab" has the material "SurfaceStyle"
    And the object "IfcWallType/Wall" has the material "SurfaceStyle"

Scenario: Load project
    Given an empty Blender session
    When I press "bim.load_project(filepath='{cwd}/test/files/basic.ifc')"
    Then an IFC file exists
    And the object "IfcProject/My Project" is an "IfcProject"
    And the object "IfcSite/My Site" is an "IfcSite"
    And the object "IfcBuilding/My Building" is an "IfcBuilding"
    And the object "IfcBuildingStorey/Ground Floor" is an "IfcBuildingStorey"
    And the object "IfcBuildingStorey/Level 1" is an "IfcBuildingStorey"
    And the object "IfcSlab/Slab" is an "IfcSlab"
    And the object "IfcWall/Wall" is an "IfcWall"
    And the object "IfcElementAssembly/Empty" is an "IfcElementAssembly"
    And the object "IfcBeam/Beam" is an "IfcBeam"
    And the object "IfcSite/My Site" is in the collection "IfcSite/My Site"
    And the object "IfcBuilding/My Building" is in the collection "IfcBuilding/My Building"
    And the object "IfcBuildingStorey/Ground Floor" is in the collection "IfcBuildingStorey/Ground Floor"
    And the object "IfcBuildingStorey/Level 1" is in the collection "IfcBuildingStorey/Level 1"
    And the object "IfcElementAssembly/Empty" is in the collection "IfcBuildingStorey/Level 1"
    And the object "IfcBeam/Beam" is in the collection "IfcBuildingStorey/Level 1"
    And the object "IfcSlab/Slab" is in the collection "IfcBuildingStorey/Ground Floor"
    And the object "IfcWall/Wall" is in the collection "IfcBuildingStorey/Level 1"
    And "scene.BIMProjectProperties.is_loading" is "False"

Scenario: Load project - IfcZip
    Given an empty Blender session
    And I press "bim.load_project(filepath='{cwd}/test/files/basic.ifczip')"
    Then the object "IfcProject/My Project" is an "IfcProject"

Scenario: Load project - advanced mode
    Given an empty Blender session
    When I press "bim.load_project(filepath='{cwd}/test/files/basic.ifc', is_advanced=True)"
    Then an IFC file exists
    And "scene.BIMProjectProperties.is_loading" is "True"
    And the object "IfcProject/My Project" does not exist

Scenario: Load project elements - load all project elements
    Given an empty Blender session
    And I press "bim.load_project(filepath='{cwd}/test/files/basic.ifc', is_advanced=True)"
    When I set "scene.BIMProjectProperties.filter_mode" to "NONE"
    And I press "bim.load_project_elements"
    Then the object "IfcProject/My Project" is an "IfcProject"
    And the object "IfcSite/My Site" is an "IfcSite"
    And the object "IfcBuilding/My Building" is an "IfcBuilding"
    And the object "IfcBuildingStorey/Ground Floor" is an "IfcBuildingStorey"
    And the object "IfcBuildingStorey/Level 1" is an "IfcBuildingStorey"
    And the object "IfcSlab/Slab" is an "IfcSlab"
    And the object "IfcWall/Wall" is an "IfcWall"
    And the object "IfcElementAssembly/Empty" is an "IfcElementAssembly"
    And the object "IfcBeam/Beam" is an "IfcBeam"
    And the object "IfcSite/My Site" is in the collection "IfcSite/My Site"
    And the object "IfcBuilding/My Building" is in the collection "IfcBuilding/My Building"
    And the object "IfcBuildingStorey/Ground Floor" is in the collection "IfcBuildingStorey/Ground Floor"
    And the object "IfcBuildingStorey/Level 1" is in the collection "IfcBuildingStorey/Level 1"
    And the object "IfcElementAssembly/Empty" is in the collection "IfcBuildingStorey/Level 1"
    And the object "IfcBeam/Beam" is in the collection "IfcBuildingStorey/Level 1"
    And the object "IfcSlab/Slab" is in the collection "IfcBuildingStorey/Ground Floor"
    And the object "IfcWall/Wall" is in the collection "IfcBuildingStorey/Level 1"
    And the object "IfcSlab/Slab" has data which is an IFC representation
    And the object "IfcBeam/Beam" has data which is an IFC representation
    And the object "IfcWall/Wall" has data which is an IFC representation
    And the object "IfcSlabType/Slab" has data which is an IFC representation
    And the object "IfcWallType/Wall" has data which is an IFC representation
    And "scene.BIMProjectProperties.is_loading" is "False"

Scenario: Load project elements - load objects filtered by decomposition
    Given an empty Blender session
    And I press "bim.load_project(filepath='{cwd}/test/files/basic.ifc', is_advanced=True)"
    When I set "scene.BIMProjectProperties.filter_mode" to "DECOMPOSITION"
    And I set "scene.BIMProjectProperties.should_filter_spatial_elements" to "True"
    Then "scene.BIMProjectProperties.filter_categories['IfcSite/My Site'].total_elements" is "0"
    Then "scene.BIMProjectProperties.filter_categories['IfcBuilding/My Building'].total_elements" is "0"
    Then "scene.BIMProjectProperties.filter_categories['IfcBuildingStorey/Ground Floor'].total_elements" is "1"
    Then "scene.BIMProjectProperties.filter_categories['IfcBuildingStorey/Level 1'].total_elements" is "2"
    When I set "scene.BIMProjectProperties.filter_categories['IfcBuildingStorey/Level 1'].is_selected" to "True"
    And I press "bim.load_project_elements"
    Then the object "IfcProject/My Project" is an "IfcProject"
    And the object "IfcSite/My Site" is an "IfcSite"
    And the object "IfcBuilding/My Building" is an "IfcBuilding"
    And the object "IfcBuildingStorey/Level 1" is an "IfcBuildingStorey"
    And the object "IfcWall/Wall" is an "IfcWall"
    And the object "IfcElementAssembly/Empty" is an "IfcElementAssembly"
    And the object "IfcBeam/Beam" is an "IfcBeam"
    And the object "IfcSite/My Site" is in the collection "IfcSite/My Site"
    And the object "IfcBuilding/My Building" is in the collection "IfcBuilding/My Building"
    And the object "IfcBuildingStorey/Level 1" is in the collection "IfcBuildingStorey/Level 1"
    And the object "IfcWall/Wall" is in the collection "IfcBuildingStorey/Level 1"
    And the object "IfcElementAssembly/Empty" is in the collection "IfcBuildingStorey/Level 1"
    And the object "IfcBeam/Beam" is in the collection "IfcBuildingStorey/Level 1"
    And the object "IfcBuildingStorey/Ground Floor" does not exist
    And the object "IfcSlab/Slab" does not exist

Scenario: Load project elements - load objects filtered by IFC class
    Given an empty Blender session
    And I press "bim.load_project(filepath='{cwd}/test/files/basic.ifc', is_advanced=True)"
    When I set "scene.BIMProjectProperties.filter_mode" to "IFC_CLASS"
    And I set "scene.BIMProjectProperties.should_filter_spatial_elements" to "True"
    Then "scene.BIMProjectProperties.filter_categories['IfcWall'].total_elements" is "1"
    And "scene.BIMProjectProperties.filter_categories['IfcSlab'].total_elements" is "1"
    And "scene.BIMProjectProperties.filter_categories['IfcElementAssembly'].total_elements" is "1"
    And "scene.BIMProjectProperties.filter_categories['IfcBeam'].total_elements" is "1"
    When I set "scene.BIMProjectProperties.filter_categories['IfcSlab'].is_selected" to "True"
    And I press "bim.load_project_elements"
    Then the object "IfcProject/My Project" is an "IfcProject"
    And the object "IfcSite/My Site" is an "IfcSite"
    And the object "IfcBuilding/My Building" is an "IfcBuilding"
    And the object "IfcBuildingStorey/Ground Floor" is an "IfcBuildingStorey"
    And the object "IfcSlab/Slab" is an "IfcSlab"
    And the object "IfcSite/My Site" is in the collection "IfcSite/My Site"
    And the object "IfcBuilding/My Building" is in the collection "IfcBuilding/My Building"
    And the object "IfcBuildingStorey/Ground Floor" is in the collection "IfcBuildingStorey/Ground Floor"
    And the object "IfcSlab/Slab" is in the collection "IfcBuildingStorey/Ground Floor"
    And the object "IfcBuildingStorey/Level 1" does not exist
    And the object "IfcWall/Wall" does not exist

Scenario: Load project elements - load objects filtered by whitelist
    Given an empty Blender session
    And I press "bim.load_project(filepath='{cwd}/test/files/basic.ifc', is_advanced=True)"
    When I set "scene.BIMProjectProperties.filter_mode" to "WHITELIST"
    And I set "scene.BIMProjectProperties.filter_query" to "IfcSlab"
    And I set "scene.BIMProjectProperties.should_filter_spatial_elements" to "True"
    And I press "bim.load_project_elements"
    Then the object "IfcProject/My Project" is an "IfcProject"
    And the object "IfcSite/My Site" is an "IfcSite"
    And the object "IfcBuilding/My Building" is an "IfcBuilding"
    And the object "IfcBuildingStorey/Ground Floor" is an "IfcBuildingStorey"
    And the object "IfcSlab/Slab" is an "IfcSlab"
    And the object "IfcSite/My Site" is in the collection "IfcSite/My Site"
    And the object "IfcBuilding/My Building" is in the collection "IfcBuilding/My Building"
    And the object "IfcBuildingStorey/Ground Floor" is in the collection "IfcBuildingStorey/Ground Floor"
    And the object "IfcSlab/Slab" is in the collection "IfcBuildingStorey/Ground Floor"
    And the object "IfcBuildingStorey/Level 1" does not exist
    And the object "IfcWall/Wall" does not exist

Scenario: Load project elements - load objects filtered by blacklist
    Given an empty Blender session
    And I press "bim.load_project(filepath='{cwd}/test/files/basic.ifc', is_advanced=True)"
    When I set "scene.BIMProjectProperties.filter_mode" to "BLACKLIST"
    And I set "scene.BIMProjectProperties.filter_query" to "IfcSlab"
    And I set "scene.BIMProjectProperties.should_filter_spatial_elements" to "True"
    And I press "bim.load_project_elements"
    Then the object "IfcProject/My Project" is an "IfcProject"
    And the object "IfcSite/My Site" is an "IfcSite"
    And the object "IfcBuilding/My Building" is an "IfcBuilding"
    And the object "IfcBuildingStorey/Level 1" is an "IfcBuildingStorey"
    And the object "IfcWall/Wall" is an "IfcWall"
    And the object "IfcElementAssembly/Empty" is an "IfcElementAssembly"
    And the object "IfcBeam/Beam" is an "IfcBeam"
    And the object "IfcSite/My Site" is in the collection "IfcSite/My Site"
    And the object "IfcBuilding/My Building" is in the collection "IfcBuilding/My Building"
    And the object "IfcBuildingStorey/Level 1" is in the collection "IfcBuildingStorey/Level 1"
    And the object "IfcWall/Wall" is in the collection "IfcBuildingStorey/Level 1"
    And the object "IfcElementAssembly/Empty" is in the collection "IfcBuildingStorey/Level 1"
    And the object "IfcBeam/Beam" is in the collection "IfcBuildingStorey/Level 1"
    And the object "IfcBuildingStorey/Ground Floor" does not exist
    And the object "IfcSlab/Slab" does not exist

Scenario: Load project elements - load no objects due to filter
    Given an empty Blender session
    And I press "bim.load_project(filepath='{cwd}/test/files/basic.ifc', is_advanced=True)"
    When I set "scene.BIMProjectProperties.filter_mode" to "IFC_CLASS"
    And I set "scene.BIMProjectProperties.should_filter_spatial_elements" to "True"
    And I press "bim.load_project_elements"
    Then the object "IfcProject/My Project" is an "IfcProject"
    And the object "IfcSite/My Site" does not exist
    And the object "IfcBuilding/My Building" does not exist
    And the object "IfcBuildingStorey/Ground Floor" does not exist
    And the object "IfcBuildingStorey/Level 1" does not exist
    And the object "IfcSlab/Slab" does not exist
    And the object "IfcWall/Wall" does not exist

Scenario: Load project elements - manual offset of object placements
    Given an empty Blender session
    And I press "bim.load_project(filepath='{cwd}/test/files/manual-geolocation.ifc', is_advanced=True)"
    When I set "scene.BIMProjectProperties.false_origin_mode" to "MANUAL"
    And I set "scene.BIMProjectProperties.false_origin" to "268388500, 5774506000, 21900"
    And I press "bim.load_project_elements"
    Then the object "IfcPlate/1780 x 270 PRECAST WALL" is at "0,0,0"

Scenario: Load project elements - manual offset of cartesian points
    Given an empty Blender session
    And I press "bim.load_project(filepath='{cwd}/test/files/manual-geolocation-coords.ifc', is_advanced=True)"
    When I set "scene.BIMProjectProperties.false_origin_mode" to "MANUAL"
    And I set "scene.BIMProjectProperties.false_origin" to "1990711,5971553,22700"
    And I press "bim.load_project_elements"
    Then the object "IfcBuildingElementProxy/NAME" has a vertex at "0,0,0"
    And the object "IfcBuildingElementProxy/NAME" has a vertex at "-1,0,0"
    And the object "IfcBuildingElementProxy/NAME" has a vertex at "0,.5,0"
    And the object "IfcBuildingElementProxy/NAME" has a vertex at "-1,.5,0"
    And the object "IfcBuildingElementProxy/NAME" has a vertex at "-1,.5,2.2"

Scenario: Load project elements - auto offset of object placements
    Given an empty Blender session
    When I press "bim.load_project(filepath='{cwd}/test/files/auto-geolocation.ifc')"
    Then the object "IfcPlate/1780 x 270 PRECAST WALL" is at "0,0,0"

Scenario: Load project elements - auto offset of cartesian points
    Given an empty Blender session
    When I press "bim.load_project(filepath='{cwd}/test/files/manual-geolocation-coords.ifc')"
    Then the object "IfcBuildingElementProxy/NAME" is at "0,0,0"

Scenario: Unload project
    Given an empty Blender session
    When I press "bim.load_project(filepath='{cwd}/test/files/basic.ifc', is_advanced=True)"
    And I press "bim.unload_project"
    Then an IFC file does not exist
    And "scene.BIMProjectProperties.is_loading" is "False"

Scenario: Link IFC
    Given an empty IFC project
    When I press "bim.link_ifc(filepath='{cwd}/test/files/basic.ifc')"
    Then "scene.BIMProjectProperties.links['{cwd}/test/files/basic.ifc'].is_loaded" is "True"
    And the collection "IfcProject/basic.ifc" exists
    And the object "Chunk" exists
    And the object "Chunk" is placed in the collection "IfcProject/basic.ifc"

Scenario: Toggle link visibility - wireframe mode
    Given an empty IFC project
    And I press "bim.link_ifc(filepath='{cwd}/test/files/basic.ifc')"
    When I press "bim.toggle_link_visibility(link='{cwd}/test/files/basic.ifc', mode='WIREFRAME')"
    Then "scene.BIMProjectProperties.links['{cwd}/test/files/basic.ifc'].is_wireframe" is "True"
    And the object "Chunk" should display as "WIRE"
    When I press "bim.toggle_link_visibility(link='{cwd}/test/files/basic.ifc', mode='WIREFRAME')"
    Then "scene.BIMProjectProperties.links['{cwd}/test/files/basic.ifc'].is_wireframe" is "False"
    And the object "Chunk" should display as "TEXTURED"

Scenario: Toggle link selectability
    Given an empty IFC project
    And I press "bim.link_ifc(filepath='{cwd}/test/files/basic.ifc')"
    When I press "bim.toggle_link_selectability(link='{cwd}/test/files/basic.ifc')"
    Then "scene.BIMProjectProperties.links['{cwd}/test/files/basic.ifc'].is_selectable" is "False"
    And the collection "IfcProject/basic.ifc" is unselectable
    When I press "bim.toggle_link_selectability(link='{cwd}/test/files/basic.ifc')"
    Then "scene.BIMProjectProperties.links['{cwd}/test/files/basic.ifc'].is_selectable" is "True"
    And the collection "IfcProject/basic.ifc" is selectable

Scenario: Toggle link visibility - visible mode
    Given an empty IFC project
    And I press "bim.link_ifc(filepath='{cwd}/test/files/basic.ifc')"
    When I press "bim.toggle_link_visibility(link='{cwd}/test/files/basic.ifc', mode='VISIBLE')"
    Then "scene.BIMProjectProperties.links['{cwd}/test/files/basic.ifc'].is_hidden" is "True"
    And the collection "IfcProject/basic.ifc" exclude status is "True"
    When I press "bim.toggle_link_visibility(link='{cwd}/test/files/basic.ifc', mode='VISIBLE')"
    Then "scene.BIMProjectProperties.links['{cwd}/test/files/basic.ifc'].is_hidden" is "False"
    And the collection "IfcProject/basic.ifc" exclude status is "False"

Scenario: Unload link
    Given an empty Blender session
    And I press "bim.link_ifc(filepath='{cwd}/test/files/basic.ifc')"
    When I press "bim.unload_link(filepath='{cwd}/test/files/basic.ifc')"
    Then "scene.BIMProjectProperties.links['{cwd}/test/files/basic.ifc'].is_loaded" is "False"
    And the collection "IfcProject/basic.ifc" does not exist

Scenario: Load link
    Given an empty Blender session
    And I press "bim.link_ifc(filepath='{cwd}/test/files/basic.ifc')"
    And I press "bim.unload_link(filepath='{cwd}/test/files/basic.ifc')"
    When I press "bim.load_link(filepath='{cwd}/test/files/basic.ifc')"
    Then "scene.BIMProjectProperties.links['{cwd}/test/files/basic.ifc'].is_loaded" is "True"
    And the collection "IfcProject/basic.ifc" exists in viewlayer

Scenario: Unlink IFC
    Given an empty Blender session
    And I press "bim.link_ifc(filepath='{cwd}/test/files/basic.ifc')"
    And I press "bim.unload_link(filepath='{cwd}/test/files/basic.ifc')"
    When I press "bim.unlink_ifc(filepath='{cwd}/test/files/basic.ifc')"
    Then "scene.BIMProjectProperties.links.get('{cwd}/test/files/basic.ifc')" is "None"
    And "scene.collection.children.get('IfcProject/basic.ifc')" is "None"
    And the object "Chunk" does not exist

Scenario: Export IFC - blank project
    Given an empty IFC project
    When I press "export_ifc.bim(filepath='{cwd}/test/files/temp/export.ifc')"
    Then nothing happens

Scenario: Export IFC - with basic contents
    Given an empty Blender session
    And I press "bim.load_project(filepath='{cwd}/test/files/basic.ifc')"
    When I press "export_ifc.bim(filepath='{cwd}/test/files/temp/export.ifc')"
    Then "scene.BIMProperties.ifc_file" is "{cwd}/test/files/temp/export.ifc"

Scenario: Export IFC - with basic contents and saving as another file
    Given an empty Blender session
    And I press "bim.load_project(filepath='{cwd}/test/files/basic.ifc')"
    When I press "export_ifc.bim(filepath='{cwd}/test/files/temp/export.ifc', should_save_as=True)"
    Then "scene.BIMProperties.ifc_file" is "{cwd}/test/files/temp/export.ifc"

Scenario: Export IFC - with basic contents and saving as IfcJSON where import is not supported
    Given an empty Blender session
    And I press "bim.load_project(filepath='{cwd}/test/files/basic.ifc')"
    When I press "export_ifc.bim(filepath='{cwd}/test/files/temp/export.ifcjson', should_save_as=True)"
    Then "scene.BIMProperties.ifc_file" is "{cwd}/test/files/basic.ifc"

Scenario: Export IFC - with basic contents and round-tripping an IfcZip
    Given an empty Blender session
    And I press "bim.load_project(filepath='{cwd}/test/files/basic.ifc')"
    When I press "export_ifc.bim(filepath='{cwd}/test/files/temp/export.ifczip', should_save_as=True)"
    Then "scene.BIMProperties.ifc_file" is "{cwd}/test/files/basic.ifc"
    When an empty Blender session is started
    And I press "bim.load_project(filepath='{cwd}/test/files/temp/export.ifczip')"
    Then the object "IfcProject/My Project" is an "IfcProject"

Scenario: Export IFC - with basic contents and saving as a relative path
    Given an empty Blender session
    And I press "bim.load_project(filepath='{cwd}/test/files/basic.ifc')"
    When I press "wm.save_mainfile(filepath='{cwd}/test/files/temp/export.blend')"
    And I press "export_ifc.bim(filepath='{cwd}/test/files/temp/export.ifc', use_relative_path=True, save_as_invoked=True)"
    Then "scene.BIMProperties.ifc_file" is "export.ifc"

Scenario: Export IFC - with deleted objects synchronised
    Given an empty IFC project
    When the object "IfcBuildingStorey/My Storey" is selected
    And I delete the selected objects
    And I press "export_ifc.bim(filepath='{cwd}/test/files/temp/export.ifc')"
    And an empty Blender session is started
    And I press "bim.load_project(filepath='{cwd}/test/files/temp/export.ifc')"
    Then the object "IfcBuildingStorey/My Storey" does not exist

Scenario: Export IFC - with moved object location synchronised
    Given an empty IFC project
    When the object "IfcBuildingStorey/My Storey" is moved to "0,0,1"
    And I press "export_ifc.bim(filepath='{cwd}/test/files/temp/export.ifc')"
    And an empty Blender session is started
    And I press "bim.load_project(filepath='{cwd}/test/files/temp/export.ifc')"
    Then the object "IfcBuildingStorey/My Storey" is at "0,0,1"

Scenario: Export IFC - with moved grid axis location synchronised
    Given an empty IFC project
    And I press "mesh.add_grid"
    When the object "IfcGridAxis/01" is moved to "1,0,0"
    And I press "export_ifc.bim(filepath='{cwd}/test/files/temp/export.ifc')"
    And an empty Blender session is started
    And I press "bim.load_project(filepath='{cwd}/test/files/temp/export.ifc')"
    Then the object "IfcGridAxis/01" bottom left corner is at "1,-2,0"

Scenario: Export IFC - with changed object scale synchronised
    Given an empty IFC project
    And I add a cube
    And the object "Cube" is selected
    And I set "scene.BIMRootProperties.ifc_product" to "IfcElement"
    And I set "scene.BIMRootProperties.ifc_class" to "IfcWall"
    And I press "bim.assign_class"
    And the object "IfcWall/Cube" is selected
    When the object "IfcWall/Cube" is scaled to "2"
    And I press "export_ifc.bim(filepath='{cwd}/test/files/temp/export.ifc')"
    And an empty Blender session is started
    And I press "bim.load_project(filepath='{cwd}/test/files/temp/export.ifc')"
    Then the object "IfcWall/Cube" dimensions are "4,4,4"

Scenario: Export IFC - with changed style element synchronised
    Given an empty IFC project
    And I add a cube
    And the object "Cube" is selected
    And I add a material
    And I set "scene.BIMRootProperties.ifc_product" to "IfcElement"
    And I set "scene.BIMRootProperties.ifc_class" to "IfcWall"
    And I press "bim.assign_class"
    And the object "IfcWall/Cube" is selected
    When I add a material
    And the material "Material.001" colour is set to "1,0,0,1"
    And I press "export_ifc.bim(filepath='{cwd}/test/files/temp/export.ifc')"
    And an empty Blender session is started
    And I press "bim.load_project(filepath='{cwd}/test/files/temp/export.ifc', should_start_fresh_session=False)"
    Then the material "Material.001" colour is "1,0,0,1"
