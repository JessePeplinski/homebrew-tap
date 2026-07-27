cask "portdeck@beta" do
  version "0.1.0-beta.7"
  sha256 "ab4910f7cda96eb160b951f2df00f251bcc45892a249866248eb4b5157fbb4a9"

  url "https://github.com/JessePeplinski/portdeck/releases/download/v#{version}/PortDeck-#{version}-macos-arm64.zip",
      verified: "github.com/JessePeplinski/portdeck/"
  name "PortDeck"
  desc "Menu bar command center for local development services and deployments"
  homepage "https://portdeck.vercel.app/"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "PortDeck.app"
end
