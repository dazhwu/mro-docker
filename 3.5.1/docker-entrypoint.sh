#!/bin/bash
set -e

# If no R scripts besides demo.R are found in the work directory, 
# then start an interactive R session. Otherwise, exit to bash shell.
if [ ! "$(find . -type f -name '*.R*' ! -name 'demo.R')" ]; then
  /usr/bin/R --no-save
else
  /bin/bash
fi

