#!/usr/bin/env python3
"""Validate front matter and image references for blog posts.

By default only checks posts with uncommitted changes under content/posts/
(what you're about to commit). Pass explicit slugs/paths to check just
those, or --all to audit every post in the repo.
"""
import os
import re
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
POSTS_DIR = os.path.join(ROOT, 'content', 'posts')
AUTHORS_DIR = os.path.join(ROOT, 'content', 'authors')

REQUIRED_FIELDS = ('title', 'date', 'draft', 'authors')
IMAGE_REF_RE = re.compile(r'!\[[^\]]*\]\(([^)\s]+)\)')


def parse_front_matter(path):
    """Return (fields dict, body lines). fields is None if there is no block."""
    with open(path, encoding='utf-8') as fh:
        lines = fh.read().splitlines()
    if not lines or lines[0] != '---':
        return None, lines
    try:
        end = lines.index('---', 1)
    except ValueError:
        return None, lines
    fields = {}
    for line in lines[1:end]:
        if ':' not in line:
            continue
        key, _, value = line.partition(':')
        fields[key.strip()] = value.strip()
    return fields, lines[end + 1:]


def list_strings(raw):
    if not raw:
        return []
    return [item.strip().strip('"\'') for item in raw.strip('[]').split(',') if item.strip()]


def is_local_reference(value):
    return bool(value) and not value.startswith(('/', 'http://', 'https://'))


def known_authors():
    if not os.path.isdir(AUTHORS_DIR):
        return set()
    return {
        name for name in os.listdir(AUTHORS_DIR)
        if os.path.isdir(os.path.join(AUTHORS_DIR, name))
    }


def check_post(slug, authors):
    post_dir = os.path.join(POSTS_DIR, slug)
    index_path = os.path.join(post_dir, 'index.md')
    if not os.path.isfile(index_path):
        return [f'{slug}: missing index.md']

    fields, body_lines = parse_front_matter(index_path)
    if fields is None:
        return [f'{slug}: index.md has no "---" front matter block']

    problems = []
    for field in REQUIRED_FIELDS:
        if not fields.get(field):
            problems.append(f'{slug}: missing required front matter field "{field}"')

    post_authors = list_strings(fields.get('authors'))
    if not post_authors:
        problems.append(f'{slug}: "authors" list is empty')
    for author in post_authors:
        if author not in authors:
            problems.append(f'{slug}: author "{author}" has no profile in content/authors/')

    featured = fields.get('featured_image', '').strip('"\'')
    if is_local_reference(featured) and not os.path.isfile(os.path.join(post_dir, featured)):
        problems.append(f'{slug}: featured_image "{featured}" not found in post folder')

    body = '\n'.join(body_lines)
    for ref in IMAGE_REF_RE.findall(body):
        if is_local_reference(ref) and not os.path.isfile(os.path.join(post_dir, ref)):
            problems.append(f'{slug}: image reference "{ref}" not found in post folder')

    return problems


def all_slugs():
    return sorted(
        name for name in os.listdir(POSTS_DIR)
        if os.path.isdir(os.path.join(POSTS_DIR, name)) and name != '__trashed'
    )


def changed_slugs():
    """Slugs with uncommitted changes under content/posts/, or None if git is unavailable."""
    try:
        out = subprocess.run(
            ['git', 'status', '--porcelain', '--', 'content/posts'],
            cwd=ROOT, capture_output=True, text=True, check=True,
        ).stdout
    except (subprocess.CalledProcessError, FileNotFoundError):
        return None
    slugs = set()
    for line in out.splitlines():
        path = line[3:].strip().strip('"')
        parts = path.split('/')
        if len(parts) >= 3 and parts[0] == 'content' and parts[1] == 'posts':
            slugs.add(parts[2])
    return slugs


def main():
    args = [a for a in sys.argv[1:] if a != '--all']
    existing = set(all_slugs())

    if '--all' in sys.argv[1:]:
        target_slugs = sorted(existing)
    elif args:
        target_slugs = sorted({os.path.basename(a.rstrip('/')) for a in args})
    else:
        changed = changed_slugs()
        if changed is None:
            target_slugs = sorted(existing)
        else:
            target_slugs = sorted(changed & existing)
            if not target_slugs:
                print('No changed posts under content/posts/ to validate (use --all to check every post).')
                return 0

    authors = known_authors()
    problems = []
    for slug in target_slugs:
        if slug not in existing:
            problems.append(f'{slug}: no such post folder in content/posts/')
            continue
        problems.extend(check_post(slug, authors))

    if problems:
        print(f'Found {len(problems)} problem(s) in {len(target_slugs)} post(s):\n')
        for problem in problems:
            print(f'  - {problem}')
        return 1

    print(f'OK: {len(target_slugs)} post(s) validated, no problems found.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
