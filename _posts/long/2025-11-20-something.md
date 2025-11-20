---
title: "I Turned My Old PC into a Linux Gaming Console (And I Can’t Believe How Well It Works)"
date: 2025-11-19
tags: [linux, gaming, steamos]
published: false
---

When Valve announced the new Steam Machine, I was genuinely excited. I’m not an avid gamer myself - my days of playing [Witcher 3](https://www.thewitcher.com/us/en/witcher3) or [Warhammer 40K](https://www.focus-entmt.com/en/games/warhammer-40000-space-marine-2) are mostly behind me. But I have a son who is just old enough that we can start playing games together on a console.

The catch? I don't own a console. But I *do* have a dedicated gaming PC collecting dust.

I immediately thought: maybe I can just install [SteamOS](https://store.steampowered.com/steamos) on it, like what powers the [Steam Deck](https://store.steampowered.com/steamdeck/) and the future [Steam Machine](https://store.steampowered.com/sale/steammachine). After a little digging, I found out the official SteamOS isn't something they make publicly available for installation on arbitrary hardware.

### The Need for Console Simplicity

The good news is that any Linux distribution can benefit from the kernel optimizations Valve baked into SteamOS. But that wasn't the point.

As someone who runs two Linux servers in my home lab, I actively did **not** want to deal with the inherent complexity of Linux when it comes to gaming, especially in the living room.

The goal was simple:

**I needed a distribution that functioned exactly like SteamOS**.

I wanted a PC that would boot directly into the full-screen Steam interface, requiring no password (I know, bad security, but it’s dedicated to gaming in my living room, so I don't care), and requiring zero terminal interaction. I just wanted to turn it on and play.

### The Search: Bazzite, ChimeraOS, and the "Ugly Website" Winner

I started researching. It turns out there are a few interesting solutions out there. The two primary ones that stood out were **Bazzite** and **ChimeraOS**.

*   **ChimeraOS** is specifically aimed at instantly turning any PC into a gaming console, supporting thousands of games and platforms with a fully controller-compatible interface and automatic, non-intrusive updates.
*   **Bazzite** is a custom Fedora Atomic image designed to make gaming smoother and simpler across desktop PCs, handhelds, and home theater PCs (HTPCs). They even have a specific `bazzite-deck` variant optimized for a console-like experience, booting directly to Game mode. Bazzite is also updated multiple times a week with packages from upstream Fedora, addressing common issues like out-of-date packages that plagued SteamOS.

Bazzite, in particular, had a beautiful, stunning website. And as a person who's been using Linux for a while, I know that sometimes a beautiful website is a red flag for actual functionality.

Then there was **Nobara**.

The Nobara Project is a modified version of Fedora Linux that adds user-friendly fixes to address things typically absent from a fresh Fedora install, especially for gaming, such as WINE dependencies, 3rd party codecs, and NVIDIA drivers.

Nobara stood out as probably the best option. The website looked honestly terrible - definitely made by amateurs or someone who doesn't know front-end design at all. But the main point was a large, visible download button, a clear project overview, and the promise that it fixes most issues to offer a better gaming experience out of the box.

It looked like it had a single maintainer or maybe just a couple of contributors, which suggests focus. And based on the description, it did everything I ever wanted: **It basically turns your PC into a Linux gaming console**.

### The Installation

My setup isn't a powerhouse, but it's capable: it has an AMD 5600 CPU, 16 gigabytes of RAM, and an Nvidia 4060 GPU. It’s more than enough for 1080P gaming, which is good enough for playing with my son on the TV.

The installation process was incredibly simple and quick.

- I downloaded the ISO.
- I used Balena Etcher to burn it to a USB (I did waste 15 minutes trying to find my old USB stick, since it had been a while since I reinstalled Linux).
- I reinstalled it onto my PC.

The whole process probably took me 20 minutes.

***[Placeholder for a photo of the USB drive with the Nobara logo burned onto it]***

### The Console Experience

Once it booted, I was immediately greeted with the Steam interface. Fantastic.

I logged in. This was the only non-console part of the experience: I painfully entered my long Steam password using the joystick. (In retrospect, I should have just connected a keyboard, but hey, I was trying to fully immerse myself in the controller experience).

After logging into Steam, all my games were immediately playable. Out of my modest library of seven games, six worked right away: *Witcher 3*, the *Portal* games (1 and 2), and *Warhammer 40K*. *GTA 5* was the only exception, but honestly, I don't care about that game anymore.

I cannot express how shocked I was. Seven or eight years ago, trying to play games on Linux was impossible - nothing worked. Now, the experience is smooth and simple, and it just works.

We immediately installed [Sonic Racing](https://store.steampowered.com/app/212480/Sonic__AllStars_Racing_Transformed_Collection/) and [Moving Out](https://store.steampowered.com/app/996770/Moving_Out/), which were tons of fun. I’m now waiting for Black Friday to buy more games, including the [Untitled Goose Game](https://goose.game/).

***[Placeholder for a screenshot of the Steam Library in Game Mode]***

### The One Glitch and the Upside of Low-Res 4K

Like any good piece of tech, it wasn't *entirely* flawless, but the issues were minor. I had one issue with Nobara: an extremely annoying, jumping, flickering interface *within* the Steam UI. The moment I turned on a game, the flickering stopped.

After some searching, I discovered the real issue was the interface scaling. I dialed it down a notch, and it stopped.

The only other technical curiosity I had revolved around the display setup:

- My PC case is chunky and doesn't look particularly pretty in the living room. My wife approved of the ugly black case because it doesn't have flashy RGB lights.
- I play on a 4K TV.
- For some reason, the only resolution Nobara offered was 1080P.

I initially planned to spend time figuring out how to force at least 2K resolution, because 1080P felt like "not enough" on a 4K screen. But then I started playing games, and sitting four or five feet away on the couch, **I couldn't even tell the difference**. The quality is perfect, and I see absolutely no problems playing 1080P on a 4K TV.

Why should I care if it already looks good?

### Life in the Linux Console Era

The overall experience still feels surreal to me.

As a techie, the lack of a password at boot bothers me slightly, but I'm getting used to it since this machine is purely dedicated to Steam and games.

Upgrades are handled directly in the SteamOS interface, which is amazing - I don't need to do anything, I just hit "update" and it works. Since it's technically Fedora Linux underneath, I can occasionally switch to the desktop experience, connect a mouse and keyboard, and manually upgrade the system dependencies and packages. This doesn’t sound awful to me at all.

***[Placeholder for a photo of the full living room setup, showing the PC next to the TV]***

Honestly, this feels like the beginning of the end for Windows for personal use.

If you have an old gaming rig that you aren't using and you don't have a console, **it’s pretty easy. Just go do it**.

Good luck and have fun!
