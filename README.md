## Build (stanio)

This fork uses alternative to the official Bibata_Cursor
[build tools](https://github.com/stanio/stanio-misc/releases/tag/mousegen-0.3)
that should provide somewhat better quality results.  The build requires
[Java](https://adoptium.net/) 11 or later on your executable `PATH`.  On first
run it will download a released `mousegen` executable.

A notable difference with the official Bibata_Cursor is this build requires
the cursor hostpost embedded into the individual source SVG files, as seen in
this fork, rather than maintained separately in `configs/**.build.toml` files:

```xml
  <circle id="cursor-hotstop" cx="..." cy="..." />
```

Better quality results are achieved by rasterizing the source SVGs at each
individual resolution, and employing pixel-grid alignment hints embedded into
the sources:

```xml
  <path id="align-anchor" d="m #,# ..." />

  <g>
    <path class="align-anchor" d="m #,# ..." />
```

For my releases I have two scripts with specific configurations:

```
$ ./mousegen-windows
$ ./mousegen-linux
```

For building customized versions of the cursors see `mousegen-render` further.

### `mousegen-render` – Basic options

Get a rough overview of the available options:

```sh
$ ./mousegen-render --help
```

The default output directory is `themes/`, and without options given, it would
render just PNG bitmaps at their default size/resolution (256×256).  Customize
the build output directory via `--build-dir <dir>`.

To render either Linux (X) or Windows cursors specify `--linux-cursors` or
`--windows-cursors` option:

```sh
$ ./mousegen-render --windows-cursors
$ ./mousegen-render --linux-cursors
```

Both can't be effective at the same time, currently.

### Filtering cursors to render

To render a few selected cursors – specify them with `-f <cursor>` options:

```sh
$ ./mousegen-render ... -f left_ptr -f left_ptr_watch -f xterm
```

The `<cursor>` name is the original file name without the `.svg` suffix.

Note, the specified filter applies on top of `--windows-cursors` or
`--linux-cursors` name mapping in effect:

```sh
$ ./mousegen-render --windows-cursors -f left_side
```

will not render any cursor, unless you specify `--all-cursors` option:

```sh
$ ./mousegen-render --windows-cursors --all-cursors -f left_side
$ ./mousegen-render --windows-cursors --all-cursors # render all
```

### Customizing the resolutions/sizes

The default resolutions currently are:

-   Windows: 32, 48, 64, 72, 96, 128
-   Linux: 24, 32, 48, 64, 72, 96

Customize the output resolutions using `-r` option(s):

```sh
$ ./mousegen-render -r 32,48,64
```

`--windows-cursors` also implies three (canvas) sizing-schemes: Normal, Large,
and  Extra-Large (N, L, XL).  Customize the sizing schemes via `-s` option(s).
The following will output only Normal and Large variants:

```sh
$ ./mousegen-render -s N,L
```

To reset to just the original sizing use `-s SOURCE` – that's equivalent to
Extra-Large (full canvas) but doesn't change the theme name to reflect that.

### Customizing the color

```sh
$ ./mousegen-render --color Ice,Turquoise
```

Find and customize the color mappings in `colors.jsonc`.

### Customizing the pointer shadow

The cursors don't have a shadow by default (I've also removed all shadows from
the original sources).  To get cursors with shadow use `--pointer-shadow`:

```sh
$ ./mousegen-render --pointer-shadow
```

The full syntax is:

    --pointer-shadow[=<blur>[,<dx>[,<dy>[,<opacity>[,#<color>]]]]]

The default values are:

    --pointer-shadow=6,18,9,0.3,#000000

To render both variants: with and without shadow, add `--no-shadow-also`:

    --pointer-shadow --no-shadow-also

## Customizing the stroke thickness

    --thin-stroke
    --stroke-width=12
    --stroke-width=6:Hairline
    --base-stroke-width=16
    --min-stroke-width=0.9
    --whole-pixel-stroke
    --expand-fill=4
    --default-stroke-also

## `--all-variants` shorthand

Shorthand for `--default-stroke-also` and `--no-shadow-also`:

    --thin-stroke --pointer-shadow --all-variants

Note, if `--color` is specified `--all-variants` doesn't include a default
(unchanged) color variant.  Have a _Default_ empty color map in `colors.json`:

```jsonc
{
  "Default": {},
  "White": {
    ...
  },
  ...
}
```

and specify it explicitly:

    --color Default,White

---

## ⚠️ Notice: Final Major Version v2.x.x

I've launched the successor to this project at https://www.github.com/ful1e5/bibata for **downloading and personalizing Bibata**, now the main source for new features. I recommend downloading from there. This repository is still maintained for [Linux packages](#packages).

-   Available at: https://www.bibata.live
-   Development Preview: https://dev.bibata.live

## 💖 Support Bibata's Future

Your sponsorship is crucial for Bibata's ongoing success. A **$1** contribution helps maintain servers for **24/7 accessibility**. With your support, I can upgrade to high-performance AWS servers, improving user experience. Sponsors also enjoy exclusive premium features for a more rewarding engagement.

# Bibata Cursor

[![build](https://github.com/ful1e5/Bibata_Cursor/actions/workflows/build.yml/badge.svg)](https://github.com/ful1e5/Bibata_Cursor/actions/workflows/build.yml)

TLDR; This cursor set is a masterpiece of cursors available on the internet,
hand-designed by [Abdulkaiz Khatri](https://twitter.com/ful1e5).

Bibata is an open source, compact, and material designed cursor set that aims
to improve the cursor experience for users. It is one of the most popular cursor sets
in the Linux community and is now available for free on Windows as well, with multiple color
and size options. Its goal is to offer personalized cursors to users.

#### What does "Bibata" mean?

The sweetest word I ever spoke was "BI-Buh," which, coincidentally, is also the word for peanuts.
To make it more pronounceable and not sound like a baby's words, I added the suffix "Ta."
And with that, my journey in the world of open source began.

## Notes

-   All cursor's SVG files are found in [svg](./svg) directory or you can also find them on
    [Figma](https://www.figma.com/file/Y9RKZLXhSvaxpUzsKGJkp6/Bibata-Cursor?node-id=0%3A1).

-   This repository is now synchronized with the [bibata](https://www.bibata.live) project,
    which has become the new mainstream for acquiring new features and updates.
    I recommend downloading from there. However, this repository is still periodically maintained
    to ensure its relevance and usability for [linux packages](#packages).

<!-- If you're interested, you can learn more about "sponsor-spotlight" on
 https://dev.to/ful1e5/lets-give-recognition-to-those-supporting-our-work-on-github-sponsors-b00 -->

![shoutout-sponsors](https://sponsor-spotlight.vercel.app/sponsor?login=ful1e5)

-   **2024-06-14**: [4460d91](https://github.com/ful1e5/Bibata_Cursor/commit/4460d9118dce220d606c38308b93181861b8a85a) Partitioned cursor build configuration into multiple files according to platform:
    -   `build.toml`
        -   `configs/normal/x.build.toml`
        -   `configs/normal/win_xl.build.toml`
        -   `configs/normal/win_rg.build.toml`
        -   `configs/normal/win_lg.build.toml`
    -   `build.right.toml`
        -   `configs/right/x.build.toml`
        -   `configs/right/win_xl.build.toml`
        -   `configs/right/win_rg.build.toml`
        -   `configs/right/win_lg.build.toml`

---

![Bibata Amber](https://github.com/ful1e5/Bibata_Cursor/assets/24286590/d64d75e5-3ac9-45f3-8afe-e92719fd48d1)
![Bibata Classic](https://github.com/ful1e5/Bibata_Cursor/assets/24286590/04df0fbe-36fc-47bd-ad0a-c70eaea871f3)
![Bibata Ice](https://github.com/ful1e5/Bibata_Cursor/assets/24286590/56e7e67a-cf77-407c-871c-f663a93508f7)

---

![Bibata Amber Right](https://github.com/ful1e5/Bibata_Cursor/assets/24286590/204a036a-796d-4277-85d2-30b7fb2449f2)
![Bibata Classic Right](https://github.com/ful1e5/Bibata_Cursor/assets/24286590/fb4cac21-e8a8-46e9-9ce2-688f35bbcbaa)
![Bibata Ice Right](https://github.com/ful1e5/Bibata_Cursor/assets/24286590/c64f45d6-cd8d-46e6-8386-e2f3b7012db7)

## Variants:

-   Normal
    -   **Bibata Original Amber:** Yellowish and sharp edge bibata cursors.
    -   **Bibata Modern Amber:** Yellowish and rounded edge bibata cursors.
    -   **Bibata Original Classic:** Black and sharp edge bibata cursors.
    -   **Bibata Modern Classic:** Black and rounded edge bibata cursors.
    -   **Bibata Original Ice:** White and sharp edge bibata cursors.
    -   **Bibata Modern Ice:** White and rounded edge bibata cursors.
-   Right Hand
    -   **Bibata Original Amber Right:** Yellowish and sharp edge right-hand bibata cursors.
    -   **Bibata Modern Amber Right:** Yellowish and rounded edge right-hand bibata cursors.
    -   **Bibata Original Classic Right:** Black and sharp edge right-hand bibata cursors.
    -   **Bibata Modern Classic Right:** Black and rounded edge right-hand bibata cursors.
    -   **Bibata Original Ice Right:** White and sharp edge right-hand bibata cursors.
    -   **Bibata Modern Ice Right:** White and rounded edge right-hand bibata cursors.

## Cursor Sizes

### Xcursor Sizes:

<kbd>16</kbd>
<kbd>20</kbd>
<kbd>22</kbd>
<kbd>24</kbd>
<kbd>28</kbd>
<kbd>32</kbd>
<kbd>40</kbd>
<kbd>48</kbd>
<kbd>56</kbd>
<kbd>64</kbd>
<kbd>72</kbd>
<kbd>80</kbd>
<kbd>88</kbd>
<kbd>96</kbd>

### Windows Cursor Size:

-   <kbd>16x16</kbd> - Small
-   <kbd>24x24</kbd> - Regular
-   <kbd>32x32</kbd> - Large
-   <kbd>48x48</kbd> - Extra Large

## Colors:

### Bibata Amber

-   Base Color - `#FF8300` (Amber)
-   Outline Color - `#FFFFFF` (White)
-   Watch Background Color - `#001524` (Rich Black)

### Bibata Classic

-   Base Color - `#000000` (Black)
-   Outline Color - `#FFFFFF` (White)
-   Watch Background Color - `#000000` (Black)

### Bibata Ice

-   Base Color - `#FFFFFF` (White)
-   Outline Color - `#000000` (Black)
-   Watch Background Color - `#FFFFFF` (White)

## How to get it

### Easiest Way

You can download latest `stable` & `development` releases from [bibata.live](https://bibata.live) or on
[Release Page](https://github.com/ful1e5/Bibata_Cursor/releases).

### Packages

> **Note**
> If you're having trouble with the packages please submit a request to the package maintainer
> before creating an issue.

#### Arch Linux/Manjaro

##### AUR @yochananmarqos

```bash
paru -S bibata-cursor-theme-bin # (recommended)
paru -S bibata-cursor-theme
```

Or [PKGBUILD](https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=bibata-cursor-theme)

#### Fedora

##### copr-repo by @peterwu (recommended)

```bash
sudo dnf copr enable peterwu/rendezvous
sudo dnf install bibata-cursor-themes
```

##### copr-repo by @muhalantabli

```bash
sudo dnf copr enable muhalantabli/copr-repo
sudo dnf install bibata-cursor-theme
```

## Installing Bibata Cursor

#### Linux X11/Wayland

**Installation:**

```bash
tar -xvf Bibata.tar.gz                # extract `Bibata.tar.gz`
mv Bibata-* ~/.local/share/icons/     # Install to local users
sudo mv Bibata-* /usr/share/icons/    # Install to all users
```

**Uninstallation:**

```bash
rm ~/.local/share/icons/Bibata-*      # Remove from local users
sudo rm /usr/share/icons/Bibata-*     # Remove from all users
```

#### Windows

**Installation:**

1. Unzip `.zip` file
2. Open unziped directory in Explorer, and **right click** on `install.inf`.
3. Click 'Install' from the context menu, and authorize the modifications to your system.
4. Open Control Panel > Personalization and Appearance > Change mouse pointers,
   and select **Bibata Cursors**.
5. Click '**Apply**'.

**Uninstallation:**

Run the `uninstall.bat` script packed with the `.zip` archive

**OR** follow these steps:

1. Go to **Registry Editor** by typing the same in the _start search box_.
2. Expand `HKEY_CURRENT_USER` folder and expand `Control Panel` folder.
3. Go to `Cursors` folder and click on `Schemes` folder - all the available custom cursors that are
   installed will be listed here.
4. **Right Click** on the name of cursor file you want to uninstall; for eg.: _Bibata Cursors_ and
   click `Delete`.
5. Click '**yes**' when prompted.

## Build From Source

### Prerequisites

-   Python version 3.7 or higher
-   [clickgen](https://github.com/ful1e5/clickgen)>=2.1.8 (`pip install clickgen`)
-   [yarn](https://github.com/yarnpkg/yarn)

### Quick start

1. Install [build prerequisites](#prerequisites) on your system
2. `git clone https://github.com/ful1e5/Bibata_Cursor`
3. `cd Bibata_Cursor`
4. `yarn install`
5. `yarn generate`
6. See [Installing Bibata Cursor](#installing-bibata-cursor).

### Getting Started

Once you have the [build prerequisites](#prerequisites) installed, You can personalize colors,
customize sizes, change target platforms, and more. This process involves using external tools,
as this repository only contains SVG files and configuration for these tools:

-   [cbmp](https://github.com/ful1e5/cbmp): Used for customizing colors and generating PNG files.
-   [ctgen](https://github.com/ful1e5/clickgen): Used for customizing sizes and building XCursor and Windows Cursors.

You can refer to the README of each tool for more information on their command-line options.

#### Crafting Your Bibata

[https://bibata.live](https://bibata.live) simplifies the personalization of cursor themes, making it easy and accessible for users.
With bibata, you can enhance your cursor experience effortlessly. Best of all, it's available for free, allowing you to
enjoy a customized bibata cursor theme tailored to your preferences.

The process of creating custom cursor themes involves two main steps:

1. Rendering SVG files to PNG files.
2. Building cursor themes from PNG files.

#### Customize Colors

`cbmp` provides three options for changing colors:

1. `-bc`: Base color, which replaces the `#00FF00` color in the SVG.
2. `-oc`: Outlined color, which replaces the `#0000FF` color in the SVG.
3. `-wc` (optional): Watch Background color, which replaces the `#FF0000` color in the SVG.

```bash
npx cbmp [...] -bc '<hex>' -oc '<hex>' -wc '<hex>'
```

Alternatively, you can provide a JSON configuration file to render SVG files, which contains a sequence of `cbmp` commands:

```bash
npx cbmp render.json
```

#### Customize Sizes

##### Customize Windows Cursor size

To build Windows cursor with size `16`:

```bash
ctgen build.toml -s 16 -p windows -d 'bitmaps/Bibata-Modern-Ice' -n 'Bibata-Modern-Ice' -c 'White and rounded egde bibata cusors with size 16'
```

You can also customize output directory with `-o` option:

```bash
ctgen build.toml -s 16 -p windows -d 'bitmaps/Bibata-Modern-Ice' -o 'out' -n 'Bibata-Modern-Ice' -c 'White and rounded egde Bibata cursors with size 16'
```

##### Customize XCursor size

To build XCursor with size `16`:

```bash
ctgen build.toml -s 16 -p x11 -d 'bitmaps/Bibata-Modern-Ice' -n 'Bibata-Modern-Ice' -c 'White and rounded egde Bibata cursors with size 16'
```

You can also assign multiple sizes to `ctgen` for XCursors build:

```bash
ctgen build.toml -s 16 18 24 32 -p x11 -d 'bitmaps/Bibata-Modern-Ice' -n 'Bibata-Modern-Ice' -c 'Custom white and rounded egde Bibata cursors'
```

#### Examples

Lets generate Bibata-Modern with green and black colors:

```bash
npx cbmp -d 'svg/modern' -o 'bitmaps/Bibata-Hacker' -bc '#00FE00' -oc '#000000'
```

After rendering custom color you have to build cursor through `ctgen`:

```bash
ctgen build.toml -d 'bitmaps/Bibata-Hacker' -n 'Bibata-Hacker' -c 'Green and Black Bibata cursors.'
```

Afterwards, Generated theme can be found in the `themes` directory.

###### Bibata Gruvbox

```bash
npx cbmp -d 'svg/original' -o 'bitmaps/Bibata-Gruvbox' -bc '#282828' -oc '#EBDBB2' -wc '#000000'
ctgen build.toml -d 'bitmaps/Bibata-Gruvbox' -n 'Bibata-Gruvbox' -c 'Groovy Bibata cursors.'
```

###### Bibata Solarized Dark

```bash
npx cbmp -d 'svg/original' -o 'bitmaps/Bibata-Solarized-Dark' -bc '#002b36' -oc '#839496' -wc '#000000'
ctgen build.toml -d 'bitmaps/Bibata-Solarized-Dark' -n 'Bibata-Solarized-Dark' -c 'Solarized Dark Bibata cursors.'
```

###### Bibata Solarized Light

```bash
npx cbmp -d 'svg/original' -o 'bitmaps/Bibata-Solarized-Light' -bc '#839496' -oc '#002b36'
ctgen build.toml -d 'bitmaps/Bibata-Solarized-Light' -n 'Bibata-Solarized-Light' -c 'Solarized Light Bibata cursors.'
```

###### Bibata Dracula

```bash
npx cbmp -d 'svg/original' -o 'bitmaas/Bibata-Dracula' -bc '#282a36' -oc '#f8f8f2'
ctgen build.toml -d 'bitmaps/Bibata-Dracula' -n 'Bibata-Dracula' -c 'Dracula Bibata cursors.'
```

## You may also like...

-   [**Bibata**](https://bibata.live) - The place where Bibata's cursor gets personalized.
-   [**Bibata Adapta**](https://gitlab.com/cscs/Bibata_AdaptaBreath_Cursors) - Bibata Based Cursor Made for AdaptaBreath and Manjaro.
-   [**Bibata Translucent**](https://github.com/Silicasandwhich/Bibata_Cursor_Translucent) - Bibata translucent is a translucent flavor of the Bibata.

## Testing Cursor

There are several websites that allow you to test your cursor states by hovering over buttons. This can be very useful when developing or verifying the behavior of a cursor. The following websites cover many of the most commonly used cursors, although they may not include all available options.

-   [Cursor-Test](https://vibhorjaiswal.github.io/Cursor-Test/)
-   [Mozilla CSS Cursor](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor)

For a blueprint for creating XCursors, you may also want to refer to [Cursor-demo](https://wiki.tcl-lang.org/page/Cursor+demo).

## Credit

[Wedge Loading Animation](https://loading.io/spinner/wedges/-pie-wedge-pizza-circle-round-rotate) ·
[Adwaita](https://github.com/GNOME/adwaita-icon-theme) ·
[Dmz](https://github.com/GalliumOS/dmz-cursor-theme) ·
[Yaru](https://github.com/ubuntu/yaru)
