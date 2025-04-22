TF_VARS = "dev.tfvars"

.PHONY: plan
plan:
	terraform plan -var-file=$(TF_VARS)

.PHONY: apply
apply:
	terraform apply -var-file=$(TF_VARS) -auto-approve

.PHONY: port-forward
port-forward:
	./scripts/port_forward.sh

.PHONY: destroy
destroy:
	terraform destroy -auto-approve
