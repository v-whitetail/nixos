
alias :q = exit
alias cat = bat
alias vim = nvim ./
alias lf = yazi

alias cdnix = cd /home/v/crystalPeak/nixos
alias honix = man home-configuration.nix
alias manix = man configuration.nix

alias ssh-on = sudo systemctl start sshd.service
alias ssh-off = sudo systemctl start sshd.service

def write-rust-aoc [] {
  print "Session Name:\t"
  let session = input
  zellij -l write-rust-aoc -s $session
}

def write-rust [] {
  print "Session Name:\t"
  let session = input
  zellij -l write-rust -s $session
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

def bg-shuf [] {
  let bg_dir = '/home/v/Pictures/Wallpapers/'
  let bg_img = ls $bg_dir | shuf -n 1
  let bg_src = $bg_dir ++ $bg_img;

  cd /home/v/crystalPeak/nixos/
  cp -f $bg_src ./sddm-background.jpg
  cp -f $bg_src /home/v/.config/swaylock-bg.jpg
}

def nu-wifi [] {
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

def nu-gc [upper_bound: int] {
  let dir = pwd
  cd /nix/var/nix/profiles/
  let range = seq 2 $upper_bound
  let links = ls | $in
                 | split row -r "\n"
                 | split column -r " "
                 | get column1

  $links | each { |link_name|
    $range | each { |link_index|
      if ($link_name | str contains $"system-($link_index)-") {
        print $link_name
        break
      }
    }
  } | ignore

  print "Comfirm Delete? [yes/no]"
  let confirm = (input)

  match $confirm {
    "yes" => {
      $links | each { |link_name|
        $range | each { |link_index|
          if ($link_name | str contains $"system-($link_index)-") {
            sudo rm $link_name
          }
        }
      } | ignore
    }
    _ => { print "aborting garbage collector" }
  }
  cd $dir
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
