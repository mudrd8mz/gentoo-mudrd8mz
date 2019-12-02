# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PHP_EXT_NAME="ast"
USE_PHP="php7-1 php7-2 php7-3"

inherit php-ext-pecl-r3

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Extension exposing PHP 7 abstract syntax tree"
HOMEPAGE="https://pecl.php.net/package/ast"
LICENSE="BSD-3-Clause"
SLOT="0"
