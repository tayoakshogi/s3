# **Simple Storage Service - S3**

## **Getting S3**

### The Amazon S3 service is an object storage service that offers industry-leading scalability, data availability, security, and performance. This means customers of all sizes and industries can use it to store and protect any amount of data for a range of use cases, such as data lakes, websites, cloud-native applications, backups, archive, machine learning, and analytics. Amazon S3 is designed for 99.999999999% (11 9's) of durability, and stores data for millions of customers all around the world.. 



<img width="1280" alt="image" src="https://user-images.githubusercontent.com/18147793/155443602-8ee4afe8-57dd-4886-ae3d-6650ec20d5f1.png">



## **Documentation**

### If you don't understand something about this service, the [extensive documentation](https://aws.amazon.com/pm/serv-s3/?trk=ps_a134p000004f2aOAAQ&trkCampaign=acq_paid_search_brand&sc_channel=PS&sc_campaign=acquisition_US&sc_publisher=Google&sc_category=Storage&sc_country=US&sc_geo=NAMER&sc_outcome=acq&sc_detail=amazon%20s3&sc_content=S3_e&sc_matchtype=e&sc_segment=488982706722&sc_medium=ACQ-P%7CPS-GO%7CBrand%7CDesktop%7CSU%7CStorage%7CS3%7CUS%7CEN%7CText&s_kwcid=AL!4422!3!488982706722!e!!g!!amazon%20s3&ef_id=Cj0KCQiA09eQBhCxARIsAAYRiylWBrvOL9yHOCKlJxZy1FnefalIWR3AeCrqnIvdnqj8N6afDvG_zx4aAg55EALw_wcB:G:s&s_kwcid=AL!4422!3!488982706722!e!!g!!amazon%20s3) is a great place to look for answers.

## **Support**
### For those without premium support access, you can utilize the [repost.aws](repost.aws) blog to ask questions on any AWS services you may be facing issues with.

## **This Repository**
### This repository contains an absrtaciton of my experience with the S3 service. Feel free to raise an issue if you find a problem with my approach.

## **s3BucketOwnership**
### This script helps to automate the implementation of the recently added Object ownership access control issue usually encountered when a cross account role/user adds a new file to a Bucket without the "--acl bucket-owner-full-control" flag.

### Running this script would loop through all the Buckets in your AWS account and enforce the rule.


## **s3BucketPolicy**
### Sometimes in AWS environment, we want to deny access to an S3 Bucket for all other IAM roles/users except for specific roles. This is possible by following this template.

### With this, the administrator is able to block all roles not listed within the bucket policy.


## **s3BucketProvisioning**
### The Terraform version 4 upgrade recently broke the process of creating the s3 service. Follow this provided template within the s3provisioning* folder guides administraotr on easily provisioning Buckets with features like:
### - Private access
### - Encryption
### - Lifecycle configuration
### - Analytics configuration
### - Bucket ownership enforcement
### - Tagging configuration and many others.