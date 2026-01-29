output "app_url" {
  value       = "http://${aws_instance.hmsapp_server.public_ip}"
  description = "The public URL of the Student Management System"
}

output "rds_endpoint" {
  value = aws_db_instance.hms_db.endpoint
}

output "ssh_command" {
  value       = "ssh -i your-key.pem ubuntu@${aws_instance.hmsapp_server.public_ip}"
  description = "Command to SSH into the instance if you need to debug"
}
