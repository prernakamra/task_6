provider "aws" {
  region                  = "us-east-2"
  profile                 = "default"
}
resource "aws_instance" "amzonos" {
  ami           = "ami-077e31c4939f6a2f3"
  instance_type = "t2.micro"

  tags = {
    Name = "os connected with storage"
  }
}
output "o1" {

value = aws_instance.amzonos.availability_zone

}
resource "aws_ebs_volume" "example" {
  availability_zone = aws_instance.amzonos.availability_zone
  size              = 5

  tags = {
    Name = "external block storage"
  }
}
output "ebs_id" {
value = aws_ebs_volume.example
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.amzonos.id
}
