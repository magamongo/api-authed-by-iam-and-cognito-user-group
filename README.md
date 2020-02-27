# api-authed-by-iam-and-cognito-user-group

A boilerplate of SAM-based API service which have following features  
- Users are managed by Cognito
- Users are grouped into two Cognito User Group(i.e. Admin and Member)
- Each user's API call is restricted according to his/her Cognito User Group(and IAM role attached to it)
- CORS enabled

## Requirements

* AWS CLI already configured with Administrator permission
* [Docker installed](https://www.docker.com/community-edition)
* [Golang](https://golang.org)
* [AWS-SAM-CLI](https://github.com/awslabs/aws-sam-cli)

## Setup

1. Build

```
make build
```

2. deploy  

Add `--capabilities CAPABILITY_NAMED_IAM` flag to avoid an error of `Requires capabilities : [CAPABILITY_NAMED_IAM]`.
In this SAM template, we create a new IAM role with a specified name and the action need an explicit confirmation with the flag.

```
sam deploy --capabilities CAPABILITY_NAMED_IAM
```

3. do some manual configs of Cognito  

- Cognito User Pool  
Go to the created Cognito User Pool's page in AWS Management console and
    - Create users
    - Add them to a User Group
In the default setting of this `template.yml`, the user management is bsically supposed to be done in AWS management console.

- Cognito ID Pool  
Go to the created Cognito ID Pool's page in AWS Management console and activate `Choose role from token` option of the corresponding Cognito User Pool.
I could not find this [config](https://docs.aws.amazon.com/ja_jp/cognito/latest/developerguide/cognito-user-pools-user-groups.html) in CFn [docs](https://docs.aws.amazon.com/ja_jp/AWSCloudFormation/latest/UserGuide/aws-properties-cognito-identitypool-cognitoidentityprovider.html).

## Call from browsers

To call the created API, you need to:
1. Log in
2. retrieve credentials(i.e. `accessKeyId`, `secretAccessKey`, `sessionToken`). [amazon-cognito-identity-js](https://www.npmjs.com/package/amazon-cognito-identity-js) would be helpful.
3. make a  AWS Signature Version 4 the credentials. [aws4](https://www.npmjs.com/package/aws4) would be helpful.
4. add the signature to the header and send a request

## Reference

- [RFC: API Gateway IAM (AWS_IAM) Authorizers](https://github.com/awslabs/serverless-application-model/issues/781)