{# 鼠标点击特效 #}
{% if theme.cursor_effect == "fireworks" %}
  <script async src="/js/cursor/fireworks.js"></script>
{% elseif theme.cursor_effect == "explosion" %}
  <canvas class="fireworks" style="position: fixed;left: 0;top: 0;z-index: 1; pointer-events: none;" ></canvas>
  <script src="//cdn.bootcss.com/animejs/2.2.0/anime.min.js"></script>
  <script async src="/js/cursor/explosion.min.js"></script>
{% elseif theme.cursor_effect == "love" %}
  <script async src="/js/cursor/love.min.js"></script>
{% elseif theme.cursor_effect == "text" %}
  <script async src="/js/cursor/text.js"></script>
{% endif %}

{# 搞怪网页标题 #} {% if theme.title_trick.enable %}
<script>
  var OriginTitile = document.title;
  var titleTime;
  document.addEventListener("visibilitychange", function() {
    if (document.hidden) {
      document.title = "{{ theme.title_trick.leave }}" + OriginTitile;
      clearTimeout(titleTime);
    } else {
      document.title = "{{ theme.title_trick.enter }}" + OriginTitile;
      titleTime = setTimeout(function() {
        document.title = OriginTitile;
      }, 2000);
    }
  });
</script>
{% endif %}