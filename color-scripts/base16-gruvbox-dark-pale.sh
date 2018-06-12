#!/usr/bin/env bash
# Base16 3024 - Mate Terminal color scheme install script
# Jan T. Sott (http://github.com/idleberg)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Gruvbox Dark, Pale"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-gruvbox-dark-pale"
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
dset palette "'#262626:#d75f5f:#afaf00:#ffaf00:#83adad:#d485ad:#85ad85:#dab997:#8a8a8a:#d75f5f:#afaf00:#ffaf00:#83adad:#d485ad:#85ad85:#ebdbb2'"
dset background-color "'#262626'"
dset foreground-color "'#dab997'"
dset bold-color "'#dab997'"
dset bold-color-same-as-fg "true"
dset use-theme-colors "false"
dset use-theme-background "false"
