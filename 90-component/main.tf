module "component" {
  for_each      = var.components
  source        = "git::https://github.com/jai527/roboshop-infra-dev.git?ref=main"
  component     = each.key
  rule_priority = each.value.rule_priority
}