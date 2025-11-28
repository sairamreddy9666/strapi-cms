resource "aws_instance" "strapi-server" {
  tags = {
    Name    = "strapi-server"
    project = "strapi"
  }
  ami               = "ami-0d176f79571d18a8f"
  instance_type     = "t2.micro"
  key_name          = "mumbai-kp"
  security_groups   = ["fst-sg"]
  user_data         = file("user-data.sh")
  count             = 1
  availability_zone = "ap-south-1a"
  root_block_device {
    volume_size = 20
  }
}
