cask "portdeck@beta" do
  version "0.1.0-beta.4"
  sha256 "ce8b60941d2a28f42feeb210809fe5275cfcc870ea7342ef87fb01f9c599f9c4"

  url "https://github.com/JessePeplinski/portdeck/releases/download/v#{version}/PortDeck-#{version}-macos-arm64.zip",
      verified: "github.com/JessePeplinski/portdeck/"
  name "PortDeck"
  desc "Menu bar command center for local development services and deployments"
  homepage "https://portdeck.vercel.app/"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "PortDeck.app"
end
