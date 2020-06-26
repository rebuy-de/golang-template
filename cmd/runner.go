package cmd

import (
	"context"

	"github.com/spf13/cobra"

	"github.com/rebuy-de/rebuy-go-sdk/v2/pkg/logutil"
)

type Runner struct {
	name string
}

func (r *Runner) Bind(cmd *cobra.Command) error {
	cmd.PersistentFlags().StringVar(
		&r.name, "name", "there",
		`your name`)
	return nil
}

func (r *Runner) Run(ctx context.Context, cmd *cobra.Command, args []string) {
	ctx = logutil.Start(ctx, "main")

	logutil.Get(ctx).Infof("Hello %s!", r.name)
}
