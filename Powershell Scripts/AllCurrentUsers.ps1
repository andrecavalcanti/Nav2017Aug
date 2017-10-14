if (!(test-path $profile.AllUsersCurrentHost))
{new-item -type file -path $profile.AllUsersCurrentHost -force}
psEdit $profile.AllUsersCurrentHost