import centre from '../assets/images/centre-1.jpg'
import wheelchair from '../assets/images/eq-wheelchair.jpg'
import { categories, categoryPath } from '../data/categories'
import { faqs } from '../data/faqs'
import { site } from '../data/site'
import { Link } from './Link'
import { ArrowIcon, PhoneIcon, WhatsAppIcon } from './Icons'
import { Logo } from './Logo'

const steps = [
  {
    title: 'Choose a service',
    text: 'Pick what you need — a 30-minute visit, a few hours of help, or a full 12 or 24-hour shift.',
  },
  {
    title: 'We send a verified professional',
    text: 'A qualified, police-verified nurse, caregiver or therapist comes to your door.',
  },
  {
    title: 'Care, with support behind it',
    text: 'Vitals are recorded at every visit, and a senior medical supervisor is always on call.',
  },
]

export function HowItWorks() {
  return (
    <section className="section" id="how-it-works" aria-labelledby="how-title">
      <div className="container">
        <div className="section-head">
          <p className="eyebrow">How it works</p>
          <h2 id="how-title">Care at home in three simple steps</h2>
        </div>
        <ol className="steps">
          {steps.map((s, i) => (
            <li key={s.title}>
              <span className="step-num">{String(i + 1).padStart(2, '0')}</span>
              <h3>{s.title}</h3>
              <p>{s.text}</p>
            </li>
          ))}
        </ol>
      </div>
    </section>
  )
}

export function MoreCare() {
  const cards = [
    {
      img: centre,
      alt: 'A bright, clean room at a care centre',
      title: 'Verified care centres',
      text: 'Field-audited elder care homes, rehabilitation and recovery centres with clear bed availability.',
    },
    {
      img: wheelchair,
      alt: 'A wheelchair available on rent',
      title: 'Medical equipment on rent',
      text: 'Wheelchairs, hospital beds and oxygen concentrators delivered home, with a refundable deposit.',
    },
  ]
  return (
    <section className="section section-tint" aria-labelledby="more-title">
      <div className="container">
        <div className="section-head">
          <p className="eyebrow">Also on ALLCURO</p>
          <h2 id="more-title">Need a stay or equipment?</h2>
        </div>
        <div className="more-grid">
          {cards.map((c) => (
            <article className="more-card" key={c.title}>
              <img src={c.img} alt={c.alt} loading="lazy" />
              <div>
                <h3>{c.title}</h3>
                <p>{c.text}</p>
                <a className="text-link" href={site.phoneHref}>
                  Ask our team <ArrowIcon size={16} />
                </a>
              </div>
            </article>
          ))}
        </div>
      </div>
    </section>
  )
}

export function Faq() {
  return (
    <section className="section" id="faq" aria-labelledby="faq-title">
      <div className="container faq-wrap">
        <div className="section-head">
          <p className="eyebrow">Questions</p>
          <h2 id="faq-title">Frequently asked questions</h2>
        </div>
        <div className="faq-list">
          {faqs.map((f, i) => (
            <details key={f.q} open={i === 0}>
              <summary>{f.q}</summary>
              <p>{f.a}</p>
            </details>
          ))}
        </div>
      </div>
    </section>
  )
}

export function CallBand() {
  return (
    <section className="call-band" aria-labelledby="call-title">
      <div className="container call-inner">
        <div>
          <h2 id="call-title">Need help choosing? Just call us.</h2>
          <p>Our care desk is open 24 hours, every day. We will understand your needs and book the right person.</p>
        </div>
        <div className="call-actions">
          <a className="btn btn-light btn-lg" href={site.phoneHref}>
            <PhoneIcon /> {site.phoneDisplay}
          </a>
          <a className="btn btn-ghost-light btn-lg" href={site.whatsappHref} target="_blank" rel="noreferrer">
            <WhatsAppIcon /> WhatsApp us
          </a>
        </div>
      </div>
    </section>
  )
}

export function Footer() {
  return (
    <footer className="footer">
      <div className="container footer-grid">
        <div>
          <Logo light />
          <p className="footer-tag">{site.tagline}</p>
          <p className="footer-small">Verified home nursing, elder care and family health services.</p>
        </div>
        <div>
          <h3>Services</h3>
          <ul>
            {categories.map((c) => (
              <li key={c.slug}>
                <Link to={categoryPath(c.slug)}>{c.label}</Link>
              </li>
            ))}
          </ul>
        </div>
        <div>
          <h3>Contact</h3>
          <ul>
            <li><a href={site.phoneHref}>{site.phoneDisplay}</a></li>
            <li><a href={`mailto:${site.email}`}>{site.email}</a></li>
            <li>{site.cities.join(' · ')}</li>
          </ul>
        </div>
      </div>
      <div className="container footer-bottom">
        <span>© {new Date().getFullYear()} ALLCURO. All rights reserved.</span>
        <span>For medical emergencies, call 112.</span>
      </div>
    </footer>
  )
}
