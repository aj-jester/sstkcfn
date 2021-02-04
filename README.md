# SstkCfn

AWS-SDK + CfnDsl wrapper to launch AWS CloudFormation stacks

#### Table of Contents

1. [Installation](#installation)
1. [Configuration](#configuration)
1. [Launch stack](#launch-stack)
1. [Config order](#config-order)
1. [Commands](#commands)

## Installation
* Clone this repo
* Install the following ruby gems
    * aws-sdk
    * cfndsl
    * cri
    * text-table

    If using RVM you can import **sstkcfn.gem** gemset.

* Move `stacks.example` to $HOME and rename.

    `mv stacks.example ~/stacks`
    ```
    $HOME
    ├── stacks
    |   ├── data_fragments
    |   ├── dsl
    |   |   └── fragment
    |   └── params
    ```

## Configuration
1. Copy the example config `sstkcfn.yaml.example` to $HOME and rename.

    `cp sstkcfn.yaml.example ~/.sstkcfn.yaml`.

1. Update `template:stack_dir` with path to `<home_dir>/stacks`.

1. Update `aws` with AWS API credentials.
    * Ensure the user has the following AWS policy permissions
   ```
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Action": [
                  "cloudformation:*",
                  "ec2:*"
              ],
              "Resource": "*"
          }
      ]
  }
   ```

## Launch stack
1. Add a dsl to `<home_dir>/stacks/dsl/`
    * See `stacks.example/dsl/ec2-instance.rb` to get started.
    * https://github.com/neillturner/cfndsl_examples

1. Run `create-stack` command

    `$ bin/sstkcfn create-stack --environment dev --name ec2-instance`
    
    `name` must match the dsl file name.

    `environment` can be anything, this might change in the future.
    
1. Run `stack-events` to see the status

    `$ bin/sstkcfn stack-events --environment dev --name ec2-instance`
    
## Config order
Configuration loads in the following order

* /etc/sstkcfn.yaml
* ~/sstkcfn.yaml
* ~/.sstkcfn.yaml
    
## Commands
#### `create-stack`
`$ bin/sstkcfn create-stack --environment dev --name ec2-instance`

#### `update-stack`
`$ bin/sstkcfn update-stack --environment dev --name ec2-instance`

#### `delete-stack`
`$ bin/sstkcfn delete-stack --environment dev --name ec2-instance`

#### `stack-events`
`$ bin/sstkcfn stack-events --environment dev --name ec2-instance`

#### `gen-template`
`$ bin/sstkcfn gen-template --environment dev --name ec2-instance`

#### `gen-fragment`
`$ bin/sstkcfn gen-fragment --environment dev --name ec2-instance`

#### `help`
`$ bin/sstkcfn --help`
