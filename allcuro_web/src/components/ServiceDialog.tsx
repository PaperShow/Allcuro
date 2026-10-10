import { useEffect, useRef } from 'react'
import { categories, categoryById } from '../data/categories'
import { site } from '../data/site'
import type { Service } from '../data/types'
import { IconTile } from './CareIcon'
import { CheckIcon, ClockIcon, CloseIcon, MinusIcon, PhoneIcon, UserIcon, WhatsAppIcon } from './Icons'

const split = (text: string) =>
  text
    .split(';')
    .map((t) => t.trim().replace(/\.$/, ''))
    .filter(Boolean)

export function ServiceDialog({ service: s, onClose }: { service: Service; onClose: () => void }) {
  const ref = useRef<HTMLDialogElement>(null)
  const cat = categoryById[s.category] ?? categories[0]

  useEffect(() => {
    const d = ref.current
    if (!d) return
    d.showModal()
    document.body.classList.add('no-scroll')
    return () => {
      document.body.classList.remove('no-scroll')
      if (d.open) d.close()
    }
  }, [])

  const whatsapp = `${site.whatsappHref}?text=${encodeURIComponent(`Hi ALLCURO, I would like to book: ${s.name}`)}`

  return (
    <dialog
      ref={ref}
      className="dialog"
      aria-labelledby="dlg-title"
      onClose={onClose}
      onClick={(e) => e.target === ref.current && onClose()}
    >
      <div className="dialog-body">
        <button type="button" className="dialog-close" onClick={onClose} aria-label="Close">
          <CloseIcon />
        </button>

        <div className="dlg-head">
          <IconTile name={s.icon} ink={cat.ink} wash={cat.wash} size={64} />
          <div>
            <p className="svc-cat" style={{ color: cat.ink }}>
              {cat.label} · {s.subcategory}
            </p>
            <h3 id="dlg-title">{s.name}</h3>
          </div>
        </div>

        <p className="dlg-desc">{s.description}</p>

        <div className="dlg-facts">
          <div>
            <span>Price</span>
            <strong>{s.price}</strong>
          </div>
          <div>
            <span>
              <ClockIcon size={16} /> Time
            </span>
            <strong>{s.duration}</strong>
          </div>
          <div>
            <span>
              <UserIcon size={16} /> Who comes
            </span>
            <strong>{s.professional}</strong>
          </div>
        </div>

        <div className="dlg-lists">
          <div>
            <h4>What’s included</h4>
            <ul className="list-yes">
              {split(s.includes).map((t) => (
                <li key={t}>
                  <CheckIcon /> {t}
                </li>
              ))}
            </ul>
          </div>
          <div>
            <h4>Not included</h4>
            <ul className="list-no">
              {split(s.notIncluded).map((t) => (
                <li key={t}>
                  <MinusIcon /> {t}
                </li>
              ))}
            </ul>
          </div>
        </div>

        {s.notes && <p className="dlg-note">Note: {s.notes}</p>}

        <div className="dlg-actions">
          <a className="btn btn-primary btn-lg" href={site.phoneHref}>
            <PhoneIcon /> Call to book
          </a>
          <a className="btn btn-outline btn-lg" href={whatsapp} target="_blank" rel="noreferrer">
            <WhatsAppIcon /> Book on WhatsApp
          </a>
        </div>
      </div>
    </dialog>
  )
}
