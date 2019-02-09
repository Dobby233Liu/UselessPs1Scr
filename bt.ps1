$skr = $(Dir -force -name -path *.vod)
$skr2 = $skr -replace ".vod", ""
$skr2 | Out-File -FilePath dict.txt -Encoding utf8 -Force