SCCACHE="$(which sccache)"
[[ -x $SCCACHE ]] && export RUSTC_WRAPPER="$SCCACHE"
