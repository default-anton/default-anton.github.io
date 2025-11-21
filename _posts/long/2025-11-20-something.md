---
title: "I Turned My Idle PC into a Linux Gaming Console"
date: 2025-11-19
tags: [linux, gaming, steamos]
published: false
---

When Valve announced the new Steam Machine, I was genuinely excited. I’m not an avid gamer myself. I built a solid PC thinking I would get back into gaming, but after playing through [The Witcher 3](https://www.thewitcher.com/us/en/witcher3) and [Space Marine 2](https://www.focus-entmt.com/en/games/warhammer-40000-space-marine-2), life happened, priorities changed, and the machine sat silent. But I have a son who is just old enough that we can start playing games together on a console.

The catch? I don't own a console. But I *do* have that idle PC collecting dust.

I immediately thought: maybe I can just install [SteamOS](https://store.steampowered.com/steamos) on it, like what powers the [Steam Deck](https://store.steampowered.com/steamdeck/) and the future [Steam Machine](https://store.steampowered.com/sale/steammachine). After a little digging, I found out the official SteamOS isn't something they make publicly available for installation on arbitrary hardware.

### The Need for Console Simplicity

The good news is that any Linux distribution can benefit from the kernel optimizations Valve baked into SteamOS. But that wasn't the point.

As someone who runs two Linux servers in my home lab, I actively did **not** want to deal with the inherent complexity of Linux when it comes to gaming, especially in the living room.

The goal was simple:

*I needed a distribution that functioned exactly like SteamOS.*

I wanted a PC that would boot directly into the full-screen Steam interface, requiring no password (I know, bad security, but it’s dedicated to gaming in my living room, so I don't care), and requiring zero terminal interaction. I just wanted to turn it on and play.

### The Search: Bazzite, ChimeraOS, and the "Ugly Website" Winner

I started researching. It turns out there are a few interesting solutions out there. The two primary ones that stood out were **Bazzite** and **ChimeraOS**.

*   [ChimeraOS](https://chimeraos.org/) aims to turn any PC into a gaming console. However, I found the website wasn't particularly useful, and their wiki is hosted on GitHub, which I find harder to navigate compared to standard documentation sites.
*   [Bazzite](https://bazzite.gg/) is a custom Fedora Atomic image optimized for smooth gaming on desktops and handhelds. It features a specific `bazzite-deck` variant for a console-like experience and receives frequent updates from upstream Fedora.

Bazzite, in particular, has a beautiful, stunning website. But frankly, the "immutable OS" approach felt like overkill for my needs. I haven't had much experience with atomic distributions, and I wasn't looking to learn a new paradigm. If something goes wrong on a gaming rig, I can just reinstall it in 20 minutes. I'm well-versed in standard Fedora, so sticking to a mutable, familiar base felt safer.

I also tend to be wary when a project feels *too* polished or tries to appeal to everyone. I often prefer software driven by a handful of opinionated maintainers who build exactly what they want to use.

Then there was **[Nobara](https://nobaraproject.org/)**.

The Nobara Project is an unofficial Fedora spin maintained by [GloriousEggroll](https://github.com/GloriousEggroll) (the developer behind [Proton-GE](https://github.com/GloriousEggroll/proton-ge-custom)). It comes pre-loaded with essential gaming tools like Steam, Lutris, OBS, and WINE dependencies, along with specific gaming optimizations baked right in. It even ships with NVIDIA drivers pre-configured if you choose the correct ISO.

Nobara stood out as probably the best option. The [wiki](https://wiki.nobaraproject.org/) was easy to read and navigable, which gave me confidence that if things broke, I could fix them.

The main website, however, looked honestly utilitarian - definitely made by engineers rather than designers. But to me, that's often a good sign. It suggests a project built by a true Linux user who cares more about the code than the marketing. The main point was a large, visible download button, a clear project overview, and the promise that it fixes most issues to offer a better gaming experience out of the box.

It is a solo project (one maintainer), which suggests a singular, focused vision. And based on the description, it did everything I ever wanted: **It basically turns your PC into a Linux gaming console**.

### The Installation

My setup is fairly modern but modest: it has an AMD Ryzen 5 5600 CPU, 16 GB of RAM, and an NVIDIA RTX 4060 GPU. It’s perfect for 1080p gaming, which is good enough for playing with my son on the TV.

The installation process was incredibly simple and quick.

- I downloaded [the ISO](https://nobaraproject.org/download-nobara/).
- I used [Balena Etcher](https://etcher.balena.io/) to burn it to a USB.
- I reinstalled it onto my PC.

The whole process probably took me 20 minutes.

![Nobara GRUB menu](/img/2025-11-20/nobara-grub-menu.png)

### The Console Experience

Once it booted, I was immediately greeted with the Steam interface. Fantastic.

I logged in. This was the only non-console part of the experience: I painfully entered my long Steam password using the controller. (In retrospect, I should have just connected a keyboard, but hey, I was trying to fully immerse myself in the controller experience).

After logging into Steam, all my games were immediately playable. Out of my modest library of seven games, six worked right away: *The Witcher 3*, the *Portal* games (1 and 2), and *Warhammer 40,000: Space Marine 2*. *GTA 5* was the only exception, but honestly, I don't care about that game anymore.

![Steam Library in Game Mode](/img/2025-11-20/htpc-steam-library.jpg)

I cannot express how shocked I was. Seven or eight years ago, trying to play games on Linux was impossible - nothing worked. Now, the experience is smooth and simple, and it just works.

We immediately installed [Sonic Racing](https://store.steampowered.com/app/212480/Sonic__AllStars_Racing_Transformed_Collection/) and [Moving Out](https://store.steampowered.com/app/996770/Moving_Out/), which were tons of fun. I’m now waiting for Black Friday to buy more games, including the [Untitled Goose Game](https://goose.game/).

### The One Glitch and the Upside of Low-Res 4K

Like any good piece of tech, it wasn't *entirely* flawless, but the issues were minor. I had one issue with Nobara: an extremely annoying, jumping, flickering interface *within* the Steam UI. The moment I turned on a game, the flickering stopped.

![Flickering Steam UI](/img/2025-11-20/htpc-steam-flickering.gif)

After some searching, I discovered the real issue was the interface scaling. I dialed it down a notch, and it stopped.

![Steam display scaling settings](/img/2025-11-20/htpc-display-scaling-flicker-fix.jpg)

The only other technical curiosity I had revolved around the display setup:

- My PC case is a chunky black tower that doesn't exactly blend with the living room decor, but my wife accepted it solely because it lacks flashy RGB lights.
- I play on a 4K TV.
- For some reason, the only resolution Nobara offered was 1080p.

I initially planned to spend time figuring out how to force at least 1440p resolution, because 1080p felt like "not enough" on a 4K screen. But then I started playing games, and sitting four or five feet away on the couch, **I couldn't even tell the difference**. The quality is perfect, and I see absolutely no problems playing in 1080p on a 4K TV.

Why should I care if it already looks good?

### Life in the Linux Console Era

The overall experience still feels surreal to me.

As a techie, the lack of a password at boot bothers me slightly, but I'm getting used to it since this machine is purely dedicated to Steam and games.

Upgrades are handled directly in the SteamOS interface, which is amazing - I don't need to do anything, I just hit "update" and it works. Since it's technically Fedora Linux underneath, I can occasionally switch to the desktop experience, connect a mouse and keyboard, and manually upgrade the system dependencies and packages. This doesn’t sound awful to me at all.

![My HTPC setup in the living room](/img/2025-11-20/htpc-living-room.jpg)

Honestly, this feels like the beginning of the end for Windows for personal use.

If you have an old gaming rig that you aren't using and you don't have a console, **it’s pretty easy. Just go do it**.

Good luck and have fun!
