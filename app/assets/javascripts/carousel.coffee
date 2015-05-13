$(document).ready ()->
  setTimeout ()->
    root = exports ? this
    if $('.companion-slide').length>0

      $('.companion-slide').height $(window).height()
      $('.companion-slide').each (index,el)->

        $(el).height $(window).height()
        if $(el).css('background-image')!="none"
          data=window.rezise_background $(el), $(el).css('background-image').split("(")[1].split(")")[0]
        window.place_elements($(el))
      $(window).resize ()->
        $('.companion-slide').each (index,el)->
          $(el).height $(window).height()
          if $(el).css('background-image')!="none"
            data=window.rezise_background $(el), $(el).css('background-image').split("(")[1].split(")")[0]
          window.place_elements($(el))
  ,1000

@current_slide=0
@images={count:0}
@place_elements=($el)->
  $el.find('.middle').css {
    top:($el.height()-$el.find('.middle').height())/2+'px'
  }
  return
@rezise_background=($object,image)->
  root = exports ? this
  unless root.images[root.images.count]
    root.images[root.images.count]={}
    root.images.count++
    img=new Image()
    img.onload=()->

      root.images[root.images.count]={
        w:img.width
        h:img.height

      }
    img.src=image
  unless root.images[root.images.count]
    setTimeout ()->
      @rezise_background($object, $object.css('background-image').split("(")[1].split(")")[0])
    100
    return
  $('.video_overlay').each (i,e)->

    h=$($(e).data('video')).height()
    w=$($(e).data('video')).width()

    $(e).css {
      height:h
      top:'-'+h+'px'
    }
    $($(e).data('video')).unbind 'loadedmetadata'
    $($(e).data('video')).bind 'loadedmetadata', ()->
      setTimeout ()->
        $(window).resize()
      , 200
  $('.video-overlay').css {

  }
  data=root.images[root.images.count]



  data.tmp_width=$(window).width()
  data.wK=data.w/data.h
  data.tmp_height=data.tmp_width/data.wK

  if data.tmp_height<$(window).height()
    data.tmp_width = $(window).height()*data.wK
    data.tmp_height = data.tmp_width/data.wK
  data.left_offset=($(window).width()-data.tmp_width)/2
  data.top_offset=($(window).height()-data.tmp_height)/2
  #console.log data
  $object.css {
    "background-size":data.tmp_width+'px'
    "background-position": data.left_offset+'px '+data.top_offset+'px'
  }
  return data
