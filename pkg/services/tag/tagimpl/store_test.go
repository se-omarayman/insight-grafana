package tagimpl

import (
	"context"
	"testing"

	"github.com/grafana/grafana/pkg/infra/db"
	"github.com/grafana/grafana/pkg/services/tag"

	"github.com/stretchr/testify/require"
)

type getStore func(db.DB) store

func testIntegrationSavingTags(t *testing.T, fn getStore) {
	if testing.Short() {
		t.Skip("skipping integration test")
	}
	ss := db.InitTestDB(t)
	store := fn(ss)
	tagPairs := []*tag.Tag{
		{Key: "outage"},
		{Key: "type", Value: "outage"},
		{Key: "server", Value: "server-1"},
		{Key: "error"},
	}
	tags, err := store.EnsureTagsExist(context.Background(), tagPairs)

	require.Nil(t, err)
	require.Equal(t, 4, len(tags))
}
