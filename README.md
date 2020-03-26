
<!-- Module Name and description are required -->
# Module Name

Module description

<!-- Compatibility section is optional -->
## Compatibility

This is where you might mention what module version(s) are compatible with
which Terraform verion(s).

<!-- Usage section is required -->
## Usage

<!-- NOTE: Examples should go into an `/examples` directory, with a link here
along the following lines:

There are multiple examples included in the [examples](./examples/) folder but 
simple usage is as follows:
 -->
Sample module block showing required fields configured.  You can have
multiple examples if it makes sense for the module.

```hcl
module "your_custom_name_for_your_instance_of_this_module" {
  source                = "git@github.com:thesis/this-module-name.git"
  name                  = "name-of-your-project"
  org_id                = "your-org-id"
  billing_account       = "your-billing-account"
  project_owner_members = ["john@email.co", "lilly@email.co",]
  location              = "us-central1"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- The following Inputs example will be over-written by pre-commit hooks, 
  and is here only as an example in case you opt not to use the hooks. -->
## Inputs

Table of available module inputs in the format:

|Name | Description | Type |Default | Required
--- | --- | --- | --- | --- |
`inputName`| Description of this input | input type | `default value` | boolean

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Notes section is optional -->
## Notes

Anything quirky about the module folks may want to know about. Relevant
links or additional useful information.  Format is up to you.

<!-- License is required -->
## License 

See [LICENSE](./LICENSE) for full details.

<!-- Before open-sourcing this module, Remove this comment and update the
  LICENSE file at the repo root. Else: Copyright Thesis, Inc., 2020 -->
