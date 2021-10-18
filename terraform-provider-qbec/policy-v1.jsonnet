local lib = import './lib/aws-s3-deny-non-corp.libsonnet';
lib.s3DenyNonCorpPolicy('the-bucket', [
  '11.11.11.11/32',
  '22.22.22.22/32',
  '33.33.33.33/32',
  '44.44.44.44/32',
])
