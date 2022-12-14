package apikeyimpl

import (
	"testing"

	"github.com/grafana/grafana/pkg/infra/db"
	"github.com/grafana/grafana/pkg/setting"
)

func TestIntegrationXORMApiKeyDataAccess(t *testing.T) {
	testIntegrationApiKeyDataAccess(t, func(ss db.DB, cfg *setting.Cfg) store {
		return &sqlStore{db: ss, cfg: cfg}
	})
}
