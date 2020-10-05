//  Copyright © Microsoft Corporation
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

prefix = "osdu-r3"

# Storage Settings
storage_containers = [
  "legal-service-azure-configuration",
  "opendes",
  "osdu-wks-mappings"
]

# Database Settings
cosmos_db_name             = "osdu-data"
cosmosdb_consistency_level = "Session"
cosmos_databases = [
  {
    name       = "osdu-db"
    throughput = 4000
  }
]
cosmos_sql_collections = [
  {
    name               = "LegalTag"
    database_name      = "osdu-db"
    partition_key_path = "/id"
  },
  {
    name               = "StorageRecord"
    database_name      = "osdu-db"
    partition_key_path = "/id"
  },
  {
    name               = "StorageSchema"
    database_name      = "osdu-db"
    partition_key_path = "/kind"
  },
  {
    name               = "TenantInfo"
    database_name      = "osdu-db"
    partition_key_path = "/id"
  },
  {
    name               = "UserInfo"
    database_name      = "osdu-db"
    partition_key_path = "/id"
  },
  {
    name               = "Authority"
    database_name      = "osdu-db"
    partition_key_path = "/dataPartitionId"
  },
  {
    name               = "EntityType"
    database_name      = "osdu-db"
    partition_key_path = "/dataPartitionId"
  },
  {
    name               = "SchemaInfo"
    database_name      = "osdu-db"
    partition_key_path = "/dataPartitionId"
  },
  {
    name               = "Source"
    database_name      = "osdu-db"
    partition_key_path = "/dataPartitionId"
  },
  {
    name               = "RegisterAction"
    database_name      = "osdu-db"
    partition_key_path = "/dataPartitionId"
  },
  {
    name               = "RegisterDdms"
    database_name      = "osdu-db"
    partition_key_path = "/dataPartitionId"
  },
  {
    name               = "RegisterSubscription"
    database_name      = "osdu-db"
    partition_key_path = "/dataPartitionId"
  },
  {
    name               = "IngestionStrategy"
    database_name      = "osdu-db"
    partition_key_path = "/workflowType"
  },
  {
    name               = "WorkflowStatus"
    database_name      = "osdu-db"
    partition_key_path = "/workflowId"
  },
  {
    name               = "Workflow"
    database_name      = "osdu-db"
    partition_key_path = "/workflowId"
  },
  {
    name               = "WorkflowRun"
    database_name      = "osdu-db"
    partition_key_path = "/workflowId"
  }
]

# Service Bus Settings
sb_topics = [
  {
    name                         = "recordstopic"
    default_message_ttl          = "PT30M" //ISO 8601 format
    enable_partitioning          = false
    requires_duplicate_detection = true
    support_ordering             = true
    authorization_rules = [
      {
        policy_name = "policy"
        claims = {
          listen = true
          send   = true
          manage = false
        }
      }
    ]
    subscriptions = [
      {
        name                                 = "recordstopicsubscription"
        max_delivery_count                   = 5
        lock_duration                        = "PT5M" //ISO 8601 format
        forward_to                           = ""     //set with the topic name that will be used for forwarding. Otherwise, set to ""
        dead_lettering_on_message_expiration = true
        filter_type                          = null
        sql_filter                           = null
        action                               = ""
      },
      {
        name                                 = "wkssubscription"
        max_delivery_count                   = 5
        lock_duration                        = "PT5M" //ISO 8601 format	
        forward_to                           = ""     //set with the topic name that will be used for forwarding. Otherwise, set to ""	
        dead_lettering_on_message_expiration = true
        filter_type                          = null
        sql_filter                           = null
        action                               = ""
      }
    ]
  },
  {
    name                         = "legaltags"
    default_message_ttl          = "PT30M" //ISO 8601 format
    enable_partitioning          = false
    requires_duplicate_detection = true
    support_ordering             = true
    authorization_rules = [
      {
        policy_name = "policy"
        claims = {
          listen = true
          send   = true
          manage = false
        }
      }
    ]
    subscriptions = [
      {
        name                                 = "legaltagsubscription"
        max_delivery_count                   = 5
        lock_duration                        = "PT5M" //ISO 8601 format
        forward_to                           = ""     //set with the topic name that will be used for forwarding. Otherwise, set to ""
        dead_lettering_on_message_expiration = true
        filter_type                          = null
        sql_filter                           = null
        action                               = ""
      },
      {
        name                                 = "compliance-change--integration-test"
        max_delivery_count                   = 1
        lock_duration                        = "PT5M" //ISO 8601 format
        forward_to                           = ""     //set with the topic name that will be used for forwarding. Otherwise, set to ""
        dead_lettering_on_message_expiration = true
        filter_type                          = null
        sql_filter                           = null
        action                               = ""
      }
    ]
  },
  {
    name                         = "recordstopicdownstream"
    default_message_ttl          = "PT30M" //ISO 8601 format
    enable_partitioning          = false
    requires_duplicate_detection = true
    support_ordering             = true
    authorization_rules = [
      {
        policy_name = "policy"
        claims = {
          listen = true
          send   = true
          manage = false
        }
      }
    ]
    subscriptions = [
      {
        name                                 = "downstreamsub"
        max_delivery_count                   = 5
        lock_duration                        = "PT5M" //ISO 8601 format
        forward_to                           = ""     //set with the topic name that will be used for forwarding. Otherwise, set to ""
        dead_lettering_on_message_expiration = true
        filter_type                          = null
        sql_filter                           = null
        action                               = ""
      }
    ]
  },
  {
    name                         = "indexing-progress"
    default_message_ttl          = "PT30M" //ISO 8601 format
    enable_partitioning          = false
    requires_duplicate_detection = true
    support_ordering             = true
    authorization_rules = [
      {
        policy_name = "policy"
        claims = {
          listen = true
          send   = true
          manage = false
        }
      }
    ]
    subscriptions = [
      {
        name                                 = "indexing-progresssubscription"
        max_delivery_count                   = 5
        lock_duration                        = "PT5M" //ISO 8601 format
        forward_to                           = ""     //set with the topic name that will be used for forwarding. Otherwise, set to ""
        dead_lettering_on_message_expiration = true
        filter_type                          = null
        sql_filter                           = null
        action                               = ""
      }
    ]
  }
]
