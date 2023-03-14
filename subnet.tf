# Get list of availability zones
data "aws_availability_zones" "available" {
    state = "available"
}

# Create public subnet
resource "aws_subnet" "public" { 
    count = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
    vpc_id                  = aws_vpc.myvpc.id
    cidr_block              = cidrsubnet(var.vpc_cidr, 8 , count.index+1)
    map_public_ip_on_launch = true
    availability_zone       = data.aws_availability_zones.available.names[count.index]
    tags = {
    Name = "PublicSubnet - ${count.index}"
  }
    }

#private subnets 
resource "aws_subnet" "private" {
  count= var.preferred_number_of_private_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets
  vpc_id= aws_vpc.myvpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + 3)
  map_public_ip_on_launch = true
  # index%2 as we want to put our subnets only in 2 az (reminder values will be only 0 or 1)
  availability_zone       = data.aws_availability_zones.available.names[count.index%2]
  tags ={
  Name = format("PrivateSubnet-%s", count.index)
        }
} 

