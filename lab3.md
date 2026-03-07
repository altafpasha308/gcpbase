# Terraform Lab 3 - GCS Remote Backend

---

## What is a Remote Backend?

```
┌──────────────────────────────────────────────────────────────┐
│              Local vs Remote Backend                         │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Local Backend (default):                                    │
│    terraform.tfstate → stored on your local machine         │
│    ⚠️  Lost if machine is deleted                            │
│    ⚠️  Cannot be shared with team                           │
│                                                              │
│  Remote Backend (GCS):                                       │
│    terraform.tfstate → stored in GCS bucket                 │
│    ✅ Persistent and safe                                    │
│    ✅ Shared across team                                     │
│    ✅ Supports state locking                                 │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 1: Navigate to Directory

```bash
cd ~/base/system
```

---

## Step 2: Check provider.tf for SA JSON Path

```bash
cat provider.tf
```

```
┌──────────────────────────────────────────────────────────────┐
│              provider.tf output                              │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  provider "google" {                                         │
│    credentials = file("/home/upgcloudevopstest_ac0cfc07_     │
│                        f7ec_/sa.json")                       │
│    project     = "your-gcp-project-id"                      │
│    region      = "us-central1"                              │
│  }                                                           │
│                                                              │
│  ← Copy the credentials path for use in backend.tf          │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 3: Create backend.tf

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
│              backend.tf Fields Explained                     │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  credentials → path to SA JSON key file                     │
│                (same path as in provider.tf)                │
│                                                              │
│  bucket      → GCS bucket name to store state file         │
│                (bucket created in Lab 2)                    │
│                                                              │
│  prefix      → folder path inside the bucket               │
│                state will be at:                            │
│                gs://amitow23test123/networking/             │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 4: terraform init

Re-initialize Terraform to migrate state to GCS backend.

```bash
terraform init
```

```
┌──────────────────────────────────────────────────────────────┐
│              terraform init output                           │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Initializing the backend...                                 │
│                                                              │
│  Successfully configured the backend "gcs"! ✅               │
│  Terraform will automatically use this backend              │
│  unless the backend configuration changes.                  │
│                                                              │
│  Initializing provider plugins...                            │
│  - Reusing previous version of hashicorp/google v6.8.0     │
│                                                              │
│  Terraform has been successfully initialized! ✅             │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 5: Verify State is Stored in GCS

```bash
# List bucket contents to confirm state file
gsutil ls gs://amitow23test123/networking/
```

```
┌──────────────────────────────────────────────────────────────┐
│              gsutil ls output                                │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  gs://amitow23test123/networking/default.tfstate            │
│                                                              │
│  State file is now stored remotely in GCS ✅                 │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 6: Commit and Push to GitHub

```bash
# Check status
git status

# Stage backend.tf
git add .

# Commit
git commit -m "Add GCS remote backend"

# Push to GitHub
git push origin main
```

---

## Full Flow Summary

```
┌──────────────────────────────────────────────────────────────┐
│                  Lab 3 Flow                                  │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  1. cat provider.tf        → get SA JSON file path          │
│  2. vi backend.tf          → configure GCS backend          │
│  3. terraform init         → migrate state to GCS           │
│  4. gsutil ls              → verify state in bucket         │
│  5. git add .              → stage files                    │
│  6. git commit -m "msg"    → commit                         │
│  7. git push origin main   → push to GitHub                 │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Quick Reference

| Command | Description |
|---|---|
| `cat provider.tf` | View provider config and SA path |
| `vi backend.tf` | Create backend config |
| `terraform init` | Initialize and migrate to remote backend |
| `gsutil ls gs://<bucket>/<prefix>/` | Verify state file in GCS |
| `git add .` | Stage all files |
| `git commit -m "message"` | Commit |
| `git push origin main` | Push to GitHub |

---

> **Note:** Never commit the `sa.json` key file to GitHub. Ensure it is listed in `.gitignore`. The `backend.tf` file only stores the **path** to the key, not the key itself.
