Invoke-WebRequest -Uri "https://api.bilibili.com/x/player/playurl?avid=$($args[0])&cid=$($args[1])&qn=80&type=" -Headers @{"User-Agent"="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36"; "Referer"="https://www.bilibili.com/video/"+$args[0]; "Origin"="https://www.bilibili.com"} -OutFile $env:temp/_urlresult.xml
$xmldata = [xml](Get-Content $env:temp/_urlresult.xml)
$url = $xmldata.PlayurlRes.durl.url
$url
Invoke-WebRequest -Uri "$url" -OutFile $($args[2]) -Headers @{"User-Agent"="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36"; "Referer"="https://www.bilibili.com/video/"+$args[0]; "Origin"="https://www.bilibili.com"}
del $env:temp/_urlresult.xml