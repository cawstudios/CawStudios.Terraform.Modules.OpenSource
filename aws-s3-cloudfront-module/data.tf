data "aws_canonical_user_id" "current" {}
data "aws_cloudfront_cache_policy" "cache_policy_cloudfront" {
  name = var.cache_policy_name_cloudfront
}
data "aws_s3_bucket" "demo-portal-s3-bucket" {
  bucket = "${local.parent_org_name}-${local.cloud_provider}-${local.region}-${local.environment}-s3-${local.project}-${var.s3_bucket_name}"
  depends_on = [
    aws_s3_bucket.this-s3-bucket
  ]
}
