# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit multilib versionator

MY_PV=$(replace_all_version_separators _ "$(get_version_component_range 2-)")
MY_PN=df
MY_P=${MY_PN}_${MY_PV}

DESCRIPTION="A single-player fantasy game"
HOMEPAGE="http://www.bay12games.com/dwarves"
SRC_URI="http://www.bay12games.com/dwarves/${MY_P}_linux.tar.bz2"

LICENSE="free-noncomm BSD BitstreamVera"
SLOT="0"
KEYWORDS="~amd64 ~x86 -*"
IUSE="debug"

RDEPEND="media-libs/glew:0[abi_x86_32(-)]
	media-libs/libsdl[abi_x86_32(-),joystick,video]
	media-libs/sdl-image[abi_x86_32(-),png]
	media-libs/sdl-ttf[abi_x86_32(-)]
	>=sys-apps/coreutils-7.1
	sys-libs/zlib[abi_x86_32(-)]
	virtual/glu[abi_x86_32(-)]
	x11-libs/gtk+:2[abi_x86_32(-)]"
# Yup, libsndfile, openal and ncurses are only needed at compile-time; the code
# dlopens them at runtime if requested.
DEPEND="${RDEPEND}
	media-libs/libsndfile[abi_x86_32(-)]
	media-libs/openal[abi_x86_32(-)]
	sys-libs/ncurses[abi_x86_32(-),unicode]
	virtual/pkgconfig"

S=${WORKDIR}/${MY_PN}_linux

gamesdir="/opt/${PN}"
QA_PRESTRIPPED="${gamesdir}/libs/Dwarf_Fortress"
RESTRICT="strip"

pkg_setup() {
	multilib_toolchain_setup x86
}

src_prepare() {
	rm -f libs/*.so* || die
	cp "${FILESDIR}"/{dwarf-fortress,Makefile} . || die
	default

	# Fix build with gcc-5.4
	sed -e '1i#include <math.h>\' \
		-i g_src/ttf_manager.cpp || die
}

src_configure() {
	tc-export CXX PKG_CONFIG
	CXXFLAGS+=" -D$(use debug || echo N)DEBUG"
}

src_compile() {
	default
	sed -i -e "s:^gamesdir=.*:gamesdir=${gamesdir}:" dwarf-fortress || die
}

src_install() {
	# install data-files and libs
	insinto "${gamesdir}"
	doins -r raw data libs

	# install our wrapper
	dobin dwarf-fortress

	# install docs
	dodoc README.linux *.txt

	fperms 755 "${gamesdir}"/libs/Dwarf_Fortress
}

pkg_postinst() {
	elog "System-wide Dwarf Fortress has been installed to ${gamesdir}. This is"
	elog "symlinked to ~/.dwarf-fortress when dwarf-fortress is run."
	elog "For more information on what exactly is replaced, see /usr/bin/dwarf-fortress."
	elog "Note: This means that the primary entry point is /usr/bin/dwarf-fortress."
	elog "Do not run ${gamesdir}/libs/Dwarf_Fortress."
	elog
	elog "Optional runtime dependencies:"
	elog "Install sys-libs/ncurses[$(use amd64 && echo "abi_x86_32,")unicode] for [PRINT_MODE:TEXT]"
	elog "Install media-libs/openal$(use amd64 && echo "[abi_x86_32]") and media-libs/libsndfile$(use amd64 && echo "[abi_x86_32]") for audio output"
	elog "Install media-libs/libsdl[$(use amd64 && echo "abi_x86_32,")opengl] for the OpenGL PRINT_MODE settings"
}
