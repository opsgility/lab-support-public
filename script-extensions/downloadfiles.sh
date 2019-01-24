SourceFileUrl=$1      # http://someurl/StudentFiles.zip
DestinationFolder=$2  # /usr/opsgilitytraining

if [ -z "${SourceFileUrl}" ]; then
  echo "no download url for lab"
else
  echo "setting up student files" 
  # apt-get install unzip -y # already on ubuntu 18.04
  mkdir $DestinationFolder
  wget -P $DestinationFolder $SourceFileUrl
  filename=$(basename $SourceFileUrl) 
  destinationFullPath="$DestinationFolder/$filename"
  unzip $destinationFullPath -d $DestinationFolder
  chmod -R 775 $DestinationFolder
  chown -R demouser $DestinationFolder
fi
