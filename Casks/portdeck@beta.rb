cask "portdeck@beta" do
  version "0.1.0-beta.2"
  sha256 "65bfa0c67e0db5d746f6ab1856197983e507122e1061e5173752e121bbdc3b03"

  url "https://github.com/JessePeplinski/portdeck/releases/download/v#{version}/PortDeck-#{version}-macos-arm64.zip",
      verified: "github.com/JessePeplinski/portdeck/"
  name "PortDeck"
  desc "Menu bar command center for local development services and deployments"
  homepage "https://portdeck.vercel.app/"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "PortDeck.app"
end
