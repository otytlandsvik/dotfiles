# My Personal Home Configuration using Nix home-manager

This is my personal home configuration using home-manager as a standalone util. Its structure is an attempt at a modular and flexible design and is intended to be used both standalone on non-nixos systems and along with NixOS system configs like [my NixOS config](https://github.com/otytlandsvik/nixos-config) (also as a standalone non-root tool).
The structure is inspired by [EmergentMind's config](https://github.com/EmergentMind/nix-config) as well as a heap of others. It currently only configures one user and host, but is structured such that more can be added in the future with varying configs as needed.

**This config**:

- Uses flakes
- Uses the 24.11 branch
- Is meant to be used both on NixOS with a separate system config, and on non-nixos systems

## Bootstrapping

As a reminder to myself and as a resource to anyone seeking inspiration, here is the bootstrapping process:

1. Move to the location you want your config to live (I put mine in `~/dotfiles`)
2. Clone this repository:
   ```sh
   $ git clone git@github.com:otytlandsvik/dotfiles.git
   ```
3. Make your desired modifications to `home.nix` (opt in or out of any optional modules, or change the entire config if you like)
4. Remember to change the output target in `flake.nix` to reflect your username and point to the correct nix file
5. Install [the home-manager standalone tool](https://nix-community.github.io/home-manager/) using Nix (the package manager):

   ```sh
   $ nix-shell -p home-manager
   ```

   Or, on NixOS you can also make it available as a system package:

   ```nix
   environment.systemPackages = [
     pkgs.home-manager
   ];
   ```

   Or, on NixOS you can also make this package explicitly available to your user:

   ```nix
   users.users."username" = {

     ...

     packages = [ pkgs.home-manager ];
   };
   ```

   **After bootstrapping, home-manager will install and manage itself.** That's why it's sufficient to run it in a nix-shell.

6. Build the config using home-manager (as an example, if `username@host` was added as a flake output):
   ```sh
   $ home-manager switch --flake .#username@host
   ```

> [!NOTE]
> The `.` here evaluates to the cwd. It must be a path to the directory containing `flake.nix`

#### Now your dotfiles are managed by home-manager!

Test it by running one of the programs configured, like `nvim`.
