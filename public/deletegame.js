function deleteGame(id){
    $.ajax({
        url: '/game/' + id,
        type: 'DELETE',
        success: function(result){
            window.location.reload(true);
        }
    })
};

function deleteGamePlatform(vid, plid){
  $.ajax({
      url: '/game_plat/vid/' + vid + '/platform/' + plid,
      type: 'DELETE',
      success: function(result){
          if(result.responseText != undefined){alert(result.responseText)} 
          else {window.location.reload(true)} 
      }
  })
};
