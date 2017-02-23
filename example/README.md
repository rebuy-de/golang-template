# golang-template

A template for new Golang projects.

## Usage

1. Copy all files into the new project.
2. `s/golang-template/your-project/`
  * in every file
  * don't miss `.gitignore`

## Updating

The `golang.mk` is a Makefile include file.
It is designed to be replaced by an updated version.

1. Overwrite the `golang.mk` in your project with the one in this one.
2. Check this `Makefile` to see if some parameters might have changed.
