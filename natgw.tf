/* #resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
  count = var.preferred_number_of_elastic_ip
  tags = {
    Name = format("nat-eip -%d",count.index)
  }
} */
/* resource "aws_nat_gateway" "nat" {
  count = var.preferred_number_of_natgw
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  depends_on    = [aws_internet_gateway.igw]
  tags = {
      Name = format("Nat -%d", count.index)
    }
} */