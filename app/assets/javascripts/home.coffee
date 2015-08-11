$('.infinite-table').infinitePages
 loading: ->
   $(this).text("Loading...")
 success: ->
 error: ->
    $(this).text("Trouble! Please drink some coconut water and click again")
