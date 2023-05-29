disable_mlock = "true"
ui            = "true"
listener "tcp" {
  address     = "0.0.0.0:8200"
  cluster_address     = "0.0.0.0:8201"
  tls_disable = "true"
}
storage "raft" {
  node_id = "vault2"
  path = "/vault/file"
    retry_join {
    leader_api_addr = "http://vault3:8300"
  }
    retry_join {
    leader_api_addr = "http://vault4:8400"
  }
}
api_addr =  "http://vault2:8200"
disable_clustering = "false"
cluster_addr = "https://vault2:8201"
cluster_name = "sourceshift.org"
log_level = "trace"
default_lease_ttl = "768h"
max_lease_ttl = "768h"
