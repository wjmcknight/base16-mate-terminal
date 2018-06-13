#!/usr/bin/env bash
# Base16 3024 - Mate Terminal color scheme install script
# Jan T. Sott (http://github.com/idleberg)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Gruvbox Light, Medium"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-gruvbox-light-medium"
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
dset palette "'#fbf1c7:#9d0006:#79740e:#b57614:#076678:#8f3f71:#427b58:#504945:#bdae93:#9d0006:#79740e:#b57614:#076678:#8f3f71:#427b58:#282828'"
dset background-color "'#fbf1c7'"
dset foreground-color "'#504945'"
dset bold-color "'#504945'"
dset bold-color-same-as-fg "true"
dset use-theme-colors "false"
dset use-theme-background "false"
