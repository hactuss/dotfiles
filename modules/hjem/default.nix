{
  my-variables,
  ...
}: {
  hjem.users.${my-variables.username} = {
    directory = "/home/hactuss";
    files = {
    };
  };
}
