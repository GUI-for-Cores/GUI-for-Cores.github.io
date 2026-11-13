#!/usr/bin/env bash
set -euo pipefail

# Interactive installer for GUI.for.Clash and GUI.for.SingBox.
# curl -fsSL https://gui-for-cores.github.io/install.sh | bash

TTY=/dev/tty
UA="GUI.for.Cores-install"

die() { printf '错误：%s\n' "$*" >&2; exit 1; }
info() { printf '%s\n' "$*"; }
need_cmd() { command -v "$1" >/dev/null 2>&1 || die "未找到命令：$1"; }

ask() {
	local prompt="$1" def="${2-}" ans
	if [ -n "$def" ]; then
		printf '%s [%s]: ' "$prompt" "$def" >"$TTY"
	else
		printf '%s: ' "$prompt" >"$TTY"
	fi
	IFS= read -r ans <"$TTY" || exit 1
	if [ -z "$ans" ]; then
		ans="$def"
	fi
	printf '%s' "$ans"
}

yesno() {
	local prompt="$1" def="${2:-n}" ans hint
	if [ "$def" = y ]; then
		hint="Y/n"
	else
		hint="y/N"
	fi
	while :; do
		printf '%s [%s]: ' "$prompt" "$hint" >"$TTY"
		IFS= read -r ans <"$TTY" || exit 1
		ans="${ans:-$def}"
		case "$ans" in
		y | Y | yes | YES) return 0 ;;
		n | N | no | NO) return 1 ;;
		esac
		printf '请输入 y 或 n\n' >"$TTY"
	done
}

choose() {
	local ans
	printf '%s: ' "$1" >"$TTY"
	IFS= read -r ans <"$TTY" || exit 1
	printf '%s' "$ans"
}

