$ ->
  # convert bootstrap-datepicker value to rails date format (yyyy-mm-dd) on our hidden field
  $(document).on 'changeDate', '.bootstrap-datepicker', (evt) ->
    rails_date = evt.date.getFullYear() + '-' + ('0' + (evt.date.getMonth() + 1)).slice(-2) + '-' + ('0' + evt.date.getDate()).slice(-2)
    $(this).next("input[type=hidden]").val(rails_date)
  $(document).on 'changeDate', '.activity-date.bootstrap-datepicker', (evt) ->
    console.log(evt);
    console.log("activity/"+($(this)[0].id).split("-")[1]);
    $.ajax({
      method: "PATCH",
      url: "/activities/"+($(this)[0].id).split("-")[1],
      data: { planned_on: evt.date }
    });
