cask "portdeck@beta" do
  version "0.1.0-beta.9"
  sha256 "0cfdfbc3dc5fd8ce77680e0f2123cdafba66a26ea1128383fedcce284595fbc6"

  url "https://github.com/JessePeplinski/portdeck/releases/download/v#{version}/PortDeck-#{version}-macos-arm64.zip",
      verified: "github.com/JessePeplinski/portdeck/"
  name "PortDeck"
  desc "Menu bar command center for local development services and deployments"
  homepage "https://portdeck.vercel.app/"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "PortDeck.app"
end