expand_path() {
	local p="$1"
	case "$p" in
	~) p="$HOME" ;;
	~/*) p="$HOME/${p#~/}" ;;
	esac
	realpath -m "$p"
}

ARCH=
OS_NAME=
OS_ID=
OS_LIKE=
PKG=
REPO=
APP_ID=
BIN_NAME=
LINK_NAME=
SCHEME=
APP_TITLE=
COMMENT_EN=
COMMENT_ZH=
KEYWORDS=
MIRROR=
TMP=

cleanup() {
	if [ -n "${TMP-}" ]; then
		rm -rf "$TMP"
	fi
}
trap cleanup EXIT

detect_arch() {
	case "$(uname -m)" in
	x86_64 | amd64) ARCH=amd64 ;;
	aarch64 | arm64) ARCH=arm64 ;;
	*) die "不支持的架构：$(uname -m)。仅支持 amd64 与 arm64。" ;;
	esac
}

detect_os() {
	if [ -r /etc/os-release ]; then
		# shellcheck source=/dev/null
		. /etc/os-release
		OS_NAME=${PRETTY_NAME:-$ID}
		OS_ID=${ID:-}
		OS_LIKE=${ID_LIKE:-}
	else
		OS_NAME=unknown
		OS_ID=
		OS_LIKE=
	fi
	local key
	key=$(printf '%s %s' "$OS_ID" "$OS_LIKE" | tr '[:upper:]' '[:lower:]')
	case " $key " in
	*' debian '* | *' ubuntu '* | *' linuxmint '* | *' pop '* | *' elementary '* | *' raspbian '* | *' neon '*)
		PKG=apt
		;;
	*' fedora '* | *' rhel '* | *' centos '* | *' rocky '* | *' almalinux '* | *' nobara '* | *' mageia '*)
		PKG=dnf
		;;
	*' suse '* | *' opensuse '* | *' sles '*)
		PKG=zypper
		;;
	*' arch '* | *' manjaro '* | *' endeavouros '* | *' cachyos '* | *' archlinux '*)
		PKG=pacman
		;;
	*)
		PKG=
		;;
	esac
}

dep_install_cmd() {
	case "$PKG" in
	apt) printf 'sudo apt install libgtk-3-0 libwebkit2gtk-4.1-0' ;;
	dnf) printf 'sudo dnf install gtk3 webkit2gtk4.1' ;;
	zypper) printf 'sudo zypper install gtk3 webkit2gtk-4.1' ;;
	pacman) printf 'sudo pacman -S gtk3 webkit2gtk-4.1' ;;
	*)
		printf 'Debian/Ubuntu: sudo apt install libgtk-3-0 libwebkit2gtk-4.1-0\n'
		printf 'Fedora:        sudo dnf install gtk3 webkit2gtk4.1\n'
		printf 'openSUSE:      sudo zypper install gtk3 webkit2gtk-4.1\n'
		printf 'Arch:          sudo pacman -S gtk3 webkit2gtk-4.1'
		;;
	esac
}

has_lib() {
	local name="$1" ld p
	for ld in ldconfig /sbin/ldconfig /usr/sbin/ldconfig; do
		if command -v "$ld" >/dev/null 2>&1 || [ -x "$ld" ]; then
			if "$ld" -p 2>/dev/null | grep -F "$name" | grep -q .; then
				return 0
			fi
			break
		fi
	done
	for p in /usr/lib/*/"$name"* /usr/lib64/"$name"* /lib/*/"$name"* /lib64/"$name"* /usr/lib/"$name"*; do
		[ -e "$p" ] && return 0
	done
	return 1
}

check_deps() {
	local missing=0
	if has_lib libgtk-3.so.0; then
		info "  GTK3：已安装"
	else
		info "  GTK3：未找到"
		missing=1
	fi
	if has_lib libwebkit2gtk-4.1.so.0; then
		info "  WebKit2GTK 4.1：已安装"
	else
		info "  WebKit2GTK 4.1：未找到"
		missing=1
	fi
	return "$missing"
}

select_app() {
	info ""
	info "请选择要安装的程序："
	info "  1) GFC  — GUI.for.Clash"
	info "  2) GFS  — GUI.for.SingBox"
	local c
	while :; do
		c=$(choose "请输入序号")
		case "$c" in
		1 | gfc | GFC | Gfc)
			REPO=GUI-for-Cores/GUI.for.Clash
			APP_ID=GUI.for.Clash
			BIN_NAME=GUI.for.Clash
			LINK_NAME=gui-for-clash
			SCHEME=clash
			APP_TITLE="GUI.for.Clash"
			COMMENT_EN="A GUI client for Clash"
			COMMENT_ZH="适用于 Clash 的图形客户端"
			KEYWORDS="gfc;gui;clash;mihomo;"
			break
			;;
		2 | gfs | GFS | Gfs)
			REPO=GUI-for-Cores/GUI.for.SingBox
			APP_ID=GUI.for.SingBox
			BIN_NAME=GUI.for.SingBox
			LINK_NAME=gui-for-singbox
			SCHEME=sing-box
			APP_TITLE="GUI.for.SingBox"
			COMMENT_EN="A GUI client for sing-box"
			COMMENT_ZH="适用于 sing-box 的图形客户端"
			KEYWORDS="gfs;gui;sb;singbox;"
			break
			;;
		*) printf '请输入 1 或 2\n' >"$TTY" ;;
		esac
	done
}

DATA_HOME="${XDG_DATA_HOME:-}"
[ "${DATA_HOME#/}" != "$DATA_HOME" ] || DATA_HOME="$HOME/.local/share"

default_dir() { printf '%s\n' "$HOME/.local/opt/$APP_ID"; }
data_dir() { printf '%s\n' "$DATA_HOME/$APP_ID"; }
desktop_path() { printf '%s\n' "$DATA_HOME/applications/${LINK_NAME}.desktop"; }
icon_path() { printf '%s\n' "$DATA_HOME/icons/hicolor/256x256/apps/${LINK_NAME}.png"; }
link_path() { printf '%s\n' "$HOME/.local/bin/$LINK_NAME"; }
polkit_path() { printf '%s\n' "/etc/polkit-1/rules.d/99-${LINK_NAME}.rules"; }

find_existing() {
	local d p exec_line
	d=$(default_dir)
	if [ -x "$d/$BIN_NAME" ]; then
		printf '%s\n' "$d"
		return 0
	fi
	p=$(link_path)
	if [ -e "$p" ]; then
		printf '%s\n' "$(dirname "$(readlink -f "$p")")"
		return 0
	fi
	p=$(desktop_path)
	if [ -f "$p" ]; then
		exec_line=$(grep -E '^Exec=' "$p" | head -n1 | sed 's/^Exec=//; s/ %u$//; s/^"//; s/"$//')
		if [ -n "$exec_line" ] && [ -e "$exec_line" ]; then
			printf '%s\n' "$(dirname "$exec_line")"
			return 0
		fi
	fi
	return 1
}

is_system_path() {
	case "$1" in
	/usr | /usr/* | /bin | /bin/* | /sbin | /sbin/* | /lib | /lib/* | /lib64 | /lib64/*)
		return 0
		;;
	*)
		return 1
		;;
	esac
}

api_get() {
	local url="$1" dest="$2" token="${GH_TOKEN:-${GITHUB_TOKEN:-}}"
	set -- -fsSL -A "$UA" -H "Accept: application/vnd.github+json" -o "$dest" "$url"
	if [ -n "$token" ]; then
		set -- -fsSL -A "$UA" -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $token" -o "$dest" "$url"
	fi
	curl "$@"
}

api_path() {
	local url="$1"
	printf '%s' "${url#https://api.github.com/}"
}

# Parse a GitHub release JSON. Prints: tag, download URL, digest.
parse_asset() {
	local json="$1" want="$2"
	if command -v python3 >/dev/null 2>&1; then
		python3 -c '
import json,sys
want=sys.argv[1]
d=json.load(open(sys.argv[2]))
tag=d.get("tag_name") or ""
for a in d.get("assets") or []:
    if a.get("name")==want:
        print(tag)
        print(a.get("browser_download_url") or "")
        print(a.get("digest") or "")
        break
else:
    sys.exit(2)
' "$want" "$json"
	elif command -v jq >/dev/null 2>&1; then
		jq -r --arg n "$want" '
			.tag_name,
			(.assets[] | select(.name==$n) | .browser_download_url),
			(.assets[] | select(.name==$n) | .digest // "")
		' "$json"
	else
		die "需要 python3 或 jq 来解析 GitHub API 返回的 JSON"
	fi
}

fetch_release() {
	local tag="${1-}" url json want out
	want="${APP_ID}-linux-${ARCH}.zip"
	json=$(mktemp)
	if [ -z "$tag" ] || [ "$tag" = latest ]; then
		url="https://api.github.com/repos/${REPO}/releases/latest"
	else
		case "$tag" in
		v*) ;;
		*) tag="v$tag" ;;
		esac
		url="https://api.github.com/repos/${REPO}/releases/tags/${tag}"
	fi
	# API is always direct so the digest cannot be spoofed by a download mirror.
	if ! api_get "$url" "$json"; then
		if command -v gh >/dev/null 2>&1 && gh api "$(api_path "$url")" >"$json"; then
			:
		else
			rm -f "$json"
			die "无法获取版本信息：$url
若遇到 GitHub API 限流，可设置 GH_TOKEN 后重试。"
		fi
	fi
	if ! out=$(parse_asset "$json" "$want"); then
		rm -f "$json"
		die "该版本没有资源：$want"
	fi
	rm -f "$json"
	printf '%s\n' "$out"
}

normalize_mirror() {
	local p="$1"
	p="${p#"${p%%[![:space:]]*}"}"
	p="${p%"${p##*[![:space:]]}"}"
	case "$p" in
	"" | */ | *[?=]) ;;
	*) p="$p/" ;;
	esac
	printf '%s' "$p"
}

