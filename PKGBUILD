# Maintainer: zorko <kyworn@gmail.com>
pkgname=hid-nintendo-licensed-led
pkgver=1.0.4
pkgrel=1
pkgdesc="Plug-and-play player LED assignment for Nintendo-licensed Bluetooth controllers on Linux"
arch=('any')
url="https://github.com/Kyworn/${pkgname}"
license=('MIT')
depends=('python')
source=("${pkgname}-${pkgver}.tar.gz::${url}/archive/v${pkgver}.tar.gz")
sha256sums=('215289f053664cc5994e8eef832a8c180f69a6a0d64192a53eec995b7f1ddf12')

package() {
    cd "${srcdir}/${pkgname}-${pkgver}"

    install -Dm755 procon-led "${pkgdir}/usr/bin/procon-led"
    install -Dm644 99-nintendo-licensed-led.rules "${pkgdir}/usr/lib/udev/rules.d/99-nintendo-licensed-led.rules"
}
