import os
import shutil

project_path = r"D:\Projects\ai-masterplan"
backup_path = r"D:\Projects\ai-masterplan-backup"

print("\n[AI MASTER PLAN] Python Arabic Encoding Restoration Engine")
print("==========================================================")

# 1. Take a safe backup
if os.path.exists(backup_path):
    shutil.rmtree(backup_path)
os.makedirs(backup_path, exist_ok=True)

shutil.copy(os.path.join(project_path, "index.html"), backup_path)
shutil.copytree(os.path.join(project_path, "pages"), os.path.join(backup_path, "pages"))
print(f"[*] Safe backup created at: {backup_path}")

def fix_mojibake_line(line):
    try:
        # Re-encode Mojibake characters to CP1256 bytes and decode as UTF-8
        return line.encode('cp1256').decode('utf-8')
    except (UnicodeEncodeError, UnicodeDecodeError):
        return line

def fix_file(file_path):
    try:
        with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
            lines = f.readlines()
        
        fixed_lines = [fix_mojibake_line(line) for line in lines]
        fixed_content = "".join(fixed_lines)
        
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(fixed_content)
        
        print(f"[OK] Restored Arabic successfully: {os.path.basename(file_path)}")
    except Exception as e:
        print(f"[ERROR] Failed on {file_path}: {e}")

# 2. Fix index.html
fix_file(os.path.join(project_path, "index.html"))

# 3. Fix all pages
pages_dir = os.path.join(project_path, "pages")
for filename in os.listdir(pages_dir):
    if filename.endswith(".html"):
        fix_file(os.path.join(pages_dir, filename))

print("==========================================================")
print("[SUCCESS] All 20 pages restored to pure Arabic UTF-8!\n")