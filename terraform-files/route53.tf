data "aws_route53_zone" "selected" {
  name = var.hosted-zone
}



resource "aws_route53_record" "rental" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name = "rental.${var.hosted-zone}"
  type = "A"
  alias {
    name = aws_lb.rental-lb.dns_name
    zone_id = aws_lb.rental-lb.zone_id
    evaluate_target_health = true
  }
  depends_on = [aws_cloudfront_distribution.alb]

}