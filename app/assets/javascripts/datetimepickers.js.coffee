$(document).on "ready page:load", ->
  $("[data-behavior='datepicker']").datetimepicker({pickTime: false, useCurrent: false})
  $("[data-behavior='timepicker']").datetimepicker({
    pickDate: false, useCurrent: false, defaultDate: moment().startOf('day')
    })
  return
