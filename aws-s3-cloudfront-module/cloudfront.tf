resource "aws_cloudfront_distribution" "this-cdn-portal" {
  origin {
    domain_name = data.aws_s3_bucket.demo-portal-s3-bucket.bucket_domain_name
    origin_id   = data.aws_s3_bucket.demo-portal-s3-bucket.bucket_domain_name
  }
  wait_for_deployment = false
  enabled             = true
  is_ipv6_enabled     = true
  # default_root_object = "index.html"
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = data.aws_s3_bucket.demo-portal-s3-bucket.bucket_domain_name
    compress               = true
    cache_policy_id        = data.aws_cloudfront_cache_policy.cache_policy_cloudfront.id
    viewer_protocol_policy = "allow-all"
  }
  web_acl_id = aws_wafv2_web_acl.this-waf-web-acl.arn
  price_class = "PriceClass_All"
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  
  tags = {
    app-role               = "Cloudfront distribution for s3"
    app-name               = "portal-cloudfront"
    security-accessibility = "Public"
    environment 	   = "demo"
  }
  depends_on = [
    aws_s3_bucket.this-s3-bucket,
    data.aws_cloudfront_cache_policy.cache_policy_cloudfront
  ]
}



