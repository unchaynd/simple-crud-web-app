(function() {
  var addCol, nextColID;

  nextColID = 0;

  addCol = function() {
    var newCol, prefix;
    prefix = "col-" + nextColID;
    nextColID += 1;
    newCol = $('#col-template').clone().attr('id', prefix);
    return newCol.find('#col-name').removeAttr('id').attr('name', prefix + "-name").end().find('#col-type').removeAttr('id').attr('name', prefix + "-type").end().appendTo('#col-list').removeAttr('hidden inert');
  };

  $(document).ready(function() {
    return addCol();
  });

}).call(this);
