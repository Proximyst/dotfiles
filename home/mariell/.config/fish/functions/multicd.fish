function multicd
  set -l length (math (string length -- $argv) - 1)
  echo cd (string repeat -n $length ../)
end
