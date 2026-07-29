cask "portdeck@beta" do
  version "0.1.0-beta.14"
  sha256 "e0e37eb378ac0d6a3cf9202d8a0679bd0bd5d3c4bf0c7636a4d5ed9c14cf8ad7"

  url "https://github.com/JessePeplinski/portdeck/releases/download/v#{version}/PortDeck-#{version}-macos-arm64.zip",
      verified: "github.com/JessePeplinski/portdeck/"
  name "PortDeck"
  desc "Menu bar command center for local development services and deployments"
  homepage "https://portdeck.vercel.app/"

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "PortDeck.app"
end
