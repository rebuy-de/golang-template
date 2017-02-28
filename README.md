# golang-template

A template for new Golang projects.

## Usage

### Creating a new Project

1. Copy all files from `/example` into the new project.
2. Take a look at the checklist in `/example/README.md`.

### Updating

The `golang.mk` is a Makefile include file. This include file and the
`Dockerfile` are designed to be replaced by an updated version.

1. Copy updated `Dockerfile` and `golang.mk` into your project.
2. Take a look at the diff to see if things might break.

## Development

1. Do stuff.
2. Use `release.sh <version>` to bump a release.
3. Push it.
