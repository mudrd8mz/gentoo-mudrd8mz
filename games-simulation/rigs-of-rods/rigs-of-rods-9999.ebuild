# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils git-r3

DESCRIPTION="Rigs of Rods - soft body physics simulator"
HOMEPAGE="https://rigsofrods.org/"
EGIT_REPO_URI="https://github.com/RigsOfRods/rigs-of-rods.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-games/mygui-3.2.2[ogre,-opengl]
	>=dev-libs/angelscript-2.31.2
	>=dev-games/ogre-1.9.0[cg,ois,zip]
	>=dev-libs/boost-1.50
	net-misc/curl[ssl]
	dev-libs/openssl
	x11-libs/gtk+
	>=media-libs/openal-1.17.0
	>=x11-libs/wxGTK-2.6
	"

RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PV}-ogre-includes.patch"
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE="RelWithDebInfo"
	)
	cmake-utils_src_configure
}

src_install() {
	dodir "/usr/share/rigsofrods"
	cp -ar "${S}_build/bin/" "${D}/usr/share/rigsofrods/"
}
