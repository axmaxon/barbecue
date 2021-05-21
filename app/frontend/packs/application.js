// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/frontend and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import "../styles/application.scss"
import "bootstrap/dist/js/bootstrap.js"
import "../scripts/datepicker.js"
import "../scripts/datepicker.min.js"

const images = require.context('../images/', true)

Rails.start()
