var Calendar = function() {
  var userId = null;
  var userRole = null;
  var startDate = null;
  var endDate = null;
  var beginningOfWeek = null;
  var _calenderEl = null;
  var _selectedWindowWrapEl = null;
  var _selectedWindowEl = null;
  var _submitEl = null;

  function init() {
    _calenderEl = $('#calendar');
    _selectedWindowWrapEl = $('#selected-window-wrap');
    _selectedWindowEl = $('#selected-window');
    _submitEl = $('#submit-window');
    beginningOfWeek = new Date(_calenderEl.data('time'));
    userId = _calenderEl.data('user');
    userRole = _calenderEl.data('user-role');

    bindEventListeners();
  }

  function bindEventListeners() {
    $('.booking-btn').on('click', function(e) {
      e.preventDefault();
      handleHourButtonClick(this);
    });

    _submitEl.on('click', function(e) {
      e.preventDefault();
      handleCreateSubmit();
    });
  }

  function handleHourButtonClick(_el) {
    var selectedHour = $(_el).data('time');
    var selectedTime = new Date(selectedHour);

    if (startDate && selectedTime.getTime() === startDate.getTime()) {
      $('.booking-btn').removeClass('selected');
      $('.calendar-hour').removeClass('selected');
      resetCalendar();
      return;
    }

    if ($(_el).hasClass('selected')) {
      $(_el).removeClass('selected');
      $(_el).parent().removeClass('selected');
    } else if ($('.booking-btn.selected').length <= 2) {
      if (endDate) {
        $('.booking-btn[data-time="' + endDate.getTime() + '"]').removeClass('selected');
      }

      if (startDate > selectedTime) {
        return false;
      }

      $(_el).addClass('selected');
      $(_el).parent().addClass('selected');
    }

    if (!startDate) {
      startDate = selectedTime;
    } else {
      endDate = selectedTime;

      // highlight all the cells in between, unless it's before the startDate
      $('.calendar-hour').each(function(index, cell) {
        var cellDateString = $('.booking-btn', cell).data('time');
        var cellDate = new Date(cellDateString).getTime();

        if (cellDate >= startDate && cellDate <= endDate) {
          $(cell).addClass('selected');
        } else {
          $(cell).removeClass('selected');
        }
      });

      // Show the submit button
      _selectedWindowEl.text(startDate.toString() + ' - ' + endDate.toString());
      _selectedWindowWrapEl.removeClass('hide');
    }

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
      //
      window.location.reload();
    });

    request.fail(function(data) {
      // TODO: Don't use alerts, either hook into flash or make an element in JS
      alert('Unable to save availability');
    });
  }

  function resetCalendar() {
    startDate = null;
    endDate = null;
    _selectedWindowEl.text('');
    _selectedWindowWrapEl.addClass('hide');
  }

  init();

  return {
    beginningOfWeek: beginningOfWeek,
    endDate: endDate,
    startDate: startDate
  };
};


$(document).on('turbolinks:load', function() {
  var calendar = new Calendar();
});

