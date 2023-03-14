# create private route table
resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.myvpc.id

  tags ={
      Name = format("Private-Route-Table" )
    }
}

# associate all private subnets to the private route table
resource "aws_route_table_association" "private-subnets-assoc" {
  count          = length(aws_subnet.private[*])
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private-rtb.id
}

# route table for public subnets
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = var.public_route_table_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rtb"
  }
}
# route table association for public subnets
resource "aws_route_table_association" "pub-subnets-assoc" {
  count          = length(aws_subnet.public[*])
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public-rtb.id
}