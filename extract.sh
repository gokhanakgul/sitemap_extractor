#echo wget will try to download a sitemap file from sanalmarket
 
CANDIDATESITE=$1
EXPORTFILE=$2  
 
echo wget will try to download a sitemap file from $CANDIDATESITE
 
#curl https://www.sanalmarket.com.tr/robots.txt | grep ".*\.xml" | xargs wget
 
curl $CANDIDATESITE/robots.txt | grep ".*\.xml" | xargs wget
 
echo 'Removed xmlns fields'
 
#The XML-> PYX -> XML trick did not work for me (using XMLStarlet version 1.4.2).
#However, the XMLStarlet documentation contains this handy sed command that removes namespace declarations from an XML document:
#https://stackoverflow.com/questions/9025492/xmlstarlet-does-not-select-anything
 
# sed  -i  , The solution is to send a zero-length extension like this
 
sed -i '' -e 's/ xmlns.*=".*"//g' *.xml
 
echo 'Extract xml file to target $EXPORTFILE file '
xmlstarlet -q sel -t -v '//loc' -n *.xml > $EXPORTFILE
