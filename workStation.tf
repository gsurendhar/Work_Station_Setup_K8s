resource "aws_instance" "k8s_workstation" {
    ami = data.aws_ami.devops.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.allow-all.id]
    user_data = file("bootstrap.sh")
    
    root_block_device {
    volume_size = 40
    volume_type = "gp3" # or "gp2", depending on your preference
    }
   
    tags    = {
        Name = "roboshop-dev"
        Project = "Roboshop"
    }
}

resource "aws_security_group" "allow-all" {
    name = "allow-all-workstation"
    description = " allowing all ports from internet "
    ingress {
        from_port   =   0
        to_port     =   0
        protocol    =   "-1"
        cidr_blocks =   ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    egress {
        from_port   =   0
        to_port     =   0
        protocol    =   "-1"
        cidr_blocks =   ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags    = {
        Name = "workstation"
        Project = "Roboshop"
    }
}