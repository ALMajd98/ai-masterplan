# ============================================
# AI Master Plan — Meta Tags Auto-Injection Script
# Adds SEO + Open Graph + Twitter Cards to all pages
# ============================================

$projectPath = "D:\Projects\ai-masterplan"
$siteUrl = "https://ALMajd98.github.io/ai-masterplan"
$siteName = "AI Master Plan"
$siteAuthor = "The Majd"

Write-Host "`n[AI MASTER PLAN] Meta Tags Setup Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# ===== Meta Tags Template للصفحة الرئيسية =====
$rootMetaTags = @"
    <meta name="description" content="منظومة ذكاء اصطناعي احترافية متكاملة — محلية وسحابية — بأحدث نماذج Phi-4، Qwen3، DeepSeek V4، و 10,000+ MCP. دليل شامل للمطور السعودي بميزانية 0-20`$ شهرياً.">
    <meta name="keywords" content="ذكاء اصطناعي, AI, Ollama, Cline, MCP, Next.js, سبتمبر 2026, سعودية, تجارة إلكترونية, Qwen, DeepSeek, Gemini, Groq">
    <meta name="author" content="$siteAuthor">
    <meta name="theme-color" content="#3b82f6">
    <meta name="robots" content="index, follow">
    
    <!-- Open Graph / Facebook / WhatsApp / LinkedIn -->
    <meta property="og:type" content="website">
    <meta property="og:url" content="$siteUrl/">
    <meta property="og:title" content="$siteName v4.0 — الدليل الاحترافي الشامل">
    <meta property="og:description" content="منظومة ذكاء اصطناعي احترافية متكاملة بأحدث نماذج 2026. 19 صفحة توثيقية، 10,000+ MCP، و 60+ فحص أمني.">
    <meta property="og:image" content="$siteUrl/assets/icons/og-image.png">
    <meta property="og:image:width" content="1200">
    <meta property="og:image:height" content="630">
    <meta property="og:locale" content="ar_SA">
    <meta property="og:site_name" content="$siteName">
    
    <!-- Twitter Card -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="$siteName v4.0 — الدليل الاحترافي الشامل">
    <meta name="twitter:description" content="منظومة ذكاء اصطناعي احترافية بميزانية 0-20`$ شهرياً.">
    <meta name="twitter:image" content="$siteUrl/assets/icons/og-image.png">
"@

# ===== Meta Tags Template للصفحات الداخلية =====
$pagesMetaTags = @"
    <meta name="description" content="PAGE_DESC_PLACEHOLDER">
    <meta name="author" content="$siteAuthor">
    <meta name="theme-color" content="#3b82f6">
    <meta name="robots" content="index, follow">
    
    <!-- Open Graph -->
    <meta property="og:type" content="article">
    <meta property="og:title" content="PAGE_TITLE_PLACEHOLDER | $siteName">
    <meta property="og:description" content="PAGE_DESC_PLACEHOLDER">
    <meta property="og:image" content="$siteUrl/assets/icons/og-image.png">
    <meta property="og:locale" content="ar_SA">
    
    <!-- Twitter Card -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="PAGE_TITLE_PLACEHOLDER | $siteName">
    <meta name="twitter:description" content="PAGE_DESC_PLACEHOLDER">
"@

