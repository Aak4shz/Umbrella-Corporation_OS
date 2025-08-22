// ---------- Data ----------
const cars = [
  {
    id: "ax-01",
    brand: "Tesla",
    model: "Model S Plaid",
    type: "EV",
    year: 2024,
    price: 18500000, // ₹
    hp: 1020,
    zeroTo100: 2.1,
    topSpeed: 322,
    range: 600,
    fuel: "Electric",
    drive: "AWD",
    transmission: "Single-speed",
    featured: true,
    color: "#2b2f3a"
  },
  {
    id: "ax-02",
    brand: "Porsche",
    model: "911 Turbo S",
    type: "Coupe",
    year: 2023,
    price: 34000000,
    hp: 640,
    zeroTo100: 2.6,
    topSpeed: 330,
    range: 450,
    fuel: "Petrol",
    drive: "AWD",
    transmission: "8-speed PDK",
    featured: true,
    color: "#2a2f45"
  },
  {
    id: "ax-03",
    brand: "BMW",
    model: "i7 xDrive60",
    type: "Sedan",
    year: 2024,
    price: 19500000,
    hp: 536,
    zeroTo100: 4.5,
    topSpeed: 240,
    range: 625,
    fuel: "Electric",
    drive: "AWD",
    transmission: "Single-speed",
    featured: false,
    color: "#1f2a3a"
  },
  {
    id: "ax-04",
    brand: "Lamborghini",
    model: "Revuelto",
    type: "Hybrid",
    year: 2024,
    price: 60000000,
    hp: 1001,
    zeroTo100: 2.5,
    topSpeed: 350,
    range: 400,
    fuel: "Hybrid",
    drive: "AWD",
    transmission: "8-speed DCT",
    featured: true,
    color: "#302934"
  },
  {
    id: "ax-05",
    brand: "Mercedes",
    model: "AMG GT 63 S",
    type: "Sedan",
    year: 2022,
    price: 26000000,
    hp: 639,
    zeroTo100: 3.2,
    topSpeed: 315,
    range: 520,
    fuel: "Petrol",
    drive: "AWD",
    transmission: "9-speed AT",
    featured: false,
    color: "#222935"
  },
  {
    id: "ax-06",
    brand: "Audi",
    model: "RS e-tron GT",
    type: "EV",
    year: 2023,
    price: 17000000,
    hp: 646,
    zeroTo100: 3.3,
    topSpeed: 250,
    range: 488,
    fuel: "Electric",
    drive: "AWD",
    transmission: "2-speed",
    featured: false,
    color: "#233042"
  },
  {
    id: "ax-07",
    brand: "Ferrari",
    model: "Roma Spider",
    type: "Convertible",
    year: 2024,
    price: 42000000,
    hp: 612,
    zeroTo100: 3.4,
    topSpeed: 320,
    range: 500,
    fuel: "Petrol",
    drive: "RWD",
    transmission: "8-speed DCT",
    featured: true,
    color: "#372a2a"
  },
  {
    id: "ax-08",
    brand: "Tata",
    model: "Curvv EV",
    type: "SUV",
    year: 2025,
    price: 2000000,
    hp: 210,
    zeroTo100: 7.2,
    topSpeed: 160,
    range: 450,
    fuel: "Electric",
    drive: "FWD",
    transmission: "Single-speed",
    featured: false,
    color: "#21312f"
  },
  {
    id: "ax-09",
    brand: "Mahindra",
    model: "XUV.e8",
    type: "SUV",
    year: 2025,
    price: 3200000,
    hp: 300,
    zeroTo100: 6.8,
    topSpeed: 180,
    range: 500,
    fuel: "Electric",
    drive: "AWD",
    transmission: "Single-speed",
    featured: false,
    color: "#1f2e2f"
  }
];

// ---------- Utils ----------
const INR = n => `₹${n.toLocaleString('en-IN')}`;
const km = n => `${n} km`;
const kmh = n => `${n} km/h`;
const sec = n => `${n}s`;

// ---------- Elements ----------
const grid = document.getElementById('carsGrid');
const countShown = document.getElementById('countShown');
const avgPrice = document.getElementById('avgPrice');
const avgHp = document.getElementById('avgHp');
const fuelTypes = document.getElementById('fuelTypes');
const noResults = document.getElementById('noResults');
const typeFilters = document.getElementById('typeFilters');
const priceRange = document.getElementById('priceRange');
const priceValue = document.getElementById('priceValue');
const searchInput = document.getElementById('searchInput');
const sortSelect = document.getElementById('sortSelect');
const clearFilters = document.getElementById('clearFilters');
const modal = document.getElementById('modal');
const modalBackdrop = document.getElementById('modalBackdrop');
const modalClose = document.getElementById('modalClose');
const modalHero = document.getElementById('modalHero');
const modalTitle = document.getElementById('modalTitle');
const modalSubtitle = document.getElementById('modalSubtitle');
const mPrice = document.getElementById('mPrice');
const mHp = document.getElementById('mHp');
const mZero = document.getElementById('mZero');
const mTop = document.getElementById('mTop');
const mRange = document.getElementById('mRange');
const mFuel = document.getElementById('mFuel');
const mDrive = document.getElementById('mDrive');
const mTrans = document.getElementById('mTrans');
const mCompare = document.getElementById('mCompare');
const mBook = document.getElementById('mBook');
const compareTray = document.getElementById('compareTray');
const compareList = document.getElementById('compareList');
const clearCompare = document.getElementById('clearCompare');
const yearEl = document.getElementById('year');
const themeToggle = document.getElementById('themeToggle');
const ctaExplore = document.getElementById('ctaExplore');
const carouselTrack = document.getElementById('carouselTrack');

