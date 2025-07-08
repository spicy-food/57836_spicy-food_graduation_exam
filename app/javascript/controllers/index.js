import { application } from "./application"

// すべてのコントローラを自動で読み込む
const context = require.context(".", true, /\.js$/)
context.keys().forEach(filename => {
  if (filename === "./application.js" || filename === "./index.js") return
  application.register(
    filename.replace("./", "").replace("_controller.js", ""),
    context(filename).default
  )
})