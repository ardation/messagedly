( function( $ ) {

	document.addEventListener("deviceready", onDeviceReady, false);

  //Browser Friendly
  if (device == undefined)
    var device = {name: "Browser", version: "Version", uuid: "QPDN4KLN4JKB2"};

  function onDeviceReady() {
  	// Connect
    var pusher = new Pusher('1268146fc5d29f8982e5');

    pusher.connection.bind('state_change', connectionStateChange);
    var channel = pusher.subscribe(device.uuid);
    channel.bind('pusher:subscription_succeeded', subscriptionSucceeded);
    channel.bind('send_sms', handleMyEvent);

    window.sms = new SmsPlugin();

  	function connectionStateChange(state) {
      if (state.current == 'connected') {
        $('#connectionStatus').addClass('btn-success').html('<span class="fui-check"></span>' + state.current);
      } else {
        $('#connectionStatus').removeClass('btn-success').html('<span class="fui-cross"></span>' + state.current);
      }
  	}

  	function subscriptionSucceeded() {
  		$('#subscriptionStatus').html('<span class="fui-check"></span>confirmed').addClass('btn-success');
  	}

  	function handleMyEvent( data ) {
      window.sms.send(data.phone, data.message);
      $('#nomessage').remove();
  		$('#myEventData').append('<li><div class="todo-icon fui-arrow-right"></div><div class="todo-content"><h4 class="todo-name">'+data.phone+'</h4><div class="message">'+data.message+'</div></div></li>');
  	}

  }

} )( jQuery );

Pusher.log = function( msg ) {
	if( window.console && window.console.log ) {
		window.console.log( msg );
	}
};
