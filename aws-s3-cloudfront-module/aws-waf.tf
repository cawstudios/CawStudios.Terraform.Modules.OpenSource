resource "aws_wafv2_web_acl" "this-waf-web-acl" {
  provider = aws.aws-waf-web-acl-provider  
  name        = "${local.parent_org_name}-${local.cloud_provider}-${local.region}-${local.environment}-waf_web_acl"
  description = "Bot Control waf aws acl"
  scope       = "CLOUDFRONT"

  default_action {
    allow {}
  }
  
  rule {
  name = "AWS-AWSManagedRulesBotControlRuleSet"
  priority = 0
  statement {
    managed_rule_group_statement {
      vendor_name = "AWS"
      name = "AWSManagedRulesBotControlRuleSet"
    }
  }
  override_action {
    count {}
  }
  visibility_config {
    sampled_requests_enabled = true
    cloudwatch_metrics_enabled = true
    metric_name = "AWS-AWSManagedRulesBotControlRuleSet"
  }
}
  visibility_config {
    sampled_requests_enabled = true
    cloudwatch_metrics_enabled = true
    metric_name = "AWS-AWSManagedRulesBotControlRuleSet"
  }
}