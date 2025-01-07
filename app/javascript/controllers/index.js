import { application } from "controllers/application"
import DatepickerController from "./datepicker_controller"
import MapController from "./map_controller"
import AddressAutocompleteController from "./address_autocomplete_controller"

application.register("datepicker", DatepickerController)
application.register("map", MapController)
application.register("address-autocomplete", AddressAutocompleteController)
