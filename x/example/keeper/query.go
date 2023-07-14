package keeper

import (
	"github.com/zkevm/sequencer/x/example/types"
)

var _ types.QueryServer = Keeper{}
