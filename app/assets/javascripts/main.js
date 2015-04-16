$(function(){
	$('#menu_button').on('click', function(){
		$('#menu_sidebar')
			.sidebar('toggle')
		;
	});
	$('#menu_button_search').on('click', function(){
		$('#menu_sidebar_search')
			.sidebar('toggle')
		;
	});
});