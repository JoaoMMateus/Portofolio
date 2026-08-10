/* Footer contact links come from data/contact.json and are rendered at runtime,
   so the address, phone number and profiles are edited in one place.
   Any element carrying data-contacts-src is filled in; data-contacts-labels
   set to "minimal" keeps icons only, except for entries marked showLabel:"always". */
(function () {
  var ALLOWED_SCHEMES = ['http:', 'https:', 'mailto:', 'tel:', 'sms:'];

  /* Replaces {email}, {phone}, ... with the top-level string fields of the file. */
  function fill(template, values) {
    return String(template || '').replace(/\{(\w+)\}/g, function (match, key) {
      return Object.prototype.hasOwnProperty.call(values, key) ? values[key] : match;
    });
  }

  function hasAllowedScheme(href) {
    var scheme = (href.match(/^[a-zA-Z][a-zA-Z0-9+.\-]*:/) || [''])[0].toLowerCase();
    return ALLOWED_SCHEMES.indexOf(scheme) !== -1;
  }

  function buildItem(link, values, showEveryLabel) {
    var href = fill(link.href, values);
    if (!hasAllowedScheme(href)) return null;

    var anchor = document.createElement('a');
    anchor.href = href;
    if (link.class) anchor.className = link.class;
    if (link.newTab) {
      anchor.target = '_blank';
      anchor.rel = 'noopener noreferrer';
    } else if (link.target) {
      anchor.target = link.target;
    }

    var icon = document.createElement('i');
    icon.className = 'fa ' + (link.icon || '');
    icon.setAttribute('aria-hidden', 'true');
    anchor.appendChild(icon);

    var label = fill(link.label, values);
    if (label && (showEveryLabel || link.showLabel === 'always')) {
      anchor.appendChild(document.createTextNode(' ' + label));
    } else if (label) {
      anchor.setAttribute('aria-label', label);
    }

    var item = document.createElement('li');
    item.className = 'list-inline-item';
    item.appendChild(anchor);
    return item;
  }

  function render(list, data) {
    var values = {};
    Object.keys(data).forEach(function (key) {
      if (typeof data[key] === 'string') values[key] = data[key];
    });

    var showEveryLabel = list.getAttribute('data-contacts-labels') !== 'minimal';
    var fragment = document.createDocumentFragment();

    (data.links || []).forEach(function (link) {
      var item = buildItem(link, values, showEveryLabel);
      if (item) fragment.appendChild(item);
    });

    list.appendChild(fragment);
  }

  document.addEventListener('DOMContentLoaded', function () {
    var lists = document.querySelectorAll('[data-contacts-src]');
    Array.prototype.forEach.call(lists, function (list) {
      fetch(list.getAttribute('data-contacts-src'))
        .then(function (response) {
          if (!response.ok) throw new Error('HTTP ' + response.status);
          return response.json();
        })
        .then(function (data) {
          render(list, data);
        })
        .catch(function (error) {
          console.error('Could not load footer contacts:', error);
        });
    });
  });
})();
