function Default-Config {
    Set-Location ~
    New-Item -Path '~/.mincfg' -ItemType File
    Set-Content -Path '.mincfg' -Value "~/Desktop"
}

function Get-Help-Flag {
    Write-Host "Script that allows you to download any Mindustry version. Flags:`n`t -p - change download path and run`n`t -h - display this message`n`t -d - display download path`nUsage:`n`t./minstall.sh -p [yourpathhere]`n"
}

function Display-Flag {
    Set-Location ~
    $a = Get-Content -Path ".mincfg" 
    Write-Host "Recent location: `n`t$a"
}

function Get-Mindustry {
    Set-Location ~
    Write-Host "Mindustry version: "
    $Version = Read-Host
    $path = (Get-Content -Path ".mincfg")
    Set-Location $path
    Invoke-WebRequest "https://github.com/Anuken/Mindustry/releases/download/v$Version/Mindustry.jar"
    $loc = Get-Location
    Write-Host "Downloaded mindustry $Version at $loc"
}

if ($args.Length -eq 0) {
    Get-Help-Flag
}

foreach ($i in $args) {
    if (!(Test-Path "~/.mincfg")) {
        Default-Config
    }
    switch ($i.ToLower()) {
        {($_ -eq "-h") -or ($_ -eq "--help")} {
            Get-Help-Flag
            Return
        }
        {($_ -eq "-d") -or ($_ -eq "--display")} {
            Display-Flag
            Return
        }
        {($_ -eq "-p") -or ($_ -eq "--path")} {
            $wr = $args[$args.Length - 1]
            Set-Location ~/
            Set-Location $wr
            $loc = Get-Location
            Set-Content -Path "~/.mincfg" -Value $loc
            Get-Mindustry
            Return
        }
    }
    Get-Mindustry
}