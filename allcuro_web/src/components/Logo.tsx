export function Logo({ light = false }: { light?: boolean }) {
  return (
    <span className={`logo ${light ? 'logo-light' : ''}`}>
      <svg width="36" height="36" viewBox="0 0 34 34" aria-hidden="true">
        <rect width="34" height="34" rx="10" fill={light ? '#DDF4E4' : '#26593B'} />
        <path
          d="M6 18h5l2.5-6 4 11 3-8 1.5 3H28"
          fill="none"
          stroke={light ? '#26593B' : '#FFFFFF'}
          strokeWidth="2.4"
          strokeLinecap="round"
          strokeLinejoin="round"
        />
      </svg>
      <span className="logo-word">ALLCURO</span>
    </span>
  )
}
