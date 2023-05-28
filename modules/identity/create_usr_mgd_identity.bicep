param deploymentParams object
param identityParams object
param tags object

param create_sql_admin_user bool = false

// Create User-Assigned Identity
resource r_usr_mgd_identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: '${identityParams.identityNamePrefix}_${deploymentParams.enterprise_name_suffix}_${deploymentParams.global_uniqueness}'
  location: deploymentParams.location
  tags: tags
}


// Create SQL User Admin Managed Identity

resource r_mysql_usr_admin_mgd_identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = if (create_sql_admin_user) {
  name: 'mysql_user_admin_${deploymentParams.enterprise_name_suffix}_${deploymentParams.global_uniqueness}'
  location: deploymentParams.location
  tags: tags
}



// Output
output usr_mgd_identity_id string = r_usr_mgd_identity.id
output usr_mgd_identity_clientId string = r_usr_mgd_identity.properties.clientId
output usr_mgd_identity_principalId string = r_usr_mgd_identity.properties.principalId
output usr_mgd_identity_name string = r_usr_mgd_identity.name


output mysql_usr_admin_mgd_identity_id string = create_sql_admin_user ? r_mysql_usr_admin_mgd_identity.id : ''
output mysql_usr_admin_mgd_identity_clientId string = create_sql_admin_user ? r_mysql_usr_admin_mgd_identity.properties.clientId : ''
output mysql_usr_admin_mgd_identity_principalId string = create_sql_admin_user ? r_mysql_usr_admin_mgd_identity.properties.principalId : ''
output mysql_usr_admin_mgd_identity_name string = create_sql_admin_user ? r_mysql_usr_admin_mgd_identity.name : ''

