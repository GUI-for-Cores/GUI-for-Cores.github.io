window.runtime = {
  WindowSetSystemDefaultTheme() {},
  EventsOnMultiple(id, fn) {},
  WindowIsMaximised() {},
  WindowIsMinimised() {},
  EventsOff() {},
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
          arch: "arm64",
          basePath: window.location.pathname.slice(0, -1),
        };
      },
      Readdir() {
        return { flag: true, data: "" };
      },
      IsStartup() {
        return true;
      },
      async Download(url, path) {
        return { flag: false, body: "Web端不支持" };
      },
      async Requests(method, url, headers, body, options) {
        if (
          url ==
          "https://github.com/MetaCubeX/mihomo/releases/download/Prerelease-Alpha/version.txt"
        ) {
          return {
            flag: true,
            status: 200,
            headers: {},
            body: "alpha-xxxxxxx",
          };
        }
        if (
          url ==
          "https://github.com/GUI-for-Cores/Ruleset-Hub/releases/download/latest/meta.json"
        ) {
          const res = await fetch("meta.json");
          const body = await res.text();
          return {
            flag: true,
            status: 200,
            headers: {},
            body: body,
          };
        }
        if (
          url ==
          "https://github.com/GUI-for-Cores/Ruleset-Hub/releases/download/latest/sing.json"
        ) {
          const res = await fetch("sing.json");
          const body = await res.text();
          return {
            flag: true,
            status: 200,
            headers: {},
            body: body,
          };
        }
        const res = await fetch(url, {
          method,
          headers,
          body: ["HEAD", "GET"].includes(method) ? null : JSON.stringify(body),
        });
        let respBody = await res.text();

        return {
          flag: true,
          status: res.status,
          headers: {
            ...res.headers,
            ...(url.includes("api.github.com")
              ? { "Content-Type": "application/json" }
              : {}),
          },
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
      Removefile() {},
      Exec(path, args) {
        if (path == "bash") {
          return { flag: true, data: "" };
        }

        if (path == "data/mihomo/mihomo-darwin-arm64" && args.includes("-v")) {
          return {
            flag: true,
            data: "Mihomo Meta v1.19.1 darwin arm64 with go1.23.4 Tue Dec 31 16:58:41 UTC 2024\nUse tags: with_gvisor",
          };
        }
        if (
          path == "data/mihomo/mihomo-darwin-arm64-alpha" &&
          args.includes("-v")
        ) {
          return {
            flag: true,
            data: "Mihomo Meta alpha-xxxxxxx darwin arm64 with go1.23.4 Tue Jan  7 00:00:00 UTC 2025\nUse tags: with_gvisor",
          };
        }

        if (path == "data/sing-box/sing-box" && args.includes("version")) {
          return {
            flag: true,
            data: "sing-box version 1.10.7\n\nEnvironment: go1.23.4 darwin/arm64\nTags: with_gvisor,with_quic,with_dhcp,with_wireguard,with_ech,with_utls,with_reality_server,with_acme,with_clash_api\nRevision: 253b41936ecd6ae17948d49d9c510d7100830927\nCGO: disabled",
          };
        }

        if (
          path == "data/sing-box/sing-box-latest" &&
          args.includes("version")
        ) {
          return {
            flag: true,
            data: "sing-box version 1.11.0-beta.24\n\nEnvironment: go1.23.4 windows/amd64\nTags: with_gvisor,with_quic,with_dhcp,with_wireguard,with_ech,with_utls,with_reality_server,with_acme,with_clash_api\nRevision: 8cc7734a921bf6c24d52d3b8dc40a553a88d7f5a\nCGO: disabled",
          };
        }
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
      AbsolutePath(path) {
        return { flag: true, data: path };
      },
    },
  },
};
