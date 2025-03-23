resource "aws_launch_template" "my_launch_template" {
  name = "my-launch-template"
  description = "My Launch Template"
  image_id = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  depends_on = [aws_db_instance.my-database-server] # Önce DB oluşsun
  
  vpc_security_group_ids = [ aws_security_group.rental-secgrp.id ]
  key_name = var.instance_keypair
  user_data = filebase64("${path.module}/userdata.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "my launch template"
    }
  }
}