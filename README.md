# toggleR

## Building

WiP

## Dependencies

The package `toggleR` depends on `httr` to use the REST api on https://toggl.com

## Methods

WiP

## Usage

A simple example

```R
library(tidyverse)
library(jsonlite)
library(httr)

library(toggleR)

# get the list of groups from toggl in json format
groups.json <- get.toggl.groups(Sys.getenv("TOGGL_TOKEN"), Sys.getenv("TOGGL_WORKSPACE"))
# extract the data as a tibble
groups <- as_tibble(fromJSON(content(groups.json, "text")))
```

For more details

```R
?get.toggl.groups
```

to read the documentation in the package

