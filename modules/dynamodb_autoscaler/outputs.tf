output "aws_appautoscaling_target" {
  description = "The DynamoDB table autoscaling targets"
  value = {
    read_target  = aws_appautoscaling_target.read_target
    write_target = aws_appautoscaling_target.write_target
  }
}

output "aws_appautoscaling_policy" {
  description = "The DynamoDB table autoscaling policies"
  value = {
    read_policy  = aws_appautoscaling_policy.read_policy
    write_policy = aws_appautoscaling_policy.write_policy
  }
}
