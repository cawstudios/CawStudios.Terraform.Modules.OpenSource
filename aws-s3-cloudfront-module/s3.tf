resource "aws_s3_bucket" "this-s3-bucket" {
  bucket        = "${local.parent_org_name}-${local.cloud_provider}-${local.region}-${local.environment}-s3-${local.project}-${var.s3_bucket_name}"
  force_destroy = true
  tags = {
    app-role               = "s3 Bucket"
    app-name               = "${var.s3_bucket_name}-S3-Bucket"
    security-accessibility = "Private"
  }
}
resource "aws_s3_bucket_website_configuration" "this-s3-website-configuration" {
  bucket   = "${local.parent_org_name}-${local.cloud_provider}-${local.region}-${local.environment}-s3-${local.project}-${var.s3_bucket_name}"
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "index.html"
  }
  depends_on = [
    aws_s3_bucket.this-s3-bucket
  ]
}
resource "aws_s3_bucket_policy" "this-s3-policy" {
  bucket   = "${local.parent_org_name}-${local.cloud_provider}-${local.region}-${local.environment}-s3-${local.project}-${var.s3_bucket_name}"
  policy   = <<POLICY
{
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "AddPerm",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${local.parent_org_name}-${local.cloud_provider}-${local.region}-${local.environment}-s3-${local.project}-${var.s3_bucket_name}/*"
        }
    ]
}
POLICY
  depends_on = [
    aws_s3_bucket.this-s3-bucket
  ]
}
resource "aws_s3_bucket_acl" "this-s3-acl_policy" {
  bucket   = "${local.parent_org_name}-${local.cloud_provider}-${local.region}-${local.environment}-s3-${local.project}-${var.s3_bucket_name}"
  access_control_policy {
    grant {
      grantee {
        id   = data.aws_canonical_user_id.current.id
        type = "CanonicalUser"
      }
      permission = "READ"
    }
    grant {
      grantee {
        id   = data.aws_canonical_user_id.current.id
        type = "CanonicalUser"
      }
      permission = "READ_ACP"
    }
    grant {
      grantee {
        id   = data.aws_canonical_user_id.current.id
        type = "CanonicalUser"
      }
      permission = "WRITE"
    }
    grant {
      grantee {
        id   = data.aws_canonical_user_id.current.id
        type = "CanonicalUser"
      }
      permission = "WRITE_ACP"
    }
    grant {
      grantee {
        type = "Group"
        uri  = "http://acs.amazonaws.com/groups/global/AllUsers"
      }
      permission = "READ_ACP"
    }
    grant {
      grantee {
        type = "Group"
        uri  = "http://acs.amazonaws.com/groups/global/AllUsers"
      }
      permission = "READ"
    }
    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }
  depends_on = [
    aws_s3_bucket.this-s3-bucket
  ]
}