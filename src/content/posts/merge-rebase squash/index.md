---
title: Git Merge vs Rebase vs Squash
published: 2025-02-01
image: "_cover.D2kcx8Ae_Z27Btg0.webp"
description: "3 cách merge git gây lú"
tags: [Git, Version Control]
category: 'Technology'
draft: false
lang: "en"
---

# Git Merge vs Rebase vs Squash - A Simple Guide

Let's break down these Git operations in simple terms with practical examples.

## Merge: Combining Branches

Merging is like adding your changes alongside others' work. It creates a new commit that combines two branches.

```bash
# Scenario: Merging feature branch into main
git checkout main
git merge feature-branch
```

**What happens:**

```
Before merge:
main:     A---B---C
feature:      \
               D---E

After merge:
main:     A---B---C---F
feature:      \     /
               D---E
```

**When to use merge:**

- When you want to preserve the branch history
- For feature branches that represent complete, logical units of work
- When working on long-running branches

## Rebase: Reorganizing History

Rebasing is like moving your changes to start from a different point. It makes history linear and clean.

```bash
# Scenario: Rebasing feature branch onto main
git checkout feature-branch
git rebase main
```

**What happens:**

```
Before rebase:
main:     A---B---C
feature:      \
               D---E

After rebase:
main:     A---B---C
                   \
                    D'---E'
```

**When to use rebase:**

- When you want a clean, linear project history
- Before merging your feature branch into main
- When updating your feature branch with latest changes from main

## Squash: Combining Multiple Commits

Squashing combines multiple commits into one, making history cleaner and more organized.

```bash
# Scenario: Squashing last 3 commits
git rebase -i HEAD~3
```

**What happens:**

```
Before squash:
A---B---C---D---E

After squash:
A---B---F        # where F contains changes from C, D, and E
```

## Real-World Example

Let's see how these work together in a typical workflow:

```bash
# Start a feature branch
git checkout -b feature/user-auth
git commit -m "Add login form"
git commit -m "Add validation"
git commit -m "Fix typos"

# Main branch has new updates
# Option 1: Merge
git checkout main
git merge feature/user-auth

# Option 2: Rebase and Squash
git checkout feature/user-auth
git rebase -i main  # Squash commits during rebase

# In the rebase interactive editor:
pick abc123 Add login form
squash def456 Add validation
squash ghi789 Fix typos
```

## Quick Decision Guide

**Choose Merge when:**

- You want to preserve complete history
- Working with shared branches
- Need to maintain branch context

**Choose Rebase when:**

- You want a clean, linear history
- Working on a personal feature branch
- Need to integrate latest changes from main

**Use Squash when:**

- You have multiple small, related commits
- Want to clean up before merging
- Need to simplify history

## Best Practices

1. Never rebase shared branches
2. Squash before merging feature branches
3. Use meaningful commit messages
4. Keep feature branches short-lived
5. Regularly sync with main branch

Remember: There's no "best" option - each has its use case. Choose based on your team's workflow and project needs.
