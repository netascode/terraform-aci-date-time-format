terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  display_format = "utc"
  timezone       = "p120_Europe-Vienna"
  show_offset    = false
}

data "aci_rest" "datetimeFormat" {
  dn = "uni/fabric/format-default"

  depends_on = [module.main]
}

resource "test_assertions" "datetimeFormat" {
  component = "datetimeFormat"

  equal "displayFormat" {
    description = "displayFormat"
    got         = data.aci_rest.datetimeFormat.content.displayFormat
    want        = "utc"
  }

  equal "tz" {
    description = "tz"
    got         = data.aci_rest.datetimeFormat.content.tz
    want        = "p120_Europe-Vienna"
  }

  equal "showOffset" {
    description = "showOffset"
    got         = data.aci_rest.datetimeFormat.content.showOffset
    want        = "disabled"
  }
}
