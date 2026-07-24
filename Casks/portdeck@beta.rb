cask "portdeck@beta" do
  version "0.1.0-beta.6"
  sha256 "e84119c6cfc01bc913b22dbc5c7d4d586d68968489003e73aaf028e9612f0cd5"

  url "https://github.com/JessePeplinski/portdeck/releases/download/v#{version}/PortDeck-#{version}-macos-arm64.zip",
      verified: "github.com/JessePeplinski/portdeck/"
  name "PortDeck"
  desc "Menu bar command center for local development services and deployments"
  homepage "https://portdeck.vercel.app/"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "PortDeck.app"
end
