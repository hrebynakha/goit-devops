module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "test-django-app-lesson-7"
  table_name  = "terraform-locks"
}


module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
  private_subnets    = ["10.0.2.0/24", "10.0.4.0/24", "10.0.6.0/24"]
  availability_zones = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  vpc_name           = "test-lesson-7-vpc"
}


module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "lesson-7-ecr"
  scan_on_push = true
}


module "eks" {
  source          = "./modules/eks"          
  cluster_name    = "eks-lesson-7-ecr"            
  subnet_ids      = module.vpc.public_subnets     
  instance_type   = "t2.micro"                    
  desired_size    = 1                             
  max_size        = 2                             
  min_size        = 1                             
}