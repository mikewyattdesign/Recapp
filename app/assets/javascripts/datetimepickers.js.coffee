$(document).on "ready page:load", ->
  $("[data-behavior='datepicker']").datetimepicker({pickTime: false})
  $("[data-behavior='timepicker']").datetimepicker({
    pickDate: false
    })
  return
