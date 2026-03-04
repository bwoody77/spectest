// Stranger Things glow bar — stays dim, brief intense glow
const glowStyle = document.createElement('style');
glowStyle.textContent = `
@keyframes st-glow {
  0% { opacity: 0.1; }
  10% { opacity: 0.5; }
  20% { opacity: 0.1; }
  35% { opacity: 0.8; }
  45% { opacity: 0.6; }
  55% { opacity: 1; }
  75% { opacity: 0.2; }
  85% { opacity: 0.4; }
  100% { opacity: 0.1; }
}`;
document.head.appendChild(glowStyle);

// Stranger Things "Upside Down" theme transition effect
//
// Lightning: Brief white flashes before anything else
// Phase 1: Rotate clockwise (Z-axis) to upside-down (slow start, accelerating),
//          fade to grayscale then black (original theme visible throughout)
// Phase 2: Fade in stranger-things theme (still upside-down) + more lightning
// Phase 3: Go black, snap upright, fade in right-side-up

export function strangerThingsTransition(applyTheme) {
  const root = document.getElementById('spec-main-content');
  if (!root) return;

  const PHASE1 = 4800;   // rotate + fade to grayscale then black
  const PHASE2 = 2500;   // fade in upside-down stranger-things theme
  const PHASE3 = 2000;   // fade in right-side-up from black

  // --- Lightning flashes ---
  const overlay = document.createElement('div');
  overlay.style.cssText =
    'position:fixed;inset:0;z-index:999999;pointer-events:none;opacity:0;background:white;';
  document.body.appendChild(overlay);

  function flash(opacity, duration) {
    return new Promise((resolve) => {
      overlay.style.transition = `opacity ${duration}ms linear`;
      requestAnimationFrame(() => {
        overlay.style.opacity = opacity;
        setTimeout(resolve, duration);
      });
    });
  }

  // Two irregular lightning strikes, spaced out
  async function lightning() {
    await flash(0.9, 70);   // first strike
    await flash(0, 100);    // dark
    await flash(0.6, 50);   // afterflash
    await flash(0, 600);    // long pause
    await flash(1, 60);     // second strike — full white
    await flash(0, 90);     // dark
    await flash(0.4, 40);   // flicker
    await flash(0, 400);    // pause
    await flash(0.7, 50);   // third strike
    await flash(0, 80);     // dark
    await flash(0.3, 35);   // faint afterflash
    await flash(0, 2000);   // 2s pause before rotation
    overlay.style.display = 'none';
  }

  lightning().then(() => {
    startRotation();
  });

  function startRotation() {
    root.style.transformOrigin = 'center center';
    const HALF1 = PHASE1 / 2;

    // Phase 1a: Rotate + fade to grayscale (first half)
    root.style.transition =
      `transform ${PHASE1}ms ease-in, filter ${HALF1}ms ease-in`;
    requestAnimationFrame(() => {
      root.style.transform = 'rotateZ(180deg)';
      root.style.filter = 'grayscale(1)';
    });

    // Phase 1b: Fade from grayscale to black (second half)
    setTimeout(() => {
      root.style.transition =
        `transform ${HALF1}ms ease-in, filter ${HALF1}ms ease-in`;
      root.style.filter = 'grayscale(1) brightness(0)';
    }, HALF1);

    setTimeout(() => {
      // Apply theme while black — stay upside-down
      applyTheme();

      // Phase 2: Fade in stranger-things upside-down + lightning
      root.style.transition = `filter ${PHASE2}ms ease-out`;
      requestAnimationFrame(() => {
        root.style.filter = 'grayscale(0) brightness(1)';
      });

      // Re-attach overlay for phase 2 lightning
      overlay.style.display = '';
      overlay.style.opacity = 0;
      document.body.appendChild(overlay);

      async function phase2Lightning() {
        await flash(0, 400);     // let theme fade in a bit first
        await flash(0.8, 60);    // strike
        await flash(0, 100);     // dark
        await flash(0.5, 40);    // afterflash
        await flash(0, 500);     // pause
        await flash(1, 50);      // big strike
        await flash(0, 80);      // dark
        await flash(0.3, 35);    // flicker
        await flash(0, 300);     // settle
        overlay.remove();
      }

      phase2Lightning().then(() => {
        // Phase 3: Go black, snap upright, fade in
        root.style.transition = `filter 400ms ease-in`;
        root.style.filter = 'brightness(0)';

        setTimeout(() => {
          // Snap upright while black
          root.style.transition = 'none';
          root.style.transform = '';
          root.offsetHeight;

          // Fade in right-side-up
          root.style.transition = `filter ${PHASE3}ms ease-out`;
          requestAnimationFrame(() => {
            root.style.filter = 'brightness(1)';
          });

          setTimeout(() => {
            root.style.transition = '';
            root.style.filter = '';
            root.style.transformOrigin = '';
          }, PHASE3);
        }, 400);
      });
    }, PHASE1);
  }
}
