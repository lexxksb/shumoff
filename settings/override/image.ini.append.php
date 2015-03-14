<?php /* #?ini charset="utf-8"?

[ImageMagick]
IsEnabled=true
ExecutablePath=/usr/bin
Executable=convert
Filters[]=geometry/thumbnailize=-thumbnail "%1x%2^" -gravity center -extent %1x%2
Filters[]=geometry/thumbnailize2=-geometry %1x%2^ -gravity center -crop %1x%2+0+0 +repage

[small]
Filters[]=geometry/scale=100;100

[medium]
Filters[]=geometry/scale=200;200

[large]
Filters[]=geometry/scale=300;300
*/ ?>