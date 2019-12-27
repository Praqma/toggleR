# toggleR

## Building

[![CircleCI](https://circleci.com/gh/Praqma/toggleR/tree/master.svg?style=svg)](https://circleci.com/gh/Praqma/toggleR/tree/master)

## Dependencies

The package `toggleR` depends on: 

- `httr` to use the REST api on https://toggl.com
- `jsonlite` to parse JSON data

## Methods

WiP

## Usage

A simple example

```R
library(tidyverse)
library(jsonlite)
library(httr)

library(toggleR)

# get the list of groups from toggl
groups <- as_tibble(get.toggl.groups(Sys.getenv("TOGGL_TOKEN"), Sys.getenv("TOGGL_WORKSPACE")))
```

To get the detailed report for a group 

```R
# get the entries for a group for the last 30 days
get.toggl.group.data(Sys.getenv("TOGGL_TOKEN"), Sys.getenv("TOGGL_WORKSPACE"), <groupId>, since = Sys.Date() - 30)
```


For more details

```R
?get.toggl.groups
```

to read the documentation in the package

