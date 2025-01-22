window.runtime = {
  WindowSetSystemDefaultTheme() {},
  EventsOnMultiple(id, fn) {},
  WindowIsMaximised() {},
  WindowIsMinimised() {},
};

window.go = {
  bridge: {
    App: {
      UpdateTray() {},
      UpdateTrayMenus() {},
      GetEnv() {
        return { os: "darwin" };
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
      ExecBackground(path, args, out, end) {
        return { flag: true, data: 999 };
      },
    },
  },
};
