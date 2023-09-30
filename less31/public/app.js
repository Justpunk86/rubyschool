
function something()
{
	var x = window.localStorage.getItem('aaa');
	x = x*1 + 1;
	window.localStorage.setItem('aaa', x);
	alert(x);

}

function add_to_cart(id) {
	var key = 'product_' + id
	var x = window.localStorage.getItem(key);
	x = x*1 + 1;
	window.localStorage.setItem(key, x)
	upd_orders_input();
	upd_orders_btn();
}

function get_total_qty() {
	var total = 0;
	var key;
	for (var i = 0; i < localStorage.length; i++){
		key = localStorage.key(i);
		if (key.indexOf('product_') == 0){
			total += localStorage.getItem(key)*1;
		}
	}
	//$('body').append("Total qty pizzas added to card: " + total);
	return total;
}

function get_cart_orders() {
	var orders = '';
	var key;
	var value;
	for (var i = 0; i < localStorage.length; i++){
		key = localStorage.key(i);
		value = localStorage.getItem(key);
		if (key.indexOf('product_') == 0){
			orders += key + '=' + value + ',';
		}
	}

	return orders;
}

function upd_orders_input() {
	var orders = get_cart_orders();
	$('#orders_input').val(orders);
}

function upd_orders_btn() {
	var text = 'Cart (' + get_total_qty() + ')';
	$('#orders_btn').val(text);
}

function empty_cart() {
	window.localStorage.clear();
	/*for (var i = 0; i < localStorage.length; i++){
		key = localStorage.key(i);
		if (key.indexOf('product_') == 0){
			window.localStorage.removeItem(key);
		}
	}*/
	upd_orders_input();
	upd_orders_btn();
	
	$('#cart').text('Your cart is now empty');
	return false;
}