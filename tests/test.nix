let 
dir = builtins.readDir /home/hactuss;
directoryfilter = builtins.filter (x: x = "Documents") dir;
in 
directoryfilter;
