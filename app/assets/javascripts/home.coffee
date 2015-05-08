
@waitDoc=()->
  if window.docReady
    window.docReady ()->
      @mainFunction()

  else
    setTimeout ()->
      @waitDoc()
    ,50
@time_out=1000
@speed=500
@thread=''
@slides_array=[]
@waitDoc()
@mainFunction=()->
  console.log "ready"
  callContainer=document.getElementById('myknopka')
  window.slides_array=callContainer.querySelectorAll('.slide')
  console.log window.slides_array
  window.thread=setInterval ()->

    window.animate_thread(window.slides_array)
  ,15000
  window.animate_thread(window.slides_array)
  callContainer.onmouseover=()->
    console.log "remove animate thread"
    clearInterval(window.thread)
  callContainer.onmouseout=()->
    console.log "add animate thread"
    window.thread=setInterval ()->
      window.animate_thread(window.slides_array)
    ,15000

@animate_thread=(objs)->
  console.log 'interval'
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

    console.log "time_out "+delay
    console.log slide



    if objs[i+1]
      next=objs[i+1]
    else
      next=objs[0]
    if objs[i-1]
      prevous=objs[i-1]
    else
      prevous=objs[objs.length-1]

    window.rotate_slide(next,slide,delay,prevous)


    i++
  return
@rotate_slide=(next,slide,time_out,prevous)->
  setTimeout ()->
    prevous.classList.remove('zoom_in')
    prevous.classList.add('zoom_out')
    setTimeout ()->
      slide.classList.remove('zoom_out')
      slide.classList.add('zoom_in')
    ,500

  ,time_out

