(function() {
  var addCol, nextColumnOrdinal;

  nextColumnOrdinal = 0;

  addCol = function() {
    var i, j, len, len1, newCol, parameter, prefix, ref, ref1, type;
    prefix = "col-" + nextColumnOrdinal;
    nextColumnOrdinal += 1;
    newCol = $('#col-template').clone(true).attr('id', prefix);
    ref = ['name', 'type'];
    for (i = 0, len = ref.length; i < len; i++) {
      parameter = ref[i];
      newCol.find("[name='" + parameter + "'").attr('name', prefix + "-" + parameter);
    }
    ref1 = ['discard', 'move-up', 'move-down'];
    for (j = 0, len1 = ref1.length; j < len1; j++) {
      type = ref1[j];
      newCol.find("button." + type).attr('data-for', "#" + prefix);
    }
    return newCol.appendTo('#col-list').removeAttr('hidden inert');
  };

  $(document).ready(function() {
    $('#add-col').on('click', addCol);
    $('.discard').on('click', function() {
      return $(this.getAttribute('data-for')).remove();
    });
    $('.move-up').on('click', function() {
      var operand, prev;
      operand = $(this.getAttribute('data-for'));
      prev = operand.prev();
      if (prev.length === 0) {
        return;
      }
      return operand.detach().insertBefore(prev);
    });
    $('.move-down').on('click', function() {
      var next, operand;
      operand = $(this.getAttribute('data-for'));
      next = operand.next();
      if (next.length === 0) {
        return;
      }
      return operand.detach().insertAfter(next);
    });
    return addCol();
  });

}).call(this);
