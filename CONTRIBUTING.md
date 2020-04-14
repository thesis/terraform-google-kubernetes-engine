# Contributing to this module


This repo provides a template for creating a new Terraform module, following
the [standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure) required for publishing to the Terraform
Registry.

## Getting Started

<!-- After creating your copy of the repo, you should replace this section with any
information specific to development on your module. :)
 -->

This repo has been set up as a Github template repo. You can generate a new
repo from this one using the "Use this template" option above the "Clone or
download" button.


## Pre-commit hooks

We use [Terraform pre-commit hooks](https://github.com/antonbabenko/pre-commit-terraform)
to ensure consitent formatting and to auto-generate documentation.

### Installation
Make sure you have all [pre-commit](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md#1-install-dependencies) installed, then run `pre-commit install` at
the root of your repo.

### Usage

If you prefer to generate your own docs, keep the following line commented out
in `.pre-commit.yaml`:  `- id: terraform_docs`. Keep in mind, however, that if
you choose to publish your module to the Terraform Registry, docs will be auto-
generated, so you may want to keep that hook in place to see how it behaves
before you publish.

If you want to use the terraform_docs pre-commit hook, uncomment the above line.

This hook will delete and replace anything in your `README.md` between the
following lines:

```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
```

## Version tags

We're using a github action to automatically create tags and bump the version
on merge to master.

We have already installed this action here.

For full usage instructions, consult the [official documentation](https://github.com/marketplace/actions/github-tag-bump#usage)

The action will automatically run at your PR merge to master.


### Recommended Workflow and Settings

The first merge to master will create a tag (`0.1.0`)if no tag is present. All
versions prior to open-sourcing your module should remain lower than `1.0.0`

The only required environment variable is `GITHUB_TOKEN`, which github
automatically generates. While it's sourced via `${{ secrets.GITHUB_TOKEN }}`,
you will not see it in your repo's secrets dashboard.

Set any [optional environment variables](https://github.com/marketplace/actions/github-tag-bump#options)

We recommend the following:
- Leave `DEFAULT_BUMP` at its default ("minor").
- Do not change the `fetch-depth` config value in the settings for the
`actions/checkout@master` action used by the Bump tag action.
- A depth of "1" means the merge commit is the only commit fetched in order to
determine bump version.
- Make sure the merge commit contains either the `#major` or `#patch` tag, if
the given PR is not a "minor" version release.
