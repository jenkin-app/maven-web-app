data "aws_ami" "my-lastest-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "linux_server" {
  ami                         = data.aws_ami.my-lastest-ami.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet-1.id
  vpc_security_group_ids      = [aws_security_group.sg.id]
  associate_public_ip_address = true
  key_name                    = "ec2-server-key"
  user_data                   = "${file("linux-server.sh")}"

  tags = {
    Name = "Linux-server"
  }
}

resource "aws_instance" "jenkins_server" {
  ami                         = data.aws_ami.my-lastest-ami.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet-1.id
  vpc_security_group_ids      = [aws_security_group.sg.id]
  associate_public_ip_address = true
  key_name                    = "ec2-server-key"
  user_data                   = "${file("install-jenkins.sh")}"

  tags = {
    Name = "Jenkins-server"
  }
}