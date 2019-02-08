# golang-template

A template for new Golang projects.

## Usage

### New Project

Just copy the `example` repository and adjust it to your needs.

### GitHub Action

This repo contains a [GitHub Action](https://github.com/features/actions) which
checks that there is no drift away from the template.

To use it the file `.github/main.workflow` needs to contain this content:

```
workflow "Push" {
  on = "push"
  resolves = ["Verify Golang Template"]
}

action "Verify Golang Template" {
  uses = "rebuy-de/golang-template@v3.0.0"
}
```
