 #echo wget will try to download a sitemap file from sanalmarket
  3 
  4 CANDIDATESITE=$1
  5 EXPORTFILE=$2
  6 
  7 echo wget will try to download a sitemap file from $CANDIDATESITE
  8 
  9 #curl https://www.sanalmarket.com.tr/robots.txt | grep ".*\.xml" | xargs wget
 10 
 11 curl $CANDIDATESITE/robots.txt | grep ".*\.xml" | xargs wget
 12 
 13 echo 'Removed xmlns fields'
 14 
 15 #The XML-> PYX -> XML trick did not work for me (using XMLStarlet version 1.4.2).
 16 #However, the XMLStarlet documentation contains this handy sed command that removes namespace declarations from an XML document:
 17 #https://stackoverflow.com/questions/9025492/xmlstarlet-does-not-select-anything
 18 
 19 # sed  -i  , The solution is to send a zero-length extension like this
 20 
 21 sed -i '' -e 's/ xmlns.*=".*"//g' *.xml
 22 
 23 
 24 echo 'Extract xml file to target $EXPORTFILE file '
 25 xmlstarlet -q sel -t -v '//loc' -n *.xml > $EXPORTFILE
