resource "aws_iam_role" "test-instane-role" {
  name = "test-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "test-instane-role-attach" {
  role       = aws_iam_role.test-instane-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "test-instance-role" {
  name = "test-instance-role"
  role = aws_iam_role.test-instane-role.name
}
