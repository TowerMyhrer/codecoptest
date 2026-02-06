param(
    [Switch]$Fail, 
    [Switch]$ExitCode, 
    $Parameter1
)

if ($Fail) {
    throw "This script fails!"
}

if ($ExitCode) {
    exit 5
}
$AppName = "Green Yard Kleven"
$projectFolder = (Get-Location).Path
# Create Docs path
$NewFolderPath = $projectFolder + "\docs\media"
If (-not(test-path -Path $NewFolderPath)) {
    Write-Host "Creating docs and media folder $NewFolderPath"
   New-Item -Name "docs\media" -Type Directory
}

$url = "https://towertmp.github.io/AL-DocsTemplate/media/favicon.ico"
$destination = $projectFolder + "\docs\media\favicon.ico"
Invoke-WebRequest -Uri $url -OutFile $destination

$url = "https://towertmp.github.io/AL-DocsTemplate/media/logo.svg"
$destination = $projectFolder + "\docs\media\logo.svg"
Invoke-WebRequest -Uri $url -OutFile $destination

$url = "https://towertmp.github.io/AL-DocsTemplate/media/logo.png"
$destination = $projectFolder + "\docs\media\logo.png"
Invoke-WebRequest -Uri $url -OutFile $destination

$url = "https://towertmp.github.io/AL-DocsTemplate/media/cover.png"
$destination = $projectFolder + "\docs\media\cover.png"
Invoke-WebRequest -Uri $url -OutFile $destination

$url = "https://towertmp.github.io/AL-DocsTemplate/media/docfxTemplate.json"
$destination = $projectFolder + "\docs\docfx.json"
Invoke-WebRequest -Uri $url -OutFile $destination

$url = "https://towertmp.github.io/AL-DocsTemplate/media/coverTemplate.md"
$destination = $projectFolder + "\docs\cover.md"
Invoke-WebRequest -Uri $url -OutFile $destination

$filePath = $projectFolder + "\docs\index.md"
$FileContent = "# Documentation for " + $AppName + ".`n`nThis is the documentation for " + $AppName + ".`n"
$FileContent | Out-File -FilePath $filePath -Encoding UTF8

$filePath = $projectFolder + "\docs\toc.yml"
$FileContent = "items:" + "`n- name: " + $AppName + "`n  href: index.md" 
$FileContent | Out-File -FilePath $filePath -Encoding UTF8


$Env:MyVariable
$Parameter1
$PSVersionTable
