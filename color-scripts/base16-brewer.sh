#!/usr/bin/env bash
#
# Adapted from Base16-Builder's Gnome Terminal template.

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Brewer"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-brewer"
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
dset palette "'#0c0d0e:#e31a1c:#31a354:#dca060:#3182bd:#756bb1:#80b1d3:#b7b8b9:#737475:#e31a1c:#31a354:#dca060:#3182bd:#756bb1:#80b1d3:#fcfdfe'"
dset background-color "'#0c0d0e'"
dset foreground-color "'#b7b8b9'"
dset bold-color "'#b7b8b9'"
dset bold-color-same-as-fg "true"
dset use-theme-colors "false"
dset use-theme-background "false"

