// Stranger Things "Upside Down" theme transition effect
//
// Phase 1: Rotate clockwise (Z-axis) to upside-down, gradually fade to grayscale
//          (original theme visible throughout)
// Phase 2: Apply stranger-things theme, sporadic lightning flashes of color
// Phase 3: Go black, reset to upright
// Phase 4: Slowly fade from black to theme colors

export function strangerThingsTransition(applyTheme) {
  const root = document.getElementById('spec-main-content');
  if (!root) return;

  const PHASE1 = 4800;  // rotate + fade to grayscale
  const PHASE2 = 3000;  // lightning flashes
  const PHASE3 = 600;   // hold black
  const PHASE4 = 2400;  // fade from black to color

  root.style.transformOrigin = 'center center';

  // Phase 1: Rotate to upside-down while gradually fading to grayscale
  // Theme has NOT changed yet — original theme colors fade to gray
  root.style.transition =
    `transform ${PHASE1}ms ease-in-out, filter ${PHASE1}ms ease-in-out`;
  requestAnimationFrame(() => {
    root.style.transform = 'rotateZ(180deg)';
    root.style.filter = 'grayscale(1)';
  });

  setTimeout(() => {
    // NOW apply the stranger-things theme (hidden under grayscale)
    applyTheme();

    // Phase 2: Sporadic lightning flashes (irregular color bursts)
    root.style.transition = 'none';

    // Irregular flash pattern — short color bursts with random gaps
    const pattern = [
      // [delay from phase2 start, duration of color flash]
      [200, 60],
      [500, 40],
      [580, 80],
      [900, 50],
      [1100, 120],
      [1150, 30],
      [1500, 70],
      [1650, 40],
      [1700, 100],
      [2000, 50],
      [2250, 60],
      [2300, 30],
      [2350, 80],
      [2600, 40],
      [2750, 60],
      [2800, 30],
    ];

    for (const [delay, duration] of pattern) {
      setTimeout(() => {
        root.style.filter = 'grayscale(0)';
        setTimeout(() => {
          root.style.filter = 'grayscale(1)';
        }, duration);
      }, delay);
    }

    setTimeout(() => {
      // Phase 3: Go black and reset to upright
      root.style.transition = 'filter 400ms ease-in';
      root.style.filter = 'grayscale(1) brightness(0)';

      setTimeout(() => {
        // Snap upright while fully black (invisible)
        root.style.transition = 'none';
        root.style.transform = '';
        root.offsetHeight;

        // Phase 4: Slowly fade from black to theme colors
        root.style.transition = `filter ${PHASE4}ms ease-out`;
        requestAnimationFrame(() => {
          root.style.filter = 'grayscale(0) brightness(1)';
        });

        setTimeout(() => {
          root.style.transition = '';
          root.style.filter = '';
          root.style.transformOrigin = '';
        }, PHASE4);
      }, PHASE3);
    }, PHASE2);
  }, PHASE1);
}
