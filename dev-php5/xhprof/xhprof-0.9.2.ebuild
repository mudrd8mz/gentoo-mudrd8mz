# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

PHP_EXT_NAME="xhprof"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-source-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="XHProf: A Hierarchical Profiler for PHP"
HOMEPAGE="http://pecl.php.net/package/xhprof"
SRC_URI="http://pecl.php.net/get/${P}.tgz"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND="!dev-php5/ZendOptimizer"
RDEPEND="${DEPEND}"

src_unpack() {
	php-ext-source-r2_src_unpack
	for slot in $(php_get_slots); do
			mv "${WORKDIR}/${slot}/extension/"* "${WORKDIR}/${slot}/"
	done
}

src_install() {
	dodoc CHANGELOG CREDITS LICENSE README
	php-ext-source-r2_src_install

	php-ext-source-r2_addtoinifiles "xhprof.output_dir" '"/tmp/xhprof"'
}
