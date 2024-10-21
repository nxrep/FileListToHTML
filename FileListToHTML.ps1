# Reads all files in a directory and generates an HTML report
Param (
  [string]$dir
)
if ($dir -eq "") {
  # if no path specified use current directory of script
  $dir=(Get-ChildItem).DirectoryName[0]
}

$VERSION="1.0.0"

Write-Host "File List to HTML - Version $($VERSION)"

Write-Host "Retrieving filenames in directory: $($dir) .."
$fileNames=(Get-ChildItem -Path $dir).Name

$date = Get-Date -format "yyyy-MM-dd"
$reportFileName="report-"+$date+".htm"
Write-Host "Generating HTML report: $($reportFileName) .."
$reportFileName=$dir+"\"+$reportFileName
Write-Host $reportFileName
# wrap filenames in HTML 
$BodyHTML="<p> Directory: $($dir) </p>"
$BodyHTML+="<ul>"
Foreach ($item in $fileNames)
{
  if ($item -like "*.*" ){
    $BodyHTML+="<li> 📄"+$item+"</li>"
  }else{
    $BodyHTML+="<li> 📂"+$item+"</li>"
  }
}
$BodyHTML+="</ul>"
$HMTLreport=ConvertTo-Html -Body $BodyHTML -Title "Directory Listing"

Out-File -InputObject $HMTLreport -FilePath $reportFileName
