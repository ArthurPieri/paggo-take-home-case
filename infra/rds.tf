resource "aws_db_subnet_group" "pg" {
  name = "my_database_subnetgroup"
  subnet_ids = ["subnet-abcdefgh", "subnet-ijklmnop"]

  tags = {
    Name = "PostgresSubnetGroup"
  }
}

resource "aws_db_instance" "pg" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "11.5"
  instance_class       = "db.t2.micro"
  name                 = "pg"
  username             = "admin"
  password             = "mysecurepassword"
  db_subnet_group_name = aws_db_subnet_group.pg.name
  publicly_accessible  = true
  skip_final_snapshot = true
}

