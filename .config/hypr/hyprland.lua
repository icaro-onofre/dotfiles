-- Hyprland config, migrated from hyprland.conf to the Lua format (Hyprland 0.55+)
-- Wiki: https://wiki.hypr.land/configuring/


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/configuring/core/monitors/
-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@144", position = "0x0", scale = "1", transform = 0 })
-- hl.monitor({ output = "DP-1", mode = "1920x1080@60", position = "0x0", scale = "1", transform = 0 })
hl.monitor({ output = "HDMI-A-2", mode = "1920x1080@144.00Hz", position = "0x0", scale = "1", transform = 0 })
-- hl.monitor({ output = "HDMI-A-2", mode = "1440x900@60.00", position = "0x0", scale = "1", transform = 0 })
-- hl.monitor({ output = "HDMI-A-2", mode = "1024x768@60.00", position = "0x0", scale = "1", transform = 0 })

-- Setup que eu utilizo em BH
-- hl.monitor({ output = "VGA-1", mode = "1440x900@60.00", position = "0x0", scale = "1", transform = 0 })
-- hl.monitor({ output = "VGA-1", mode = "1440x900@60.02", position = "0x0", scale = "1", transform = 0 })
-- hl.monitor({ output = "VGA-1", mode = "1024x768@60.00", position = "0x0", scale = "1", transform = 0 })


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "nemo"
local menu        = "rofi -show drun"


-------------------
---- AUTOSTART ----
-------------------

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- NOTA: "preload = .../lain_wp.jpg" foi removido: e opcao do hyprpaper e deve ficar
-- no hyprpaper.conf:
--   preload = /home/icaro/.dotfiles/themes/lain_wp.jpg
--   wallpaper = ,/home/icaro/.dotfiles/themes/lain_wp.jpg
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper")
    -- O restante da linha original era comentario, entao o comando rodava sem argumentos:
    -- systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    hl.exec_cmd("dbus-update-activation-environment")
    -- hl.exec_cmd(terminal)
    -- hl.exec_cmd("nm-applet")
    hl.exec_cmd("waybar")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/configuring/core/environment-variables/
hl.env("BROWSER", "helium")
hl.env("TERM", "xterm-256color")
hl.env("XCURSOR_SIZE", "12")
hl.env("HYPRCURSOR_SIZE", "12")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/configuring/core/advanced-configuration/permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--     ecosystem = {
--         enforce_permissions = true,
--     },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/configuring/core/config-options/
hl.config({
    -- This fixed flickering on hyprland
    cursor = {
        no_hardware_cursors = true,
    },

    general = {
        gaps_in  = 0,
        gaps_out = 0,

        border_size = 3,

        col = {
            active_border   = "rgb(c35f4b)",
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/configuring/extra/tearing/ before you turn this on
        allow_tearing = false,

        -- layout = "dwindle",
    },

    decoration = {
        dim_inactive = true,
        dim_strength = 0.2,

        rounding       = 0,
        rounding_power = 1, -- era 0; o minimo aceito e 1 (sem efeito com rounding = 0)

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1,
        inactive_opacity = 1,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = true,
            size    = 3,
            passes  = 1,

            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    -- See https://wiki.hypr.land/configuring/layouts/dwindle-layout/ for more
    -- dwindle = {
    --     preserve_split = true, -- You probably want this
    -- },

    -- See https://wiki.hypr.land/configuring/layouts/master-layout/ for more
    master = {
        new_status = "master",
    },

    misc = {
        enable_anr_dialog       = false,
        force_default_wallpaper = 0,     -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

hl.workspace_rule({ workspace = "s[true]", gaps_in = 0, gaps_out = 0 })

-- Default animations, see https://wiki.hypr.land/configuring/core/animations/ for more
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}   } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}   } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}      } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1.0} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}    } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- Ref https://wiki.hypr.land/configuring/core/rules/workspace-rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "us, br",
        -- kb_variant = "dvorak,",
        kb_model   = "",
        kb_options = "grp:alt_caps_toggle, caps:super",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },

        scroll_method = "on_button_down",
        scroll_button = 275,
    },
})

-- Example per-device config
-- See https://wiki.hypr.land/configuring/core/devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/configuring/core/binds/
local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local exec    = hl.dsp.exec_cmd

-- Bind that switches AND shows overlay
-- NOTA: "ALT + SUPER" da erro de carga (so modificadores, sem tecla); SUPER_L e aceito como tecla.
hl.bind("ALT + SUPER_L", exec([[hyprctl notify -1 1500 0 "󰌌  $(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')"]]))

hl.bind(mainMod .. " + SHIFT + F", exec("~/.dotfiles/scripts/window-finder.sh"))

