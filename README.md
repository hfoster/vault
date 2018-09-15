# HashiCorp Vault

## Cloud hosted, High Availability implementation

#### To install

    cd terraform
    terraform init -backend-config=backend-config/<env_name>
    terraform plan -var env_name=<env_name> -var route53_zone_id=<route53_zone_id> -var domain_name=<domain_name> -var ec2_key_pair=<ec2_key_pair> -out=<env_name>.plan
    terraform apply <env_name>.plan

#### To use

Use the [HTTP API](https://www.vaultproject.io/api/index.html).
