cask "portdeck@beta" do
  version "0.1.0-beta.3"
  sha256 "58707e694f54bd1ff796daaae93ccde73cf2ea4d4ce356976f8ab9837c35a307"

  url "https://github.com/JessePeplinski/portdeck/releases/download/v#{version}/PortDeck-#{version}-macos-arm64.zip",
      verified: "github.com/JessePeplinski/portdeck/"
  name "PortDeck"
  desc "Menu bar command center for local development services and deployments"
  homepage "https://portdeck.vercel.app/"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "PortDeck.app"
end
