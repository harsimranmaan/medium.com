{
  // s3DenyNonCorpPolicy encapsulates the policy to deny access to the bucket `bucketName`
  // to all IPs other than the ones supplied by the  `ipAddresses` list
  s3DenyNonCorpPolicy(bucketName, ipAddresses=[],):: {
    Version: '2012-10-17',
    Statement: [
      {
        Sid: 'SourceIP',
        Action: 's3:*',
        Effect: 'Deny',
        Resource: [
          // use jsonnet string format from the standard lib
          std.format('arn:aws:s3:::%s', bucketName),
          std.format('arn:aws:s3:::%s/*', bucketName),
        ],
        Condition: {
          NotIpAddress: {
            'aws:SourceIp': ipAddresses,
          },
        },
        Principal: '*',
      },
    ],
  },
}
