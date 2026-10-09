# ============================================================
# AI Master Plan — Universal Meta Tags Auto-Injector
# 100% Encoding-Safe Script (Contains NO Arabic literals)
# Extracts all metadata dynamically from your HTML pages
# ============================================================

$projectPath = "D:\Projects\ai-masterplan"
$siteUrl = "https://ALMajd98.github.io/ai-masterplan"
$siteName = "AI Master Plan"
$siteAuthor = "ALMajd98"

Write-Host "`n[AI MASTER PLAN] Meta Tags Setup Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# 1. Process index.html (Root)
$indexPath = "$projectPath\index.html"
if (Test-Path $indexPath) {
    $content = [System.IO.File]::ReadAllText($indexPath, [System.Text.Encoding]::UTF8)
    
    if ($content -notmatch 'property="og:') {
        # Extract Title
        $titleMatches = [regex]::Match($content, '<title>(.*?)</title>')
        $extractedTitle = if ($titleMatches.Success) { $titleMatches.Groups[1].Value.Trim() } else { "AI Master Plan v4.0" }
        
        # Extract Description
        $descMatches = [regex]::Match($content, '<meta name="description" content="(.*?)"')
        $extractedDesc = if ($descMatches.Success) { $descMatches.Groups[1].Value.Trim() } else { "AI Master Plan" }
        
        $rootMeta = @"
    <meta name="author" content="$siteAuthor">
    <meta name="theme-color" content="#3b82f6">
    <meta name="robots" content="index, follow">
    
    <!-- Open Graph -->
    <meta property="og:type" content="website">
    <meta property="og:url" content="$siteUrl/">
    <meta property="og:title" content="$extractedTitle">
    <meta property="og:description" content="$extractedDesc">
    <meta property="og:image" content="$siteUrl/assets/icons/og-image.png">
    <meta property="og:image:width" content="1200">
    <meta property="og:image:height" content="630">
    <meta property="og:locale" content="ar_SA">
    <meta property="og:site_name" content="$siteName">
    
    <!-- Twitter Card -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="$extractedTitle">
    <meta name="twitter:description" content="$extractedDesc">
    <meta name="twitter:image" content="$siteUrl/assets/icons/og-image.png">
"@
        
        # Inject
        if ($content -match '(<link rel="icon"[^>]+>)') {
            $content = $content -replace '(<link rel="icon"[^>]+>)', "`$1`n$rootMeta"
        } else {
            $content = $content -replace '(</title>)', "`$1`n$rootMeta"
        }
        
        [System.IO.File]::WriteAllText($indexPath, $content, [System.Text.Encoding]::UTF8)
        Write-Host "[OK] index.html - Meta Tags added" -ForegroundColor Green
    } else {
        Write-Host "[SKIP] index.html (already has Meta/OG)" -ForegroundColor Yellow
    }
}

# 2. Process Pages
$pages = Get-ChildItem "$projectPath\pages\*.html"
foreach ($page in $pages) {
    $content = [System.IO.File]::ReadAllText($page.FullName, [System.Text.Encoding]::UTF8)
    
    if ($content -notmatch 'property="og:') {
        # Extract Title
        $titleMatches = [regex]::Match($content, '<title>(.*?)</title>')
        $pageTitle = if ($titleMatches.Success) { $titleMatches.Groups[1].Value.Trim() } else { "AI Master Plan" }
        
        # Extract Description
        $descMatches = [regex]::Match($content, '<meta name="description" content="(.*?)"')
        $pageDesc = if ($descMatches.Success) { $descMatches.Groups[1].Value.Trim() } else { "$pageTitle - الدليل الاحترافي الشامل" }
        
        $pagesMeta = @"
    <meta name="author" content="$siteAuthor">
    <meta name="theme-color" content="#3b82f6">
    <meta name="robots" content="index, follow">
    
    <!-- Open Graph -->
    <meta property="og:type" content="article">
    <meta property="og:url" content="$siteUrl/pages/$($page.Name)">
    <meta property="og:title" content="$pageTitle">
    <meta property="og:description" content="$pageDesc">
    <meta property="og:image" content="$siteUrl/assets/icons/og-image.png">
    <meta property="og:locale" content="ar_SA">
    
    <!-- Twitter Card -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="$pageTitle">
    <meta name="twitter:description" content="$pageDesc">
    <meta name="twitter:image" content="$siteUrl/assets/icons/og-image.png">
"@
        
        # Inject Favicon if missing
        if ($content -notmatch 'rel="icon"') {
            $faviconLine = '    <link rel="icon" type="image/svg+xml" href="../assets/icons/favicon.svg">'
            $content = $content -replace '(</title>)', "`$1`n$faviconLine"
        }
        
        # Inject Meta Block
        if ($content -match '(<link rel="icon"[^>]+>)') {
            $content = $content -replace '(<link rel="icon"[^>]+>)', "`$1`n$pagesMeta"
        } else {
            $content = $content -replace '(</title>)', "`$1`n$pagesMeta"
        }
        
        [System.IO.File]::WriteAllText($page.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "[OK] pages/$($page.Name) - Meta Tags added" -ForegroundColor Green
    } else {
        Write-Host "[SKIP] pages/$($page.Name) (already has Meta/OG)" -ForegroundColor Yellow
    }
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "[SUCCESS] All system operations completed!" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan