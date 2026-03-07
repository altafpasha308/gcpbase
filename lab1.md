# Terraform on GCP - Setup Lab

---

## Step 1: Login to GCP and Cloud Shell

```
1. Go to https://console.cloud.google.com
2. Login with your Google account
3. Click the Cloud Shell icon at the top right  >_
```

### Verify Tools in Cloud Shell

```bash
# List your GCP projects
gcloud projects list

# Verify Terraform is installed
terraform --version

# Verify Git is installed
git --version
```

```
┌──────────────────────────────────────────────────────────────┐
│              Cloud Shell Tool Versions                       │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  gcloud projects list                                        │
│  PROJECT_ID        NAME          PROJECT_NUMBER             │
│  my-gcp-project    My Project    123456789                   │
│                                                              │
│  terraform --version                                         │
│  Terraform v1.x.x                                           │
│                                                              │
│  git --version                                               │
│  git version 2.x.x                                          │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 2: Create Service Account with Owner Permission

```
1. Go to GCP Console → IAM & Admin → Service Accounts
2. Click 'Create Service Account'
3. Fill in:
   - Name        : terraform-sa
   - Description : Terraform Service Account
4. Click 'Create and Continue'
5. Role → Select 'Owner'
6. Click 'Continue' → Click 'Done'
7. Click on the created service account
8. Go to 'Keys' tab → 'Add Key' → 'Create new key'
9. Select JSON → Click 'Create'
10. JSON key file downloads automatically
11. Upload the JSON file to Cloud Shell
```

```
┌──────────────────────────────────────────────────────────────┐
│         IAM & Admin → Service Accounts → Create             │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Name        : terraform-sa                                  │
│  Role        : Owner                                         │
│  Key Type    : JSON  ← download this file                   │
│                                                              │
│  Navigation:                                                 │
│  IAM & Admin                                                 │
│       └── Service Accounts                                  │
│                  └── Create Service Account                 │
│                         └── Keys → Add Key → JSON           │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 3: Create Project Directory Structure

```bash
# Create base directory
mkdir base
cd base

# Create system directory
mkdir system
cd system
```

---

## Step 4: Create provider.tf

```bash
vi provider.tf
```

Add the following content:

```hcl
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  credentials = file("your-json-file-location")
  project     = "your-gcp-project-id"
  region      = "us-central1"
}
```

```bash
# Save and exit vi
# Press Esc then type :wq and press Enter
```

```
┌──────────────────────────────────────────────────────────────┐
│              provider.tf Values to Update                    │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  credentials = file("your-json-file-location")              │
│    → replace with path to your downloaded JSON key file     │
│    → example: file("/home/user/terraform-sa.json")          │
│                                                              │
│  project = "your-gcp-project-id"                            │
│    → replace with your actual GCP project ID                │
│    → example: "my-gcp-project-123"                          │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 5: Initialize Terraform

```bash
terraform init
```

```
┌──────────────────────────────────────────────────────────────┐
│              terraform init output                           │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Initializing the backend...                                 │
│  Initializing provider plugins...                            │
│  - Finding hashicorp/google versions matching "6.8.0"...    │
│  - Installing hashicorp/google v6.8.0...                    │
│  - Installed hashicorp/google v6.8.0                        │
│                                                              │
│  Terraform has been successfully initialized! ✅             │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

```bash
# Verify .terraform directory created
ls -la
```

---

## Step 6: Initialize Git Repository

```bash
git init

# Configure git user
git config --global user.name learner
git config --global user.email learner@ow.com
```

---

## Step 7: Create .gitignore

```bash
vi .gitignore
```

Add the following content:

```
.terraform
*.tfstate
```

```bash
# Save and exit vi
# Press Esc then type :wq and press Enter
```

```
┌──────────────────────────────────────────────────────────────┐
│              .gitignore Explanation                          │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  .terraform   → provider binaries (large, auto-downloaded)  │
│  *.tfstate    → state files (contain sensitive info)        │
│                                                              │
│  These should NEVER be committed to Git.                    │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 8: Create Remote Repo on GitHub

```
1. Go to https://github.com
2. Click '+' → New repository
3. Fill in:
   - Name       : base
   - Visibility : Public or Private
   - Do NOT initialize with README
4. Click 'Create repository'
5. Copy the HTTPS URL
```

---

## Step 9: Push to GitHub

```bash
# Stage all files
git add .

# Commit
git commit -m "Add"

# Add remote origin (replace with your repo URL)
git remote add origin https://github.com/<your-username>/base.git

git branch -M main

# Push to GitHub
git push origin main
```

---

## Full Directory Structure

```
┌──────────────────────────────────────────────────────────────┐
│              Final Directory Structure                       │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  base/                                                       │
│  └── system/                                                 │
│       ├── provider.tf      ← Terraform provider config      │
│       ├── .gitignore       ← excludes .terraform + tfstate  │
│       └── .terraform/      ← ignored (not pushed to Git)    │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Quick Reference

| Command | Description |
|---|---|
| `gcloud projects list` | List GCP projects |
| `terraform --version` | Check Terraform version |
| `terraform init` | Initialize Terraform providers |
| `git init` | Initialize Git repo |
| `git config --global user.name <n>` | Set Git username |
| `git config --global user.email <email>` | Set Git email |
| `git add .` | Stage all files |
| `git commit -m "message"` | Commit staged files |
| `git remote add origin <url>` | Link to remote repo |
| `git push origin main` | Push to GitHub |

---

> **Note:** Never commit your JSON key file to Git. Add it to `.gitignore` or store it outside the project directory. The `.terraform` folder and `.tfstate` files must always be excluded from version control.
