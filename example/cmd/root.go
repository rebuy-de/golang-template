package cmd

import (
	"os"

	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
	graylog "gopkg.in/gemnasium/logrus-graylog-hook.v2"
)

func NewRootCommand() *cobra.Command {
	var (
		gelfAddress string
		verbose     bool
	)

	cmd := &cobra.Command{
		Use:   "golang-template",
		Short: "an example app for golang which can be used as template",
		PersistentPreRun: func(cmd *cobra.Command, args []string) {
			log.SetLevel(log.InfoLevel)
			name := os.Args[0]

			if verbose {
				log.SetLevel(log.DebugLevel)
			}

			if gelfAddress != "" {
				labels := map[string]interface{}{
					"facility":   name,
					"version":    BuildVersion,
					"commit-sha": BuildHash,
				}
				hook := graylog.NewGraylogHook(gelfAddress, labels)
				hook.Level = log.DebugLevel
				log.AddHook(hook)
			}

			log.WithFields(log.Fields{
				"Version": BuildVersion,
				"Date":    BuildDate,
				"Commit":  BuildHash,
			}).Infof("%s started", name)
		},
		PersistentPostRun: func(cmd *cobra.Command, args []string) {
			log.Infof("%s stopped", os.Args[0])
		},
	}

	cmd.PersistentFlags().BoolVarP(
		&verbose, "verbose", "v", false,
		`Show debug logs.`)
	cmd.PersistentFlags().StringVar(
		&gelfAddress, "gelf-address", "",
		`Address to Graylog for logging (format: "ip:port").`)

	cmd.AddCommand(NewVersionCommand())

	return cmd
}
