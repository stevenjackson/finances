$(document).ready(function() {
    $("#unsorted_transactions tr").click(function(){
      transaction.select($(this));
    });

    $("body").keydown(function(e){
      transaction.handleKey(e.keyCode);
    });

    var stickyOffset = $('.sticky').offset();
    $(window).scroll(function() {
      if (!stickyOffset) return;

      if (stickyOffset.top < $(window).scrollTop()) {
       $('.sticky').addClass('fixed');
      } else {
       $('.sticky').removeClass('fixed');
      }
    });

    categoryAutocomplete.bind($('#category'));
});

(function( transaction, $, undefined ) {
    transaction.select = function($row) {
        $("#unsorted_transactions tr").removeClass("selected");
        $row.toggleClass("selected");
        this.updateTransactionData($row);
        this.scrollIfNeeded($row);
    };

    transaction.scrollIfNeeded = function($row) {
      if(this.inView($row[0])) return;

      scrollTo(0, $row.position().top - $row.height());
    };

    transaction.inView = function(elem) {
      var windowTop = $(window).scrollTop();
      var windowBottom = windowTop + $(window).height();
      var elemTop = $(elem).offset().top;
      var onPage = elemTop >= windowTop;
      var aboveFold = elemTop <= windowBottom;
      return onPage && aboveFold;
    };

    transaction.updateTransactionData = function($row) {
      var $rowId = $row[0].id.match(/\d+/);
      var $rowAmount = $row.children(".amount").text().match(/\d+/);
      if($rowId) {
        $("#transaction_id").val($rowId[0]);
      }
      if($rowAmount) {
        $("#amount").val($rowAmount[0]);
      }
    };

    transaction.handleKey = function(keyCode) {
        row = transaction.selectedRow();
        switch(keyCode) {
            case 40: //down arrow
              transaction.select(transaction.nextRow(row));
            break;
            case 38: //up arrow
              transaction.select(transaction.prevRow(row));
            break;
            case 39: //right arrow
              $("#category").focus();
            break;
            case 37: //left arrow
              $("#category").blur();
            break;
            case 13: //enter
              $("input[value='Assign']").click();
            break;
            case 191: // slash
              $("input[value='Split']").click();
            break;
            default:
              //alphanumeric
              if(keyCode >= 48 && keyCode <= 90) {
                $("#category").focus();
              }
            break;
        }
    };

    transaction.nextRow = function(row) {
        if(!row) {
          nextRow = transaction.firstRow();
        } else if($(row).index() == transaction.count() - 1){
          nextRow = transaction.firstRow();
        } else {
          nextRow = $(row).next();
        }
        return nextRow;
    }

    transaction.prevRow = function(row) {
        if(!row) {
          prevRow = transaction.lastRow();
        } else if($(row).index() == 0){
          prevRow = transaction.lastRow();
        } else {
          prevRow = $(row).prev();
        }
        return prevRow;
    }

    transaction.firstRow = function() {
        return $("#unsorted_transactions tr:first");
    }

    transaction.lastRow = function() {
        return $("#unsorted_transactions tr:last");
    }

    transaction.count = function() {
        return $("#unsorted_transactions tr").size();
    }

    transaction.selectedRow = function() { 
        return this.findOne("#unsorted_transactions tr.selected");
    }

    transaction.findOne = function(selector) {
        result = $(selector)
        if(result.length == 0){
            return null;
        } else {
            return result[0];
        }
    }
}( window.transaction = window.transaction || {}, jQuery ));

(function( categoryAutocomplete, $, undefined ) {
  categoryAutocomplete.data = function() {
    var data = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      limit: 10,
      prefetch: {
        url: 'category'
      }
    });
    data.initialize();
    return data;
  };

  categoryAutocomplete.bind = function($elem) {
    $elem.typeahead({
      hint: true,
      highlight: true,
      minLength: 1
    },
    {
      name: 'categories',
      displayKey: 'name',
      source: this.data().ttAdapter(),
      templates: {
        suggestion: Handlebars.compile('<p>{{name}}  ${{amount}}</p>')
      }
    });
  }
}( window.categoryAutocomplete = window.categoryAutocomplete || {}, jQuery ));
