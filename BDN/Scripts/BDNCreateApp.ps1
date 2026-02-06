param(
    $AppName
)

write-host "Creating app with name " $Parameter1

# Create src path
$NewFolderPath = $projectFolder  + $AppName + "\src\Media"
$NewFolderName = $AppName + "\Media"
If (-not(test-path -Path $NewFolderPath)) {
New-Item -Name $NewFolderName -Type Directory
}

# Create ruleset folder in .vscode
$NewFolderPath = $projectFolder  +$AppName + "\.vscode\.rulesets"
$newFolder = $AppName + "\.vscode\.rulesets"
If (-not(test-path -Path $NewFolderPath)) {
   New-Item -Name $newFolder -Type Directory
}

$NewFolderPath = $projectFolder  + $AppName
$url = "https://towertmp.github.io/AL-DocsTemplate/media/main.rulesetTemplate.json"
$destination = $NewFolderPath + "\main.ruleset.json"
Invoke-WebRequest -Uri $url -OutFile $destination

$NewFolderPath = $projectFolder  +$AppName
$url = "https://towertmp.github.io/AL-DocsTemplate/media/BDN.ruleset.Template.json"
$destination = $NewFolderPath + "\.vscode\.rulesets\BDN.ruleset.json"
Invoke-WebRequest -Uri $url -OutFile $destination

$url = "https://towertmp.github.io/AL-DocsTemplate/media/applogo.jpg"
$destination = $NewFolderPath + "\Media\AppLogo.jpg"
Invoke-WebRequest -Uri $url -OutFile $destination

# Create App Json

$GUID = New-Guid 
$GitHubPagesURL = "https://towertmp.github.io/"

$filePath = $projectFolder  + $AppName + "\app.json"
$content =  "{`n  `"id`": `"" + $GUID + "`",`n  `"name`": `"" + $AppName + "`",`n  `"publisher`": `"Tower Newco AS`",`n  `"version`": `"1.0.0.0`",`n  `"brief`": `"Brief Description of App`",`n  `"description`": `"Description of App`",`n  `"privacyStatement`": `"https://www.towernewco.no/`",`n  `"EULA`": `""  + $GitHubPagesURL + "/" + "/DocsTemplate/`",`n  `"help`": `"" + $GitHubPagesURL + "/" + $AppName +"/`",`n  `"url`": `"https://www.towernewco.no/`","
Add-Content -Path $filePath -Value $content
$content = "  `"logo`": `"./Media/AppLogo.jpg`",`n  `"dependencies`": [],`n  `"screenshots`": [],`n  `"platform`": `"1.0.0.0`",`n  `"application`": `"26.0.0.0`",`n  `"idRanges`": [`n     {`n      `"from`": 50000,`n      `"to`": 50149`n    }`n  ],`n  `"features`": [`n    `"NoImplicitWith`",`n    `"TranslationFile`"`n  ],`n  `"resourceExposurePolicy`": {`n    `"allowDebugging`": true,`n    `"allowDownloadingSource`": false,`n    `"includeSourceInSymbolFile`": false`n  },`n   `"contextSensitiveHelpUrl`": `"" + $GitHubPagesURL + "/" + $AppName + "/`",`n  `"runtime`": `"16.0`"`n}"
Add-Content -Path $filePath -Value $content

# Create AL.Workspace file

$url = "https://towertmp.github.io/AL-DocsTemplate/media/workspace.txt"
$destination = $NewFolderPath + "\al.code-workspace"
Invoke-WebRequest -Uri $url -OutFile $destination

(Get-Content $destination).Replace("{{APPNAME}}",$AppName) | Set-Content $destination

Write-Host "App Created and ready for development $AppName"
