
resource "aws_s3_bucket" "terraform-source-bucket" {
  bucket = var.source_bucket_name
}

resource "aws_s3_bucket" "terraform-publish-bucket" {
  bucket = var.publish_bucket_name
}