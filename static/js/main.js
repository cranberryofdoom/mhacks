$(document).ready(
	function(){
		$('#start').click(
			function(){
				var team_name = $('input').val();
				$('input').attr('disabled', true);
				$('#start').hide();
				$('input').css('width', '100%')
				.css('text-align', 'center')
				.css('font-size', '35px');
			});
	});
function impact(){
	$('#throw-circle').css('background-color', 'black');
}