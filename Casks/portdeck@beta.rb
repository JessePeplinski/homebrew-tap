cask "portdeck@beta" do
  version "0.1.0-beta.13"
  sha256 "62deffc8d5e5165bfec4ab6c77a02af472281f06493084de7a0dc49f7ce2bfa2"

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
