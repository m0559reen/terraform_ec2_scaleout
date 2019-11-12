locals {
  subnet_ids = {
    "0" = "${var.subnet_id["private-1c"]}"
    "1" = "${var.subnet_id["private-1a"]}"
  }
}

# prd-web-2 ~

resource "aws_instance" "prd-web-scale-01" {
    instance_type               = "${var.prd_web_scaleout_type}"
    ami                         = "${var.prd_web_scaleout_ami}"
    subnet_id                   = "${lookup(local.subnet_ids, count.index%2)}"
    vpc_security_group_ids      = [
                                  "${var.security_group_id["prd-common"]}",
                                  "${var.security_group_id["prd-allow-http"]}",
                                  ]
    associate_public_ip_address = true
    key_name                    = "${var.ec2_key_name}"
    iam_instance_profile        = "${var.prd-web-iam_instance_profile}"

    count                       = "${var.prd_web_scaleout_count}"

    root_block_device = {
        volume_type             = "gp2"
        volume_size             = "100"
        delete_on_termination   = true
    }

    tags = {
        Name                    = "${format("${var.project_code}-prd-web-%01d", count.index+2)}"
        Roles                   = "web"
        Environment             = "prd"
        Bastion                 = "${var.bastion_ec2}"
    }
}

# elb
#resource "aws_elb_attachment" "prd-web-jp" {
#    count                      = "${var.prd_web_scaleout_count}"
#    elb                        = "${var.aws_elb["prd-web-jp"]}"
#    instance                   = "${element(aws_instance.prd-web-scale-01.*.id, count.index)}"
#}

# alb
resource "aws_alb_target_group_attachment" "prd-web-jp" {
    count                      = "${var.prd_web_scaleout_count}"
    target_group_arn           = "${var.aws_alb_target_group["prd-web-jp"]}"
    target_id                  = "${element(aws_instance.prd-web-scale-01.*.id, count.index)}"
    port                       = 80
}