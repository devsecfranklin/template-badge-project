# Artwork

* [Adding a logo to your KiCAD PCB](https://www.re-innovation.co.uk/docs/adding-logo-to-kicad/)

## Outline the Image

* Import the jpg/png to inkscape.
* Use the "Draw bezier curves and Straight lines" tool to outline the image completely.
* Save the outline as a "plain SVG", and save it that way (rather than inkscape SVG)
* [Outline the image](https://www.youtube.com/watch?v=lcmY77oxd8w)

## Convert the Outline to Bitmap

* Download/install gimp on your computer.
* Open the `.svg` file from the last step in gimp. Choose all the defaults in the dialogs.
  * If you make changes it will mess with the scale.
* Select `file -> Export as` and uncheck the box that says  "Select file type by Extension"
* Now export as windows 24 bit BMP.
  * Check the box for "do no t write color space information" 
  * Under advanced options select 24 bit color.
* [How to add logo or image on the PCB board silkscreen layer in KiCad v5](https://acoptex.com/wp/how-to-add-logo-or-image-on-the-pcb-board-in-kicad-v5/)

## Import the Bitmap to KiCad

* From the top level of the kicad project, select the Image Converter tool.
* Now load in the bitmap from the previous step.
* Export this as a footprint to the `kicad/footprints` directory.

