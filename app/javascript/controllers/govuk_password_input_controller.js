import { Controller } from "@hotwired/stimulus";
import { PasswordInput } from "govuk-frontend";

// Connects to data-module="govuk-password-input"
export default class extends Controller {
  connect() {
    new PasswordInput(this.element);
  }
}
