import { useState } from 'react'
import { ALL_SLUG, categoryPath } from '../data/categories'
import { site } from '../data/site'
import { Link } from './Link'
import { CloseIcon, MenuIcon, PhoneIcon } from './Icons'
import { Logo } from './Logo'

const links = [
  { href: categoryPath(ALL_SLUG), label: 'Services' },
  { href: '/#how-it-works', label: 'How it works' },
  { href: '/#why-allcuro', label: 'Why ALLCURO' },
  { href: '/#faq', label: 'FAQ' },
]

interface Props {
  largeText: boolean
  onToggleText: () => void
}

export function Header({ largeText, onToggleText }: Props) {
  const [open, setOpen] = useState(false)

  return (
    <header className="header">
      <div className="container header-inner">
        <Link to="/" className="brand" aria-label="ALLCURO home">
          <Logo />
        </Link>

        <nav className={`nav ${open ? 'is-open' : ''}`} aria-label="Main">
          {links.map((l) => (
            <Link key={l.href} to={l.href} onClick={() => setOpen(false)}>
              {l.label}
            </Link>
          ))}
          <a className="nav-phone" href={site.phoneHref}>
            <PhoneIcon size={18} /> Call {site.phoneDisplay}
          </a>
        </nav>

        <div className="header-actions">
          <button
            type="button"
            className="text-toggle"
            onClick={onToggleText}
            aria-pressed={largeText}
            title={largeText ? 'Use normal text size' : 'Make text larger'}
          >
            <span className="a-sm" aria-hidden="true">A</span>
            <span className="a-lg" aria-hidden="true">A</span>
            <span className="sr-only">{largeText ? 'Use normal text size' : 'Make text larger'}</span>
          </button>
          <a className="header-phone" href={site.phoneHref}>
            <PhoneIcon size={18} />
            <span>{site.phoneDisplay}</span>
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
