# Artwork

What you need to know about getting artwork from an image file
into a shape and silscreen on a PCB.

## Layers on a PCB

* The [silkscreen is a layer of ink trace](https://www.pcbway.com/pcb_prototype/PCB_Silkscreen.html) used to identify the PCB components, marks, logos, symbols, and so on.
* The [solder mask is a colored layer](https://en.wikipedia.org/wiki/Solder_mask) of polymer that goes over the copper traces.
  * [PCB Solder mask](https://www.pcbway.com/pcb_prototype/PCB_Solder_mask.html#:~:text=PCB%20Solder%20mask,between%20closely%20spaced%20solder%20pads.)

When an artist provides artwork for a badge there are limits on what can be shown on the silscreen layer.
In other words, an 8-bit black and white graphic would look closeer to the original artwork. Full color
graphics with lots of lines and shading would not be reproduced well on the silscreen layer.

## Convert the Image to Plain SVG

* [Install Inkscape](https://inkscape.org/release/inkscape-1.2.2/)
* Import the jpg/png graphics file to Inkscape.
* Save the graphic as a "plain SVG", and save it that way
  * Do not save as Inkscape SVG

## Convert the Graphic to Bitmap

* [Download/install gimp](https://www.gimp.org/) on your computer.
* Open the `.svg` file from the last step in Gimp. Choose all the defaults in the dialogs.
  * You can change the scale at this time. Recommend to do everything in metric to avoid conversion mistakes.
* Select `file -> Export as` and uncheck the box that says  "Select file type by Extension"
* Now export as windows 24 bit BMP.
  * Check the box for "do not write color space information"
  * Under advanced options select 24 bit color.

## Import the Bitmap to KiCad, Export Footprint

* From the top level of the kicad project, select the Image Converter tool.
* Now load in the bitmap from the previous step.
* Export this as a footprint to the `kicad/footprints` directory using the "export to file" button.

## Create a New Library, add Footprint

* From top level of KiCad project, select the "Footprint Editor"
* Create a new library in `kicad/libraries`. Usual name we use is `dead10c5`
* Make sure you are on the "edge cuts" layer (slect from dropdown).
* Import the `.mod` footprint file you created, save it in the new library.

## Add Outline to PCB

* Add a PCB to the project.
* Make sure you are on the "edge cuts" layer (slect from dropdown).
* Click on `Place` and `add footprint`
* Click on the new outline with the selection tool and go into properties.
* Uncheck the  "reference designator" box.
* Select the `*.kicad_mod` file you created.
* Scale it
* Import the graphics to the silkscreen layer with `File -> import graphics`

## Extra links

* [Adding a logo to your KiCAD PCB](https://www.re-innovation.co.uk/docs/adding-logo-to-kicad/)
* [How to add logo or image on the PCB board silkscreen layer in KiCad v5](https://acoptex.com/wp/how-to-add-logo-or-image-on-the-pcb-board-in-kicad-v5/)