-- BEGIN passing keybindings to discord
-- hl.bind("CTRL + SHIFT + 1", hl.dsp.send_shortcut({ mods = "CTRL SHIFT", key = "1", window = "class:^(discord)$" }))
-- hl.bind("CTRL + SHIFT + 2", hl.dsp.send_shortcut({ mods = "CTRL SHIFT", key = "2", window = "class:^(discord)$" }))
-- hl.bind("CTRL + SHIFT + M", hl.dsp.send_shortcut({ mods = "CTRL SHIFT", key = "M", window = "class:^(discord)$" }))
-- hl.bind("CTRL + SHIFT + X", hl.dsp.send_shortcut({ mods = "CTRL SHIFT", key = "X", window = "class:^(discord)$" }))
hl.bind("CTRL + SHIFT + D", hl.dsp.send_shortcut({ mods = "CTRL SHIFT", key = "D", window = "class:^(discord)$" }))
-- END passing keybindings to discord

hl.bind(mainMod .. " + C",            hl.dsp.window.close())
hl.bind(mainMod .. " + CTRL + ALT + L", hl.dsp.exit())
hl.bind(mainMod .. " + V",            hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + G",            hl.dsp.group.toggle())

-- Cycle to the next window in the active group
hl.bind(mainMod .. " + TAB", hl.dsp.group.next())

hl.bind(mainMod .. " + P", exec(menu))
-- TODO trying to create a rofi interface for pass
-- hl.bind(mainMod .. " + CTRL + P", exec([[rofi -dmenu -p "🔑 Password" < <(find ~/.password-store -name "*.gpg" | sed "s|$HOME/.password-store/||;s|.gpg$||") | xargs -r -I{} sh -c 'gpg --passphrase "$(rofi -dmenu -p "🔒 GPG Passphrase" -password)" --batch -d ~/.password-store/"{}.gpg" 2>/dev/null | head -1 | wl-copy']]))

hl.bind(mainMod .. " + F",        hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + ALT + X",  exec("hyprshot -m region"))
hl.bind(mainMod .. " + CTRL + 1", exec([[hyprshot -m region --raw | tesseract stdin stdout | tee >(wl-copy) | notify-send "OCR Copied" "$(cat)"]]))

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

---- MY MAGIC WORKSPACES

-- mods + key toggles the special workspace; mods + SHIFT + key moves the active window into it
local function magic(mods, key, name)
    hl.bind(mods .. " + " .. key,         hl.dsp.workspace.toggle_special(name))
    hl.bind(mods .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = "special:" .. name }))
end

magic(mainMod, "Y", "terminals")
magic(mainMod, "S", "steam")
magic(mainMod, "D", "discord")
magic(mainMod, "O", "o")
magic(mainMod, "I", "i")
magic(mainMod, "U", "U")
magic(mainMod, "M", "M")
magic(mainMod, "R", "R")
-- magic(mainMod, "G", "game")
magic(mainMod, "Q", "buff")
magic(mainMod, "A", "anotherbuff")
magic(mainMod, "w", "ww")

-- hide open shown discord
-- hl.bind("SUPER + X", exec([[~/.dotfiles/scripts/hide-show-hyprland.sh pavucontrol "magic:pavucontrol"]]))

magic(mainMod, "X", "x")
magic(mainMod, "z", "z")
magic(mainMod, "E", "ee")

-- MainMod + ALT for every possible letter of keyboard
-- ("x" fica de fora: SUPER + ALT + X e o hyprshot)
for letter in ("abcdefghijklmnopqrstuvwyz"):gmatch(".") do
    magic(mainMod .. " + ALT", letter:upper(), letter)
end

-- HIDE ALL MAGIC WORKSPACES
hl.bind(mainMod .. " + SPACE", function()
    hl.dispatch(hl.dsp.workspace.toggle_special("__TEMP"))
    hl.dispatch(hl.dsp.workspace.toggle_special("__TEMP"))
end)

---- END MAGIC WORKSPACES

-- Increase / decrease inactive opacity
-- NOTA: "hyprctl setprop" nao existe mais. "+" nao pode ser usado na string do bind e
-- exigiria SHIFT, entao uso a tecla fisica "equal" (a mesma do +).
local inactiveOpacity = 1
local function changeInactiveOpacity(delta)
    inactiveOpacity = math.max(0, math.min(1, inactiveOpacity + delta))
    hl.config({ decoration = { inactive_opacity = inactiveOpacity } })
