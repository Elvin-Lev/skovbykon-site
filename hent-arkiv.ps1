# Henter de billeder der findes i Internet Archive (Wayback Machine)
# Start via hent-arkiv.cmd. Log: hent-arkiv-log.txt

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ErrorActionPreference = "Continue"
$ProgressPreference = "SilentlyContinue"

$root = $PSScriptRoot
if ([string]::IsNullOrEmpty($root)) { $root = (Get-Location).Path }
$dest = Join-Path $root "img\metoder"
$log = Join-Path $root "hent-arkiv-log.txt"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
"=== Start: $(Get-Date) ===" | Out-File -FilePath $log -Encoding utf8

Write-Host ""
Write-Host "Henter 9 billeder fra Internet Archive" -ForegroundColor Cyan
Write-Host ""
$ok=0; $fejl=@(); $i=0

$filer = @(
  @{ url = "https://web.archive.org/web/20181112132105id_/https://www.skovbykon.dk/images/stories/skovbykon/Arbotom1.png"; navn = "Arbotom1.png" }
  @{ url = "https://web.archive.org/web/20170729132650id_/https://www.skovbykon.dk/images/stories/skovbykon/Arbotom_scanning1.png"; navn = "Arbotom_scanning1.png" }
  @{ url = "https://web.archive.org/web/20181112120022id_/https://www.skovbykon.dk/images/stories/skovbykon/Arbotom2.PNG"; navn = "Arbotom2.PNG" }
  @{ url = "https://web.archive.org/web/20190802125325id_/https://www.skovbykon.dk/images/stories/skovbykon/magnetisk_scanner1.gif"; navn = "magnetisk_scanner1.gif" }
  @{ url = "https://web.archive.org/web/20190802125533id_/https://www.skovbykon.dk/images/stories/skovbykon/ITR_blodboeg_72dpi.png"; navn = "ITR_blodboeg_72dpi.png" }
  @{ url = "https://web.archive.org/web/20190802125525id_/https://www.skovbykon.dk/images/stories/skovbykon2/resistograph3.jpg"; navn = "resistograph3.jpg" }
  @{ url = "https://web.archive.org/web/20181112162314id_/https://www.skovbykon.dk/images/stories/skovbykon2/resistograf4.jpg"; navn = "resistograf4.jpg" }
  @{ url = "https://web.archive.org/web/20190802125500id_/https://www.skovbykon.dk/images/stories/skovbykon2/svamp_blodboeg.jpg"; navn = "svamp_blodboeg.jpg" }
  @{ url = "https://web.archive.org/web/20190803033048id_/https://www.skovbykon.dk/images/stories/skovbykon2/makroskop_ahorn.jpg"; navn = "makroskop_ahorn.jpg" }
)

foreach ($f in $filer) {
  $i++
  $ud = Join-Path $dest $f.navn
  Write-Host ("[{0}/{1}] {2}" -f $i, $filer.Count, $f.navn) -NoNewline
  try {
    Invoke-WebRequest -Uri $f.url -OutFile $ud -UseBasicParsing -TimeoutSec 120
    $st = (Get-Item $ud).Length
    if ($st -lt 500) { throw "kun $st bytes" }
    $ok++; Write-Host ("  OK ({0} KB)" -f [math]::Round($st/1KB)) -ForegroundColor Green
    "OK   $($f.navn)  $st bytes" | Out-File -FilePath $log -Append -Encoding utf8
  } catch {
    $fejl += $f.navn; Write-Host "  FEJL" -ForegroundColor Red
    "FEJL $($f.navn)  $($_.Exception.Message)" | Out-File -FilePath $log -Append -Encoding utf8
  }
  Start-Sleep -Milliseconds 800
}

Write-Host ""
Write-Host ("Faerdig: {0} af {1} hentet." -f $ok, $filer.Count) -ForegroundColor Cyan
if ($fejl.Count -gt 0) { Write-Host "Fejlede:" -ForegroundColor Red; $fejl | ForEach-Object { Write-Host "  $_" } }
Write-Host ""
