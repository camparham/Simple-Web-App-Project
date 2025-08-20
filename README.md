# Simple-Web-App-Project

## Goal
Launch a static website on a custom domain using Amazon S3 for hosting and Route 53 for DNS—minimal, low-cost, and fast to deploy.

## Value
This setup is the quickest path to getting a site live on your own domain without servers. It’s great for portfolios, docs, and proof-of-concepts. (Note: S3 website endpoints are HTTP-only; HTTPS requires adding CloudFront later.)

## Tasks completed
- Domain & DNS
    - Registered/hosted domain in Route 53 (hosted zone created).
- S3 buckets
    - Created two buckets to match the domain names:
        - camexplores.click (site bucket)
- Site bucket configuration (camexplores.click )
    - Disabled Block Public Access for the bucket (required for S3 website hosting).
    - Enabled Static website hosting; set:
        - Index document: index.html
        - Error document: error.html
- Uploaded site files (index.html, assets).
- Added public-read bucket policy so the website endpoint can serve objects:
  (json)
    {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadForWebsite",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::camexplores.click/"
    }
  ]

}

- Redirect bucket configuration (camexplores.click )
    - Enabled Static website hosting → Redirect requests to camexplores.click  (protocol: http).
- Route 53 records
    - Created A (Alias) record for the apex camexplores.click  → S3 website endpoint of the site bucket (choose the Website endpoint, not the S3 API).
    - Created A (Alias) (or CNAME) for camexplores.click → S3 website endpoint of the redirect bucket.
- Validation
    - Tested camexplores.click for correct content and redirect.
    - Synced updates with:
      (bash) aws s3 sync ./site s3://camexplores.click  --delete


## Impact 
* Launched a custom-domain site with near-zero ops and sub-$1/month cost at low traffic.
* Established clean DNS and bucket naming patterns (apex + www redirect).
* Documented a repeatable deploy workflow (aws s3 sync) for fast content updates.
* Noted security trade-off: HTTP-only S3 website endpoint; plan to add CloudFront + ACM for HTTPS when needed.
