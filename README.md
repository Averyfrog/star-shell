<h1 align="center"> star-shell </h1>

![image](https://github.com/user-attachments/assets/29427224-a5dd-478b-a7ee-9301bbedd2a1)

<img src="https://github.com/user-attachments/assets/342cda88-72a4-4b7a-b667-4bf32667d9fe" alt="music" width="250"/>


###### In Early Development
**A Hyprland shell aimed to work best with NixOS**

If you have any suggestions, please open an issue.

## Installation
Add 
```nix
star-shell = {
  url = "github:averyfrog/star-shell";
};
```
to your flake inputs.

Next, add
```nix
inputs.star-shell.packages.${system}.default
```
to your `environment.systemPackages`.

Finally, use your preferred method to run `star-shell` on startup.
