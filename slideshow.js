// https://www.htmlgoodies.com/beyond/javascript/stips/create-a-simple-automated-slideshow.html

jQuery.fn.center = function(parent) {
    parent = $(parent ? this.parent() : window);

    this.css({
        "position": "absolute",
        "top": (((parent.height() - this.outerHeight()) / 2) + parent.scrollTop() + "px"),
        "left": (((parent.width() - this.outerWidth()) / 2) + parent.scrollLeft() + "px")
    });
    return this;
}

jQuery.fn.setDivSize = function(extraHeight, extraWidth) {
  var img = new Image();
  img.src = this.children('img').attr('src');
  this.height(img.height + extraHeight)
      .width(img.width  + extraHeight);
  return this;
}

$(function() {
  var timerHandle,
      slideshowDiv = $('#slideshow'),
      divClone     = slideshowDiv.clone(),
      noOfSlides   = slideshowDiv.children('div').length;

  $('#start').click(function(evt) {
    var delay          = parseInt($("#interval option:selected").val()),
        order          = $('input[name=order]:checked').val(),
        effect         = $('input[name=effect]:checked').val(),
        transitionTime = parseInt($("#transitionTime option:selected").val());

    //debugger;
    $('#stop').trigger('click');

    switch ( order ) {
      case 'random':
        var divIndex = Math.floor(Math.random() * noOfSlides);
        $('#slideshow > div').eq(divIndex).prependTo($('#slideshow'));
        break;
      case 'reverse':
        var slides = $('#slideshow > div');
        $('#slideshow').append(slides.get().reverse());
        break;
      case 'shuffle':
        var slides = $('#slideshow > div');
        while (slides.length) {
          $('#slideshow').append(slides.splice(Math.floor(Math.random() * slides.length), 1)[0]);
        }
        break;
    }

    //show the first slide immediately
    $('#slideshow > div:first')
      .setDivSize(30, 40)
      .center()
      [(effect == 'fade' ? 'fadeIn' : 'slideDown')](transitionTime);

    play(order, noOfSlides, delay, effect, transitionTime);
  });

  $('#pause').click(function() {
    if (!timerHandle) return;

    with ($(this)) {
      toggleClass('paused');
      text(hasClass('paused')
           ? 'Continue Slideshow'
           : 'Pause Slideshow');
    }
  });

  $('#stop').click(function() {
    $('#pause').removeClass('paused').text('Pause Slideshow');
    clearTimeout(timerHandle);
    timerHandle = 0;
    $('#slideshow').replaceWith(divClone.clone());
  });

  $('#hide').click(function () {
    $header = $(this);
    $content = $('#controls');
    $content.slideToggle(500, function () {
        //execute this after slideToggle is done
        //change text of header based on visibility of content div
        $header.text(function () {
            //change text based on condition
            return $content.is(":visible") ? "-" : "+";
        });
    });
  });

  function play(order, noOfSlides, delay, effect, transitionTime) {
    timerHandle = setInterval(function() {
      if (!$('#pause').hasClass('paused')) {
        if (order === 'random') {
          var divIndex = Math.floor(Math.random() * (noOfSlides - 1)) + 1;
          //console.log(divIndex);
          //set the next() slide
          $('#slideshow > div')
            .eq(divIndex)
            .detach()
            .insertAfter( $('#slideshow > div:first') );
        }

        $('#slideshow > div:first')
          [( effect == 'fade' ? 'fadeOut' : 'slideUp')](transitionTime)
          .next()
          .setDivSize(30,40)
          .center()
          [( effect == 'fade' ? 'fadeIn' : 'slideDown')](transitionTime)
          .end()
          .appendTo('#slideshow');
      }
    },  delay);
  }
});
