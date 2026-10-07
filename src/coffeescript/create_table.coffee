nextColumnOrdinal = 0

addCol = ->
	prefix = "col-#{nextColumnOrdinal}"
	nextColumnOrdinal += 1
	newCol = $('#col-template').clone(true).attr('id', prefix)
	for parameter in ['name', 'type']
		newCol.find("[name='#{parameter}'").attr('name', "#{prefix}-#{parameter}")
	for type in ['discard', 'move-up', 'move-down']
		newCol.find("button.#{type}").attr('data-for', "##{prefix}")
	newCol.appendTo('#col-list').removeAttr('hidden inert')

$(document).ready ->
	$('#add-col').on 'click', addCol
	$('.discard').on 'click', -> $(this.getAttribute('data-for')).remove()

	# TODO: The repetition of logic here bothers me. I may be able to use some functional programming trickery to avoid
	# it.
	$('.move-up').on 'click', ->
		operand = $(this.getAttribute('data-for'))
		prev = operand.prev()
		return if prev.length is 0
		operand.detach().insertBefore(prev)

	$('.move-down').on 'click', ->
		operand = $(this.getAttribute('data-for'))
		next = operand.next()
		return if next.length is 0
		operand.detach().insertAfter(next)

	addCol()
