resource "aci_rest" "datetimeFormat" {
  dn         = "uni/fabric/format-default"
  class_name = "datetimeFormat"
  content = {
    displayFormat = var.display_format
    tz            = var.timezone
    showOffset    = var.show_offset == true ? "enabled" : "disabled"
  }
}
