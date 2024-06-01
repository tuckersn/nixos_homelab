# vscode.nix for users/tuck
{ pkgs, ... }:

{
	programs.vscode = {
		enable = true;
		extensions = with pkgs.vscode-extensions; [
		] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
			{
				name = "even-better-toml";
				publisher = "tamasfe";
				version = "0.19.2";
				sha256 = "0q9z98i446cc8bw1h1mvrddn3dnpnm2gwmzwv2s3fxdni2ggma14";
			}
			{
				name = "material-icon-theme";
				publisher = "PKief";
				version = "5.3.0";
				sha256 = "1gpbnwmqw0mxa6ald73ir44diyvlz4r8dar3jb5f9jqlmak92a28";
			}
			{
				name = "gitlens";
				publisher = "eamodio";
				version = "2024.5.2505";
				sha256 = "1jilq3brqvag4djksnckaxlk8g8ia6h89kcxnr2z8mcgyajqgycf";
			}
			{
				name = "Go";
				publisher = "golang";
				version = "0.41.4";
				sha256 = "03gxgcvjk5plzkk7gjsrrck1kszzbzswkbcr33m3qlkyz4iw9nly";
			}
			{
				name = "remote-ssh";
				publisher = "ms-vscode-remote";
				version = "0.112.2024051615";
				sha256 = "0ndvy0lcgp04yy1pd2p3bxi9nas5ncb5dka7a804kvawq1pylxxy";
			}
			{
				name = "remote-containers";
				publisher = "ms-vscode-remote";
				version = "0.366.0";
				sha256 = "0mk4fc0vr4igl1lbvdrqgfs6qfbkyqkki2rbix8vmqq97jp3zmqj";
			}
		];
	};
}
