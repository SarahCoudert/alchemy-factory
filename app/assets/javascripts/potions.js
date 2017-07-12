$( document ).on('turbolinks:load', function() {
	
	$("#new_price").on("click", function(){
		production_cost = $("#production_cost").text();
		margin = $("#margin").val();
		data = {production_cost: production_cost, margin: margin}
		$.ajax({
		    method: "GET",
		    url: "/potions/ajax/get_new_price",
		    data: data,
			dataType: 'json',
		    contentType : 'application/json',
		    success: function (data) {
				$("#result").text(data);
		    }
		})
	});

});