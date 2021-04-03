# aws-ecr
Build and push image to AWS ECR inside Github Actions workflow.

## Parameters
| Parameter | Type | Default | Required | Description |
|-----------|------|---------|----------|-------------|
| `access_key_id` | `string` | | yes | Your AWS access key id |
| `secret_access_key` | `string` | |yes | Your AWS secret access key |
| `account_id` | `string` | | yes | Your AWS Account ID |
| `repo` | `string` | | yes | Name of your ECR repository |
| `region` | `string` | | yes | Your AWS region |
| `create_repo` | `boolean` | `false` | no | Set this to true to create the repository if it does not already exist |
| `tags` | `string` | `latest` | no | Comma-separated string of ECR image tags (ex latest,1.0.0,) |
| `dockerfile` | `string` | `Dockerfile` | no | Name of Dockerfile to use |
| `extra_build_args` | `string` | `""` | no | Extra flags to pass to docker build (see docs.docker.com/engine/reference/commandline/build) |
| `path` | `string` | `.` | no | Path to Dockerfile, defaults to the working directory |

# Usage example

Here is an example of workflow. Included is a small trick for setting environment values from branch name and using a short SHA also as a tag value.

```
name: Build and push image to ECR

on:
  push:
    branches:
      - master
      - develop
    paths-ignore:
      - README.md

jobs:
  build-and-push:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Set short SHA value
        run: |
          echo "SHORT_SHA=`echo ${GITHUB_SHA} | cut -c1-8`" >> $GITHUB_ENV 
      - name: Set env to staging
        if: endsWith(github.ref, '/develop')
        run: |
          echo "ENVIRONMENT=staging" >> $GITHUB_ENV
      - name: Set env to production
        if: endsWith(github.ref, '/master')
        run: |
          echo "ENVIRONMENT=production" >> $GITHUB_ENV
      - uses: docker://zzorica/aws-ecr:latest
        with:
          access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          account_id: ${{ secrets.AWS_ACCOUNT_ID }}
          repo: reponame
          region: us-east-1
          tags: ${{ env.ENVIRONMENT }},${{ env.SHORT_SHA }}
          create_repo: false
```