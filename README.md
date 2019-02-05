# Slideshow

A simple slideshow generator making use of jquery and the cycle2 plugin.

Slideshow takes a folder of images (`images` by default) and generates a HTML
file that will display them as a slideshow using
[Cycle2](http://jquery.malsup.com/cycle2/).

## Getting Started

```
git clone https://github.com/cpackham/slideshow.git
cd slideshow
cp /path/to/images/*.jpg images
make
xdg-open index.html
```

The slideshow can be navigated using the left/right arrow keys and
paused/resumed by pressing the spacebar.
