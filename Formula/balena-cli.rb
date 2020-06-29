require "language/node"

class BalenaCli < Formula
  desc "The official balena CLI tool"
  homepage "https://www.balena.io/docs/reference/cli/"
  # Frequent upstream releases, do not update more than once a week
  url "https://registry.npmjs.org/balena-cli/-/balena-cli-12.2.0.tgz"
  sha256 "53428d2a98de33191e4b5ad1ef429667a7400e4b8d66402065cb63f6a7326b76"

  bottle do
    sha256 "f70852ef533bd566f3c330ac77e971a5898b24952b8233879884c99f0d424770" => :catalina
    sha256 "092679388036915200db9f73ce6396c04649ca1ee60f45e3a2b22e75e969f67c" => :mojave
    sha256 "bf22c13c44066d0aa5c94df2513010279afc3474f0e915de9f641336d4de0696" => :high_sierra
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
