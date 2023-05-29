disable_mlock = "true"
ui            = "true"
listener "tcp" {
  address     = "0.0.0.0:8200"
  cluster_address     = "0.0.0.0:8201"
  tls_disable = "true"
}
storage "raft" {
  node_id = "rb4-m2"
  path = "/app/data/vault"
}
api_addr =  "http://rb4-m2-p1-vault.hld.sourceshift.org:8200"
disable_clustering = "false"
cluster_addr = "https://rb4-m2-p1-vault.hld.sourceshift.org:8200"
cluster_name = "sourceshift.org"
log_level = "Trace"
default_lease_ttl = "768h"
max_lease_ttl = "768h"
