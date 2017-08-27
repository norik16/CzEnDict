# -*- coding:utf-8 -*-
import json
import sqlite3

JSON_FILE = "dict.json"
DB_FILE = "dict.sqlite"

traffic = json.load(open(JSON_FILE))
conn = sqlite3.connect(DB_FILE)
c = conn.cursor()


# Load data from JSON

#c.execute('create table dictonary ("id", "origin", "originLanguage", "translations", "classes")')
#conn.commit()
#
#sizeT = len(traffic)
#counter = 0
#
#for item in traffic:
#    translations = ""
#    first = True
#    counter += 1
#    for tran in item["translations"]:
#        if first:
#            translations += tran
#            first = False
#        else:
#            translations += "=" + tran
#
#    data = [item["id"], item["origin"], item["originLanguage"], translations, ""]
#
#    print ("Row inserted ("  + str(counter) + " / " + str(sizeT) + ")")
#    
#    c.execute('insert into dictonary values (?, ?, ?, ?, ?)', data)
#    conn.commit()

#c.execute('insert into table_name values (?,?)', data)


#Create table for recents
#c.execute('create table recent ("id", "origin", "translation")')
c.execute('DROP TABLE recent')
c.execute('CREATE TABLE recent ( id INTEGER PRIMARY KEY AUTOINCREMENT, origin NOT NULL, translation NOT NULL)')
conn.commit()


c.execute('DROP TABLE favorite')
c.execute('CREATE TABLE favorite ( id INTEGER PRIMARY KEY AUTOINCREMENT, translationid NOT NULL)')
conn.commit()

c.close()
