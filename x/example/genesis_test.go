package example_test

import (
	"testing"

	"github.com/stretchr/testify/require"
	keepertest "github.com/zkevm/sequencer/testutil/keeper"
	"github.com/zkevm/sequencer/testutil/nullify"
	"github.com/zkevm/sequencer/x/example"
	"github.com/zkevm/sequencer/x/example/types"
)

func TestGenesis(t *testing.T) {
	genesisState := types.GenesisState{
		Params: types.DefaultParams(),

		// this line is used by starport scaffolding # genesis/test/state
	}

	k, ctx := keepertest.ExampleKeeper(t)
	example.InitGenesis(ctx, *k, genesisState)
	got := example.ExportGenesis(ctx, *k)
	require.NotNil(t, got)

	nullify.Fill(&genesisState)
	nullify.Fill(got)

	// this line is used by starport scaffolding # genesis/test/assert
}
