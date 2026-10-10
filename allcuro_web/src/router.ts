import { useSyncExternalStore } from 'react'

// Minimal history-API router: the site only has a home page and /services/:slug,
// so a routing library would be more weight than help.

const subscribe = (onChange: () => void) => {
  window.addEventListener('popstate', onChange)
  return () => window.removeEventListener('popstate', onChange)
}

export const usePath = () => useSyncExternalStore(subscribe, () => window.location.pathname)

export function navigate(to: string) {
  window.history.pushState(null, '', to)
  window.dispatchEvent(new PopStateEvent('popstate'))
}
