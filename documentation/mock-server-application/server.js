const cds = require ('@sap/cds')
// const proxy = require("@sap/cds-odata-v2-adapter-proxy");
const customIndexJS = require ('./customIndex.js')

module.exports = cds.server



// cds.on("bootstrap", app => app.use(proxy()) );

cds.on('bootstrap', app => {
  app.get ('/', (_,res) => res.send (customIndexJS.html)) 
})

const cds_swagger = require ('cds-swagger-ui-express')
cds.on ('bootstrap', app => app.use (cds_swagger()) )