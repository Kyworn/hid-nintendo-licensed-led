# Maintainer: zorko <kyworn@gmail.com>
pkgname=hid-nintendo-licensed-led
pkgver=1.0.0
pkgrel=1
pkgdesc="Automatic player LED assignment for Nintendo-licensed Bluetooth controllers (vendor 0E6F)"
arch=('any')
url="https://github.com/Kyworn/${pkgname}"
license=('MIT')
depends=('python')
source=("${pkgname}-${pkgver}.tar.gz::${url}/archive/v${pkgver}.tar.gz")
sha256sums=('36770513c7be1377017fb71e4d44c80e7674b25089627f56bb1751cbfd981bff')

package() {
    cd "${srcdir}/${pkgname}-${pkgver}"

    install -Dm755 procon-led.sh "${pkgdir}/usr/local/bin/procon-led.sh"
    install -Dm644 99-nintendo-licensed-led.rules "${pkgdir}/usr/lib/udev/rules.d/99-nintendo-licensed-led.rules"
}
