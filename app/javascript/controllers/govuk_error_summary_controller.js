import { Controller } from "@hotwired/stimulus";
import { ErrorSummary } from "govuk-frontend";
import { gsap } from "gsap";

// Connects to data-module="govuk-error-summary"
export default class extends Controller {
  connect() {
    new ErrorSummary(this.element);

    this.animateErrorSummary();
  }

  animateErrorSummary() {
    const computedStyle = window.getComputedStyle(this.element);
    const finalStyles = {
      border: computedStyle.border,
      opacity: 1,
      height: "auto",
      padding: computedStyle.padding,
      marginBottom: computedStyle.marginBottom,
    };

    gsap.set(this.element, {
      borderLeftWidth: computedStyle.borderLeftWidth,
      borderRightWidth: computedStyle.borderRightWidth,
      height: 0,
      marginBottom: 0,
      opacity: 0,
      overflow: "hidden",
      paddingBottom: 0,
      paddingTop: 0,
    });

    gsap.to(this.element, {
      ...finalStyles,
      duration: 0.3,
      ease: "power2.out",
      onComplete: () => {
        gsap.set(this.element, { overflow: "visible" });
      },
    });
  }
}
