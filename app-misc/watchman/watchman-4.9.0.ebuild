# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Watches files and records, or triggers actions, when they change."
HOMEPAGE="https://facebook.github.io/watchman/"
SRC_URI="https://github.com/facebook/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libressl openssl ssl python pcre"

DEPEND="ssl? (
    !libressl? ( dev-libs/openssl:0= )
    libressl? ( dev-libs/libressl:0= )
)"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default
	./autogen.sh || die "autogen.sh failed"
}

src_configure() {
	econf \
		--enable-conffile="${EPREFIX}"/etc/"${PN}".json \
		--enable-statedir="${EPREFIX}"/var/run/"${PN}" \
		--enable-lenient \
		$(use_with python) \
		$(use_with pcre)
}
