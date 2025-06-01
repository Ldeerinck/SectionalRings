#  Feature list

Need to print
- Add ability to print marked up map
- Add ability to print a selected region of the marked up map

Need better settings management
- Add ability to load/save the settings between runs (currently they are hard-coded on start)
- Add ability to load/save landables between runs (the Sectional is included in them)

Handle multiple Sectionals
- Add ability to choose which Sectional from a drop down list
- Load Sectional from the web, rather than keeping it as an Asset, but keep it local (don't re-download each use)
- Create option to remove all cached sectionals
- Keep track of sectional date (they are valid for only so long)
- Auto-clean up expired sectionals
- Only use landables for the selected Sectional

Localization Support https://medium.com/simform-engineering/localize-your-apps-to-support-multiple-languages-ios-localization-in-swiftui-c72d891a3e9
- Move hard-coded values
- Add setting for units (feet vs. meters)
- Add multi-language options (German, Italian, French, ?)  Can use Google translate to get values

Add winds support
- Add ability to set wind speed/direction.  This makes all circles become ellipses.

Add option for "Altitude Needed" insead of "How risky"
- Add legend to the map
- Add ability to select legends
- Add ability to create a custom legend
- Add legends to load/save data

Fix Lambert projection calculations

Add ability to load landout points

Add option to support terrain

