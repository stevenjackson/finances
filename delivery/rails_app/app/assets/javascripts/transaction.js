$(document).ready(function() {
    $("#unsorted_transactions tr").click(function(){
        transaction.select($(this));
    });

    $("body").keydown(function(e){
        transaction.handleKey(e.keyCode);
    });
});

(function( transaction, $, undefined ) {
    transaction.select = function($row) {
        $("#unsorted_transactions tr").removeClass("selected");
        $row.toggleClass("selected");

        $("#transaction_id").val($row[0].id.match(/\d+/)[0]);
        $("#amount").val($row.children(".amount").text().match(/\d+/)[0]);
    };
    transaction.handleKey = function(keyCode) {
        row = transaction.selectedRow();
        console.log(keyCode + "," +  row);
        switch(keyCode) {
            case 40: //down arrow
              transaction.select(transaction.nextRow(row));
            break;
            case 38: //up arrow
              transaction.select(transaction.prevRow(row));
            break;
            case 13: //enter
              $("input[value='Assign']").click();
            break;
            case 191: // slash
              $("input[value='Split']").click();
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
        return transaction.findOne("#unsorted_transactions tr.selected");
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