mirror_url() {
	local url="$1"
	if [ -z "$MIRROR" ]; then
		printf '%s' "$url"
	else
		printf '%s%s' "$MIRROR" "$url"
	fi
}

ask_mirror() {
	MIRROR=
	info ""
	if yesno "是否使用 GitHub 加速镜像？" n; then
		info "请输入镜像前缀，将加在原 GitHub 下载地址前面。"
		info "例如：https://ghfast.top/"
		info "（API 仍直连 GitHub，用于获取 SHA256。）"
		MIRROR=$(normalize_mirror "$(ask "镜像前缀")")
		[ -n "$MIRROR" ] || die "未输入镜像前缀"
	fi
}

write_desktop() {
	local dir="$1" dest parent
	dest=$(desktop_path)
	parent=$(dirname "$dest")
	mkdir -p "$parent"
	cat >"$dest" <<EOF
[Desktop Entry]
Type=Application
Version=1.0
Name=$APP_TITLE
GenericName=Network Debugging Tools
GenericName[zh_CN]=网络调试工具
Comment=$COMMENT_EN
Comment[zh_CN]=$COMMENT_ZH
Exec="$dir/$BIN_NAME" %u
Icon=$LINK_NAME
Terminal=false
StartupNotify=true
StartupWMClass=$BIN_NAME
Categories=Network;Utility;
MimeType=x-scheme-handler/$SCHEME;
Keywords=$KEYWORDS
SingleMainWindow=true
EOF
	if command -v update-desktop-database >/dev/null 2>&1; then
		update-desktop-database "$parent" 2>/dev/null || true
	fi
	if command -v xdg-mime >/dev/null 2>&1; then
		xdg-mime default "${LINK_NAME}.desktop" "x-scheme-handler/${SCHEME}" 2>/dev/null || true
	fi
}

