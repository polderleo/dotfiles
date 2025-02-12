import { map, rule, withModifier, writeToProfile } from "karabiner.ts";

// Use `--dry-run` as profile to print the config json to console
writeToProfile("Default profile", [
  rule("Hyper key").manipulators([
    map("caps_lock").toHyper().toIfAlone("escape"),
  ]),

  rule("Vim motions").manipulators([
    withModifier("Hyper")([
      map("h").to("left_arrow"),
      map("l").to("right_arrow"),
      map("k").to("up_arrow"),
      map("j").to("down_arrow"),
      map("n").to("page_down"),
    ]),
  ]),

]);
