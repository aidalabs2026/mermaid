export const SITE_NAME = 'Mermaid Preview';
export const SITE_TITLE_SUFFIX = 'Mermaid Preview — Render Diagrams in Your Browser';
export const SITE_DESCRIPTION =
  'Render Mermaid diagrams instantly. Flowchart, sequence, class, state, ER, gantt, pie, mindmap and more — all in your browser. Your diagram never leaves your device.';
export const SITE_URL = 'https://mermaid.aidalabs.kr';
export const SITE_LOCALE = 'en';
export const CONTACT_EMAIL = 'facered79@gmail.com';

// Google Search Console meta-tag verification token.
// Set after creating the GSC property and choosing the "HTML tag" method.
// Leave empty to omit the meta entirely.
export const GSC_VERIFICATION = 'tAy5xjnlcP6nYG7CuBLll7K3n1WvQYe_KsWKCJugDxE';

// Google Analytics 4 Measurement ID (G-XXXXXXXXXX). Leave empty to skip GA4.
export const GA4_MEASUREMENT_ID = '';

export const NAV_ITEMS: Array<{ href: string; label: string }> = [
  { href: '/preview/', label: 'Preview' },
  { href: '/diagrams/', label: 'Diagrams' },
  { href: '/guides/', label: 'Guides' },
  { href: '/glossary/', label: 'Glossary' },
  { href: '/faq/', label: 'FAQ' },
  { href: '/about/', label: 'About' },
];

export const FOOTER_LINKS: Array<{ href: string; label: string }> = [
  { href: '/about/', label: 'About' },
  { href: '/privacy/', label: 'Privacy' },
  { href: '/terms/', label: 'Terms' },
  { href: '/contact/', label: 'Contact' },
];

// Mermaid library version pinned in package.json. Phase 1 uses v11.
export const MERMAID_VERSION = '11';
