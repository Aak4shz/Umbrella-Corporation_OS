# AutoX — Advanced Car Showcase

A beautiful, responsive, and interactive car showcase website built with plain HTML, CSS, and JavaScript. It includes search, filters, sorting, featured carousel, detailed modal, compare tray, stats bar, and a light/dark theme toggle.

## Project Structure
```
autox/
├─ index.html
├─ styles.css
├─ script.js
└─ README.md
```

## Features
- Modern, responsive UI with glassmorphism and smooth micro-interactions.
- Search by brand, model, or type.
- Filters:
  - Body type chips (All, Sedan, SUV, Coupe, EV, Hybrid, Convertible)
  - Max price slider with Indian formatting (Lakhs/Crores).
- Sorting:
  - Price (Low→High / High→Low)
  - Horsepower (High→Low)
  - Range (High→Low)
  - Year (New→Old)
- Live stats bar:
  - Count of cars shown
  - Average price (formatted as ₹ Lakhs/Cr)
  - Average HP
  - Fuel types in current view
- Featured carousel with smooth scroll controls.
- Modal details with rich specs and actions (Add to Compare, Test Drive).
- Compare tray to collect selected cars.
- Light/Dark theme toggle with preference saved in localStorage.
- Keyboard and accessibility niceties (Enter to open card, Esc to close modal, ARIA labels).

## Getting Started

### 1) Prerequisites
- Any modern web browser (Chrome, Edge, Firefox, Safari).
- No build tools or servers required.

### 2) Setup
- Download or copy the three files and place them in the same folder:
  - index.html
  - styles.css
  - script.js

### 3) Run
- Open index.html in a browser (double-click or drag-drop into a browser window).

## Usage Guide

### Navigation
- Header links jump to Home, Explore, Featured, and Contact sections.
- “Explore Cars” button scrolls directly to the grid.

### Search & Filters
- Search bar: type any brand/model/type keyword (e.g., “Tesla”, “SUV”, “EV”).
- Sort dropdown: choose preferred sorting criteria.
- Chips: click once to activate a body type; “All” shows everything.
- Price slider: adjust to set the maximum budget; label shows ₹ in Lakhs/Cr.
- Reset button: clears all filters and sorting to defaults.

### Explore Grid
- Hover cards for subtle elevation.
- Click a card or press Enter to open the details modal.
- Stats bar updates live based on current filters.

### Details Modal
- Shows price, horsepower, 0–100, top speed, range, fuel, drive, and transmission.
- Add to Compare: adds the model to the compare tray at the bottom of the modal.
- Clear button: clears the compare list.
- Test Drive: mock alert to simulate a request.
- Close: click ✕, backdrop, or press Esc.

### Featured Carousel
- Use ‹ and › buttons to scroll the featured models row.

### Theme Toggle
- Sun/Moon button switches themes; preference persists across reloads.

## Customization

### Add or Edit Cars
Open script.js and modify the cars array:
```javascript
{
  id: "ax-10",
  brand: "YourBrand",
  model: "Model X",
  type: "SUV",           // Sedan | SUV | Coupe | EV | Hybrid | Convertible
  year: 2025,
  price: 2500000,        // ₹ in integers
  hp: 300,
  zeroTo100: 6.5,        // seconds
  topSpeed: 200,         // km/h
  range: 500,            // km (or effective driving range)
  fuel: "Electric",      // Electric | Petrol | Hybrid | Diesel (if needed)
  drive: "AWD",          // AWD | RWD | FWD
  transmission: "AT",    // text label
  featured: false,       // true to include in Featured carousel
  color: "#223344"       // hex used for card and modal gradients
}
```

### Change Branding and Colors
- Update the brand text/logo in index.html (navbar and footer).
- Tweak theme variables in styles.css under :root and body.light.

### Typography
- Uses Google Font “Poppins”; adjust weights or families in the <head> of index.html.

## Accessibility
- Modal has role and aria attributes.
- Keyboard:
  - Enter on focused card opens modal.
  - Escape closes modal.
- Buttons and controls include accessible labels.

## Performance Tips
- The project is framework-free; it loads instantly.
- If adding images:
  - Use modern formats (WebP/AVIF) and set width/height to avoid layout shifts.
  - Lazy-load images using loading="lazy".

## FAQs

- Can this work offline?
  - Yes, it’s static. For a full PWA, add a manifest.json and service worker.

- How to add real images?
  - Replace the CSS gradient card/media backgrounds with <img> tags inside .card-media and .modal-hero.

- How to persist Compare items?
  - Store compareIds in localStorage on add/clear and rehydrate on load.

- How to hook Test Drive to a backend?
  - Replace the alert with a fetch POST to an API endpoint. Validate inputs server-side.

## Known Limitations
- No backend or database; all data is client-side in script.js.
- No router; navigation is scroll-based anchors.

## Scripts & Linking (Quick Check)
- index.html already links:
  - <link rel="stylesheet" href="styles.css" />
  - <script src="script.js" defer></script>

If files are renamed or moved, ensure paths are updated accordingly.

## License
- Personal and educational use permitted. For commercial usage, review and adjust branding/assets accordingly.

## Author Notes
- Built for a sleek demo of UI/UX patterns: filters, live stats, modals, and theming with minimal code.
- Suggestions welcome: image gallery, bookmarks, server filtering, and PWA enhancements can be added next.