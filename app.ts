import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar from "./widget/bar/Bar"
import OSD from "./widget/osd/osd"

App.start({
    css: style,
    requestHandler(request: string, res: (response: any) => void) {
      if (request == "say hi") {
        return res("hi cli")
      }
      else if (request == "reloadcss") {
        App.reset_css()
        App.apply_css(style)
        return res("done!")
      }
      res("huh?")
    },
    main() {
        App.get_monitors().map(Bar)
        App.get_monitors().map(OSD)
    },
})
