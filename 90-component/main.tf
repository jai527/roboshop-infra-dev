module "component" {
    for_each = var.components
    source = "git::https://github.com/jai527/terraform-roboshop-component.git"
    component = each.key
    rule_priority = each.value.rule_priority
  
}

