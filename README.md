## (unofficial) Malvados Feed

[![Valid Atom 1.0](http://img.shields.io/badge/feed-valid-brightgreen.svg)](http://validator.w3.org/feed/check.cgi?url=http%3A//malvados.danilosousa.net/strips)
[![Code Climate](https://codeclimate.com/github/danilopopeye/malvados-feed.png)](https://codeclimate.com/github/danilopopeye/malvados-feed)
[![Build Status](https://travis-ci.org/danilopopeye/malvados-feed.png)](https://travis-ci.org/danilopopeye/malvados-feed)
[![Dependency Status](https://gemnasium.com/danilopopeye/malvados-feed.png)](https://gemnasium.com/danilopopeye/malvados-feed)
[![Coverage Status](https://coveralls.io/repos/danilopopeye/malvados-feed/badge.png)](https://coveralls.io/r/danilopopeye/malvados-feed)
[![Analytics](https://ga-beacon.appspot.com/UA-1178851-11/danilopopeye/malvados-feed)](https://github.com/danilopopeye/malvados-feed)

This is a (unofficial) atom feed for the [Malvados.com.br](http://www.malvados.com.br) comics strips.
## feed example

``` xml
<entry>
  <id>tag:malvados.danilosousa.net,2005:Strip/530cc92c6333380002000000</id>
  <updated>2014-02-25T13:37:35-03:00</updated>
  <link rel="alternate" type="text/html" href="http://www.malvados.com.br/index1691.html"/>
  <title>Tirinha número 1691</title>
  <content type="html">
    <p>
      <img src="http://www.malvados.com.br/logo1691.gif" alt="Tirinha número 1691" />
    </p>
    <p>
      <a href="http://www.malvados.com.br/index1691.html">
        <img src="http://www.malvados.com.br/tirinha1691.jpg" alt="Tirinha número 1691" />
      </a>
    </p>
  </content>
</entry>
```

### [/strips](http://malvados.danilosousa.net/strips)

**all** ~1700 the strips (`~1mb`)

### [/strips/latest](http://malvados.danilosousa.net/strips/latest)

only the last strip (`~2kb`)
