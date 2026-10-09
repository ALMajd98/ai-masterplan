/**
 * AI MASTER PLAN v4.0 — Universal Fluid Interaction System
 * September 2026 — Works on ALL screen sizes (2K, 4K, FHD, Mobile)
 * Clean, Simple, No Device Restrictions
 */

// ============================================
// 1. INITIALIZATION ON PAGE LOAD
// ============================================
document.addEventListener('DOMContentLoaded', () => {
    initTheme();
    initSidebarState();
    initProgressSystem();
    initAnimatedCounters();
    initKeyboardShortcuts();
});

// ============================================
// 2. THEME MANAGEMENT (Dark / Light Mode)
// ============================================
function initTheme() {
    const savedTheme = localStorage.getItem('ai_masterplan_theme') || 'dark';
    if (savedTheme === 'light') {
        document.body.classList.add('light-mode');
        updateThemeIcon(true);
    }
}

function toggleTheme() {
    const isLight = document.body.classList.toggle('light-mode');
    localStorage.setItem('ai_masterplan_theme', isLight ? 'light' : 'dark');
    updateThemeIcon(isLight);
}

function updateThemeIcon(isLight) {
    const icon = document.getElementById('themeIcon');
    if (!icon) return;
    icon.className = isLight ? 'fas fa-sun' : 'fas fa-moon';
}

// ============================================
// 3. SIDEBAR TOGGLE (UNIVERSAL - No Device Checks!)
// ============================================
function initSidebarState() {
    const savedState = localStorage.getItem('ai_masterplan_sidebar_state');
    if (savedState === 'collapsed') {
        document.body.classList.add('sidebar-collapsed');
    }
}

function toggleSidebar() {
    const isCollapsed = document.body.classList.toggle('sidebar-collapsed');
    localStorage.setItem(
        'ai_masterplan_sidebar_state',
        isCollapsed ? 'collapsed' : 'expanded'
    );
}

// ============================================
// 4. SIDEBAR SEARCH FILTER
// ============================================
function searchNav(query) {
    const filter = query.toLowerCase().trim();
    const links = document.querySelectorAll('.sidebar-nav .nav-link');
    const sections = document.querySelectorAll('.sidebar-nav .nav-section');

    links.forEach(link => {
        const text = link.textContent.toLowerCase();
        link.style.display = text.includes(filter) ? 'flex' : 'none';
    });

    sections.forEach(section => {
        const visibleLinks = Array.from(section.querySelectorAll('.nav-link'))
            .filter(link => link.style.display !== 'none');
        section.style.display = (visibleLinks.length > 0 || filter === '') ? 'block' : 'none';
    });
}

// ============================================
// 5. PROGRESS TRACKING SYSTEM
// ============================================
function initProgressSystem() {
    loadProgress();
    updateProgress();
}

function updateProgress() {
    const checkboxes = document.querySelectorAll('.task-item input[type="checkbox"]');
    if (checkboxes.length === 0) return;

    const total = checkboxes.length;
    const checked = document.querySelectorAll('.task-item input[type="checkbox"]:checked').length;
    const percent = Math.round((checked / total) * 100);

    const progressFill = document.getElementById('totalProgress');
    const progressText = document.querySelector('.progress-percent');
    const completedEl = document.getElementById('completedCount');
    const totalEl = document.getElementById('totalCount');

    if (progressFill) progressFill.style.width = percent + '%';
    if (progressText) progressText.textContent = percent + '%';
    if (completedEl) completedEl.textContent = checked;
    if (totalEl) totalEl.textContent = total;

    const state = {};
    checkboxes.forEach((cb, index) => {
        state[index] = cb.checked;
    });
    localStorage.setItem('ai_masterplan_roadmap_progress', JSON.stringify(state));

    updateRoadmapPhaseStatuses();
}

function loadProgress() {
    const saved = localStorage.getItem('ai_masterplan_roadmap_progress');
    if (!saved) return;

    try {
        const state = JSON.parse(saved);
        const checkboxes = document.querySelectorAll('.task-item input[type="checkbox"]');
        checkboxes.forEach((cb, index) => {
            if (state[index] !== undefined) {
                cb.checked = state[index];
            }
        });
    } catch (e) {
        console.error('Error loading progress', e);
    }
}

