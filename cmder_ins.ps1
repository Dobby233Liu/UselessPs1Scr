$lcdir=$args[0]
$apiUrl = 'https://ci.appveyor.com/api'
$token = '55vsoj53edq12uk7lvqi'
$headers = @{
  "Authorization" = "Bearer $token"
  "Content-type" = "application/json"
}
$accountName = 'MartiUK'
$projectSlug = 'cmder'

$downloadLocation = $lcdir

# get project with last build details
$project = Invoke-RestMethod -Method Get -Uri "$apiUrl/projects/$accountName/$projectSlug" -Headers $headers

# we assume here that build has a single job
# get this job id
$jobId = $project.build.jobs[0].jobId

# get job artifacts (just to see what we've got)
$artifacts = Invoke-RestMethod -Method Get -Uri "$apiUrl/buildjobs/$jobId/artifacts" -Headers $headers

# here we just take the first artifact, but you could specify its file name
$artifactFileName = 'build\cmder_mini.zip'

# artifact will be downloaded as
$localArtifactPath = "$downloadLocation\cmder_mini.zip"

# download artifact
# -OutFile - is local file name where artifact will be downloaded into
# the Headers in this call should only contain the bearer token, and no Content-type, otherwise it will fail!
if(Test-Path $downloadLocation) {}else{
mkdir $downloadLocation
}
Invoke-RestMethod -Method Get -Uri "$apiUrl/buildjobs/$jobId/artifacts/$artifactFileName" -OutFile $localArtifactPath -Headers @{ "Authorization" = "Bearer $token" }

Expand-Archive -Path $localArtifactPath -DestinationPath $downloadLocation -Force:$Overwrite
del $localArtifactPath