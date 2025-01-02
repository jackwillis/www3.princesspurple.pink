// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import '@hotwired/turbo-rails';
import 'controllers';

document.addEventListener('turbo:load', () => {
  // If the page has a Trix editor, import Trix & ActionText
  if (document.querySelector('trix-editor')) {
    import('trix');
    import('@rails/actiontext');
  }
});
