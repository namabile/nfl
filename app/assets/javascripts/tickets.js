$(function() {
	var min_price = $('#price-label').data('min-price');
	var max_price = $('#price-label').data('max-price');
	
	$("#amount").append(" $" + min_price + " - $" + max_price);

	$( "#slider" ).slider({
		range: true,
		min: min_price,
		max: max_price,
		values: [min_price, max_price ],
		slide: function( event, ui ) {
			$( "#amount" ).html( "Price Range $" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
		},
		change: function(event, ui) {
   			var min_value = ui.values[0];
   			var max_value = ui.values[1];
   			$("#products-table").find(".ticket").each(function() {
   				var price = $(this).children(".price").text();
   				if(price < min_value || price > max_value ) {
   					$(this).css("display", "none");
   				}
   				else {
   					$(this).css("display", "");
   				}
			});
   		}
	});
	$( "#amount" ).val( "$" + $( "#slider" ).slider( "values", 0 ) +
		" - $" + $( "#slider" ).slider( "values", 1 ) );

	$("a.add-to-cart").each(function() {
		$(this).click(function () {
			event.preventDefault();
			var qty_selection = 3;
			var new_link = $(this).attr("href").replace("treq%3D2","treq%3D" + String(qty_selection));
			document.location.href = new_link;
		});
	});
});