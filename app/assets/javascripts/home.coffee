@waitDoc=()->
  if window.docReady
    window.docReady ()->
      @mainFunction()
  else
    setTimeout ()->
      @waitDoc()
    ,50
@time_out = 1000
@speed = 500
@thread = ''
@slides_array = []
@waitDoc()
@mainFunction = ()->
  callContainer=document.getElementById('myknopka')
  window.slides_array=callContainer.querySelectorAll('.slide')
  window.thread=setInterval ()->
    window.animate_thread(window.slides_array)
  ,10000
  window.animate_thread(window.slides_array)
  callContainer.onmouseenter=(e)->
    console.log e
    clearInterval(window.thread)
    if e.toElement
      $e=e.toElement
    else
      $e=e.target
    console.log $e.querySelectorAll('.slide')
    for element in $e.querySelectorAll('.slide')
      console.log element
      is_hover=false
      for cl in element.classList
        if cl=='hover-block'
          is_hover=true
      unless is_hover
        element.classList.add('all_hide')
      else
        element.classList.remove('zoom_out')
        element.classList.add('zoom_in')

  callContainer.onmouseleave=(e)->
    console.log e
    window.thread=setInterval ()->
      window.animate_thread(window.slides_array)
    ,10000
    if e.fromElement
      $e=e.fromElement
    else
      $e=e.target
    console.log $e.querySelectorAll('.slide')
    for element in $e.querySelectorAll('.slide')
      console.log element
      is_hover=false
      for cl in element.classList
        if cl=='hover-block'
          is_hover=true
      console.log(element)
      element.classList.add('zoom_out')
      unless is_hover

        console.log "is not hover"
        element.classList.remove('all_hide')
      else
        console.log "is hover"
        element.classList.remove('zoom_in')
    #$e.querySelectorAll('.slide')[0].classList.add('zoom_in')


@animate_thread=(objs)->
  timeout=2000
  in_class="zoom_in"
  out_class="zoom_out"
  i=0
  for slide in objs
    exist_out=false
    exist_in=false
    for cl in slide.classList
      if cl==out_class
        exist_out=true
      if cl==in_class
        exist_in=true
    delay=timeout*(i+1)
    if objs[i+1]
      next=objs[i+1]
    else
      next=objs[0]
    if objs[i-1]
      prevous=objs[i-1]
    else
      prevous=objs[objs.length-1]
    window.rotate_slide(next,slide,delay,prevous,objs)
    i++
  return
@rotate_slide=(next,slide,time_out,prevous,all)->
  setTimeout ()->
    prevous.classList.remove('zoom_in')
    prevous.classList.add('zoom_out')
    for e in all
      e.classList.remove('zoom_in')
    setTimeout ()->
      slide.classList.remove('zoom_out')
      slide.classList.add('zoom_in')
    ,500
  ,time_out
