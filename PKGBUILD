# Maintainer: zorko <kyworn@gmail.com>
pkgname=hid-nintendo-licensed-led
pkgver=1.0.3
pkgrel=1
pkgdesc="Automatic player LED assignment for Nintendo-licensed Bluetooth controllers (vendor 0E6F)"
arch=('any')
url="https://github.com/Kyworn/${pkgname}"
license=('MIT')
depends=('python')
source=("${pkgname}-${pkgver}.tar.gz::${url}/archive/v${pkgver}.tar.gz")
sha256sums=('b200372fb5c965775f01e66eb81353382e3a09fdae8ee57f21026782208633a6')

package() {
    cd "${srcdir}/${pkgname}-${pkgver}"

    install -Dm755 procon-led "${pkgdir}/usr/bin/procon-led"
    install -Dm644 99-nintendo-licensed-led.rules "${pkgdir}/usr/lib/udev/rules.d/99-nintendo-licensed-led.rules"
}