function updateRoadmapPhaseStatuses() {
    document.querySelectorAll('.roadmap-phase').forEach(phase => {
        const checks = phase.querySelectorAll('input[type="checkbox"]');
        const checked = phase.querySelectorAll('input[type="checkbox"]:checked');
        const statusEl = phase.querySelector('.phase-status');

        if (!statusEl) return;

        if (checked.length === checks.length && checks.length > 0) {
            statusEl.className = 'phase-status completed';
            statusEl.innerHTML = '<i class="fas fa-check-circle"></i> <span>مكتمل</span>';
        } else if (checked.length > 0) {
            statusEl.className = 'phase-status in-progress';
            statusEl.innerHTML = '<i class="fas fa-spinner fa-spin"></i> <span>قيد التنفيذ</span>';
        } else {
            statusEl.className = 'phase-status pending';
            statusEl.innerHTML = '<i class="fas fa-clock"></i> <span>لم يبدأ</span>';
        }
    });
}

function togglePhase(btn) {
    const phase = btn.closest('.roadmap-phase');
    if (phase) {
        phase.classList.toggle('collapsed');
    }
}

// ============================================
// 6. ANIMATED COUNTERS
// ============================================
function initAnimatedCounters() {
    const counters = document.querySelectorAll('.counter, .counter-animated');
    
    counters.forEach(counter => {
        const target = +counter.getAttribute('data-target');
        if (!target) return;
        
        const suffix = counter.getAttribute('data-suffix') || '';
        const duration = 1200;
        const stepTime = 20;
        const steps = duration / stepTime;
        const increment = target / steps;
        let current = 0;

        const timer = setInterval(() => {
            current += increment;
            if (current >= target) {
                counter.textContent = target.toLocaleString() + suffix;
                clearInterval(timer);
            } else {
                counter.textContent = Math.floor(current).toLocaleString() + suffix;
            }
        }, stepTime);
    });
}

// ============================================
// 7. CODE COPY FUNCTIONALITY
// ============================================
function copyCode(btn) {
    const codeBlock = btn.closest('.code-block').querySelector('code');
    if (!codeBlock) return;

    navigator.clipboard.writeText(codeBlock.innerText).then(() => {
        const icon = btn.querySelector('i');
        const originalClass = icon.className;
        icon.className = 'fas fa-check';
        icon.style.color = '#10b981';
        
        setTimeout(() => {
            icon.className = originalClass;
            icon.style.color = '';
        }, 2000);
    }).catch(err => {
        console.error('Failed to copy:', err);
    });
}

// ============================================
// 8. KEYBOARD SHORTCUTS
// ============================================
function initKeyboardShortcuts() {
    document.addEventListener('keydown', (e) => {
        // Ctrl + K → Focus search
        if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
            e.preventDefault();
            const searchInput = document.getElementById('sidebarSearch');
            if (searchInput) {
                // تأكد أن السايدبار مفتوحة
                if (document.body.classList.contains('sidebar-collapsed')) {
                    toggleSidebar();
                }
                setTimeout(() => searchInput.focus(), 100);
            }
        }
        
        // Ctrl + B → Toggle sidebar
        if ((e.ctrlKey || e.metaKey) && e.key === 'b') {
            e.preventDefault();
            toggleSidebar();
        }
        
        // Escape → Close sidebar
        if (e.key === 'Escape') {
            if (!document.body.classList.contains('sidebar-collapsed')) {
                toggleSidebar();
            }
        }
    });
}

// ============================================
// 9. UTILITY FUNCTIONS
// ============================================
function scrollToTop() {
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

function toggleFullscreen() {
    const btn = document.getElementById('fullscreenBtn');
    const icon = btn ? btn.querySelector('i') : null;
    
    if (!document.fullscreenElement) {
        document.documentElement.requestFullscreen().then(() => {
            if (icon) icon.className = 'fas fa-compress';
        }).catch(err => {
            console.error('Fullscreen error:', err);
        });
    } else {
        if (document.exitFullscreen) {
            document.exitFullscreen().then(() => {
                if (icon) icon.className = 'fas fa-expand';
            });
        }
    }
}