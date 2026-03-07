# Terraform Lab - GCP VPC Networking

---

## Step 1: Navigate to Networking Directory

```bash
cd ~/base/networking
```

---

## Step 2: Create vpc.tf

```bash
vi vpc.tf
```

Add the following content:

```hcl
resource "google_compute_network" "main-vpc" {
  name                    = "amit-01-vpc"              # Name of the VPC
  auto_create_subnetworks = false                      # Set to false for custom subnets
  description             = "Main VPC for Amit"        # Optional description
}

resource "google_compute_subnetwork" "subnet-1" {
  name          = "amit-subnet-1"                      # Name of the subnet
  ip_cidr_range = "10.0.0.0/24"                        # Subnet CIDR range
  region        = "us-east1"                           # Region for the subnet
  network       = google_compute_network.main-vpc.id   # Reference to the VPC
  description   = "Subnet 1 for Amit"
  private_ip_google_access = true                      # Enable private Google access
}

resource "google_compute_router" "main-router" {
  name    = "amit-router"
  region  = "us-east1"
  network = google_compute_network.main-vpc.id
}

resource "google_compute_router_nat" "main-nat" {
  name                               = "amit-nat"
  region                             = "us-east1"
  router                             = google_compute_router.main-router.name
  nat_ip_allocate_option             = "AUTO_ONLY"               # Automatically allocate NAT IP
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
```

```bash
# Save and exit vi
# Press Esc then type :wq and press Enter
```

---

## Resources Explained

```
┌──────────────────────────────────────────────────────────────┐
│              Networking Architecture                         │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  google_compute_network (VPC)                                │
│    name                    = amit-01-vpc                     │
│    auto_create_subnetworks = false  ← custom subnets only   │
│         │                                                    │
│         ▼                                                    │
│  google_compute_subnetwork (Subnet)                          │
│    name          = amit-subnet-1                             │
│    ip_cidr_range = 10.0.0.0/24                              │
│    region        = us-east1                                  │
│    private_ip_google_access = true                          │
│         │                                                    │
│         ▼                                                    │
│  google_compute_router                                       │
│    name   = amit-router                                      │
│    region = us-east1                                         │
│         │                                                    │
│         ▼                                                    │
│  google_compute_router_nat                                   │
│    name   = amit-nat                                         │
│    nat_ip_allocate_option = AUTO_ONLY                       │
│    source = ALL_SUBNETWORKS_ALL_IP_RANGES                   │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 3: terraform validate

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

## Step 4: terraform fmt

```bash
terraform fmt
```

```
┌──────────────────────────────────────────────────────────────┐
│              terraform fmt output                            │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  vpc.tf                                                      │
│                                                              │
│  Files formatted to canonical HCL style ✅                   │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 5: terraform plan --out tfout

```bash
terraform plan --out tfout
```

```
┌──────────────────────────────────────────────────────────────┐
│              terraform plan output                           │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  + resource "google_compute_network" "main-vpc"             │
│      + name                    = "amit-01-vpc"              │
│      + auto_create_subnetworks = false                       │
│                                                              │
│  + resource "google_compute_subnetwork" "subnet-1"          │
│      + name          = "amit-subnet-1"                       │
│      + ip_cidr_range = "10.0.0.0/24"                        │
│      + region        = "us-east1"                           │
│                                                              │
│  + resource "google_compute_router" "main-router"           │
│      + name   = "amit-router"                               │
│      + region = "us-east1"                                  │
│                                                              │
│  + resource "google_compute_router_nat" "main-nat"          │
│      + name   = "amit-nat"                                  │
│      + region = "us-east1"                                  │
│                                                              │
│  Plan: 4 to add, 0 to change, 0 to destroy.                 │
│  Saved the plan to: tfout ✅                                 │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 6: terraform apply tfout

```bash
terraform apply tfout
```

```
┌──────────────────────────────────────────────────────────────┐
│              terraform apply output                          │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  google_compute_network.main-vpc: Creating...               │
│  google_compute_network.main-vpc: Creation complete ✅        │
│                                                              │
│  google_compute_subnetwork.subnet-1: Creating...            │
│  google_compute_subnetwork.subnet-1: Creation complete ✅    │
│                                                              │
│  google_compute_router.main-router: Creating...             │
│  google_compute_router.main-router: Creation complete ✅     │
│                                                              │
│  google_compute_router_nat.main-nat: Creating...            │
│  google_compute_router_nat.main-nat: Creation complete ✅    │
│                                                              │
│  Apply complete! Resources: 4 added, 0 changed, 0 destroyed.│
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 7: terraform state list

```bash
terraform state list
```

```
┌──────────────────────────────────────────────────────────────┐
│              terraform state list output                     │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  google_compute_network.main-vpc                            │
│  google_compute_subnetwork.subnet-1                         │
│  google_compute_router.main-router                          │
│  google_compute_router_nat.main-nat                         │
│                                                              │
│  4 resources tracked in state ✅                             │
└──────────────────────────────────────────────────────────────┘
```

---

## Step 8: Commit and Push to GitHub

```bash
cd ~/base

# Check status
git status

# Stage all files
git add .

# Commit
git commit -m "Add VPC networking resources"

# Push to GitHub
git push origin main
```

---

## Full Flow Summary

```
┌──────────────────────────────────────────────────────────────┐
│                  Lab Flow                                    │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  1. vi vpc.tf              → write VPC resources            │
│  2. terraform validate     → check syntax                   │
│  3. terraform fmt          → format code                    │
│  4. terraform plan --out tfout → preview 4 resources        │
│  5. terraform apply tfout  → create VPC, subnet, router, NAT│
│  6. terraform state list   → verify 4 resources in state    │
│  7. git add . → commit → push → save to GitHub              │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Quick Reference

| Command | Description |
|---|---|
| `terraform validate` | Validate configuration |
| `terraform fmt` | Format Terraform files |
| `terraform plan --out tfout` | Preview and save plan |
| `terraform apply tfout` | Apply saved plan |
| `terraform state list` | List all resources in state |
| `terraform state show <resource>` | Show details of a resource |
| `terraform destroy` | Destroy all resources |
| `git add .` | Stage all files |
| `git commit -m "message"` | Commit |
| `git push origin main` | Push to GitHub |
