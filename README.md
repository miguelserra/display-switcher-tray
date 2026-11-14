# Display Switcher Tray

A small GNOME tray app to enable or disable monitors with one click, made for
setups where several computers share monitors through a KVM switch and the
monitors do not follow the keyboard/mouse switch.

The app talks directly to Mutter (`org.gnome.Mutter.DisplayConfig` over D-Bus),
so it works on **GNOME on Wayland** without `xrandr`.

## Features

- Detects connected monitors automatically (vendor, model and connector).
- Presets: **use all monitors** and **primary monitor only**.
- One toggle per monitor to enable/disable it individually.
- **15-second confirmation dialog** with "Keep" / "Revert"; if it is closed or
  the timer expires, the previous layout is restored automatically.
- Remembers position, scale and primary flag per connector in
  `~/.config/display-switcher/config.json`.
- Reacts to external monitor changes via the Mutter `MonitorsChanged` signal.

## Requirements

- Fedora Workstation (or another GNOME desktop) with GNOME 45+ on Wayland.
  Tested on Fedora 45 with GNOME Shell 51.1.
- Python GObject bindings and GTK 3.
- AppIndicator/KStatusNotifierItem support extension for the tray icon.

On Fedora:

```bash
sudo dnf install python3-gobject gtk3 gnome-shell-extension-appindicator
```

## Install

```bash
git clone https://github.com/miguelserra/display-switcher-tray.git
cd display-switcher-tray
./install.sh
```

`install.sh` copies the app to `~/.local/bin`, adds a desktop entry and sets it
up to start automatically with the session (remove
`~/.config/autostart/display-switcher.desktop` to disable autostart).

Start it right away with:

```bash
display-switcher-tray &
```

or open **Display Switcher Tray** from the app grid.

## Usage

Click the tray icon:

- **Ligar Todos os Ecrãs** – enable every connected monitor.
- **Apenas Ecrã Principal** – keep only the primary monitor.
- Each monitor entry toggles that output on or off.
- **Definições do Sistema...** – opens the GNOME display settings.
- **Sair** – quits the app.

At least one monitor is always kept enabled. After every change a dialog asks
you to confirm; if you do not answer within 15 seconds, the previous
configuration is restored.

## How it works

The app uses the `GetCurrentState` and `ApplyMonitorsConfig` methods of
`org.gnome.Mutter.DisplayConfig`. Logical monitors are packed horizontally in
the order of their saved `x` position, and exactly one primary monitor is sent
in each configuration.

Configuration is stored in `~/.config/display-switcher/config.json`:

```json
{
  "DP-1": { "x": 3072, "y": 0, "scale": 1.0, "primary": false },
  "DP-2": { "x": 0, "y": 0, "scale": 1.25, "primary": true }
}
```

## Notes

- Disabling an output releases the monitor on this computer; the monitor itself
  may need its input source changed (or auto-source enabled) to show another
  computer. Tools such as `ddcutil` can switch monitor inputs.
- Monitor input switching via DDC/CI is out of scope for this app.

## License

MIT
