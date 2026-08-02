{ ... }:

{
  # gotop has no home-manager program module, so write its config files directly.
  # gotop searches ~/.config/gotop for both the config file and loadable colorschemes.

  # Custom colorscheme: identical to the built-in "default" except the swap line.
  # The memory widget colors each line from `memlines`; index 0 is main memory and
  # index 1 is swap. The default swap color (ANSI 11) was rendering near-black, so it
  # is set to 256-color 208 (orange), which terminal ANSI palettes don't remap.
  xdg.configFile."gotop/mytheme.json".text = builtins.toJSON {
    name = "mytheme";
    author = "dustinm";
    fg = 7;
    bg = -1;
    borderlabel = 7;
    borderline = 6;
    cpulines = [
      4
      3
      2
      1
      5
      6
      7
      8
    ];
    battlines = [
      4
      3
      2
      1
      5
      6
      7
      8
    ];
    memlines = [
      5
      208
      4
      3
      2
      1
      6
      7
      8
    ]; # index 1 (swap) = 208 orange
    proccursor = 4;
    sparklines = [
      4
      5
    ];
    diskbar = 7;
    templow = 2;
    temphigh = 1;
  };

  # Select the colorscheme so plain `gotop` (no -c flag) uses it.
  xdg.configFile."gotop/gotop.conf".text = ''
    colorscheme=mytheme
  '';
}
