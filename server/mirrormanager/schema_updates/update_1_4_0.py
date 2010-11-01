from mirrormanager.model import Location, FileGroup, Site
from sqlobject import BoolCol

# upgrade methodology borrowed from
# http://www.mail-archive.com/sqlobject-discuss@lists.sourceforge.net/msg04714.html

class OldSite(SQLObject):
    class sqlmeta:
        fromDatabase = True
        table = 'site'

class OldHost(SQLObject):
    class sqlmeta:
        fromDatabase = True
        table = 'host'

class OldVersion(SQLObject):
    class sqlmeta:
        fromDatabase = True
        table = 'version'

def update():
    Location.createTable(ifNotExists=True)
    FileGroup.createTable(ifNotExists=True)

    if 'email_on_drop' not in OldSite.sqlmeta.columns and \
            'email_on_add' not in OldSite.sqlmeta.columns:
        OldSite.addColumn(changeSchema=True, BoolCol("emailOnDrop", default=False))
        OldSite.addColumn(changeSchema=True, BoolCol("emailOnAdd", default=False))
        for s in OldSite.select():
            s.emailOnDrop=False
            s.emailOnAdd=False

    if 'dns_country_host' not in OldHost.sqlmeta.columns:
        OldHost.addColumn(changeSchema=True, BoolCol("dnsCountryHost", default=False))
        for h in OldHost.select():
            h.dnsCountryHost = False

    if 'sortorder' not in OldVersion.sqlmeta.columns:
        OldVersion.addColumn(changeSchema=True, IntCol("sortorder"))
        for v in OldVersion.select():
            v.sortorder = v.id
