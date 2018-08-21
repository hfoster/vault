# HashiCorp Vault
## Cloud hosted, High Availability implementation

#### To install
```
cd terraform
terraform init
terraform plan -var 'route53_zone_id=<route53_zone_id>' -var 'domain_name=<domain_name>' -var 'ec2_key_pair=<ec2_key_pair>' -out=vault.plan
terraform apply "vault.plan"
```

#### To use
Use the [HTTP API](https://www.vaultproject.io/api/index.html).
