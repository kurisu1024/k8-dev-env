TF_VARS = "dev.tfvars"

.PHONY: plan
plan:
	terraform plan -var-file=$(TF_VARS)

.PHONY: apply
apply:
	terraform apply -var-file=$(TF_VARS)
