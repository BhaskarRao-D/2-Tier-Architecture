resource "aws_db_subnet_group" "my_subnet_group" {
  name       = "my-subnet-group"
  subnet_ids = [aws_subnet.publicsubnet1.id, aws_subnet.publicsubnet2.id]
}

resource "aws_db_instance" "database" {
  allocated_storage         = 10
  storage_type              = "gp2"
  identifier                = "database"
  engine                    = "mysql"
  engine_version            = "5.7"
  instance_class            = "db.t2.micro"
  vpc_security_group_ids    = [aws_security_group.rds-sg.id]
  db_subnet_group_name      = aws_db_subnet_group.my_subnet_group.name
  username                  = "bhaskar"
  password                  = "damuluri98"
  multi_az                  = false
  delete_automated_backups  = true
  parameter_group_name      = "default.mysql5.7"
  skip_final_snapshot       = true
  publicly_accessible       = true
  final_snapshot_identifier = "db-backup"
  backup_retention_period   = "0"
  deletion_protection       = false
}
