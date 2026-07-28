cask "portdeck@beta" do
  version "0.1.0-beta.12"
  sha256 "4af439573ac10df024482ce3cc8a2a7c5603cebd0f6e70f87c10602f037c4128"

  url "https://github.com/JessePeplinski/portdeck/releases/download/v#{version}/PortDeck-#{version}-macos-arm64.zip",
      verified: "github.com/JessePeplinski/portdeck/"
  name "PortDeck"
  desc "Menu bar command center for local development services and deployments"
  homepage "https://portdeck.vercel.app/"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "PortDeck.app"
end
