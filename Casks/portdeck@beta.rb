cask "portdeck@beta" do
  version "0.1.0-beta.8"
  sha256 "b67231db79e5f04b0b5ffad3b8013d452e8a9ba09235bf852f314cbcc0dfea3f"

  url "https://github.com/JessePeplinski/portdeck/releases/download/v#{version}/PortDeck-#{version}-macos-arm64.zip",
      verified: "github.com/JessePeplinski/portdeck/"
  name "PortDeck"
  desc "Menu bar command center for local development services and deployments"
  homepage "https://portdeck.vercel.app/"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "PortDeck.app"
end