// ---------- State ----------
let activeType = 'All';
let maxPrice = Number(priceRange.value);
let query = '';
let sortBy = 'relevance';
let compareIds = new Set();

// ---------- Initialize ----------
document.addEventListener('DOMContentLoaded', () => {
  // Year
  yearEl.textContent = new Date().getFullYear();

  // Theme
  const savedTheme = localStorage.getItem('theme') || 'dark';
  if (savedTheme === 'light') document.body.classList.add('light');

  // Type filter default active
  [...typeFilters.querySelectorAll('.chip')].forEach(chip => {
    chip.classList.toggle('active', chip.dataset.type === 'All');
  });

  // Price label
  priceValue.textContent = toCr(maxPrice);

  // Render
  renderGrid();
  renderCarousel();

  // Events
  typeFilters.addEventListener('click', onTypeClick);
  priceRange.addEventListener('input', onPriceInput);
  searchInput.addEventListener('input', onSearch);
  sortSelect.addEventListener('change', onSort);
  clearFilters.addEventListener('click', onReset);
  themeToggle.addEventListener('click', onThemeToggle);
  modalBackdrop.addEventListener('click', closeModal);
  modalClose.addEventListener('click', closeModal);
  clearCompare.addEventListener('click', clearCompareList);
  ctaExplore.addEventListener('click', () => document.getElementById('explore').scrollIntoView({behavior:'smooth'}));
});

// ---------- Helpers ----------
function toCr(n){
  // Show up to 2 decimals in Crores for larger numbers
  if (n >= 10000000){
    const cr = n/10000000;
    return `₹${cr.toFixed(cr % 1 === 0 ? 0 : 1)} Cr`;
  }
  // Lakhs formatting
  if (n >= 100000){
    const lk = n/100000;
    return `₹${lk.toFixed(lk % 1 === 0 ? 0 : 1)} L`;
  }
  return INR(n);
}

function computeStats(list){
  const c = list.length;
  const avgP = c ? Math.round(list.reduce((s,x)=>s+x.price,0)/c) : 0;
  const avgH = c ? Math.round(list.reduce((s,x)=>s+x.hp,0)/c) : 0;
  const fuels = [...new Set(list.map(x=>x.fuel))].join(', ') || '—';
  return {c, avgP, avgH, fuels};
}

function filterCars(){
  return cars.filter(c =>
    (activeType === 'All' || c.type === activeType) &&
    c.price <= maxPrice &&
    (`${c.brand} ${c.model} ${c.type}`.toLowerCase().includes(query))
  );
}

function sortCars(list){
  const arr = [...list];
  switch (sortBy){
    case 'price-asc': arr.sort((a,b)=>a.price-b.price); break;
    case 'price-desc': arr.sort((a,b)=>b.price-a.price); break;
    case 'hp-desc': arr.sort((a,b)=>b.hp-a.hp); break;
    case 'range-desc': arr.sort((a,b)=>b.range-a.range); break;
    case 'year-desc': arr.sort((a,b)=>b.year-a.year); break;
    default: /* relevance -> keep natural */ break;
  }
  return arr;
}

function carCard(c){
  const tags = [
    `${c.year}`,
    c.drive,
    c.fuel,
    `${c.zeroTo100}s`,
  ];
  const el = document.createElement('div');
  el.className = 'card';
  el.setAttribute('tabindex','0');
  el.innerHTML = `
    <div class="card-media" style="background: linear-gradient(135deg, ${shade(c.color,20)}, ${c.color});">
      <div class="badge">${c.type}</div>
    </div>
    <div class="card-body">
      <div class="card-title">
        <h3>${c.brand} ${c.model}</h3>
        <span class="price">${toCr(c.price)}</span>
      </div>
      <div class="tags">
        ${tags.map(t=>`<span class="tag">${t}</span>`).join('')}
      </div>
      <div class="meta">
        <div>HP: <strong>${c.hp}</strong></div>
        <div>Top: <strong>${c.topSpeed}</strong> km/h</div>
        <div>Range: <strong>${c.range}</strong> km</div>
      </div>
    </div>
  `;
  el.addEventListener('click', ()=>openModal(c));
  el.addEventListener('keypress', (e)=>{ if(e.key==='Enter') openModal(c);});
  return el;
}

