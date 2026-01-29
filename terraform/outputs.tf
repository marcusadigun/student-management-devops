output "app_url" {
  value       = "http://${aws_instance.hms_server.public_ip}"
  description = "The public URL of the Student Management System"
}

output "ssh_command" {
  value       = "ssh -i your-key.pem ubuntu@${aws_instance.hms_server.public_ip}"
  description = "Command to SSH into the instance if you need to debug"
}
