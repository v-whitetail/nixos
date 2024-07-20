
alias :q = exit
alias cat = bat
alias vim = nvim ./
alias lf = yazi
alias tw = tailwindcss

alias cdnix = cd /home/v/crystalPeak/nixos
alias honix = man home-configuration.nix
alias manix = man configuration.nix

alias ssh-on = sudo systemctl start sshd.service
alias ssh-off = sudo systemctl start sshd.service

def devshell [] {
  let flake = ls ~/.config/devshells | input list --fuzzy 'Devshell Name'
  let target = pwd

  ls $flake.name | each { |file|
    cp -r $file.name $target
    print $'Copied ($file.name) into the current directory'
  } | ignore

  ls | each { |file| chmod +rw $file.name } | ignore

  let input = [no yes] | input list --fuzzy 'Proceed to Dev Shell?'
  if $input == yes {
    nix develop
  }
}

def nixrc [] {
  let dir = pwd
  cd /home/v/crystalPeak/nixos/
  nvim ./
  cd $dir
}

def fgit [] {
  cd /home/v/crystalPeak/nixos/
  gitui
}

def ftest [] {
  cd /home/v/crystalPeak/nixos/
  sudo nixos-rebuild --flake .#v-whitetail test
}

def fbuild [] {
  cd /home/v/crystalPeak/nixos/
  sudo nixos-rebuild --flake .#v-whitetail switch
}

def nu-wifi [] {
  let wifi_scan = nmcli d wifi list

  let header_end = $wifi_scan | str index-of "\n"
  let header_row = $wifi_scan | str substring 0..$header_end

  let ssid_head = $header_row | str index-of ' SSID'
  let ssid_tail = $header_row | str index-of ' MODE'

  let scan_data = $wifi_scan | str substring $header_end..
                             | split row -r '\n'
                             | each { str substring $ssid_head.. }
  let wifi_name = $scan_data | input list --fuzzy
                             | str substring 1..($ssid_tail - $ssid_head)
                             | str trim -r

  let pass_word = input $"Password for ($wifi_name):\t"

  nmcli d wifi connect $wifi_name password $pass_word
}

def nu-gc [] {
  let source = pwd
  let target = '/nix/var/nix/profiles/'

  cd $target

  let links = ls | where { |link| $link.name | str contains 'system-' } | skip 1 | drop 1
  let length = $links | length

  print $'($length) Items available for garbage collection:'
  print $links

  let prompt  = 'Input quantity to reserve:'
  let reserve = seq 0 $length | reverse | input list --fuzzy $prompt
  let remove  = $links | take ($length - $reserve)

  print 'Items marked for garbage collection:'
  print $remove

  let confirm = [no yes] | input list --fuzzy 'Confirm garbage collection:'
  if $confirm == yes {
    $remove | each { |link|
      sudo rm $link.name
    }
    nix-store --gc
  }

  cd $source
}

def memeshell [] {
  clear
  let meme_dir = '/home/v/.config/memeshell/'
  let meme_path = ls $meme_dir | shuffle | get name | get 0
  let meme_text = dotacat $meme_path
  print $meme_text
}
alias clear = memeshell

memeshell
