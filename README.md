# AWS Floci Lab

Local AWS lab repo for learning AWS step by step without using real AWS.

Floci is the local AWS emulator.
`direnv` loads Floci environment variables when you enter this repo.

## Start Floci

```sh
floci start
```

## Load Floci env vars

`direnv` should load `.envrc` automatically when you enter the repo.

If needed:

```sh
direnv allow
```

## Verify AWS CLI points to Floci

```sh
aws sts get-caller-identity
echo $AWS_ENDPOINT_URL
```

Expected local values:
- Account: `000000000000`
- Arn: `arn:aws:iam::000000000000:root`
- Endpoint: `http://localhost.floci.io:4566`

Do not treat this lab as proof of real AWS behavior for edge cases like IAM or networking.
