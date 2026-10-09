# ============================================
# AI Master Plan — Favicon Auto-Injection Script
# Adds favicon to all HTML pages automatically
# ============================================

$projectPath = "D:\Projects\ai-masterplan"
$faviconLineRoot = '    <link rel="icon" type="image/svg+xml" href="assets/icons/favicon.svg">'
$faviconLinePages = '    <link rel="icon" type="image/svg+xml" href="../assets/icons/favicon.svg">'

Write-Host "`n[AI MASTER PLAN] Favicon Setup Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# معالجة index.html
$indexPath = "$projectPath\index.html"
if (Test-Path $indexPath) {
    $content = Get-Content $indexPath -Raw
    if ($content -notmatch 'rel="icon"') {
        $content = $content -replace '(</title>)', "`$1`n$faviconLineRoot"
        Set-Content $indexPath $content -NoNewline
        Write-Host "[OK] index.html" -ForegroundColor Green
    } else {
        Write-Host "[SKIP] index.html (already has favicon)" -ForegroundColor Yellow
    }
}

# معالجة كل صفحات pages/
$pages = Get-ChildItem "$projectPath\pages\*.html"
foreach ($page in $pages) {
    $content = Get-Content $page.FullName -Raw
    if ($content -notmatch 'rel="icon"') {
        $content = $content -replace '(</title>)', "`$1`n$faviconLinePages"
        Set-Content $page.FullName $content -NoNewline
        Write-Host "[OK] pages/$($page.Name)" -ForegroundColor Green
    } else {
        Write-Host "[SKIP] pages/$($page.Name) (already has favicon)" -ForegroundColor Yellow
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "[DONE] Favicon injected into all pages!" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan