resource "aws_db_instance" "my-database-server" { 
  allocated_storage     = 20
  max_allocated_storage = 20
  identifier            = "aydin-db"

  db_name        = "araba_kiralama"
  engine         = "mysql"
  engine_version = "8.0.35"
  instance_class = "db.t3.micro"
  username       = "admin"
  password       = "admin123"
  port           = 3306

  skip_final_snapshot = true
  publicly_accessible = true
  monitoring_interval = 0
  multi_az = false
  vpc_security_group_ids  = [aws_security_group.db-secgrp.id]
  backup_retention_period = 0
  allow_major_version_upgrade = false
  auto_minor_version_upgrade = true
  db_subnet_group_name    = aws_db_subnet_group.default.name

}

resource "aws_security_group" "db-secgrp" {
  name        = "db-secgrp"
  description = "Allow TLS inbound traffic"
  vpc_id = data.aws_vpc.default.id
    
  ingress {
    description = "allow port 3306"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [ aws_security_group.rental-secgrp.id ]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-secgrp"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "default-db-subnet-group"
  subnet_ids = data.aws_subnets.default.ids

  tags = {
    Name = "My DB subnet group"
  }
}