install_icon() {
	local tag="$1" dest parent url
	dest=$(icon_path)
	parent=$(dirname "$dest")
	mkdir -p "$parent"
	url=$(mirror_url "https://github.com/${REPO}/raw/${tag}/build/appicon.png")
	if curl -fL -sS -A "$UA" --retry 3 -o "$dest" "$url"; then
		chmod 644 "$dest"
		if command -v gtk-update-icon-cache >/dev/null 2>&1; then
			gtk-update-icon-cache -f -t "$DATA_HOME/icons/hicolor" 2>/dev/null || true
		fi
		return 0
	fi
	rm -f "$dest"
	info "警告：图标下载失败，桌面入口可能没有图标。"
	return 1
}

write_polkit() {
	local rule dest
	dest=$(polkit_path)
	rule=$(
		cat <<EOF
polkit.addRule(function (action, subject) {
  if (!subject.local || !subject.active) {
    return
  }

  if (!subject.isInGroup('${LINK_NAME}')) {
    return
  }

  switch (action.id) {
    case 'org.freedesktop.resolve1.set-domains':
    case 'org.freedesktop.resolve1.set-default-route':
    case 'org.freedesktop.resolve1.set-dns-servers':
    case 'org.freedesktop.resolve1.flush-caches':
    case 'org.freedesktop.resolve1.revert':
      return polkit.Result.YES
  }
})
EOF
	)
	info "配置免密 TUN（需要 sudo）：创建组 $LINK_NAME、写入 $dest"
	sudo groupadd -r -f "$LINK_NAME"
	sudo usermod -aG "$LINK_NAME" "$USER"
	printf '%s\n' "$rule" | sudo tee "$dest" >/dev/null
	sudo chmod 644 "$dest"
	sudo systemctl restart polkit.service 2>/dev/null || true
	info "已写入 polkit 规则。需要重新登录后组权限才会生效。"
}

