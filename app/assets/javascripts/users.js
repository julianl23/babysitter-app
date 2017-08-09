var BabysitterCalender  = function() {
  var userId = null;
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
    userId = _calenderEl.data('user');

    bindEventListeners();
  }

  function resetCalendar() {
    startDate = null;
    endDate = null;
  }

  function handleCreateSubmit() {
    if (!startDate || !endDate) {
      console.error('Missing startDate or endDate');
      return;
    }

    var data = {
      availability: {
        from: startDate.getTime(),
        to: endDate.getTime(),
        note: ''
      }
    };

    var url = '/users/' + userId + '/availabilities.json';
    var request = $.post(url, data);

    request.done(function(data) {
      console.log('success', data);
      resetCalendar();
    });

    request.fail(function(data) {
      console.log('failed', data);
    });
  }

  function handleHourButtonClick(selectedHour) {
    var selectedTime = new Date(selectedHour);

    if (!startDate) {
      startDate = selectedTime;
    } else {
      endDate = selectedTime;
      handleCreateSubmit();
    }

    console.log(selectedTime);
  }

  init();

  return {
    beginningOfWeek: beginningOfWeek,
    endDate: endDate,
    startDate: startDate
  };
};

$(document).ready(function() {
  var calendar = new BabysitterCalender();
});

