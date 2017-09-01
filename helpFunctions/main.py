import re
import hashlib

file = open("en-cs.txt")

id = 0
language = "en"

#                  1-original     2-translation 3-class  4-flags            5-author
p = re.compile(r'^([ -_a-zA-Z0-9]+)	([^	]+)	([^	]*:)?\s*(\[[^	]*])*		([^	]*)')
fl = re.compile(r'(\[[^]]*])')

lastWord = ""
lastClass = ""
lastTrans = ["smazat"]
outputEn = ""
outputCz = ""

classes = {}
flags = []

enCz = []

for line in file:
    res = p.search(line)

    if (res):

        newOrig = res.group(1)
        newTrans = res.group(2)
        newClass = res.group(3)
        newFlags = res.group(4)

        if (newOrig):
            newOrig = re.sub('"', r'', newOrig)
        if (newTrans):
            newTrans = re.sub('"', '', newTrans)
        if (newClass):
            newClass = re.sub('"', '', newClass)
        if (newFlags):
            newFlags = re.sub('"', '', newFlags)

        if newClass not in classes:
            classes[newClass] = 1
        else:
            classes[newClass] += 1

        flRes = fl.search(str(newFlags))
        # print str(newFlags)
        if flRes:
            # print flRes.groups()
            for flag in flRes.groups():
                if flag not in flags:
                    flags.append(flag)

        if (lastWord != newOrig):
            newWorld = {'id': str(hashlib.md5(lastWord + lastClass).hexdigest()),
                         'origin': lastWord,
                         'originLanguage': language,
                         'translations': lastTrans,
                         'class': lastClass}
            enCz.append(newWorld)
            wholeObj = ""
            wholeObj += '{"id":"' + newWorld['id'] + \
                   '", "origin":"' + newWorld['origin'] + \
                   '", "originLanguage":"' + newWorld['originLanguage'] + \
                   '", "translations":['
            for trans in newWorld['translations']:
                wholeObj += '"' + trans + '", '



            wholeObj = wholeObj[:-2] + ']' + \
                                       ', "class":"' + lastClass + '"}'

            # print(hashlib.md5(lastWord + lastClass).hexdigest())

            # id += 1
            lastWord = newOrig
            lastClass = newClass
            if (newClass in ["n:", "adj:", "adv:", "v:", "pron:", "num:", "conj:"]):
                lastClass = newClass[:-1]
            else:
                lastClass = "undefined"
            lastTrans = []
            lastTrans.append(newTrans)
            if len(lastTrans)!= 0 and id != 0:
                outputEn += wholeObj + ', '
            id += 1
        else:
            lastTrans.append(newTrans)
            if (newClass in ["n:", "adj:", "adv:", "v:", "pron:", "num:", "conj:"]):
                lastClass = newClass[:-1]

outputEn = '[' + outputEn[:-2] + ']'

out = open("enCz.json", "w")
out.write(outputEn)

czEn = {}
language = "cz"

for tmp in enCz:
    for trans in tmp['translations']:
        if trans in czEn:
            act = czEn[trans]
            act['translations'].append(tmp['origin'])
        else:
            newWorld = {'id': str(hashlib.md5(trans + tmp['class']).hexdigest()),
                         'origin': trans,
                         'originLanguage': language,
                         'translations': [tmp['origin']],
                         'class': tmp['class']}
            czEn[trans] = newWorld

stats1 = 0
stats2 = [0 for x in range(1000)]


for trans in czEn.items():
    tr = trans[1]
    wholeObj = ""
    wholeObj += '{"id":"' + tr['id'] + \
           '", "origin":"' + tr['origin'] + \
           '", "originLanguage":"' + tr['originLanguage'] + \
           '", "translations":['
    stats1 += 1                               #stats
    k = 0                                     #stats
    for trans in tr['translations']:
        wholeObj += '"' + trans + '", '
        k += 1                                #stats

    stats2[k] += 1                            #stats


    wholeObj = wholeObj[:-2] + ']' + \
                               ', "class":"' + tr['class'] + '"}'

    if k < 50:
        outputCz += wholeObj
        # print str(k) + '   ' + tr['origin']

outputCz = '[' + outputCz + ']'

out = open("czEn.json", "w")
out.write(outputCz)

print 'Unikatnich CZ slov: '  + str(stats1)

cumulative = 0.0
counter = 0

# for x in range(len(stats2)):
#     if stats2[x] != 0:
#         cumulative += stats2[x]/(stats1 * 1.0)
        #print str(x) + ': ' + str(stats2[x]) + '    pod je ' + str(cumulative*100) + ' %'
        #print 'Nejvyse ' + str(x) + ' znaku dlouhe je '  + str("{:.4f}".format(cumulative*100)) + ' %'


# for word in [newOrig, newTrans, newClass, newFlags]:
#
#     if not word:
#         continue
#     length = range(len(word)-1)
#     for i in length:
#         if word[len(length)-i] == '"':
#             word = word[:-i - 1] + '\\"' + word[len(length)-i]

# print [newOrig, newTrans, newClass, newFlags]

# print classes
#
# print "\n\n///////////////////////////\n\n"
#
# pFl = ''
# for flag in flags:
#     pFl += flag[1:-1] + ', '
#
# print pFl
#
# print id
#
# print