// URLs for the 3D-style category illustrations (copied from allcuro/assets/illustrations).
const arts = import.meta.glob<string>('../assets/illustrations/*.svg', {
  query: '?url',
  import: 'default',
  eager: true,
})

const artByName = Object.fromEntries(
  Object.entries(arts).map(([path, url]) => [path.split('/').pop()!.replace('.svg', ''), url]),
)

export const artUrl = (name: string) => artByName[name] ?? artByName.see_all
