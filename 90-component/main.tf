module "Component" {
for_each = var.components

source = "git::https://github.com/jai527/terraform-roboshop-component.git?ref=main"

Component = each.key
rule_priority = each.valve.rule_priority

}
