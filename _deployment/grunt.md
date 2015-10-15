---
title: Grunt Configuration
---

The initial Gruntfile contains only minimal configuration to compile
SCSS files with SASS and Compass along with basic watch commands to
trigger them. There are two initial build targets for the SCSS, code and
staging:

              dev : { // Target
                options : { // Target options
                  basePath: 'public/sites/all/themes/f1ux/',
                  outputStyle: 'expanded',
                  noLineComments: false,
                  bundleExec: true
                }
              },

              staging : { // Target
                options : { // Target options
                  basePath: 'public/sites/all/themes/f1ux/',
                  outputStyle: 'compressed',
                  noLineComments: true,
                  force: true,
                  bundleExec: true
                }
              },
            },

These make some sensible defaults as far as how Compass will handle the
styles. For dev it will expand the output and add comments to allow
easier debugging. For staging it will compress the styles and remove
comments. In both cases it will attempt to use bundler to pin the
version of the appropriate gems. The appropriate target can be passed to
Grunt via the flag `stage`. So to compile the SCSS with the staging
configuration you would run `grunt --staging=stage`. Note that this
defaults to dev, so just running `grunt` will use the dev target.

There is a simple-watch set up to monitor SCSS files. It is using
grunt-simple-watch instead of grunt-watch due to issues with inotify
through NFS. Simple watch uses polling instead of relying on the
notifications, which makes it slightly less performant, but the
difference has been nominal.

The paths to the location of the SCSS files will most likely need to be
changed to point to the appropriate path.
