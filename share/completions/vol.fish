function __vol_generate_args --description 'Function to generate args'
  set --local current_token (commandline --current-token --cut-at-cursor)
  switch $current_token
    case '/*'
      echo -e '/?\tShow help'
    case "*"
      wmic logicaldisk get name | tail --lines +2
  end
end

complete --command vol --no-files --arguments '(__vol_generate_args)'