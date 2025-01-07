import { application } from "controllers/application"
import DatepickerController from "./datepicker_controller"
import MapController from "./map_controller"

application.register("datepicker", DatepickerController)
application.register("map", MapController)
