$ ->
  $(document).foundation()

  $("#flash_content").delay(500).slideDown "slow", ->
    $(this).delay(2500).slideUp "slow"
    return

  return
