# Credits
This text is from [Nicola Paolucci](https://twitter.com/durdn), at [Atlassian](https://www.atlassian.com/git/tutorials/dotfiles). Kudos to him and to StreakyCobra.

# The best way to store your dotfiles: A bare Git repository

The technique consists in storing a [Git bare
repository](http://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/) in
a "*side*" folder (like `$HOME/.cfg` or `$HOME/.myconfig`) using a
specially crafted alias so that commands are run against that repository
and not the usual `.git` local folder, which would interfere with any
other Git repositories around.

## Starting from scratch

If you haven't been tracking your configurations in a Git repository
before, you can start using this technique easily with these lines:

```sh
git init --bare $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

- The first line creates a folder `~/.cfg` which is a [Git bare
repository](http://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/) that
will track our files.
- Then we create an alias `config` which we will use instead of the
regular `git` when we want to interact with our configuration
repository.
- We set a flag - local to the repository - to hide files we are not
explicitly tracking yet. This is so that when you type `config
status` and other commands later, files you are not interested in
tracking will not show up as `untracked`.
- Also you can add the alias definition by hand to your `.bashrc` or
use the the fourth line provided for convenience.

After you've executed the setup any file within the `$HOME` folder can
be versioned with normal commands, replacing `git` with your newly
created `config` alias, like:

```sh
config status
config add .vimrc
config commit -m "Add vimrc"
config add .bashrc
config commit -m "Add bashrc"
config push
```

## Install your dotfiles onto a new system (or migrate to this setup)

If you already store your configuration/dotfiles in a [Git
repository](/git), on a new system you can migrate to this setup with
the following steps:

- Prior to the installation make sure you have committed the alias to
your `.bashrc` or `.zsh`:

```sh
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

- And that your source repository ignores the folder where you'll
clone it, so that you don't create weird recursion problems:

```sh
echo ".cfg" >> .gitignore
```

- Now clone your dotfiles into
a [bare](http://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/) repository
in a "*dot*" folder of your `$HOME`:

```sh
git clone --bare <git-repo-url> $HOME/.cfg
```

- Define the alias in the current shell scope:

```sh
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

- Checkout the actual content from the bare repository to
your `$HOME`:

```sh
config checkout
```

- The step above might fail with a message like:

```
error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
    .gitignore
Please move or remove them before you can switch branches.
Aborting
```

This is because your `$HOME` folder might already have some stock
configuration files which would be overwritten by Git. The solution is
simple: back up the files if you care about them, remove them if you
don't care. I provide you with a possible rough shortcut to move all the
offending files automatically to a backup folder:

```sh
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```

- Re-run the check out if you had problems:

```sh
config checkout
```

- Set the flag `showUntrackedFiles` to `no` on this specific (local)
repository:

```sh
config config --local status.showUntrackedFiles no
```

- You're done, from now on you can now type `config` commands to add
and update your dotfiles:

```sh
config status
config add .vimrc
config commit -m "Add vimrc"
config add .bashrc
config commit -m "Add bashrc"
config push
```
