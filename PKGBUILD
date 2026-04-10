# Maintainer: zorko <kyworn@gmail.com>
pkgname=hid-nintendo-licensed-led
pkgver=1.0.1
pkgrel=1
pkgdesc="Automatic player LED assignment for Nintendo-licensed Bluetooth controllers (vendor 0E6F)"
arch=('any')
url="https://github.com/Kyworn/${pkgname}"
license=('MIT')
depends=('python')
source=("${pkgname}-${pkgver}.tar.gz::${url}/archive/v${pkgver}.tar.gz")
sha256sums=('dd0aceb56629c52cc1309e9e2892e461e5bb3eebdfede6715e3344c884125d1a')

package() {
    cd "${srcdir}/${pkgname}-${pkgver}"

    install -Dm755 procon-led "${pkgdir}/usr/bin/procon-led"
    install -Dm644 99-nintendo-licensed-led.rules "${pkgdir}/usr/lib/udev/rules.d/99-nintendo-licensed-led.rules"
}
