################################
# Variables: scale用個別設定
################################

variable "bastion_ec2" {
    default = "bastion-01"
}

# vpc-0cf79869 |
variable "subnet_id" {
  default = {
    private-1a = "subnet-xxxxxxxxxxxxxxxxx"
    private-1c = "subnet-xxxxxxxxxxxxxxxxx"
    private-1d = "subnet-xxxxxxxxxxxxxxxxx"
  }
}

variable "prd-web-iam_instance_profile" {
    default = "prd-web-profile"
}

variable "aws_elb" {
  default = {
    prd-web-jp = "prd-web-elb"
  }
}

variable "aws_alb_target_group" {
  default = {
    prd-web-jp = "arn:aws:elasticloadbalancing:ap-northeast-1:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  }
}

variable  "prd_web_scaleout_ami"    {}
variable  "prd_web_scaleout_count"  {}
variable  "prd_web_scaleout_type"   {}

################################
# Variables: 案件共通
################################

variable "project_code" {
  default = "project"
}

###
# SG
###
variable "security_group_id"{
  default = {
    prd-common     = "sg-xxxxxxxx"
    prd-allow-http = "sg-xxxxxxxx"
  }
}

###
# EC2
###
variable "ec2_key_name" {
  default = "ec2-key-ap-notrheast-1"
}
