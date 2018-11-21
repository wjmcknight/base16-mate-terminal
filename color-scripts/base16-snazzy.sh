#!/usr/bin/env bash
#
# Adapted from Base16-Builder's Gnome Terminal template.

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Snazzy"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-snazzy"
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
dset palette "'#282a36:#ff5c57:#5af78e:#f3f99d:#57c7ff:#ff6ac1:#9aedfe:#e2e4e5:#78787e:#ff5c57:#5af78e:#f3f99d:#57c7ff:#ff6ac1:#9aedfe:#f1f1f0'"
dset background-color "'#282a36'"
dset foreground-color "'#e2e4e5'"
dset bold-color "'#e2e4e5'"
dset bold-color-same-as-fg "true"
dset use-theme-colors "false"
dset use-theme-background "false"

