# ============================================================
# AI MASTER PLAN — Arabic Encoding Recovery Script (Mojibake Fix)
# September 2026 — Reverses ANSI-to-UTF8 corruption perfectly
# ============================================================

$projectPath = "D:\Projects\ai-masterplan"
$backupPath = "D:\Projects\ai-masterplan-backup"

Write-Host "`n[AI MASTER PLAN] Arabic Encoding Recovery Engine" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

# 1. أخذ نسخة احتياطية فورية للأمان
if (Test-Path $backupPath) { Remove-Item -Recurse -Force $backupPath }
New-Item -ItemType Directory -Force -Path $backupPath | Out-Null
Copy-Item -Path "$projectPath\index.html" -Destination "$backupPath\" -Force
Copy-Item -Path "$projectPath\pages" -Destination "$backupPath\" -Recurse -Force
Write-Host "🛡️ تم أخذ نسخة احتياطية آمنة في: $backupPath" -ForegroundColor Yellow

# دالة سحرية لعكس الترميز الخاطئ واستعادة العربي
function Recover-FileEncoding($filePath) {
    if (Test-Path $filePath) {
        # 1. قراءة الملف النصي الذي يحتوي الرموز الغريبة كـ UTF-8
        $corruptedText = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
        
        # التحقق من أن الملف يحتوي فعلاً على رموز تالفة لتجنب دبلجة الملفات السليمة
        if ($corruptedText -match 'ظ†ط¸ط±ط©' -or $corruptedText -match 'ط§ظ„ظ…ط­ظ„ظٹ' -or $corruptedText -match 'ط¥ط¹ط¯ط§ط¯' -or $corruptedText -match 'ط§ظ„ط¨ط±ظ…ط¬ط©') {
            
            # 2. تحويل الرموز الغريبة إلى بايتات النظام الافتراضية (ANSI/Windows-1256)
            $ansiEncoding = [System.Text.Encoding]::Default
            $bytes = $ansiEncoding.GetBytes($corruptedText)
            
            # 3. إعادة ترجمة البايتات بشكل سليم وصحيح إلى UTF-8
            $cleanText = [System.Text.Encoding]::UTF8.GetString($bytes)
            
            # 4. حفظ الملف بترميز UTF-8 نظيف بدون BOM
            [System.IO.File]::WriteAllText($filePath, $cleanText, [System.Text.Encoding]::UTF8)
            Write-Host "✅ تم استعادة اللغة العربية بنجاح لـ: $filePath" -ForegroundColor Green
        } else {
            Write-Host "ℹ️ الملف سليم ولا يحتاج استعادة: $filePath" -ForegroundColor Gray
        }
    }
}

# 2. معالجة الصفحة الرئيسية
Recover-FileEncoding "$projectPath\index.html"

# 3. معالجة كل الصفحات الداخلية
$pages = Get-ChildItem "$projectPath\pages\*.html"
foreach ($page in $pages) {
    Recover-FileEncoding $page.FullName
}

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "🎉 تم الانتهاء من معالجة واستعادة كافة الملفات!" -ForegroundColor Green
Write-Host "=============================================`n" -ForegroundColor Cyan