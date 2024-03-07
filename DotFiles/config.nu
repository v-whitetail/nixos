def "nu-wifi" [] {
  let wifi_scan = nmcli d wifi list
    let header_end = $wifi_scan | str index-of "\n"
    let header_row = $wifi_scan | str substring 0..$header_end
    let ssid_head = $header_row | str index-of " SSID"
    let ssid_tail = $header_row | str index-of " MODE"
    let scan_data = $wifi_scan  | str substring $header_end..
    let input_row = $scan_data  | fzf
    let wifi_name = $input_row  | str substring $ssid_head..$ssid_tail | str trim
    print "\t Input Password:"
    let pass_word = input -s
    nmcli d wifi connect $wifi_name password $pass_word
}

alias :q = exit
alias ls = eza
alias lsa = eza -a
alias cat = bat
alias vim = nvim ./

alias cdnix = cd /home/v/crystalPeak/nixos
alias honix = man home-configuration.nix
alias manix = man configuration.nix
alias nixrc = nvim /home/v/crystalPeak/nixos

alias ftest = sudo nixos-rebuild --flake .#v-whitetail test
alias fbuild = sudo nixos-rebuild --flake .#v-whitetail switch

