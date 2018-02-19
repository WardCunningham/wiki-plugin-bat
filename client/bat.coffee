log = [{date: Date.now(), text: "start client"}]

expand = (text)->
  text
    .replace /&/g, '&amp;'
    .replace /</g, '&lt;'
    .replace />/g, '&gt;'
    .replace /\*(.+?)\*/g, '<i>$1</i>'

ago = (ms) ->
  s = (new Date().getTime() - ms)/1000
  return "#{Math.floor s} s ago" if (m = s/60) < 2
  return "#{Math.floor m} m ago" if (h = m/60) < 2
  return "#{Math.floor h} h ago" if (d = h/24) < 2
  return "#{Math.floor d} d ago" if (w = d/7) < 2
  return "#{Math.floor w} w ago" if (m = d/31) < 2
  return "#{Math.floor m} mo ago" if (y = d/365) < 2
  return "#{Math.floor y} yr ago"

report = () ->
  item = (entry)->
    """
      <li>
        #{expand entry.text}<br>
        <span style="color:#bbb;">#{ago entry.date}</span>
      </li>
    """
  (item entry for entry in log).join("")

emit = ($item, item) ->
  $item.append """
    <div style="background-color:#eee;padding:15px;">
      <center>
        <button>pung</button>
        <button>gerp</button>
        <button>rack</button>
        <button>rome</button>
      </center>
      <ul>
        #{report()}
      </ul
    </div>
  """

bind = ($item, item) ->
  slug = $item.parents('.page').attr('id').split('_')[0]

  $item.dblclick -> wiki.textEditor $item, item

  refresh = ->
    log.pop() while log.length > 10
    $item.find('ul').empty().append report()

  $item.find('button').click (e) ->
    verb = $(e.target).text()
    $.post "/plugin/bat/#{slug}/#{verb}"
    log.unshift {date: Date.now(), text: "post #{verb}"}
    refresh()

  watch = ->
    $.getJSON "/plugin/bat/#{slug}/log", (data) ->
      log = data
      refresh()

  setInterval(watch, 1000)

window.plugins.bat = {emit, bind} if window?
module.exports = {expand} if module?

