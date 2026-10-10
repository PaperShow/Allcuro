import { useEffect, useState } from 'react'
import { ArtTile, IconTile } from '../components/CareIcon'
import { ArrowIcon, ClockIcon, PhoneIcon, UserIcon } from '../components/Icons'
import { CallBand } from '../components/Sections'
import { ServiceDialog } from '../components/ServiceDialog'
import { ALL_SLUG, categories, categoryById, categoryPath } from '../data/categories'
import { services } from '../data/services'
import { site } from '../data/site'
import type { Service } from '../data/types'
import { Link } from '../components/Link'

interface Group {
  key: string
  title: string
  items: Service[]
}

function groupBy(items: Service[], keyOf: (s: Service) => string): Group[] {
  const groups = new Map<string, Service[]>()
  for (const s of items) groups.set(keyOf(s), [...(groups.get(keyOf(s)) ?? []), s])
  return [...groups].map(([key, list]) => ({ key, title: categoryById[key]?.label ?? key, items: list }))
}

export function CategoryPage({ slug }: { slug: string }) {
  const [selected, setSelected] = useState<Service | null>(null)
  const isAll = slug === ALL_SLUG
  const category = categories.find((c) => c.slug === slug)

  // On phones the category switcher is a horizontal strip; bring the current one into view.
  useEffect(() => {
    document.querySelector('.side-link.is-active')?.scrollIntoView({ block: 'nearest', inline: 'center' })
  }, [])

  if (!isAll && !category) return <NotFound />

  const list = isAll ? services : services.filter((s) => s.category === category!.id)
  // "All" is grouped by care type; a single category by its subcategories.
  const groups = isAll ? groupBy(list, (s) => s.category) : groupBy(list, (s) => s.subcategory)
  const showGroupTitles = groups.length > 1

  return (
    <>
      <div className="container cat-page">
        <nav className="crumbs" aria-label="Breadcrumb">
          <Link to="/">Home</Link>
          <span aria-hidden="true">›</span>
          <span aria-current="page">{isAll ? 'All Services' : category!.label}</span>
        </nav>

        <header className="cat-head">
          <ArtTile name={isAll ? 'see_all' : category!.art} size={76} />
          <div>
            <h1>{isAll ? 'All Services' : category!.label}</h1>
            <p>
              {isAll ? 'Every ALLCURO service, grouped by type of care.' : category!.blurb}{' '}
              <strong>{list.length} services.</strong>
            </p>
          </div>
        </header>

        <div className="cat-layout">
          <aside className="cat-side" aria-label="Types of care">
            <p className="cat-side-title">Types of care</p>
            <ul>
              {categories.map((c) => (
                <li key={c.slug}>
                  <Link
                    to={categoryPath(c.slug)}
                    className={`side-link ${c.slug === slug ? 'is-active' : ''}`}
                    aria-current={c.slug === slug ? 'page' : undefined}
                  >
                    <ArtTile name={c.art} size={36} />
                    {c.label}
                  </Link>
                </li>
              ))}
              <li>
                <Link
                  to={categoryPath(ALL_SLUG)}
                  className={`side-link ${isAll ? 'is-active' : ''}`}
                  aria-current={isAll ? 'page' : undefined}
                >
                  <ArtTile name="see_all" size={36} />
                  All Services
                </Link>
              </li>
            </ul>
            <a className="side-call" href={site.phoneHref}>
              <PhoneIcon size={18} />
              <span>
                Need help choosing?
                <strong>{site.phoneDisplay}</strong>
              </span>
            </a>
          </aside>

          <div className="cat-main">
            {groups.map((g) => (
              <section key={g.key} className="svc-group" aria-label={g.title}>
                {showGroupTitles && (
                  <h2 className="svc-group-title">
                    {g.title} <span>{g.items.length}</span>
                  </h2>
                )}
                <ul className="svc-list">
                  {g.items.map((s) => (
                    <li key={s.id}>
                      <ServiceRow service={s} onOpen={() => setSelected(s)} />
                    </li>
                  ))}
                </ul>
              </section>
            ))}
          </div>
        </div>
      </div>

      <CallBand />
      {selected && <ServiceDialog service={selected} onClose={() => setSelected(null)} />}
    </>
  )
}

function ServiceRow({ service: s, onOpen }: { service: Service; onOpen: () => void }) {
  const cat = categoryById[s.category] ?? categories[0]
  return (
    <button type="button" className="svc-row" onClick={onOpen}>
      <IconTile name={s.icon} ink={cat.ink} wash={cat.wash} size={60} />
      <span className="svc-row-body">
        <span className="svc-row-name">
          {s.name}
          {s.badge && <span className="badge">{s.badge}</span>}
        </span>
        <span className="svc-row-desc">{s.description}</span>
        <span className="svc-meta">
          <span>
            <ClockIcon /> {s.duration}
          </span>
          <span>
            <UserIcon /> {s.professional}
          </span>
        </span>
      </span>
      <span className="svc-row-end">
        <span className="price">{s.price}</span>
        <span className="svc-more">
          View details <ArrowIcon size={16} />
        </span>
      </span>
    </button>
  )
}

export function NotFound() {
  return (
    <div className="container not-found">
      <h1>Page not found</h1>
      <p>This page does not exist. You can see all our services or go back home.</p>
      <div className="hero-actions">
        <Link to={categoryPath(ALL_SLUG)} className="btn btn-primary btn-lg">
          See all services
        </Link>
        <Link to="/" className="btn btn-outline btn-lg">
          Go home
        </Link>
      </div>
    </div>
  )
}
