# Terraform Script for Spinning GCloud Compute Engine for Python App 
This Terraform script automates the setup of a virtual machine (VM) instance on Google Cloud Platform (GCP) with Python and Nginx installed. It's designed to provide a straightforward way to deploy a web server without the complexities of Docker or Kubernetes.

## Prerequisites

Before you begin, ensure you have the following installed and set up:

- Terraform CLI: [Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- Google Cloud Platform (GCP) account with appropriate permissions and credentials.

### How to create Google service account json
To get the JSON key file for a Google Cloud service account using the `gcloud` CLI, you can use the following command:

```bash
gcloud iam service-accounts keys create KEY_FILE.json --iam-account SERVICE_ACCOUNT_EMAIL
```

Here's what each part of the command does:

- `gcloud iam service-accounts keys create`: This command creates a new key for a service account.
- `KEY_FILE.json`: Specify the path and filename where you want to save the JSON key file. Replace `KEY_FILE.json` with your desired file name and path.
- `--iam-account SERVICE_ACCOUNT_EMAIL`: Replace `SERVICE_ACCOUNT_EMAIL` with the email address of the service account for which you want to create the key.

### Example:

If your service account email is `example@your-project-id.iam.gserviceaccount.com`, and you want to save the JSON key file as `my-service-account-key.json`, the command would be:

```bash
gcloud iam service-accounts keys create my-service-account-key.json --iam-account example@your-project-id.iam.gserviceaccount.com
```

After running this command, `my-service-account-key.json` will contain the JSON key file for the specified service account.

## Getting Started

1. Clone the repository:

   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. Initialize Terraform:

   ```bash
   terraform init
   ```

3. Customize `variables.tf`:

   Update `project`, `region`, `zone`, `instance_name`, and other variables as needed to match your GCP setup.

4. Review and apply the Terraform plan:

   ```bash
   terraform plan
   terraform apply
   ```

   This will create a new VM instance with Python latest and Nginx installed.

## Terraform Configuration Details

### Modules Used

- **Google Compute Engine Instance**: Creates a VM instance with specified machine type and boot disk.

- **Startup Script**: Configures the VM to run a startup script that installs Python and Nginx.

### Variables

- `project`: GCP project ID.
- `region`: GCP region.
- `zone`: GCP zone.
- `instance_name`: Name of the VM instance to create.
- Adjust other variables in `variables.tf` as per your requirements.

### Customization

You can modify the startup script (`metadata_startup_script` in `google_compute_instance`) to include additional setup steps or software installations as needed.

## Cleanup

To avoid incurring charges, remember to destroy the resources created by Terraform:

```bash
terraform destroy
```

## License

This project is licensed under the [MIT License](LICENSE).

## Contributing

Pull requests and contributions are welcome. For major changes, please open an issue first to discuss what you would like to change.

---