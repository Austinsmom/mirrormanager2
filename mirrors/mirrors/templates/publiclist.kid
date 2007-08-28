<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'static.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>Fedora Public Active Mirrors</title>

</head>
<body>
<div class="floatright">
<table cellspacing="0" class="compact altrows minilist">
  <caption><strong>Mirror list filter</strong></caption>
  <tr><th colspan="2">Version</th><th colspan='0'>Architecture</th></tr>
  <span py:for="p in products">
  <tr class="separator" py:attrs="{'rowspan': len(p.versions)}">
    <th colspan="0">
      <a href="${tg.url('/publiclist/' + p.name + '/')}" py:content="p.name" />
    </th>
  </tr>
  <tr py:for="i,v in enumerate(p.versions)"
      py:attrs="{'class': i%2 and 'odd' or 'even'}">
<?python
vername=v.name
if vername == u'development':
    vername=u'rawhide'
?>
    <td></td><td><a href="${tg.url('/publiclist/' + p.name + '/' + v.name + '/')}">
      <strong py:content="vername" /></a></td>
	<td py:for="a in arches"><a href="${tg.url('/publiclist/' +
	p.name + '/' + v.name + '/' + a + '/')}" py:content="a" /></td>
  </tr>
  </span>
</table>
</div>

<h1 class="icon48 download">Fedora Public Active Mirrors</h1>

<p>
Fedora is distributed to millions of systems globally.  This would not
be possible without the donations of time, disk space, and bandwidth
by hundreds of volunteer system administrators and their companies or
institutions.  Your fast download experience is made possible by these
donations.
This list is dynamically generated every hour, listing only up-to-date mirrors.
</p>
<p>
To become a public Fedora mirror, please see <a
href="http://fedoraproject.org/wiki/Infrastructure/Mirroring">our wiki page on Mirroring</a>.
</p>

<p>
You may trim the selection through the links on the right, or see the <a
href="${tg.url('/publiclist')}">whole list</a>.
</p>

<div class="keepleft">

<h2 class="icon24 download" style="clear: both;">${title} Public Active Mirrors (${numhosts})</h2>

<p py:if="len(hosts) == 0">There are no mirrors matching your your search criteria.</p>

<tr><th>Country</th><th>Site</th><th>Host</th><th>Content</th><th>Bandwidth</th><th>Comments</th></tr>
<div py:for="i,host in enumerate(hosts)"
    py:attrs="{'class': i%2 and 'odd' or 'even'}">
<span py:if="host.country is not None" py:replace="host.country.upper()">Country</span>
<a href="${host.site.orgUrl}"><span py:replace="host.site.name">Site Name</span></a>
<span py:replace="host.name">Host Name</span>

<table>
<tr py:for="hc in host.categories" py:if="hc.category.publiclist and (valid_categories is None or hc.category.name in valid_categories)">
<td><span py:replace="hc.category.name">Category name</span></td>
<?python
http=None
ftp=None
rsync=None
for u in hc.urls:
    if not u.private:
        if u.url.startswith('http:'):
	    http=u.url
        elif u.url.startswith('ftp:'):
	    ftp=u.url
        elif u.url.startswith('rsync:'):
	    rsync=u.url
?>
<td><span py:if="http is not None"><a href="${http}">http</a></span></td>
<td><span py:if="ftp is not None"><a href="${ftp}">ftp</a></span></td>
<td><span py:if="rsync is not None"><a href="${rsync}">rsync</a></span></td>
</tr>
</table>
</td>
<td><span py:replace="host.bandwidth">Bandwidth</span></td>
<td><span py:replace="host.comment">Comment</span></td>
</tr>
</table>
</div>
</body>
</html>