end
hl.bind(mainMod .. " + equal", function() changeInactiveOpacity(0.1) end)
hl.bind(mainMod .. " + minus", function() changeInactiveOpacity(-0.1) end)

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   exec("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", exec("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  exec("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", exec("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  exec("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  exec("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/configuring/core/rules/

-- Example windowrule
-- hl.window_rule({ name = "float-kitty", match = { class = "^(kitty)$", title = "^(kitty)$" }, float = true })

-- Ignore maximize requests from apps. You'll probably like this.
-- hl.window_rule({ name = "suppress-maximize-events", match = { class = ".*" }, suppress_event = "maximize" })

-- Fix some dragging issues with XWayland
-- hl.window_rule({
--     name  = "fix-xwayland-drags",
--     match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
--     no_focus = true,
-- })


----------------------------------------
---- KEYBINDINGS FOR OPENING PROGRAMS ----
----------------------------------------

hl.bind(mainMod .. " + N", exec(fileManager))
hl.bind(mainMod .. " + T", exec(terminal))

-- hl.bind("SUPER + CTRL + T", exec([[kitty -e sh -c 'tmux']]))
hl.bind("SUPER + CTRL + T", exec([[kitty -e sh -c 'zellij -l welcome']]))
hl.bind("SUPER + CTRL + E", exec([[kitty -e sh -c 'tmux attach -t "$(tmux ls -F "#S" | fzf)"']]))

hl.bind("SUPER + CTRL + B", exec("pkill -SIGUSR1 waybar || waybar &"))
hl.bind("SUPER + CTRL + G", exec("kitty --title glances glances"))
hl.bind("SUPER + CTRL + H", exec("kitty --title htop htop"))
hl.bind("SUPER + CTRL + M", exec("kitty --title math python3"))
hl.bind("SUPER + CTRL + N", exec("nemo $HOME/Downloads"))
-- hl.bind("SUPER + CTRL + L", exec("nemo $HOME/Livros"))
-- hl.bind("SUPER + CTRL + E", exec("qutebrowser https://mail.google.com/mail/u/0/#inbox"))
-- ATENCAO: SUPER + CTRL + W tambem esta no SSH abaixo; os dois disparam juntos (como no .conf)
hl.bind("SUPER + CTRL + W", exec("qutebrowser --target window https://web.whatsapp.com/"))
hl.bind("SUPER + CTRL + F", exec("chromium-browser --new-window 'https://docs.google.com/spreadsheets/d/1L98Q1zQFFGEAeGisdsPalHc8r7p6vl0T5DHriw9NpDw/edit?gid=1900151555#gid=1900151555'"))
-- Rastreio
hl.bind("SUPER + CTRL + R", exec("chromium-browser --new-window 'https://myaccount.mercadolivre.com.br/my_purchases/2000012438917823/status?packId=2000012438917825&orderId=2000015913599356'"))

-- Ultimas transacoes
-- hl.bind("SUPER + CTRL + T", exec([[kitty --title mysql -e sh -c "mysql -u masterUnifrota -p'<SENHA>' -e 'SELECT t.data, t.dataSincronismo, t.placa, t.idTipoTransacao, t.odometroHorimetro, t.kmPercorrida FROM transacao t ORDER BY t.idTransacao DESC LIMIT 20;'; read"]]))

-- SSH connections
-- hl.bind("SUPER + CTRL + D", exec("discord"))
hl.bind("SUPER + CTRL + S", exec([[kitty -e sh -c 'TERM=xterm-256color;ssh -i ~/.ssh/awskeys/UnifrotaAWS.pem admin@web.unifrota.com.br']]))
hl.bind("SUPER + CTRL + I", exec([[kitty -e sh -c 'TERM=xterm-256color;ssh -i ~/.ssh/awskeys/UnifrotaAWS.pem admin@integ.unifrota.com.br']]))
hl.bind("SUPER + CTRL + W", exec([[kitty -e sh -c 'TERM=xterm-256color;ssh -i ~/.ssh/awskeys/RDSARM.pem admin@3.17.132.45']]))

-- Maquina nova do banco
hl.bind("SUPER + CTRL + L", exec([[kitty -e sh -c 'TERM=xterm-256color; ssh -i ~/.ssh/awskeys/RDSARM.pem admin@3.141.23.58']]))

hl.bind("SUPER + CTRL + X", exec("pavucontrol"))
-- hl.bind("SUPER + CTRL + Z", exec("zed")) -- Trying to make zed a great developming environment
-- Scratchpad
hl.bind("SUPER + CTRL + C", exec([[kitty -e sh -c 'nvim ~/scratchy']]))
hl.bind("SUPER + CTRL + Q", exec([[kitty -e sh -c 'cd ~/baum/; nvim ./']]))
---- Trying to make a shortcut that opens my youtubemusic in the right magic workspace
-- hl.bind("SUPER + CTRL + Z", exec("helium --app=https://music.youtube.com", { workspace = "special:z silent" }))

---- TODOS
-- I want to achieve a command pallete like rofi setup where I can see which
-- bindings I have to my commands, like runnin scripts, launching apps and other
-- things.


-- PLUGINS
-- hl.bind("SUPER + grave", hl.dsp.expo.toggle()) -- Super+` to open/close (hyprexpo; confira a API do plugin)

-- hl.bind("SUPER + CTRL + O", exec("helium --new-tab https://calendar.google.com/calendar/u/0/r"))
