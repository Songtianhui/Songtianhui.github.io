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

{# 页脚站点运行时间统计 #} {% if theme.footer.ages.enable %}
<script src="https://cdn.jsdelivr.net/npm/moment@2.22.2/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment-precise-range-plugin@1.3.0/moment-precise-range.min.js"></script>
<script>
  function timer() {
    var ages = moment.preciseDiff(moment(),moment({{ theme.footer.ages.birthday }},"YYYYMMDD"));
    ages = ages.replace(/years?/, "years");
    ages = ages.replace(/months?/, "moths");
    ages = ages.replace(/days?/, "days");
    ages = ages.replace(/hours?/, "hours");
    ages = ages.replace(/minutes?/, "minutes");
    ages = ages.replace(/seconds?/, "seconds");
    ages = ages.replace(/\d+/g, '<span style="color:{{ theme.footer.ages.color }}">$&</span>');
    div.innerHTML = `{{ __('footer.age')}} ${ages}`;
  }
  var div = document.createElement("div");
  //插入到copyright之后
  var copyright = document.querySelector(".copyright");
  document.querySelector(".footer-inner").insertBefore(div, copyright.nextSibling);
  timer();
  setInterval("timer()",1000)
</script>
{% endif %}

{# sweetalert #} 
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>