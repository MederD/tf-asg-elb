resource "aws_autoscaling_policy" "asg-pol" {
  name                   = "terraform-test"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg-group.name
}
