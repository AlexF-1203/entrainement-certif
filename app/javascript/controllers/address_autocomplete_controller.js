import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"
import mapboxgl from 'mapbox-gl'

export default class extends Controller {
  static targets = ["address", "map"]
  static values = { apiKey: String }

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address",
      mapboxgl: mapboxgl
    })
    this.geocoder.addTo(this.element)
    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())
  }

  #setInputValue(event) {
    this.addressTarget.value = event.result["place_name"]
    this.#initializeMap(event.result.center)
  }

  #clearInputValue() {
    this.addressTarget.value = ""
  }

  #initializeMap(coordinates) {
    mapboxgl.accessToken = this.apiKeyValue

    const map = new mapboxgl.Map({
      container: this.mapTarget,
      style: "mapbox://styles/mapbox/streets-v10",
      center: coordinates,
      zoom: 12
    })

    new mapboxgl.Marker()
      .setLngLat(coordinates)
      .addTo(map)
  }
}
