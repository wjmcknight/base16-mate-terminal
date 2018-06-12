#!/usr/bin/env bash
# Base16 3024 - Mate Terminal color scheme install script
# Jan T. Sott (http://github.com/idleberg)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Materia"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-materia"
[[ -z "$DCONFTOOL" ]] && DCONFTOOL=dconf
[[ -z "$BASE_KEY" ]] && BASE_KEY=/org/mate/terminal/profiles

PROFILE_KEY="$BASE_KEY/$PROFILE_SLUG"

dset() {
  local key="$1"; shift
  local val="$1"; shift

  "$DCONFTOOL" write "$PROFILE_KEY/$key" "$val"
}

# Because gconftool doesn't have "append"
glist_append() {
  local key="$1"; shift
  local val="$1"; shift

  local entries="$(
    {
      "$DCONFTOOL" read "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
      echo "'$val'"
    } | head -c-1 | tr "\n" ,
  )"

  "$DCONFTOOL" write "$key" "[$entries]"
}

# Append the Base16 profile to the profile list
glist_append /org/mate/terminal/global/profile-list "$PROFILE_SLUG"

dset visible-name "'$PROFILE_NAME'"
dset palette "'#263238:#ec5f67:#8bd649:#ffcc00:#89ddff:#82aaff:#80cbc4:#cdd3de:#707880:#ec5f67:#8bd649:#ffcc00:#89ddff:#82aaff:#80cbc4:#ffffff'"
dset background-color "'#263238'"
dset foreground-color "'#cdd3de'"
dset bold-color "'#cdd3de'"
dset bold-color-same-as-fg "true"
dset use-theme-colors "false"
dset use-theme-background "false"
