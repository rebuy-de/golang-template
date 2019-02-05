workflow "Test" {
  on = "push"
  resolves = ["Verify Golang Template"]
}

action "Verify Golang Template" {
  uses = "./"
  args = "example"
  env = {
    VERSION_OVERRIDE = "snapshot"
  }
}
