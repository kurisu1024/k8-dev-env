## k8-dev-env
Local-dev env for use in development. 

#### How to Use
- `dev.tfvars` file defines the TF_VAR variables. See file comment 
for default behavior. 
- cmd `make plan` executes `terraform plan` with the vars defined in `dev.tfvars`
- cmd `make apply` executes `terraform apply` with the vars defined in `dev.tfvars`

#### TODO
- Configs
- Make sure kind-dev helm-vars works with kind k8 env