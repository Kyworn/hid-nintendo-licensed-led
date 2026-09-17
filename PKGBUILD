# Maintainer: zorko <kyworn@gmail.com>
pkgname=hid-nintendo-licensed-led
pkgver=1.0.5
pkgrel=1
pkgdesc="Plug-and-play player LED assignment for Nintendo-licensed Bluetooth controllers on Linux"
arch=('any')
url="https://github.com/Kyworn/${pkgname}"
license=('MIT')
depends=('python')
source=("${pkgname}-${pkgver}.tar.gz::${url}/archive/v${pkgver}.tar.gz")
sha256sums=('4cb266c1eae4120d8ec0557c6e858676e1118ee9ad56845223c83f4b960cc7f9')

package() {
    cd "${srcdir}/${pkgname}-${pkgver}"

    install -Dm755 procon-led "${pkgdir}/usr/bin/procon-led"
    install -Dm644 99-nintendo-licensed-led.rules "${pkgdir}/usr/lib/udev/rules.d/99-nintendo-licensed-led.rules"
}