function renderGrid(){
  const list = sortCars(filterCars());
  grid.innerHTML = '';
  list.forEach(c => grid.appendChild(carCard(c)));

  const stats = computeStats(list);
  countShown.textContent = stats.c;
  avgPrice.textContent = stats.c ? toCr(stats.avgP) : '—';
  avgHp.textContent = stats.c ? `${stats.avgH} hp` : '—';
  fuelTypes.textContent = stats.fuels;

  noResults.classList.toggle('hidden', list.length>0);
}

function renderCarousel(){
  const feats = cars.filter(c=>c.featured);
  carouselTrack.innerHTML = '';
  feats.forEach(c=>{
    const card = carCard(c);
    card.classList.add('carousel-card');
    carouselTrack.appendChild(card);
  });

  const container = document.querySelector('.carousel');
  const prev = container.querySelector('.prev');
  const next = container.querySelector('.next');
  prev.onclick = ()=> carouselTrack.scrollBy({left:-320, behavior:'smooth'});
  next.onclick = ()=> carouselTrack.scrollBy({left:320, behavior:'smooth'});
}

function openModal(c){
  modalHero.style.background = `
      radial-gradient(600px 120px at -10% -20%, #4f8cff44, transparent),
      radial-gradient(400px 120px at 110% 120%, #9bff5744, transparent),
      linear-gradient(135deg, ${shade(c.color,20)}, ${c.color})`;
  modalTitle.textContent = `${c.brand} ${c.model}`;
  modalSubtitle.textContent = `${c.brand} • ${c.type} • ${c.year}`;
  mPrice.textContent = toCr(c.price);
  mHp.textContent = `${c.hp} hp`;
  mZero.textContent = sec(c.zeroTo100);
  mTop.textContent = kmh(c.topSpeed);
  mRange.textContent = km(c.range);
  mFuel.textContent = c.fuel;
  mDrive.textContent = c.drive;
  mTrans.textContent = c.transmission;

  mCompare.onclick = () => addToCompare(c);
  mBook.onclick = () => alert(`Test drive request received for ${c.brand} ${c.model}. Our team will contact you.`);

  modal.classList.remove('hidden');
  modal.setAttribute('aria-hidden', 'false');
}

function closeModal(){
  modal.classList.add('hidden');
  modal.setAttribute('aria-hidden', 'true');
}

function addToCompare(c){
  compareIds.add(c.id);
  updateCompare();
}

function updateCompare(){
  compareList.innerHTML = '';
  const items = [...compareIds].map(id => cars.find(x=>x.id===id)).filter(Boolean);
  if (items.length){
    compareTray.classList.remove('hidden');
  } else {
    compareTray.classList.add('hidden');
  }
  items.forEach(c=>{
    const pill = document.createElement('div');
    pill.className = 'compare-pill';
    pill.textContent = `${c.brand} ${c.model} (${c.hp}hp, ${toCr(c.price)})`;
    compareList.appendChild(pill);
  });
}

function clearCompareList(){
  compareIds.clear();
  updateCompare();
}

// Shade helper to adjust color depth
function shade(hex, pct){
  // hex like #223344
  const c = hex.replace('#','');
  const num = parseInt(c, 16);
  let r = (num >> 16) + pct;
  let g = ((num >> 8) & 0x00FF) + pct;
  let b = (num & 0x0000FF) + pct;
  r = Math.max(0, Math.min(255, r));
  g = Math.max(0, Math.min(255, g));
  b = Math.max(0, Math.min(255, b));
  const out = (r<<16) | (g<<8) | b;
  return `#${out.toString(16).padStart(6,'0')}`;
}

// ---------- Events ----------
function onTypeClick(e){
  const btn = e.target.closest('.chip');
  if (!btn) return;
  activeType = btn.dataset.type;
  [...typeFilters.querySelectorAll('.chip')].forEach(ch => ch.classList.toggle('active', ch===btn));
  renderGrid();
}

function onPriceInput(e){
  maxPrice = Number(e.target.value);
  priceValue.textContent = toCr(maxPrice);
  renderGrid();
}

function onSearch(e){
  query = e.target.value.trim().toLowerCase();
  renderGrid();
}

function onSort(e){
  sortBy = e.target.value;
  renderGrid();
}

function onReset(){
  activeType = 'All';
  maxPrice = Number(priceRange.max);
  query = '';
  sortBy = 'relevance';
  priceRange.value = maxPrice;
  priceValue.textContent = toCr(maxPrice);
  searchInput.value = '';
  sortSelect.value = 'relevance';
  [...typeFilters.querySelectorAll('.chip')].forEach(ch => ch.classList.toggle('active', ch.dataset.type==='All'));
  renderGrid();
}

function onThemeToggle(){
  document.body.classList.toggle('light');
  const isLight = document.body.classList.contains('light');
  localStorage.setItem('theme', isLight ? 'light' : 'dark');
}

// Accessibility: close modal on ESC
document.addEventListener('keydown', (e)=>{
  if (e.key === 'Escape' && !modal.classList.contains('hidden')) closeModal();
});
