resource "aws_ecs_cluster" "alice" {
  name = "alice"
}

resource "aws_ecs_cluster" "bob" {
  name = "bob"
}
