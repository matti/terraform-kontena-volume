module "volume1" {
  source = ".."

  name   = "test1"
  driver = "local"
  scope  = "grid"
}

module "volume2" {
  source = ".."

  name        = "test2"
  driver      = "local"
  driver_opts = ["type=golden", "speed=10k"]
  scope       = "grid"
}
