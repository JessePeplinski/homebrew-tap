cask "portdeck@beta" do
  version "0.1.0-beta.17"
  sha256 "c44af4730c2a26dcac009b352c8175b1fd766c68a7c546d678020758b41c0538"

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
