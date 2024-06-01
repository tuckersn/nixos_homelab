{ pkgs, ... }:

let
	lock-false = {
		Value = false;
		Status = "locked";
	};
	lock-true = {
		Value = true;
		Status = "locked";
	};
in
{
	programs.firefox = {
		enable = true;
		policies = {
			EnableTrackingProtection = {
				Value= true;
				Locked = true;
				Cryptomining = true;
				Fingerprinting = true;
			};
			ExtensionSettings = {
				"*".installation_mode = "blocked";
				"uBlock0@raymondhill.net" = { # https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/
					install_url = "https://addons.mozilla.org/firefox/downloads/file/4261710/ublock_origin-1.57.2.xpi";
					installation_mode = "force_installed";
				};
				"{73a6fe31-595d-460b-a920-fcc0f8843232}" = { # https://addons.mozilla.org/en-US/firefox/addon/noscript/
					install_url = "https://addons.mozilla.org/firefox/downloads/file/4206186/noscript-11.4.29.xpi";
					installation_mode = "force_installed";
				};
			};
			DisablePocket = true;
			DisableFirefoxAccounts = true;
			DisableAccounts = true;
			DisableFirefoxScreenshots = true;
			DisplayBookmarksToolbar = "never";
			DisplayMenuBar = "default-off";
			SearchBar = "unified";
			# Check about:config for options.
			Preferences = { 
				"browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
				"extensions.pocket.enabled" = lock-false;
				"extensions.screenshots.disabled" = lock-true;
				"browser.topsites.contile.enabled" = lock-false;
				"browser.formfill.enable" = lock-false;
				"browser.search.suggest.enabled" = lock-false;
				"browser.search.suggest.enabled.private" = lock-false;
				"browser.urlbar.suggest.searches" = lock-false;
				"browser.urlbar.showSearchSuggestionsFirst" = lock-false;
				"browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
				"browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
				"browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
				"browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
				"browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
				"browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
				"browser.newtabpage.activity-stream.showSponsored" = lock-false;
				"browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
				"browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
			};
		};
	};
}
