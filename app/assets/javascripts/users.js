var BabysitterCalender  = function() {
  var startDate = null;
  var endDate = null;
  var beginningOfWeek = null;
  var _calenderEl = null;

  function bindEventListeners() {
    $('.booking-btn').on('click', function(e) {
      e.preventDefault();
      handleHourButtonClick($(this).data('time'));
    });
  }

  function init() {
    _calenderEl = $('#babysitter-calendar');
    beginningOfWeek = new Date(_calenderEl.data('time'));

    bindEventListeners();
  }

  function handleHourButtonClick(selectedHour) {
    var selectedTime = new Date(selectedHour);

    if (!startDate) {
      startDate = selectedTime;
    } else {
      endDate = selectedTime;
    }

    console.log(selectedTime);
  }

  init();

  return {
    beginningOfWeek: beginningOfWeek
  };
};

$(document).ready(function() {
  var calendar = new BabysitterCalender();
  console.log(calendar.beginningOfWeek);
});

