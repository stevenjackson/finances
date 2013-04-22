$(document).ready(function() {
    $("#unsorted_transactions tr").click(function(){
        transaction.select($(this));
    });
});

(function( transaction, $, undefined ) {
    transaction.select = function(row) {
        $("#unsorted_transactions tr").removeClass("selected");
        row.toggleClass("selected");

        $("#transaction_id").val(row[0].id.match(/\d+/)[0]);
        $("#amount").val(row.children(".amount").text().match(/\d+/)[0]);
    };
}( window.transaction = window.transaction || {}, jQuery ));
