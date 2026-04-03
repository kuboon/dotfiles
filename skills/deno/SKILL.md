---
name: deno
description: Rules for using Deno
metadata:
  url: https://gist.github.com/kuboon/b0d7c4384a9baf3c650be6d6fdd5665a
  updated_on: 2026-04-01
---

# Imports

## bad

```ts
import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
```

## good

run

- `deno add jsr:@std/http`
- `deno add npm:tailwindcss` to add the import map, then

```ts
import { serve } from "@std/http/server.ts";
import { serve } from "tailwindcss";
```

# Permissions

## bad

```sh
deno run --allow-net server.ts
```

## good

Write a `deno.json` file in the root of your project:

```json
{
  "permissions": {
    "default": {
      "net": ["example.com", "api.example.com"],
      "read": ["./data/*"],
      "env": {
        "ignore": true,
        "allow": ["API_KEY", "DATABASE_URL"]
      }
    },
    "build": {
      "net": ["deno.land"],
      "read": ["./src/*"],
      "write": ["./dist/*"]
    }
  }
}
```

Then run your script with the `-P` flags:

```sh
deno run -P server.ts
deno run -P=build build.ts
```

## reference

- https://github.com/denoland/deno/blob/main/cli/schemas/config-file.v1.json
- https://docs.deno.com/runtime/fundamentals/configuration/#permissions