# ===== أوصاف خاصة بكل صفحة =====
$pageDescriptions = @{
    "01-overview.html" = @{
        title = "نظرة عامة على المنظومة"
        desc = "المعمارية الهجينة والفلسفة الأساسية لبناء منظومة ذكاء اصطناعي احترافية متكاملة."
    }
    "02-setup.html" = @{
        title = "تجهيز الجهاز"
        desc = "دليل كامل لتجهيز بيئة التطوير من الصفر: Windows 11, Ollama, Node.js, Python, Docker."
    }
    "03-ai-local.html" = @{
        title = "AI المحلي"
        desc = "تثبيت وإدارة النماذج المحلية عبر Ollama: Phi-4, Qwen3, DeepSeek-R1, Gemma 4, BGE-M3."
    }
    "04-ai-cloud.html" = @{
        title = "AI السحابي"
        desc = "المزودون المجانيون المعتمدون لسبتمبر 2026: Gemini 3, Groq, OpenRouter, Qwen API, DeepSeek V4."
    }
    "05-vscode.html" = @{
        title = "VS Code + Cline"
        desc = "إعداد بيئة البرمجة الاحترافية مع Cline v3.81 ودمج المحركات المحلية والسحابية."
    }
    "06-mcps.html" = @{
        title = "MCPs — 10,000+ أداة"
        desc = "بروتوكول Model Context Protocol — أكثر من 10 آلاف خادم MCP تحت رعاية Linux Foundation."
    }
    "07-modes.html" = @{
        title = "Custom Modes"
        desc = "شخصيات AI متخصصة: مطور Full-Stack، محلل أمني، خبير تجارة إلكترونية سعودية، باحث سوق."
    }
    "08-skills.html" = @{
        title = "Skills — المهارات الجاهزة"
        desc = "مكتبات مهارات AI احترافية جاهزة من GitHub: Anthropic Skills, Superpowers, Agents."
    }
    "09-constitution.html" = @{
        title = "الدستور البرمجي"
        desc = "القواعد الصارمة والمعايير الاحترافية التي يلتزم بها AI في كل مشروع."
    }
    "10-security.html" = @{
        title = "الأمان — 60+ فحص"
        desc = "قائمة فحص الأمان الشاملة وفق معايير OWASP 2025 + Passkeys + حماية AI."
    }
    "11-performance.html" = @{
        title = "الأداء والتوسع"
        desc = "React Compiler, Turbopack, Core Web Vitals, اختبارات k6 للأداء الاحترافي."
    }
    "12-ecommerce.html" = @{
        title = "التجارة السعودية"
        desc = "دليل متكامل للتجارة الإلكترونية في السعودية: Salla, ZATCA Phase 2, Moyasar, Tabby, Tamara."
    }
    "13-techstack.html" = @{
        title = "Tech Stack 2026"
        desc = "التقنيات المعتمدة: Next.js 16, React 19.2, Bun, Supabase, Qdrant, Hono."
    }
    "14-workflow.html" = @{
        title = "خطوات العمل اليومية"
        desc = "الـ Workflow الاحترافي اليومي من فكرة المشروع إلى النشر والمتابعة."
    }
    "15-resources.html" = @{
        title = "المصادر والمراجع"
        desc = "قنوات YouTube، مجتمعات، وثائق رسمية لمواكبة تطورات AI لعام 2026."
    }
    "16-multi-agent.html" = @{
        title = "Multi-Agent Systems"
        desc = "أنظمة Multi-Agent المتقدمة: CrewAI, LangGraph, AutoGen, Mastra للمهام المعقدة."
    }
    "17-mcp-security.html" = @{
        title = "أمان بروتوكول MCP"
        desc = "حماية منظومتك من ثغرات MCP Supply Chain، SSRF، وتسريب المفاتيح."
    }
    "18-ai-timeline.html" = @{
        title = "أحداث AI 2025-2026"
        desc = "الخط الزمني لأهم أحداث AI: DeepSeek R1, GPT-5, Qwen3.8, و MCP Linux Foundation."
    }
    "19-ai-tools-compare.html" = @{
        title = "مقارنة أدوات AI"
        desc = "مقارنة شاملة: Cline vs Cursor vs Windsurf vs Continue vs GitHub Copilot."
    }
}

# ===== معالجة index.html =====
$indexPath = "$projectPath\index.html"
if (Test-Path $indexPath) {
    $content = Get-Content $indexPath -Raw
    if ($content -notmatch 'property="og:') {
        $content = $content -replace '(<link rel="icon"[^>]+>)', "`$1`n$rootMetaTags"
        Set-Content $indexPath $content -NoNewline -Encoding UTF8
        Write-Host "[OK] index.html - Meta Tags added" -ForegroundColor Green
    } else {
        Write-Host "[SKIP] index.html (already has Meta Tags)" -ForegroundColor Yellow
    }
}

# ===== معالجة الصفحات الداخلية =====
foreach ($pageName in $pageDescriptions.Keys) {
    $pagePath = "$projectPath\pages\$pageName"
    if (Test-Path $pagePath) {
        $content = Get-Content $pagePath -Raw
        
        if ($content -notmatch 'property="og:') {
            $pageInfo = $pageDescriptions[$pageName]
            $metaBlock = $pagesMetaTags `
                -replace 'PAGE_DESC_PLACEHOLDER', $pageInfo.desc `
                -replace 'PAGE_TITLE_PLACEHOLDER', $pageInfo.title
            
            # إضافة favicon إذا لم يكن موجوداً
            if ($content -notmatch 'rel="icon"') {
                $faviconLine = '    <link rel="icon" type="image/svg+xml" href="../assets/icons/favicon.svg">'
                $content = $content -replace '(</title>)', "`$1`n$faviconLine"
            }
            
            # إضافة Meta Tags
            $content = $content -replace '(<link rel="icon"[^>]+>)', "`$1`n$metaBlock"
            
            Set-Content $pagePath $content -NoNewline -Encoding UTF8
            Write-Host "[OK] pages/$pageName - Meta Tags added" -ForegroundColor Green
        } else {
            Write-Host "[SKIP] pages/$pageName (already has Meta Tags)" -ForegroundColor Yellow
        }
    } else {
        Write-Host "[MISSING] pages/$pageName not found" -ForegroundColor Red
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "[DONE] Meta Tags injected successfully!" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "IMPORTANT:" -ForegroundColor Yellow
Write-Host "1. Edit setup-meta-tags.ps1 and change `$siteUrl to your actual GitHub Pages URL" -ForegroundColor White
Write-Host "2. Create og-image.png (1200x630px) and place in assets/icons/" -ForegroundColor White
Write-Host "3. For og-image, use any online tool like: canva.com or figma.com" -ForegroundColor White