output "this_lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = "http://${aws_lb.rental-lb.dns_name}"
}

output "websiteurl" {
    value = "http://${aws_route53_record.rental.name}"
}