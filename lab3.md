# Terraform Lab - Networking Directory Setup

---

## Step 1: Navigate to Base Directory

```bash
cd ~/base
```

---

## Step 2: Create Networking Directory

```bash
mkdir networking
cd networking
```

---

## Step 3: Create provider.tf

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
  credentials = file("/home/upgcloudevopstest_ac0cfc07_f7ec_/sa.json")
  project     = "your-gcp-project-id"
  region      = "us-central1"
}
```

```bash
# Save and exit vi
# Press Esc then type :wq and press Enter
```

---

## Step 4: Create backend.tf

```bash
vi backend.tf
```

Add the following content:

```hcl
terraform {
  backend "gcs" {
    credentials = "/home/upgcloudevopstest_ac0cfc07_f7ec_/sa.json"
    bucket      = "amitow23test123"
    prefix      = "networking"
  }
}
```

```bash
# Save and exit vi
# Press Esc then type :wq and press Enter
```

```
┌──────────────────────────────────────────────────────────────┐
│              backend prefix = "networking"                   │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  State file will be stored at:                              │
│  gs://amitow23test123/networking/default.tfstate            │
│                                                              │
│  Each directory uses its own prefix to keep                 │
│  state files separate inside the same bucket.               │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 5: Create .gitignore

```bash
vi .gitignore
```

Add the following content:

```
.terraform
*.tfstate
tfout
```

```bash
# Save and exit vi
# Press Esc then type :wq and press Enter
```

---

## Step 6: Initialize Terraform

```bash
terraform init
```

```
┌──────────────────────────────────────────────────────────────┐
│              terraform init output                           │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Initializing the backend...                                 │
│  Successfully configured the backend "gcs"! ✅               │
│                                                              │
│  Initializing provider plugins...                            │
│  - Installing hashicorp/google v6.8.0...                    │
│                                                              │
│  Terraform has been successfully initialized! ✅             │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 7: Verify Directory Structure

```bash
ls -la
```

```
┌──────────────────────────────────────────────────────────────┐
│              Final Directory Structure                       │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  base/                                                       │
│  ├── system/                                                 │
│  │   ├── provider.tf                                         │
│  │   ├── backend.tf                                          │
│  │   ├── main.tf                                             │
│  │   └── .gitignore                                          │
│  └── networking/           ← new directory                  │
│      ├── provider.tf                                         │
│      ├── backend.tf                                          │
│      └── .gitignore                                          │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 8: Commit and Push to GitHub

```bash
# Go back to base directory
cd ~/base

# Check status
git status

# Stage networking directory
git add .

# Commit
git commit -m "Add networking directory with provider and backend"

# Push to GitHub
git push origin main
```

---

## Quick Reference

| Command | Description |
|---|---|
| `mkdir networking` | Create networking directory |
| `cd networking` | Navigate into directory |
| `vi provider.tf` | Create provider config |
| `vi backend.tf` | Create backend config |
| `vi .gitignore` | Create gitignore |
| `terraform init` | Initialize Terraform |
| `ls -la` | Verify files created |
| `git add .` | Stage all files |
| `git commit -m "message"` | Commit |
| `git push origin main` | Push to GitHub |
