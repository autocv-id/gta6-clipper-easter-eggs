// Entrypoint for the gta6-clipper-01 bounty (Node 22, standard library only).
// The entry itself is the YouTube video named in VIDEO.json; this program only
// hands that file to the grader by copying it into the output directory.
// It reads nothing else, writes nothing else, and makes no network calls.
//
// Local check:
//   mkdir -p out && MAKEFUN_BOT_DIR=. MAKEFUN_OUTPUT_DIR=out node main.ts

import { copyFileSync, mkdirSync } from "node:fs";
import { join } from "node:path";

const repoDir = process.env.MAKEFUN_BOT_DIR ?? "/bot";
const outDir = process.env.MAKEFUN_OUTPUT_DIR ?? "/output";

mkdirSync(outDir, { recursive: true });
try {
  copyFileSync(join(repoDir, "VIDEO.json"), join(outDir, "VIDEO.json"));
} catch (error) {
  console.error(
    `Could not copy VIDEO.json out of ${repoDir}: ${(error as Error).message}`,
  );
  process.exit(1);
}
