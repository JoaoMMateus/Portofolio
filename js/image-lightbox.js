/* Click-to-zoom for the EXPERIENCE and PROJECTS images.
   Images are matched by their container, so new entries need no extra markup. */
$(function () {
  var selector = '.container-experience img, .container-projects img';
  var $overlay = $('#image-lightbox');
  if (!$overlay.length) return;
  var $zoomed = $overlay.find('img');

  $(selector).addClass('zoomable');

  function open(src, alt) {
    $zoomed.attr('src', src).attr('alt', alt || '');
    $overlay.addClass('is-open');
    /* force a reflow so the fade/scale transition starts from its closed state */
    void $overlay[0].offsetHeight;
    $overlay.addClass('is-visible');
  }

  function close() {
    if (!$overlay.hasClass('is-open')) return;
    $overlay.removeClass('is-visible');
    setTimeout(function () {
      if (!$overlay.hasClass('is-visible')) $overlay.removeClass('is-open');
    }, 250);
  }

  $(document).on('click', selector, function () {
    open(this.currentSrc || this.src, this.alt);
  });
  $overlay.click(close);
  $(document).keydown(function (e) {
    if (e.key === 'Escape' || e.keyCode === 27) close();
  });
});
