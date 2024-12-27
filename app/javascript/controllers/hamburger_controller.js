import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['button', 'menu', 'hamburgerIcon', 'xIcon'];

  connect() {
    // Ensure the button is visible and the menu is hidden initially
    this.buttonTarget.classList.remove('hidden');

    this.menuTarget.classList.add('hidden', 'md:block');
    this.menuTarget.setAttribute('aria-hidden', true);
  }

  toggle() {
    const isExpanded = this.buttonTarget.getAttribute('aria-expanded') === 'true';

    // Toggle aria-expanded
    this.buttonTarget.setAttribute('aria-expanded', !isExpanded);

    // Toggle menu visibility
    this.menuTarget.classList.toggle('hidden', isExpanded);
    this.menuTarget.setAttribute('aria-hidden', isExpanded);

    // Toggle icons
    this.hamburgerIconTarget.classList.toggle('hidden', !isExpanded);
    this.xIconTarget.classList.toggle('hidden', isExpanded);
  }
}
