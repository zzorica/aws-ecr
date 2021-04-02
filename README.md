# aws-ecr
Build image from and push to AWS ECR

## Parameters
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `access_key_id` | `string` | | Your AWS access key id |
| `secret_access_key` | `string` | | Your AWS secret access key |
| `account_id` | `string` | | Your AWS Account ID |
| `repo` | `string` | | Name of your ECR repository |
| `region` | `string` | | Your AWS region |
| `create_repo` | `boolean` | `false` | Set this to true to create the repository if it does not already exist |
| `tags` | `string` | `latest` | Comma-separated string of ECR image tags (ex latest,1.0.0,) |
| `dockerfile` | `string` | `Dockerfile` | Name of Dockerfile to use |
| `extra_build_args` | `string` | `""` | Extra flags to pass to docker build (see docs.docker.com/engine/reference/commandline/build) |
| `path` | `string` | `.` | Path to Dockerfile, defaults to the working directory |
