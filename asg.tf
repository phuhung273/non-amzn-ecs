module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = "example-asg"

  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = ["subnet-0db11fbbc639ac23e", "subnet-0152e4c77e752a85a"]

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  # Launch template
  launch_template_name        = "example-asg"
  launch_template_description = "Launch template example"
  update_default_version      = true

  image_id      = "ami-0c2d3a22d664bf3ca"
  instance_type = "t3.micro"
  key_name      = "terraform-key"

  create_iam_instance_profile = false
  iam_instance_profile_name   = "ecsInstanceRole"

  user_data = base64encode(file("${path.module}/user-data.sh"))
}
