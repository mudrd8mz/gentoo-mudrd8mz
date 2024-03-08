# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WX_GTK_VER="3.2-gtk3"

inherit cmake wxwidgets xdg

DESCRIPTION="Open source free form data organizer"

HOMEPAGE="https://strlen.com/treesheets/"

SRC_URI="https://github.com/aardappel/treesheets/archive/refs/tags/${PV}.tar.gz"

LICENSE="ZLIB"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND=">=x11-libs/wxGTK-3.2.2.1-r3"

DOCS="TS/*"

src_configure() {
	setup-wxwidgets
	cmake_src_configure
}

src_install() {
	cmake_src_install
	docompress -x /usr/share/doc/${PF}/examples
}
