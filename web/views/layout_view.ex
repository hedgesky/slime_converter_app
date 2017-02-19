defmodule SlimeConverter.LayoutView do
  use SlimeConverter.Web, :view

  def include_analytics do
    code = System.get_env("ANALYTICS_CODE")
    """
      <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

        ga('create', '#{code}', 'auto');
        ga('send', 'pageview');
      </script>
    """
  end
end
