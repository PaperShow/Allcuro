import { useState } from 'react'
import { ALL_SLUG, categoryPath } from '../data/categories'
import { site } from '../data/site'
import { Link } from './Link'
import { CloseIcon, MenuIcon } from './Icons'

const links = [
  { href: categoryPath(ALL_SLUG), label: 'Services' },
  { href: '/#how-it-works', label: 'How it works' },
  { href: '/#why-allcuro', label: 'Why ALLCURO' },
  { href: '/#faq', label: 'FAQ' },
]

export function Header() {
  const [open, setOpen] = useState(false)

  return (
    <header className="header">
      <div className="container header-inner">
        <Link to="/" className="wordmark">
          ALLCURO
        </Link>

        <nav className={`nav ${open ? 'is-open' : ''}`} aria-label="Main">
          {links.map((l) => (
            <Link key={l.href} to={l.href} onClick={() => setOpen(false)}>
              {l.label}
            </Link>
          ))}
          <a className="nav-phone" href={site.phoneHref}>
            Call {site.phoneDisplay}
          </a>
        </nav>

        <div className="header-actions">
          <a className="header-phone" href={site.phoneHref}>
            {site.phoneDisplay}
          </a>
          <Link className="btn btn-primary header-cta" to={categoryPath(ALL_SLUG)}>
            Book a visit
          </Link>
          <button
            type="button"
            className="menu-btn"
            onClick={() => setOpen((o) => !o)}
            aria-expanded={open}
            aria-label={open ? 'Close menu' : 'Open menu'}
          >
            {open ? <CloseIcon /> : <MenuIcon />}
          </button>
        </div>
      </div>
    </header>
  )
}