do_install() {
	local existing tag_in tag url digest dir do_desktop do_link do_polkit do_deps
	local zip sha_got sha_want parent line

	existing=$(find_existing || true)
	if [ -n "$existing" ]; then
		info ""
		info "检测到已安装：$existing"
		info "继续将进行重装 / 修复（程序升级请使用应用内自更新）。"
	fi

	need_cmd curl
	need_cmd unzip
	need_cmd sha256sum

	info ""
	info "正在获取最新版本…"
	line=$(fetch_release latest)
	tag=$(printf '%s\n' "$line" | sed -n '1p')
	url=$(printf '%s\n' "$line" | sed -n '2p')
	digest=$(printf '%s\n' "$line" | sed -n '3p')

	tag_in=$(ask "要安装的版本（回车使用最新版）" "$tag")
	if [ "$tag_in" != "$tag" ]; then
		line=$(fetch_release "$tag_in")
		tag=$(printf '%s\n' "$line" | sed -n '1p')
		url=$(printf '%s\n' "$line" | sed -n '2p')
		digest=$(printf '%s\n' "$line" | sed -n '3p')
	fi
	[ -n "$url" ] || die "未找到下载地址"
	[ -n "$digest" ] || die "该资源没有公布 SHA256（GitHub API digest 为空），已中止"

	dir=$(expand_path "$(ask "安装目录" "${existing:-$(default_dir)}")")
	if is_system_path "$dir"; then
		info "警告：$dir 通常需要 root 权限，程序自更新将无法替换二进制文件。"
		if ! yesno "仍要使用该目录？" n; then
			return 0
		fi
	fi
	parent=$dir
	while [ ! -d "$parent" ]; do
		parent=$(dirname "$parent")
	done
	[ -w "$parent" ] || die "目录不可写：$dir（自更新需要写入程序所在目录）"

	info ""
	info "检查运行依赖…"
	do_deps=n
	if check_deps; then
		:
	else
		info "缺少运行依赖，安装命令："
		info "$(dep_install_cmd)"
		if yesno "现在用 sudo 安装依赖？" n; then
			do_deps=y
		else
			info "已跳过依赖安装，程序可能无法启动。"
		fi
	fi

	do_desktop=n
	do_link=n
	do_polkit=n
	if yesno "创建桌面入口并注册 ${SCHEME}:// 协议？" y; then
		do_desktop=y
	fi
	if yesno "在 ~/.local/bin 创建命令行软链接 ${LINK_NAME}？" y; then
		do_link=y
	fi
	if yesno "配置免密 TUN（polkit 规则，需要 sudo，默认否）？" n; then
		do_polkit=y
	fi

	ask_mirror
	url=$(mirror_url "$url")

	info ""
	info "即将执行："
	info "  程序：    $APP_TITLE ($tag, linux-$ARCH)"
	info "  安装到：  $dir"
	info "  下载：    $url"
	info "  校验：    $digest"
	if [ -n "$MIRROR" ]; then
		info "  镜像：    $MIRROR"
	fi
	info "  将创建："
	info "    $dir/$BIN_NAME"
	if [ "$do_desktop" = y ]; then
		info "    $(desktop_path)"
		info "    $(icon_path)"
	fi
	if [ "$do_link" = y ]; then
		info "    $(link_path) -> $dir/$BIN_NAME"
	fi
	if [ "$do_deps" = y ] || [ "$do_polkit" = y ]; then
		info "  需要 sudo："
		[ "$do_deps" = y ] && info "    安装依赖：$(dep_install_cmd)"
		[ "$do_polkit" = y ] && info "    创建组 $LINK_NAME，写入 $(polkit_path)"
	else
		info "  需要 sudo：无"
	fi
	info "  数据目录 $(data_dir) 不会被改动。"
	if ! yesno "确认开始？" y; then
		info "已取消。"
		return 0
	fi

	if [ "$do_deps" = y ]; then
		case "$PKG" in
		apt) sudo apt install libgtk-3-0 libwebkit2gtk-4.1-0 ;;
		dnf) sudo dnf install gtk3 webkit2gtk4.1 ;;
		zypper) sudo zypper install gtk3 webkit2gtk-4.1 ;;
		pacman) sudo pacman -S gtk3 webkit2gtk-4.1 ;;
		*) die "未知发行版，请先手动安装依赖" ;;
		esac
	fi

	TMP=$(mktemp -d)
	zip="$TMP/${APP_ID}-linux-${ARCH}.zip"
	info "正在下载…"
	curl -fL -A "$UA" --retry 3 --progress-bar -o "$zip" "$url" || die "下载失败：$url"

	sha_want=${digest#sha256:}
	sha_want=$(printf '%s' "$sha_want" | tr '[:upper:]' '[:lower:]')
	[ -n "$sha_want" ] || die "无法解析 SHA256：$digest"
	sha_got=$(sha256sum "$zip" | awk '{print $1}')
	if [ "$sha_got" != "$sha_want" ]; then
		die "SHA256 校验失败，已中止。
  期望：$sha_want
  实际：$sha_got"
	fi
	info "SHA256 校验通过。"

	mkdir -p "$dir"
	unzip -o -q "$zip" -d "$dir"
	if [ ! -f "$dir/$BIN_NAME" ]; then
		die "压缩包中未找到 $BIN_NAME"
	fi
	chmod +x "$dir/$BIN_NAME"

	if [ "$do_desktop" = y ]; then
		write_desktop "$dir"
		install_icon "$tag" || true
	fi
	if [ "$do_link" = y ]; then
		mkdir -p "$HOME/.local/bin"
		ln -sfn "$dir/$BIN_NAME" "$(link_path)"
		case ":$PATH:" in
		*":$HOME/.local/bin:"*) ;;
		*) info "提示：~/.local/bin 不在 PATH 中，当前终端可能无法直接运行 $LINK_NAME。" ;;
		esac
	fi
	if [ "$do_polkit" = y ]; then
		write_polkit
	fi

	rm -rf "$TMP"
	TMP=
	info ""
	info "安装完成：$dir/$BIN_NAME"
	if yesno "现在启动 $APP_TITLE？" n; then
		nohup "$dir/$BIN_NAME" >/dev/null 2>&1 &
		info "已启动。"
	fi
}

