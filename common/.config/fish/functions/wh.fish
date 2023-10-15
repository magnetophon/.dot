
# NixOS: get the link to a binary
function wh
  command which $argv
  command readlink $(command which $argv)
end
