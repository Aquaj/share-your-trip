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
  $(document).on 'changeDate', '#roadmap_start_date.bootstrap-datepicker', (evt) ->
    if $('#roadmap_start_date.bootstrap-datepicker').val() == $('#roadmap_end_date.bootstrap-datepicker').val() and $('#roadmap_end_date.bootstrap-datepicker').val() != ""
      $(".roadmap-activity .right").hide();
      $(".add-experience").each () ->
        this.href = this.href + "?single_day=true"
    else
      $(".roadmap-activity .right").show();
      $(".add-experience").each () ->
        this.href = this.href.split("?")[0]
  $(document).on 'changeDate', '#roadmap_end_date.bootstrap-datepicker', (evt) ->
    if $('#roadmap_start_date.bootstrap-datepicker').val() == $('#roadmap_end_date.bootstrap-datepicker').val() and $('#roadmap_end_date.bootstrap-datepicker').val() != ""
      $(".roadmap-activity .right").hide();
      $(".add-experience").each () ->
        this.href = this.href + "?single_day=true"
    else
      $(".roadmap-activity .right").show();
      $(".add-experience").each () ->
        this.href = this.href.split("?")[0]
