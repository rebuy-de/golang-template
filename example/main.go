package main

import (
	log "github.com/sirupsen/logrus"

	"github.com/rebuy-de/golang-template/example/cmd"
	"github.com/rebuy-de/rebuy-go-sdk/cmdutil"
)

func main() {
	defer cmdutil.HandleExit()
	if err := cmd.NewRootCommand().Execute(); err != nil {
		log.Fatal(err)
	}
}
