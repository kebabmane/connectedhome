SHELL := /bin/bash
AWS := aws
HUGO := hugo
PUBLIC_FOLDER := public/
S3_BUCKET = s3://connectedhome.guru/
CLOUDFRONT_ID := E1FZ6OGWEN07AH
DOMAIN = onnectedhome.guru
SITEMAP_URL = https://onnectedhome.guru/sitemap.xml

DEPLOY_LOG := deploy.log

.ONESHELL:

build-production:
	HUGO_ENV=production $(HUGO) --minify

deploy: build-production
	echo "Copying files to server..."
	$(AWS) s3 sync $(PUBLIC_FOLDER) $(S3_BUCKET) --size-only --delete | tee -a $(DEPLOY_LOG)
	# filter files to invalidate cdn
	grep "upload\|delete" $(DEPLOY_LOG) | sed -e "s|.*upload.*to $(S3_BUCKET)|/|" | sed -e "s|.*delete: $(S3_BUCKET)|/|" | sed -e 's/index.html//' | sed -e 's/\(.*\).html/\1/' | tr '\n' ' ' | xargs aws cloudfront create-invalidation --distribution-id $(CLOUDFRONT_ID) --paths
	curl --silent "http://www.google.com/ping?sitemap=$(SITEMAP_URL)"
	curl --silent "http://www.bing.com/webmaster/ping.aspx?siteMap=$(SITEMAP_URL)"

aws-cloudfront-invalidate-all:
	$(AWS) cloudfront create-invalidation --distribution-id $(CLOUDFRONT_ID) --paths "/*"