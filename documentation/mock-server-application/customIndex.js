const cds = require('@sap/cds/lib')
const { find, path, fs } = cds.utils

module.exports = { get html(){

  const odata = srv => Object.keys(srv._adapters).find (a => a.startsWith ('odata'))
  const metadata = srv => odata(srv) ? ` / <a href="${srv.path}/$metadata">$metadata</a>` : ``

  let html = fs.readFileSync(path.join('./node_modules/@sap/cds/app/','index.html'),'utf-8')        // Reuse pregenerated index.html from the source library
  // .replace ('{{subtitle}}', 'Version ' + cds.version)
  .replace (/{{package}}/g, _project())
  .replace (/{{app}}/g, cds.env.folders.app.replace(/*trailing slash*/ /\/$/, ''))
  .replace ('{{apps}}', _app_links().map(
      html => `\n<li><a href="${html}">/${html.replace(/^[/]/,'')}</a></li>`
    ).join('\n') || '— none —'
  )
  .replace ('{{services}}', cds.service.providers.map (srv => `
        <details>
            <summary>
            <a href="${srv.path}">${srv.path}</a>${metadata(srv)} ${_moreLinks(srv)}
            </summary>
            <ul>${_entities_in(srv).map (e => {
            return `
            <li>
                <a href="${srv.path}/${e.replace(/\./g, '_')}">${e}</a> ${_moreLinks(srv, e)}
            </li>`}).join('')}
            </ul>
        </details>
  `).join(''))

  // add /graphql
  if (cds.env.features.graphql) {
    html = html.replace(/\n\s*<footer>/, `

        <h3>
          <a href="/graphql">/graphql</a>
        </h3>

        <footer>`)
  }

  Object.defineProperty (this,'html',{value:html})
  return html

}}

function _app_links() {
  const folder = path.resolve (cds.root, cds.env.folders.app)
  const files = find (folder, ['*.html', '*/*.html', '*/*/*.html']).map (
    file => path.relative(folder,file).replace (/\\/g,'/')
  )
  return files.concat (cds.app._app_links || [])
}

function _entities_in (service) {
  const exposed=[], {entities} = service
  for (let each in entities) {
    const e = entities [each]
    if (e['@cds.autoexposed'] && !e['@cds.autoexpose'])  continue
    if (/DraftAdministrativeData$/.test(e.name))  continue
    if (/[._]texts$/.test(e.name))  continue
    if (cds.env.effective.odata.containment && each.includes('.') && 'up_' in e.elements && e.elements.up_.target.startsWith(service.namespace+'.')) continue
    exposed.push (each.replace(/\./g,'_'))
  }
  return exposed
}

function _moreLinks (srv, entity) {
  return (srv.$linkProviders || [])
    .map (linkProv => linkProv(entity))
    .filter (l => l && l.href && l.name)
    .sort ((l1, l2) => l1.name.localeCompare(l2))
    .map (l => ` <a class="preview" href="${l.href}" title="${l.title||l.name}"> &rarr; ${l.name}</a>`)
    .join (' ')
}

function _project(){
  const cwd = global.cds.root
  try {
    const pj = require(cwd+'/package.json')
    return `${pj.name} ${pj.version}`
  } catch(e) {
    return `${cwd}`
  }
}
