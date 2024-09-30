
brew update && brew install azure-cli

az login

az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"


To persist environment variables across terminal sessions, you can save them in a profile configuration file that gets sourced every time a new shell is opened.

### Steps to persist the environment variables:

1. **Open your terminal configuration file**:
   - For **bash**: Edit `~/.bashrc` or `~/.bash_profile`.
   - For **zsh**: Edit `~/.zshrc`.
   
2. **Add the environment variables** by appending the following lines, using the values returned from the Azure command:

   ```bash
   export AZURE_CLIENT_ID="xxxxxx-xxx-xxxx-xxxx-xxxxxxxxxx"
   export AZURE_CLIENT_SECRET="xxxxxx~xxxxxx~xxxxx"
   export AZURE_TENANT_ID="xxxxx-xxxx-xxxxx-xxxx-xxxxx"
   ```

Now, the variables will persist across terminal sessions. If you use these in your code or scripts, be cautious not to commit the `.bashrc` or equivalent file to version control if it contains sensitive credentials.

Additionally, consider using a more secure solution like Azure Key Vault to manage sensitive credentials in production environments.

No, the names don't have to be strictly `terraform.tfvars` and `variables.tf`, but there are some conventions and behaviors to be aware of when naming these files in Terraform.

### 1. **`terraform.tfvars`** (or `.auto.tfvars`):
   - Terraform **automatically loads** the `terraform.tfvars` file if it's in the root directory of your project.
   - **Alternative names**: 
     - You can also name the file with a `.auto.tfvars` suffix (e.g., `production.auto.tfvars`), and Terraform will automatically load it as well.
   
   Example:
   ```bash
   production.auto.tfvars   # Auto-loaded by Terraform
   ```
   
   - If you want to use a different name (like `prod.tfvars` or `dev.tfvars`), you need to **explicitly specify** the file when running Terraform commands.

   Example:
   ```bash
   terraform apply -var-file="prod.tfvars"
   ```

### 2. **`variables.tf`**:
   - The file name `variables.tf` is just a convention for organizing your code, and it's not required.
   - You can name the file anything (e.g., `vars.tf`, `resource_group_variables.tf`, `input_variables.tf`) or even define your variables in the main `.tf` file itself.
   - **Recommended convention**: It’s a best practice to use a descriptive name like `variables.tf` to make the purpose of the file clear.

### Example of Custom Naming:

- **Custom `tfvars` file**:
  ```bash
  my_environment.tfvars
  ```
  Then apply with:
  ```bash
  terraform apply -var-file="my_environment.tfvars"
  ```

- **Custom variable definition file**:
  You can name it anything, such as `my_variables.tf`, and Terraform will pick up the variables as long as they’re properly defined inside the file.

### Summary:
- **`terraform.tfvars`** and `.auto.tfvars` are **auto-loaded** by Terraform, but you can use any name if you explicitly specify the file with the `-var-file` flag.
- **`variables.tf`** is just a naming convention for organizing variable definitions. You can name this file anything you like, but keeping descriptive names is recommended for clarity and maintainability.


Technically, you can use a `terraform.tfvars` file **without** defining variables in a `variables.tf` file, but it's not recommended for larger or more complex projects. Here's why both are typically used together:

### Why You Should Still Use `variables.tf`:
- **Documentation and Clarity**: Defining variables in `variables.tf` allows you to provide descriptions, types, and defaults. This makes your configuration easier to understand for anyone reading or using it.
- **Input Validation**: You can enforce types, constraints, and validation rules on variables in `variables.tf`. For example, ensuring a variable is a string or falls within a certain set of values.
- **Optional Defaults**: Variables in `variables.tf` can have default values, so users only need to provide a value when they want to override the default.

### Example Without `variables.tf` (Minimal Approach):
If you skip `variables.tf`, you can just use `terraform.tfvars`:

```hcl
# terraform.tfvars
resource_group_name    = "myResourceGroup"
resource_group_location = "eastus"
```

However, in this approach:
- You lose the ability to enforce variable types, provide descriptions, or set optional defaults.
- This can make your Terraform configuration harder to understand, especially for others or if the project grows over time.

### Example With Both `variables.tf` and `terraform.tfvars` (Best Practice):
Using both files, you get the benefits of structure, clarity, and flexibility:

```hcl
# variables.tf
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "myTFResourceGroup"
}

variable "resource_group_location" {
  description = "Location of the resource group"
  type        = string
  default     = "westus2"
}
```

```hcl
# terraform.tfvars (for environment-specific overrides)
resource_group_name    = "myProductionResourceGroup"
resource_group_location = "eastus"
```

### Conclusion:
While **you can use `terraform.tfvars` without `variables.tf`**, it's not the ideal approach for larger projects. **Using `variables.tf` is recommended** for documentation, validation, and better maintainability, while `terraform.tfvars` or other `.tfvars` files are great for overriding those values in different environments.