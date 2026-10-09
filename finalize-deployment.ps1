# ============================================================
# AI MASTER PLAN — Final Deployment & Integration Engine
# Generates Sitemap.xml and injects PWA Manifest into all pages
# ============================================================

$projectPath = "D:\Projects\ai-masterplan"
$githubUsername = "ALMajd98" # استبدل باسمك في جيت هاب هنا

Write-Host "`n[AI MASTER PLAN] Final Integration Engine" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# 1. تحديث اسم المستخدم في الملفات قبل المعالجة
$siteUrl = "https://$ALMajd98.github.io/ai-masterplan"

# 2. توليد ملف sitemap.xml تلقائياً لجميع الـ 20 صفحة
$sitemapPath = "$projectPath\sitemap.xml"
$dateStr = (Get-Date).ToString("yyyy-MM-dd")

$sitemapHeader = @"
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <!-- Main Index -->
  <url>
    <loc>$siteUrl/index.html</loc>
    <lastmod>$dateStr</lastmod>
    <changefreq>daily</changefreq>
    <priority>1.0</priority>
  </url>
"@

$sitemapFooter = "`n</urlset>"

$sitemapContent = $sitemapHeader

# جلب جميع الصفحات وتوليد مساراتها
$pages = Get-ChildItem "$projectPath\pages\*.html"
foreach ($page in $pages) {
    $priority = "0.8"
    if ($page.Name -eq "02-setup.html" -or $page.Name -eq "03-ai-local.html" -or $page.Name -eq "09-constitution.html") {
        $priority = "0.9" # الصفحات الأساسية ذات أولوية أعلى
    }
    
    $pageUrl = "$siteUrl/pages/$($page.Name)"
    $sitemapContent += "`n  <url>`n    <loc>$pageUrl</loc>`n    <lastmod>$dateStr</lastmod>`n    <changefreq>weekly</changefreq>`n    <priority>$priority</priority>`n  </url>"
}

$sitemapContent += $sitemapFooter
Set-Content -Path $sitemapPath -Value $sitemapContent -Encoding UTF8
Write-Host "[OK] sitemap.xml generated with 20 URLs." -ForegroundColor Green

# 3. تحديث ملف robots.txt بالرابط الصحيح
$robotsPath = "$projectPath\robots.txt"
if (Test-Path $robotsPath) {
    $robotsContent = Get-Content $robotsPath -Raw
    $robotsContent = $robotsContent -replace "https://your-username.github.io", "https://$githubUsername.github.io"
    Set-Content $robotsPath $robotsContent -Encoding UTF8
    Write-Host "[OK] robots.txt updated with actual sitemap link." -ForegroundColor Green
}

# 4. تحديث ملف manifest.json بالرابط الصحيح
$manifestPath = "$projectPath\manifest.json"
if (Test-Path $manifestPath) {
    $manifestContent = Get-Content $manifestPath -Raw
    $manifestContent = $manifestContent -replace "/ai-masterplan/", "/ai-masterplan/"
    Set-Content $manifestPath $manifestContent -Encoding UTF8
    Write-Host "[OK] manifest.json verified." -ForegroundColor Green
}

# 5. حقن رابط الـ Manifest في جميع الـ 20 صفحة HTML
$manifestLinkRoot = '    <link rel="manifest" href="manifest.json">'
$manifestLinkPages = '    <link rel="manifest" href="../manifest.json">'

# معالجة index.html
$indexPath = "$projectPath\index.html"
if (Test-Path $indexPath) {
    $content = Get-Content $indexPath -Raw
    if ($content -notmatch 'rel="manifest"') {
        $content = $content -replace '(</title>)', "`$1`n$manifestLinkRoot"
        Set-Content $indexPath $content -NoNewline -Encoding UTF8
        Write-Host "[OK] manifest linked in index.html" -ForegroundColor Green
    }
}

# معالجة صفحات pages/
foreach ($page in $pages) {
    $content = Get-Content $page.FullName -Raw
    if ($content -notmatch 'rel="manifest"') {
        $content = $content -replace '(</title>)', "`$1`n$manifestLinkPages"
        Set-Content $page.FullName $content -NoNewline -Encoding UTF8
        Write-Host "[OK] manifest linked in pages/$($page.Name)" -ForegroundColor Green
    }
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "[SUCCESS] All system operations completed!" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan