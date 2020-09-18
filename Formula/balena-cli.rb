require "language/node"

class BalenaCli < Formula
  desc "The official balena CLI tool"
  homepage "https://www.balena.io/docs/reference/cli/"
  # balena-cli should only be updated every 10 releases on multiples of 10
  url "https://registry.npmjs.org/balena-cli/-/balena-cli-12.22.0.tgz"
  sha256 "2b0cb4b78c888a2fb054bfd722d95a373686cb45bdd6686b8db8ca1d0557e96a"
  license "Apache-2.0"

  livecheck do
    url :stable
  end

  bottle do
    sha256 "e9ee324951631c0267b7eae820edcd3de0c39d205e422e616cd4655c6fd5be9c" => :catalina
    sha256 "7077786834009a3fcceb791b659c85a781f0dffd4e4fa23a80e27cac44da67d5" => :mojave
    sha256 "eda936c203059ae4666a1dbbeb6ccf42d4fb44b8029ce006362bbcfa316defdc" => :high_sierra
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "Logging in to balena-cloud.com",
      shell_output("#{bin}/balena login --credentials --email johndoe@gmail.com --password secret 2>/dev/null", 1)
  end
end
