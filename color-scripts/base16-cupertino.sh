#!/usr/bin/env bash
#
# Adapted from Base16-Builder's Gnome Terminal template.

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Cupertino"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-cupertino"
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
dset palette "'#ffffff:#c41a15:#007400:#826b28:#0000ff:#a90d91:#318495:#404040:#808080:#c41a15:#007400:#826b28:#0000ff:#a90d91:#318495:#5e5e5e'"
dset background-color "'#ffffff'"
dset foreground-color "'#404040'"
dset bold-color "'#404040'"
dset bold-color-same-as-fg "true"
dset use-theme-colors "false"
dset use-theme-background "false"

