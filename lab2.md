# Terraform GCP - Create GCS Bucket Lab

---

## Step 1: Navigate to Lab Directory

```bash
cd ~/base/system
```

---

## Step 2: Create main.tf with GCS Bucket Resource

```bash
vi main.tf
```

Add the following content:

```hcl
resource "google_storage_bucket" "example" {
  name          = "amitow23test123"  # change to a globally unique name
  location      = "US"
  force_destroy = true
}
```

```bash
# Save and exit vi
# Press Esc then type :wq and press Enter
```

```
┌──────────────────────────────────────────────────────────────┐
│              GCS Bucket Resource Explained                   │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  name          → globally unique bucket name                │
│  location      → US (multi-region)                          │
│  force_destroy → allows bucket deletion even if not empty   │
│                                                              │
│  ⚠️  Bucket names must be globally unique across all GCP    │
│     Change "amitow23test123" to your own unique name        │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 3: terraform fmt

Formats all Terraform files to canonical style.

```bash
terraform fmt
```

```
┌──────────────────────────────────────────────────────────────┐
│              terraform fmt output                            │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  main.tf                                                     │
│                                                              │
│  Files reformatted to canonical HCL style ✅                 │
│  (no output = already formatted)                            │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 4: terraform validate

Validates the Terraform configuration for syntax errors.

```bash
terraform validate
```

```
┌──────────────────────────────────────────────────────────────┐
│              terraform validate output                       │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Success! The configuration is valid. ✅                     │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 5: terraform plan --out tfout

Previews what Terraform will create and saves plan to file.

```bash
terraform plan --out tfout
```

```
┌──────────────────────────────────────────────────────────────┐
│              terraform plan output                           │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Terraform used the selected providers to generate the      │
│  following execution plan.                                   │
│                                                              │
│  + resource "google_storage_bucket" "example" {             │
│      + name          = "amitow23test123"                     │
│      + location      = "US"                                  │
│      + force_destroy = true                                  │
│    }                                                         │
│                                                              │
│  Plan: 1 to add, 0 to change, 0 to destroy.                 │
│                                                              │
│  Saved plan to: tfout ✅                                     │
└──────────────────────────────────────────────────────────────┘
```

```
┌──────────────────────────────────────────────────────────────┐
│              --out tfout Explained                           │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  terraform plan --out tfout                                  │
│    → saves the plan to a binary file called 'tfout'         │
│    → used in next step: terraform apply tfout               │
│    → ensures exactly what was reviewed gets applied         │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 6: terraform apply tfout

Applies the saved plan file.

```bash
terraform apply tfout
```

```
┌──────────────────────────────────────────────────────────────┐
│              terraform apply output                          │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  google_storage_bucket.example: Creating...                 │
│  google_storage_bucket.example: Creation complete after 2s  │
│                                                              │
│  Apply complete! Resources: 1 added, 0 changed, 0 destroyed.│
│                                                              │
│  ✅ GCS Bucket created successfully                          │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 7: Verify Bucket Created on GCP

```bash
# Verify using gcloud
gsutil ls

# Or list with details
gsutil ls -L gs://amitow23test123
```

```
┌──────────────────────────────────────────────────────────────┐
│              gsutil ls output                                │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  gs://amitow23test123/                                       │
│                                                              │
│  Bucket is now visible in GCP Console → Cloud Storage ✅    │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 8: Commit and Push to GitHub

```bash
# Verify current directory
pwd

# Check status
git status

# Stage all files
git add .

# Verify what is staged
git status
```

```
┌──────────────────────────────────────────────────────────────┐
│              git status output                               │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Changes to be committed:                                    │
│    new file:   main.tf                                       │
│                                                              │
│  Ignored files (not staged due to .gitignore):              │
│    .terraform/                                               │
│    terraform.tfstate                                         │
│    tfout                                                     │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

```bash
# Commit
git commit -m "Add GCS bucket resource"

# Push to GitHub
git push origin main
```

---

## Full Terraform Workflow Summary

```
┌──────────────────────────────────────────────────────────────┐
│              Terraform Workflow                              │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  1. vi main.tf            → write resource                  │
│  2. terraform fmt         → format code                     │
│  3. terraform validate    → check for errors                │
│  4. terraform plan --out tfout → preview changes            │
│  5. terraform apply tfout → create resources                │
│  6. gsutil ls             → verify on GCP                   │
│  7. git add .             → stage files                     │
│  8. git commit -m "msg"   → commit                          │
│  9. git push origin main  → push to GitHub                  │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Quick Reference

| Command | Description |
|---|---|
| `terraform fmt` | Format Terraform files |
| `terraform validate` | Validate configuration |
| `terraform plan --out tfout` | Preview and save plan |
| `terraform apply tfout` | Apply saved plan |
| `terraform apply` | Apply with interactive approval |
| `terraform destroy` | Destroy all resources |
| `gsutil ls` | List GCS buckets |
| `git add .` | Stage all files |
| `git commit -m "message"` | Commit staged files |
| `git push origin main` | Push to GitHub |

---

> **Note:** Always add `tfout` to `.gitignore` as it may contain sensitive data. Update your `.gitignore` to include `tfout` alongside `.terraform` and `*.tfstate`.
