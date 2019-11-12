## tree
```
.
├── README.md
├── aws.tf
├── docker-compose.yaml
├── prd_ec2-scale.tf
├── terraform.tfvars      # スケール数等の可変部分
└── variables.tf          # 基本固定の変数(初回のみ編集)
```
## Usage
```
docker-compose run --rm terraform init      # for first plugin installation
docker-compose run --rm terraform plan
docker-compose run --rm terraform apply
```

## memo
既存のterraform管理とは独立させる目的で書いたが、variablesよりもData Source活用の方がよりスマート