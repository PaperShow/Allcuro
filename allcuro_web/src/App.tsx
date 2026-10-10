import { useEffect, useState } from 'react'
import { Header } from './components/Header'
import { Hero, TrustBand } from './components/Hero'
import { CallBand, Faq, Footer, HowItWorks, MoreCare } from './components/Sections'
import { ALL_SLUG, categories } from './data/categories'
import { CategoryPage, NotFound } from './pages/CategoryPage'
import { usePath } from './router'

const TEXT_KEY = 'allcuro:large-text'
const HOME_TITLE = 'ALLCURO — Home Nursing & Elder Care'

function readLargeText() {
  try {
    return localStorage.getItem(TEXT_KEY) === '1'
  } catch {
    return false
  }
}

function Home() {
  return (
    <>
      <Hero />
      <TrustBand />
      <HowItWorks />
      <MoreCare />
      <Faq />
      <CallBand />
    </>
  )
}

export default function App() {
  const [largeText, setLargeText] = useState(readLargeText)
  const path = usePath()
  const slug = path.match(/^\/services\/([\w-]+)\/?$/)?.[1]

  useEffect(() => {
    document.documentElement.classList.toggle('large-text', largeText)
    try {
      localStorage.setItem(TEXT_KEY, largeText ? '1' : '0')
    } catch {
      // Storage unavailable (private mode) — the toggle still works for this visit.
    }
  }, [largeText])

  // On every page change: jump to the #section if one was asked for, else to the top.
  useEffect(() => {
    const target = window.location.hash && document.getElementById(window.location.hash.slice(1))
    if (target) target.scrollIntoView()
    else window.scrollTo({ top: 0, behavior: 'instant' })

    const label = slug === ALL_SLUG ? 'All Services' : categories.find((c) => c.slug === slug)?.label
    document.title = label ? `${label} at Home — ALLCURO` : HOME_TITLE
  }, [path, slug])

  let page
  if (slug) page = <CategoryPage key={slug} slug={slug} />
  else if (path === '/') page = <Home />
  else page = <NotFound />

  return (
    <>
      <a href="#main" className="skip-link">
        Skip to content
      </a>
      <Header largeText={largeText} onToggleText={() => setLargeText((v) => !v)} />
      <main id="main">{page}</main>
      <Footer />
    </>
  )
}
