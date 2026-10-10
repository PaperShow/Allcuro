import type { Category } from './types'

// Labels, icons and tones follow the home-screen grid and `CareTone`
// in allcuro/lib/core/ui/care_icon.dart. Slugs match the app's
// `/category-services/:slug` routes.
export const categories: Category[] = [
  {
    id: 'Nursing Care',
    slug: 'nursing',
    label: 'Nursing Care',
    blurb: 'Injections, IV, wound dressing, catheter and tube care by qualified nurses.',
    icon: 'nursing',
    art: 'nursing',
    ink: '#26593B',
    wash: '#E7F4EB',
  },
  {
    id: 'Elder Care',
    slug: 'elder-care',
    label: 'Elder Care',
    blurb: 'Bathing, feeding, mobility, companionship and daily support for elders.',
    icon: 'elder_care',
    art: 'elder_care',
    ink: '#B45309',
    wash: '#FEF3E2',
  },
  {
    id: 'Mother & Baby Care',
    slug: 'mother-baby',
    label: 'Mother & Baby',
    blurb: 'Pregnancy visits, recovery after delivery and gentle newborn care.',
    icon: 'mother_baby',
    art: 'mother_baby',
    ink: '#BE185D',
    wash: '#FDEEF4',
  },
  {
    id: 'Physiotherapy',
    slug: 'physiotherapy',
    label: 'Physiotherapy',
    blurb: 'Assessment and home exercise to restore strength, balance and movement.',
    icon: 'physio',
    art: 'physio',
    ink: '#1D4ED8',
    wash: '#EAF0FE',
  },
  {
    id: 'Doctor Care',
    slug: 'doctor-care',
    label: 'Doctor Visit',
    blurb: 'A doctor examines the patient at home and advises next steps.',
    icon: 'doctor',
    art: 'doctor',
    ink: '#6D28D9',
    wash: '#F2EDFE',
  },
  {
    id: 'Diagnostics',
    slug: 'diagnostics',
    label: 'Tests at Home',
    blurb: 'Blood sample collection and ECG without leaving home.',
    icon: 'diagnostics',
    art: 'diagnostics',
    ink: '#0E7490',
    wash: '#E4F5F9',
  },
  {
    id: 'Wellness',
    slug: 'wellness',
    label: 'Diet & Wellness',
    blurb: 'Nutrition and lactation guidance from trained experts.',
    icon: 'nutrition',
    art: 'wellness',
    ink: '#0F766E',
    wash: '#E3F5F2',
  },
]

export const categoryById = Object.fromEntries(categories.map((c) => [c.id, c])) as Record<
  string,
  Category
>

/** Slug of the page that lists every service across all categories. */
export const ALL_SLUG = 'all'

export const categoryPath = (slug: string) => `/services/${slug}`
