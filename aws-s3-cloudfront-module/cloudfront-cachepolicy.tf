# resource "aws_cloudfront_cache_policy" "this-cdn-ordered-cache-policy" {
#   name        = "${local.parent_org_name}-${local.cloud_provider}-${local.region}-${local.environment}-cloudfront-${local.project}-${var.cache_policy_name}_cloudfront"
#   default_ttl = 31556952
#   max_ttl     = 31556952
#   min_ttl     = 31556952
#   parameters_in_cache_key_and_forwarded_to_origin {
#     enable_accept_encoding_gzip = true
#     cookies_config {
#       cookie_behavior = "none"
#       cookies {
#         items = []
#       }
#     }
#     headers_config {
#       header_behavior = "none"
#       headers {
#         items = []
#       }
#     }
#     query_strings_config {
#       query_string_behavior = "none"
#       query_strings {
#         items = []
#       }
#     }
#   }
# }