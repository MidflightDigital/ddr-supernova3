The SNCharacters System
=======================

The _SNCharacters_ system (implemented in _Character.lua_) is a system designed to replace the built-in Character system with something more appropriate to the needs of SN3 and other themes based on modern DDR. It is intended to be relatively easy to drop into other themes. Currently, you'll have to make code for actually displaying any of the assets.

The Characters Themselves
-------------------------
Character.lua as included in this version of the theme can work with version 1 through 3 SNCharacters, which are mostly identical. The following elements are directly supported, which means that Character.lua will take care of at least part of the work for you.

### Configuration (config.lua) ###
config.lua is a file that returns a table containing at least two fields, version and color. Both must exist for the character to be considered valid.

config.lua is run in an empty environment. Any attempt to use Lua functions defined outside that file will fail, including StepMania built-in functions.

version must be 1 through 3, or else the character will be considered invalid.

color is a StepMania color. It can be either a table of 4 elements or a string. If it is a string, it will be processed by color() during the loading process.

### Graphical elements ###
Character.lua verifies that two graphics files exist in the character folder during validation.
They are "combo.png" and "combo100.png". "combo.png" is the character's normal cut-in portrait, "combo100.png" is the character's 100-milestone cut-in.

Version 2 does not require "combo.png" and instead requires "comboA.png" and "comboB.png". Version 3 is identical to version 2.

### Dancer videos ###
Dancer videos go in the DancerVideos folder. Any format of video file accepted by StepMania can be loaded.

Character.lua
-------------
Character.lua exposes a table called Characters, which contains various functions for dealing with SNCharacters.

### GetPath(string name) ###
Attempts to get the path to a character with the given name. Returns nil if it can't be found. It does not validate names, so just getting a path back from this function doesn't mean that there actually is a character there.

### GetPathIfValid(string name) ###
Similar to GetPath, but also returns nil if the character is invalid.

### Validate(string name, boolean forceRecheck) ###
Checks if there is a valid character with the given name. Returns true if successful and false if not. If forceRecheck is not true, answers are cached and will not reflect any changes to the character since the last recheck.

### GetConfig(string name, boolean forceRecheck) ###
Returns the configuration data for the character, or nil if there isn't any or it's invalid. forceRecheck acts identically to the way it does in Validate.

### GetDancerVideo(string name) ###
If the character is valid and has any dancer videos, return the path to one of them chosen at random.

### GetAssetPath(string name, string fileName) ###
If the character is valid, and the file or a fallback file exists, return its path, otherwise nil.
The main purpose of this function is to abstract the differences between character versions away.
(name should be something like "combo.png".)

### GetAllPotentialCharacterNames() ###
Returns a table containg all potential character names (that is, directory names in /SNCharacters) sorted in alphabetical order.

### GetAllCharacterNames() ###
Returns a table containing all valid character names, again sorted in alphabetical order.

_Note:_ OptionRowCharacters() is not described because it is considered part of the theme and is not designed to be used in other themes without modification. All that has to be done to adapt it to another theme is select which variable the chosen character is stored in.
