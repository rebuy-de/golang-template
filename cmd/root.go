package cmd

import (
	"github.com/rebuy-de/rebuy-go-sdk/v2/pkg/cmdutil"
	"github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

func NewRootCommand() *cobra.Command {
	r := new(Runner)

	return cmdutil.New(
		"golang-template", "Printing stuff",
		r.Bind,
		cmdutil.WithLogVerboseFlag(),
		cmdutil.WithLogToGraylog(),
		cmdutil.WithVersionCommand(),
		cmdutil.WithVersionLog(logrus.InfoLevel),
		cmdutil.WithRun(r.Run),
	)
}
