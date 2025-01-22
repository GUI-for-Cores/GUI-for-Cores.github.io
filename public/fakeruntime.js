window.runtime = {
  WindowSetSystemDefaultTheme() {},
  EventsOnMultiple(id, fn) {},
  WindowIsMaximised() {},
  WindowIsMinimised() {},
  WindowReloadApp() {
    window.location.reload();
  },
  WindowSetSize() {},
  BrowserOpenURL(url) {
    if (url.startsWith("http")) {
      window.open(url, "_blank");
      return;
    }
    url = url.replace(window.location.pathname, "");
    const { data } = window.go.bridge.App.Readfile(url);
    const link = URL.createObjectURL(
      new Blob([data], { type: "text/plain; charset=utf-8" })
    );
    window.open(link, "_blank");
  },
  ClipboardSetText(msg) {
    navigator.clipboard.writeText(msg);
    return { flag: true };
  },
};

window.go = {
  bridge: {
    App: {
      RestartApp() {
        Plugins.message.info("Web端不支持");
      },
      GetInterfaces() {
        return { flag: true, data: "eth0|WLAN0" };
      },
      UpdateTray() {},
      UpdateTrayMenus() {},
      GetEnv() {
        return {
          os: "darwin",
          basePath: window.location.pathname.slice(0, -1),
        };
      },
      Readdir() {
        return { flag: true, data: "" };
      },
      IsStartup() {
        return true;
      },
      async Requests(method, url, headers, body, options) {
        const res = await fetch(url, {
          method,
          headers,
          body: ["HEAD", "GET"].includes(method) ? null : JSON.stringify(body),
        });
        let respBody;
        if (res.headers["Content-Type"]?.includes("application/json")) {
          respBody = await res.json();
        } else {
          respBody = await res.text();
        }
        return {
          flag: true,
          status: res.status,
          headers: res.headers,
          body: respBody,
        };
      },
      Writefile(path, content) {
        path = window.location.pathname + path;
        localStorage.setItem(path, content);
        return { flag: true };
      },
      Readfile(path) {
        path = window.location.pathname + path;
        return { flag: true, data: localStorage.getItem(path) };
      },
      Exec() {
        return { flag: false, data: "Web端不支持" };
      },
      ExecBackground(path, args, out, end) {
        return { flag: false, data: "Web端不支持" };
      },
      ValidateCron() {
        return { flag: true, data: "" };
      },
      AddScheduledTask() {
        return { flag: false, data: "Web端不支持" };
      },
    },
  },
};
