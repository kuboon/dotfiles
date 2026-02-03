---
name: gist-skills
description: How to save & load skills from my gist
---

# gist filename

When I create gist with "SKILL.md" the gist subject to be "SKILL.md". It's
inconvenient. I want to avoid this but won't rename the filename "SKILL.md", I
will create gist with SKILL.md then add dummy `.<skill-name>.SKILL.md` that will
be treated as the main file.

# List skills
`gh gist list --filter "SKILL.md <other queries>"`

# Load skill
get gist-id by "List skills" then
`gh gist clone <gist-id> <workdir-root>/.claude/skills/<skill-name>`

# Save or update
- `pushd <dir-of-the-SKILL.md>`
- `git remote get-url origin`

If the output is not `gist.github.com`, the file is not saved to gist yet. Run
- `gh gist create SKILL.md -p -d "<skill-name>/SKILL.md <tag> <tag> <tag>"`
- `echo "<skill-description>" | gh gist edit <gist-id> -a ".<skill-name>.SKILL.md"`
- then `git init && git remote set-url origin <gist-url>.git`

If the output is `https://gist.github.com/<gist-id>.git`
- `gh gist edit <gist-id> SKILL.md`

Finally
- `popd`
