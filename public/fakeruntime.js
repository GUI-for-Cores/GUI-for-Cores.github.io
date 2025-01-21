window.runtime = {
  WindowSetSystemDefaultTheme() {},
  EventsOnMultiple(id, fn) {
    console.log(id, fn)
  },
  WindowIsMaximised() {},
  WindowIsMinimised() {},
}

const events = {
  data: [],
  on() {},
}

window.go = {
  bridge: {
    App: {
      UpdateTray() {},
      UpdateTrayMenus() {},
      GetEnv() {
        return { os: 'darwin' }
      },
      Readdir() {
        return { flag: true, data: '' }
      },
      IsStartup() {
        return true
      },
      Requests() {},
      Writefile(path, content) {
        localStorage.setItem(path, content)
        return { flag: true }
      },
      Readfile(path) {
        return { flag: true, data: localStorage.getItem(path) }
      },
      ExecBackground(path, args, out, end) {
        return { flag: true, data: 999 }
      },
    },
  },
}