do_refresh_desktop() {
	local dir tag line
	dir=$(find_existing || true)
	if [ -z "$dir" ] || [ ! -x "$dir/$BIN_NAME" ]; then
		dir=$(expand_path "$(ask "程序所在目录" "$(default_dir)")")
	fi
	[ -x "$dir/$BIN_NAME" ] || die "未找到程序：$dir/$BIN_NAME"

	need_cmd curl
	info "正在获取版本信息以下载图标…"
	line=$(fetch_release latest)
	tag=$(printf '%s\n' "$line" | sed -n '1p')
	tag=$(ask "图标对应的版本" "$tag")
	case "$tag" in
	v*) ;;
	*) tag="v$tag" ;;
	esac
	ask_mirror

	info ""
	info "即将写入："
	info "  $(desktop_path)"
	info "  $(icon_path)"
	info "  Exec=$dir/$BIN_NAME"
	if ! yesno "确认？" y; then
		info "已取消。"
		return 0
	fi
	write_desktop "$dir"
	install_icon "$tag" || true
	info "桌面入口已更新。"
}

do_uninstall() {
	local dir data dest
	dir=$(find_existing || true)
	if [ -z "$dir" ]; then
		dir=$(expand_path "$(ask "程序所在目录" "$(default_dir)")")
	fi

	info ""
	info "即将删除："
	if [ -e "$dir/$BIN_NAME" ] || [ -d "$dir" ]; then
		info "  程序目录：$dir"
	else
		info "  未找到程序目录（$dir）"
	fi
	[ -e "$(desktop_path)" ] && info "  $(desktop_path)"
	[ -e "$(icon_path)" ] && info "  $(icon_path)"
	[ -e "$(link_path)" ] && info "  $(link_path)"
	if ! yesno "确认卸载程序文件？（不会默认删除数据目录）" y; then
		info "已取消。"
		return 0
	fi

	data=$(data_dir)
	if [ -d "$dir" ]; then
		if [ "$(expand_path "$dir")" = "$(expand_path "$data")" ]; then
			info "安装目录与数据目录相同，只删除程序文件，保留数据。"
			rm -f "$dir/$BIN_NAME" "$dir/appicon.png"
		else
			rm -rf "$dir"
		fi
	fi
	rm -f "$(desktop_path)" "$(icon_path)" "$(link_path)"
	if command -v update-desktop-database >/dev/null 2>&1; then
		update-desktop-database "$DATA_HOME/applications" 2>/dev/null || true
	fi

	if [ -d "$data" ]; then
		info "数据目录：$data"
		if yesno "是否同时删除数据目录？（默认保留）" n; then
			rm -rf "$data"
			info "已删除数据目录。"
		else
			info "已保留数据目录。"
		fi
	fi

	dest=$(polkit_path)
	if [ -f "$dest" ]; then
		if yesno "检测到 polkit 规则，是否删除规则并移除组 $LINK_NAME？（需要 sudo）" n; then
			sudo rm -f "$dest"
			sudo gpasswd -d "$USER" "$LINK_NAME" 2>/dev/null || true
			sudo groupdel "$LINK_NAME" 2>/dev/null || true
			sudo systemctl restart polkit.service 2>/dev/null || true
			info "已移除 polkit 规则。"
		fi
	fi
	info "卸载完成。"
}

main_menu() {
	local c existing
	existing=$(find_existing || true)
	info ""
	info "已选择：$APP_TITLE"
	if [ -n "$existing" ]; then
		info "已安装：$existing"
	fi
	info "  1) 安装"
	info "  2) 更新桌面入口"
	info "  3) 卸载"
	info "  4) 退出"
	info "（程序升级请使用应用内自更新。）"
	while :; do
		c=$(choose "请输入序号")
		case "$c" in
		1) do_install; return ;;
		2) do_refresh_desktop; return ;;
		3) do_uninstall; return ;;
		4) info "已退出。"; return ;;
		*) printf '请输入 1-4\n' >"$TTY" ;;
		esac
	done
}

main() {
	if [ ! -r "$TTY" ]; then
		die "需要交互式终端。请在终端中运行，或使用：curl -fsSL https://gui-for-cores.github.io/install.sh | bash"
	fi
	detect_arch
	detect_os
	info "GUI.for.Cores 安装脚本"
	info "检测结果：架构=$ARCH    系统=${OS_NAME:-unknown}"
	select_app
	main_menu
}

main "$@"
