<!DOCTYPE html>

{% set html_class = 'theme-next ' + theme.scheme %}
{% if theme.motion.enable %}
  {% set html_class = html_class + ' use-motion' %}
{% endif %}

<html class="{{ html_class | lower }}" lang="{{ config.language }}">
  <head>
    {{ partial('_partials/head.swig', {}, {cache: theme.cache.enable}) }}
    <title>{% block title %}{% endblock %}</title>
    {% include '_third-party/analytics/index.swig' %}

    <!-- Bigfoot footers-->
    <link rel="stylesheet" href="{{ url_for(theme.vendors._internal) }}/bigfoot/bigfoot-number.css" />
        
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Blog | nishil.in</title>
    <link rel="stylesheet" href="{{ url_for(theme.vendors._internal) }}/bootstrap/dist/css/bootstrap.min.css">
    <link href="{{ url_for(theme.vendors._internal) }}/css/jumbotron-narrow.css" rel="stylesheet">
    <link href="{{ url_for(theme.vendors._internal) }}/css/style.css" rel="stylesheet">
  </head>

  <body itemscope itemtype="http://schema.org/WebPage" lang="{{ page.lang || page.language || config.language }}">
    <div class="container">
      <div class="row header">
        <div class="col-12">
          <ul class="nav nav-pills float-right">
            <li class="nav-item passive"><a class="nav-link active" href="/blog" title="CV">Blog</a></li>
            <li class="nav-item passive"><a class="nav-link" href="/projects" title="Projects">Projects</a></li>
          </ul>
          <h3 class="text-muted"><a href="/">Nishil Kohli</a></h3>
        </div>
      </div> <!-- /header -->
      {% set container_class = "container " %}
      {% if theme.sidebar.position %}
      {% set container_class = container_class + 'sidebar-position-' + theme.sidebar.position %}
      {% endif %}

    
    
      <main id="main" class="row main ">
        <div class="main-inner col-12">
          <div class="content-wrap">
            <div id="content " class="content">
              {% block content %}{% endblock %}
            </div>
          </div>
          {% if theme.sidebar.display !== 'remove' %}
          {% block sidebar %}{% endblock %}
          {% endif %}
        </div>
      </main>
      <div class="row footer">
        <div class="col-12">
          <div class="float-right">
            <a href="/blog/archives">Archive</a> | 
            <a href="/blog/categories">Categories</a> | 
            <a href="/blog/tags">Tags</a>
          </div>
          <h5 class="text-muted">Find me on the Internet</h5>
          <ul class="social">
            <li class="cell cell-6">
              <a href="https://twitter.com/nishilk" class="twitter" rel="me">
                <svg viewBox="0 0 512 512">
                  <path d="M419.6 168.6c-11.7 5.2-24.2 8.7-37.4 10.2 13.4-8.1 23.8-20.8 28.6-36 -12.6 7.5-26.5 12.9-41.3 15.8 -11.9-12.6-28.8-20.6-47.5-20.6 -42 0-72.9 39.2-63.4 79.9 -54.1-2.7-102.1-28.6-134.2-68 -17 29.2-8.8 67.5 20.1 86.9 -10.7-0.3-20.7-3.3-29.5-8.1 -0.7 30.2 20.9 58.4 52.2 64.6 -9.2 2.5-19.2 3.1-29.4 1.1 8.3 25.9 32.3 44.7 60.8 45.2 -27.4 21.4-61.8 31-96.4 27 28.8 18.5 63 29.2 99.8 29.2 120.8 0 189.1-102.1 185-193.6C399.9 193.1 410.9 181.7 419.6 168.6z"
                  />
                </svg>
                Twitter
              </a>
            </li>
            <li class="cell cell-6">
              <a href="https://github.com/charsi" class="github" rel="me">
                <svg viewBox="0 0 512 512">
                  <path d="M256 70.7c-102.6 0-185.9 83.2-185.9 185.9 0 82.1 53.3 151.8 127.1 176.4 9.3 1.7 12.3-4 12.3-8.9V389.4c-51.7 11.3-62.5-21.9-62.5-21.9 -8.4-21.5-20.6-27.2-20.6-27.2 -16.9-11.5 1.3-11.3 1.3-11.3 18.7 1.3 28.5 19.2 28.5 19.2 16.6 28.4 43.5 20.2 54.1 15.4 1.7-12 6.5-20.2 11.8-24.9 -41.3-4.7-84.7-20.6-84.7-91.9 0-20.3 7.3-36.9 19.2-49.9 -1.9-4.7-8.3-23.6 1.8-49.2 0 0 15.6-5 51.1 19.1 14.8-4.1 30.7-6.2 46.5-6.3 15.8 0.1 31.7 2.1 46.6 6.3 35.5-24 51.1-19.1 51.1-19.1 10.1 25.6 3.8 44.5 1.8 49.2 11.9 13 19.1 29.6 19.1 49.9 0 71.4-43.5 87.1-84.9 91.7 6.7 5.8 12.8 17.1 12.8 34.4 0 24.9 0 44.9 0 51 0 4.9 3 10.7 12.4 8.9 73.8-24.6 127-94.3 127-176.4C441.9 153.9 358.6 70.7 256 70.7z"
                  />
                </svg>
                GitHub
              </a>
            </li>
            <li class="cell cell-6">
              <a href="https://www.facebook.com/8488307681665f3dc017ebcab0c4cd7b1733e102" class="facebook" rel="me">
                <svg viewBox="0 0 512 512">
                  <path d="M211.9 197.4h-36.7v59.9h36.7V433.1h70.5V256.5h49.2l5.2-59.1h-54.4c0 0 0-22.1 0-33.7 0-13.9 2.8-19.5 16.3-19.5 10.9 0 38.2 0 38.2 0V82.9c0 0-40.2 0-48.8 0 -52.5 0-76.1 23.1-76.1 67.3C211.9 188.8 211.9 197.4 211.9 197.4z"
                  />
                </svg>
                Facebook
              </a>
            </li>
            <li class="cell cell-6">
              <a href="https://www.instagram.com/ncetbh/" class="instagram" rel="me">
                <svg viewBox="0 0 512 512">
                  <g>
                    <path d="M256 109.3c47.8 0 53.4 0.2 72.3 1 17.4 0.8 26.9 3.7 33.2 6.2 8.4 3.2 14.3 7.1 20.6 13.4 6.3 6.3 10.1 12.2 13.4 20.6 2.5 6.3 5.4 15.8 6.2 33.2 0.9 18.9 1 24.5 1 72.3s-0.2 53.4-1 72.3c-0.8 17.4-3.7 26.9-6.2 33.2 -3.2 8.4-7.1 14.3-13.4 20.6 -6.3 6.3-12.2 10.1-20.6 13.4 -6.3 2.5-15.8 5.4-33.2 6.2 -18.9 0.9-24.5 1-72.3 1s-53.4-0.2-72.3-1c-17.4-0.8-26.9-3.7-33.2-6.2 -8.4-3.2-14.3-7.1-20.6-13.4 -6.3-6.3-10.1-12.2-13.4-20.6 -2.5-6.3-5.4-15.8-6.2-33.2 -0.9-18.9-1-24.5-1-72.3s0.2-53.4 1-72.3c0.8-17.4 3.7-26.9 6.2-33.2 3.2-8.4 7.1-14.3 13.4-20.6 6.3-6.3 12.2-10.1 20.6-13.4 6.3-2.5 15.8-5.4 33.2-6.2C202.6 109.5 208.2 109.3 256 109.3M256 77.1c-48.6 0-54.7 0.2-73.8 1.1 -19 0.9-32.1 3.9-43.4 8.3 -11.8 4.6-21.7 10.7-31.7 20.6 -9.9 9.9-16.1 19.9-20.6 31.7 -4.4 11.4-7.4 24.4-8.3 43.4 -0.9 19.1-1.1 25.2-1.1 73.8 0 48.6 0.2 54.7 1.1 73.8 0.9 19 3.9 32.1 8.3 43.4 4.6 11.8 10.7 21.7 20.6 31.7 9.9 9.9 19.9 16.1 31.7 20.6 11.4 4.4 24.4 7.4 43.4 8.3 19.1 0.9 25.2 1.1 73.8 1.1s54.7-0.2 73.8-1.1c19-0.9 32.1-3.9 43.4-8.3 11.8-4.6 21.7-10.7 31.7-20.6 9.9-9.9 16.1-19.9 20.6-31.7 4.4-11.4 7.4-24.4 8.3-43.4 0.9-19.1 1.1-25.2 1.1-73.8s-0.2-54.7-1.1-73.8c-0.9-19-3.9-32.1-8.3-43.4 -4.6-11.8-10.7-21.7-20.6-31.7 -9.9-9.9-19.9-16.1-31.7-20.6 -11.4-4.4-24.4-7.4-43.4-8.3C310.7 77.3 304.6 77.1 256 77.1L256 77.1z"
                    />
                    <path d="M256 164.1c-50.7 0-91.9 41.1-91.9 91.9s41.1 91.9 91.9 91.9 91.9-41.1 91.9-91.9S306.7 164.1 256 164.1zM256 315.6c-32.9 0-59.6-26.7-59.6-59.6s26.7-59.6 59.6-59.6 59.6 26.7 59.6 59.6S288.9 315.6 256 315.6z"
                    />
                    <circle cx="351.5" cy="160.5" r="21.5" />
                  </g>
                </svg>
                Instagram
              </a>
            </li>
            <li class="cell cell-12">
              <a href="https://stackoverflow.com/users/3761234/charsi" class="stackoverflow" rel="me">
                <svg viewBox="0 0 512 512">
                  <path d="M294.8 361.2l-122 0.1 0-26 122-0.1L294.8 361.2zM377.2 213.7L356.4 93.5l-25.7 4.5 20.9 120.2L377.2 213.7zM297.8 301.8l-121.4-11.2 -2.4 25.9 121.4 11.2L297.8 301.8zM305.8 267.8l-117.8-31.7 -6.8 25.2 117.8 31.7L305.8 267.8zM321.2 238l-105-62 -13.2 22.4 105 62L321.2 238zM346.9 219.7l-68.7-100.8 -21.5 14.7 68.7 100.8L346.9 219.7zM315.5 275.5v106.5H155.6V275.5h-20.8v126.9h201.5V275.5H315.5z"
                  />
                </svg>
                StackOverflow
              </a>
            </li>
          </ul>
        </div>
        <div class="col-sm-8">
          <p><small>&copy; 2018 Nishil Kohli</small></p>
        </div>
      </div>
    </div>
      <!--<footer id="footer" class="footer">
        <div class="footer-inner">
          {{ partial('_partials/footer.swig', {}, {cache: theme.cache.enable}) }}
          {% include '_third-party/analytics/analytics-with-widget.swig' %}
          {% block footer %}{% endblock %}
        </div>
      </footer>-->    
    


    {% if not theme.sidebar.b2t %}
    <div class="back-to-top">
      <i class="fa fa-arrow-up"></i>
      {% if theme.sidebar.scrollpercent %}
        <span id="scrollpercent"><span>0</span>%</span>
      {% endif %}
    </div>
    {% endif %}
    {% if theme.needmoreshare2.enable and theme.needmoreshare2.float.enable %}
    <div id="needsharebutton-float">
      <span class="btn">
        <i class="fa fa-share-alt" aria-hidden="true"></i>
      </span>
    </div>
    {% endif %}
      
    

    {% include '_scripts/vendors.swig' %}
    {% include '_scripts/commons.swig' %}

    {% set scheme_script = '_scripts/schemes/' + theme.scheme | lower + '.swig' %}
    {% include scheme_script %}

    {% block script_extra %}{% endblock %}

    {% include '_scripts/boostrap.swig' %}

    {% include '_third-party/comments/index.swig' %}
    {% include '_third-party/search/index.swig' %}
    {% include '_third-party/analytics/lean-analytics.swig' %}
    {% include '_third-party/analytics/firestore.swig' %}
    {% include '_third-party/seo/baidu-push.swig' %}
    {% include '_third-party/needsharebutton.swig' %}
    {% include '_third-party/rating.swig' %}
    {% include '_third-party/mathjax.swig' %}
    {% include '_third-party/scroll-cookie.swig' %}
    {% include '_third-party/exturl.swig' %}

    <!--<<script type="text/javascript" src="{{ url_for(theme.vendors._internal) }}/jquery/index.js"></script>
    
    <script src="//cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/js/bootstrap.min.js" integrity="sha384-a5N7Y/aK3qNeh15eJKGWxsqtnX/wWdSZSKp+81YjTmS15nvnvxKHuzaWwXHDli+4" crossorigin="anonymous"></script>-->
    <!-- Bigfoot footers-->
    <script type="text/javascript" src="{{ url_for(theme.vendors._internal) }}/bigfoot/bigfoot.min.js"></script>
    <script>
      var bigfoot = $.bigfoot(
          {
          activateOnHover: true
          }
      );
      $.bigfoot();
      </script>
      <script>
      // Creates Captions from Alt tags
      $("div.post-body").children("p").children('img').each(
          function() {
          // Let's put a caption if there is one
          if ($(this).attr("alt")) {
              $(this).wrap(
                  '<figure class="image"></figure>'
              ).after(
                  '<figcaption>' +
                  $(this).attr(
                      "alt") +
                  '</figcaption>'
              );
          }
      });
    </script>
  </body>
</html>
