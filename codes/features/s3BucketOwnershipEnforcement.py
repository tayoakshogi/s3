#import required library
import boto3
import logging
from botocore.exceptions import ClientError

profile="olajide" #set profile name

# log configuration
logging.basicConfig(
    format='%(levelname)s: %(message)s',
    encoding="utf-8"
)

logger = logging.getLogger()
# Needed explicitly set level for logger
logger.setLevel("INFO")

session = boto3.Session(profile_name=profile)
s3_client = session.client('s3')

# Output the bucket names
print('The existing buckets are:')

def list_buckets(s3_client):
  response = s3_client.list_buckets()
  bucket_list = []
  for bucket in response['Buckets']:
    bucket_list.append(bucket['Name'])
  return bucket_list

bucket_list = list_buckets(s3_client)

for bucket in bucket_list:
    if (bucket.startswith('s3')) and bucket not in ['tfsdl-edp-heatmap-test','tfsdl-edp-heatmap-prod']:
        try:
            ownership_id = []
            # if 
            print('\nBucket --> %s' %(bucket))
            response = s3_client.put_bucket_ownership_controls(
            Bucket=bucket,
            ExpectedBucketOwner='123452105877',
            OwnershipControls={
                'Rules': [{
                    'ObjectOwnership': 'BucketOwnerEnforced'},]}
                    )
            logger.info("HTTPStatusCode: %s", response['ResponseMetadata']['HTTPStatusCode'])
            logger.info("RequestId: %s", response['ResponseMetadata']['RequestId'])
            logger.info("HostId: %s", response['ResponseMetadata']['HostId'])
            logger.info("Date: %s", response['ResponseMetadata']['HTTPHeaders']['date'])
            if response['ResponseMetadata']['HTTPStatusCode'] == 200:
                print('\n Succesfully processed Bucket --> %s' %(bucket))
            else:
                logger.info("HTTPStatusCode: %s", response['ResponseMetadata']['HTTPStatusCode'])
      
        except ClientError as err:
            #if err.response['Error']['Code'] == 'InternalError': # Generic error
                # We grab the message, request ID, and HTTP code to give to customer support
                print('Error Message: {}'.format(err.response['Error']['Message']))
                print('Request ID: {}'.format(err.response['ResponseMetadata']['RequestId']))
                print('Http code: {}'.format(err.response['ResponseMetadata']['HTTPStatusCode']))
            #else:
            #    raise err
        
        # except ClientError as error:
            # raise Exception('boto3 client error in s3: ' + error.__str__())

print('\nBucket --> %s' %(bucket))