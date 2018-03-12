package cmd

import (
	"github.com/rebuy-de/rebuy-go-sdk/cmdutil"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

type App struct {
	Name string
}

func (app *App) Run(cmd *cobra.Command, args []string) {
	log.Infof("hello %s", app.Name)
}

func (app *App) Bind(cmd *cobra.Command) {
	cmd.PersistentFlags().StringVarP(
		&app.Name, "name", "n", "world",
		`Your name.`)
}

func NewRootCommand() *cobra.Command {
	cmd := cmdutil.NewRootCommand(new(App))
	cmd.Short = "an example app for golang which can be used as template"
	return cmd
}
