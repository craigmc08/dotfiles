{ lib, pkgs, config, ... }:

with lib;
let cfg = config.modules.firefox;

in {
	options.modules.firefox= { enable = mkEnableOption "firefox"; };

	config = mkIf cfg.enable {
		programs.firefox = {
			enable = true;

			profiles.craig = {
				settings = {
					# Various settings.
					"browser.send_pings" = false;
					"browser.urlbar.speculativeConnect.enabled" = false;
					"dom.event.clipboardevents.enabled" = true;
					"media.navigator.enabled" = false;
					"network.IDN_show_punycode" = true;
					"extensions.activeThemeID" = "firefox-dark@mozilla.org";
					"browser.toolbars.bookmarks.visibility" = "never";
					"geo.enabled" = false;

					# Disable Pocket.
					"browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
					"browser.newtabpage.activity-stream.feeds.section.topstories" = false;
					"browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
					"browser.newtabpage.activity-stream.showSponsored" = false;
					"extensions.pocket.enabled" = false;

					# No JS in PDFs >:(
					"pdfjs.enableScripting" = false;

					# Other settings.
					"identity.fxaccounts.enabled" = false;
					"browser.search.suggest.enabled" = false;
					"browser.urlbar.suggest.history" = false;
					"media.autoplay.enabled" = false;
				};
			};
		};
	};
}
