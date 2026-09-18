Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0485218A6
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789759456; cv=pass; b=bbPb8QM72XJ9CtUZ1xoVXfLnCO6NEhwzzPRgbZ0x6z5GWKfHxXyeGfTRZF2876il4P6RgmfLgSMgga7FZjBqJlj2IJ9/Kcp1aCWDA2HD/X1FTYZJZr5V8FjJpwtUiJXtOXO3td7+Y6t7jUeOvHemFQbec7cHJSJ9nwIdCIHRsG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789759456; c=relaxed/simple;
	bh=MI2wj5I0vmugylROwVnPuAhB4aihZtNCNIsKAygOm/A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QCe+ngFzo9WT1lzW6a4tBQDngWS+QN9Td2bRDYY/HehUUsAAY0JfAiXTt50fJMaoVCcIdLNlpRtjFLmhiOQ43e3Jyp4XuNugsVx63Dyw9l1ZrzWSg46zhmE3qliz6NBweOCxd5B2NyM5U4T5b3zUvvZLE7SzVWy6NPtXbPIzN9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=antithesis.com; spf=pass smtp.mailfrom=antithesis.com; dkim=pass (1024-bit key) header.d=antithesis.com header.i=@antithesis.com header.b=GFwWq5aO; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=antithesis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antithesis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antithesis.com header.i=@antithesis.com header.b="GFwWq5aO"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa1d00daaaso1909930a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 12:24:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789759451; cv=none;
        d=google.com; s=arc-20260327;
        b=sbpnMmE8PFhJXfAmHdgqoAxsEPqVFNwWqt/UD3msolrQRTpBkDWSyvPbnPF8vaTPsp
         FzWHLq5s1uOSrhYe0Pt5VUi4C0RI+Pzjh5wM/mLYqa6AhbKINtktFLklQ4rbZz2yvrYG
         Ft/weMCeqpurufDmBxtaC0WBVDVfRoUcNsA54uOYdGow/gDlYEwdc57ZZEDMW+slpIWz
         Q1R5zFMeRk1hdgsJqZGcr3ZYwNRLRFgHqIk+ITF7VKMb/KpvRzHRddeUot2nnUKgel8e
         f132zDlUZHx3r1gwdLVMFDVtNJtb8Wg5NhT3jUk16hElEaPx/7ReMUo3tb1lXftSk6h/
         dygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=UQTtyZV2X6HDWDU+HKZuUGPgG6bm9WfVr4K1eAhS+6c=;
        fh=i5d2UcUHKyQ+Od6VuceHQlOd2PfwSDwEXQRrmu0GQxM=;
        b=oqnH6wozdDeDDXVz4mU6SmxGqFmWdtIFS7oxQKQkbN4DDe/g900e4cqQmv7kKFo+ou
         sRAbtX7LO77XSHbuhRSp79SzsBj7FkRfNnnAFBO6Jwklxb7FCR6lc+PJ4bL+bYx9HX7b
         wLfy7cmxIW4PVw/GyR+2ekDCxtoHYgcriQvHGZMn6nepxkEDTx+ctGyhzqX2+03vH2id
         cG6il8WELaCoE4dzGBLyqZ1JKou1GvN1nmScrQsfstWeZH3Izvc7kAA7k9gVyc4RU2JI
         ML2bSJAXD7uYRLhLJeud32kbE17VUjieHbgcFS7oUBcxLAhTea7ZAOTNeWvnLv9Vu0xQ
         uP2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antithesis.com; s=google; t=1789759451; x=1790364251; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UQTtyZV2X6HDWDU+HKZuUGPgG6bm9WfVr4K1eAhS+6c=;
        b=GFwWq5aOXDueJnhhhOvRJraHawdN+o01/ql56FwAMdB3u77XKdUnV/CjDDvLmc4ezg
         VYQ0dOvtd+IfExxqsAGjMx7W9lSX7+6Y5nZqapjWHKC9f1vYDDYZDx0bHAgrtHd0Wm5z
         QsH4QuO/84XxvHUwFns+xY8JBniYOvfGBeYc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789759451; x=1790364251;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UQTtyZV2X6HDWDU+HKZuUGPgG6bm9WfVr4K1eAhS+6c=;
        b=HnhO93sIVjn1xpU+LPZOdu7GdXoGDSbboVm8XacJJ9Cs8R4TfC/Q+qfb2EDCnxfAP3
         N3t8gJCyHYJ63eBIIRZmQFecSEj821PFAimcsUNoZGs3vWNpsdhgT8AeGiZjzQBk7wta
         MI3fVQRunp/M3+dwu5qNL3+xcNkL9jYkYQmOM99NcZfRl1YRerLr/nhtaxTCT0RgHvAr
         upHPHjyEdlkgDlS6uvednqo7tbpupteY6e3NxOigBILDFtwKhIOkwJKjIzYxNmbBuZmB
         rWcIeKJe5vDbr6SNfSOvqr2XuNydoW4saMZ0/6qjuI6Vym7R6zhf/2WSDv/H5H0lChbr
         p3tQ==
X-Gm-Message-State: AFuF++ksZbJ26ZCr8pa1Qg1y7lo2jUEx3GSNOgJ++TSZtWVcryCIw+md
	3p0z99Odju/JxKDDICAHsFcCAEo3ipvgnmcsE8SYE112gmKGn/lZF6geEA5z+L12mdeCxqC5Hyj
	HzuASHkqUvSXKSrZiSjXtU5QN8Jrn4DxmMsx0n3dfP7GMIL2VoLY=
X-Gm-Gg: AYBFou3y1Ae3WUs/egmjT9cgi02mTzO9ZDyEHlTEZa3snpyfsqI1KwaC8vaRZGnQ0P5
	ziYeHjFwX91wnvKNealLr8BnoLcbnY9Xn6fQZGUtEyccdDviBaHa5rHbvudj/u+Wg9IgRE2KkWQ
	xY6jFcgq0aTinJiJumF1KsR+UdNNcKzGG1U6xqzRqUiAUquAqM6kgehGTsDMDwJ8S+xzCf27n8w
	75bTBYPE73ooK66Sd2Ha1rz1mga89Qkp0QWodWFJNRpN7jzk+RDAGJfCO6qGf4XHjLChSGVwD3x
	7KTI1qk7XNKsdaO+deIfUzOzBIipER0s/oIIDX25W/ezcst7aBqT6qJsg9s1xzd0cO6SEH+j7yD
	XQzHN//tGQ5Q=
X-Received: by 2002:a17:907:970d:b0:c25:6230:dfcd with SMTP id
 a640c23a62f3a-c2a1569d656mr350778066b.15.1789759135667; Fri, 18 Sep 2026
 12:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rohan Padhye <rohan.padhye@antithesis.com>
Date: Fri, 18 Sep 2026 15:18:44 -0400
X-Gm-Features: AcwNN1Vvr_TGT4qocp9eBev_SUd4n1F8qcl_XstRJIw6DLuYnyWyAdmryGJwpV4
Message-ID: <CACnTLT0f2jjDW-=Yk6mJcYU6XX8b9jkf6jFA0iU9GHyB-KG0fg@mail.gmail.com>
Subject: [BUG] link(2) is not atomic with respect to unlink(2), violating
 POSIX XSH 2.9.7
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

Hello,

I stumbled upon a potential race-condition bug in VFS while working with a
property-based testing library (Hegel).

Summary
-------
link() and unlink() on the same name are not atomic with respect to each
other. If a file has two names, "a" and "b", then concurrent link("a", "a")
and unlink("a") can BOTH return 0, and afterwards "a" still exists. No
sequential ordering of the two calls produces that outcome: link("a", "a")
can only ever fail (EEXIST if "a" exists, ENOENT if it does not), and
either order leaves "a" absent.

Affects
-------
Reproduced on 6.18.50 (NixOS) with zfs, and also on ext4. The behaviour
comes from the VFS link path in fs/namei.c, so it should not depend on
the filesystem; the structure of that code is unchanged in mainline as
of commit c3d85c669d09 (7.3-rc cycle, 2026-09-18), where the function
is filename_linkat(), formerly do_linkat().

Specification
-------------
POSIX.1-2024, XSH 2.9.7 "Thread Interactions with File Operations"
https://pubs.opengroup.org/onlinepubs/9799919799/functions/V2_chap02.html#tag_16_09_07

  "All of the following functions shall be atomic with respect to each
  other in the effects specified in POSIX.1-2024 when they operate on
  files in the file hierarchy: [...] link() [...] unlink() [...]
  If two threads each call one of these functions, each call shall
  either see all of the specified effects of the other call, or none of
  them."

POSIX.1-2024, link()
https://pubs.opengroup.org/onlinepubs/9799919799/functions/link.html

  "The link() function shall atomically create a new hard link for the
  existing file and the link count of the file shall be incremented by
  one."

  ERRORS: [EEXIST] "The path2 argument resolves to an existing directory
  entry"; [ENOENT] "the file named by path1 does not exist".

Expected behaviour
------------------
- link("a", "a") always fails: EEXIST if "a" exists, ENOENT if not.
- Either sequential order ends with no "a":
    link("a", "a") -> EEXIST;  unlink("a") -> 0
    unlink("a") -> 0;          link("a", "a") -> ENOENT

Observed behaviour
------------------
- Start with one file that has two names, "a" and "b".
- Run link("a", "a") and unlink("a") concurrently in two threads.
- Some of the time both calls return 0. Afterwards "a" exists, and
  stat("a") shows st_nlink == 2: "a" is again a name for the same inode
  as "b". unlink() reported removing the name and link() re-created it.
- link("a","a") saw none of unlink()'s effects while resolving path1
  ("a" was found) and all of them while creating path2 ("a" was free),
  which is exactly the mixed observation 2.9.7 forbids.

Variant with rename
-------------------
The same thing happens with rename("a", "c") in place of unlink("a"):
link("a", "a") and the rename can both return 0, after which "a", "b"
and "c" all name the same inode (st_nlink == 3), whereas either
sequential order ends with "b" and "c" but no "a". Any operation that
removes the name "a" between link()'s lookup of path1 and its creation
of path2 produces the resurrection.

Root cause
----------
fs/namei.c, filename_linkat() (do_linkat() before the rename), then
vfs_link(). The source and the destination are handled in two separate
steps with no lock spanning both:

  1. filename_lookup(old) resolves "a" to its dentry/inode. No directory
     lock is held at this point.
  2. Concurrently, unlink("a") takes the directory lock, removes the
     entry "a" and drops i_nlink from 2 to 1.
  3. filename_create(new) takes the directory lock, looks up "a", finds
     it negative, and returns a dentry for it. vfs_link() then adds an
     entry "a" for the inode obtained in step 1. The check

         if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
                 return -ENOENT;

     does not fire because "b" keeps i_nlink at 1.

Note that a related system call, rename(2), does not exhibit this
atomicity violation because it implements a different strategy:
do_renameat2() (filename_renameat2() in mainline) resolves only the
parent directories up front, takes lock_rename(), and then looks up
both names with lookup_one_qstr_excl() while holding that lock.

Fix suggestion (conceptual)
---------------------------
Make the source lookup part of the locked section, mirroring rename:
resolve only the parent of path1, take the directory lock (or the
lock_rename() ordering when path1 and path2 are in different
directories), then look up the final component of path1 under that
lock and fail with ENOENT if it is no longer there before calling
vfs_link().

I realize the current behaviour may be intentional, and that the i_nlink
guard already prevents the worse outcome of resurrecting a fully unlinked
file. Let me know if this is a bug or behavior that should be documented.

Reproducer
----------
Build with: cc -O2 -pthread link_race_min.c -o link_race_min
Run in an empty directory. Exit status 1 means the race was hit. On a
2-CPU VM it typically fires within the first few hundred attempts:

  $ ./link_race_min
  attempt 49: unlink("a") and link("a","a") both succeeded; "a" exists
again, st_nlink = 2

/* link(2) vs unlink(2) race: link("a","a") must fail with EEXIST or ENOENT,
 * but on Linux it can succeed if unlink("a") runs concurrently, as long as
 * the file has another name ("b") so its link count stays above zero.
 * When that happens both calls return 0, yet "a" is still present afterwards:
 * unlink reported removing the name and link re-created it from the inode it
 * had already looked up. Build: cc -O2 -pthread link_race_min.c -o
link_race_min
 * Run in an empty directory. */
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>

static void *do_unlink(void *arg) { *(int *)arg = unlink("a"); return NULL; }
static void *do_link(void *arg)   { *(int *)arg = link("a", "a"); return NULL; }

/* Run unlink("a") and link("a","a") concurrently; return link's result. */
static int race(void)
{
    pthread_t t1, t2;
    int r_unlink, r_link;
    pthread_create(&t1, NULL, do_unlink, &r_unlink);
    pthread_create(&t2, NULL, do_link, &r_link);
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    if (r_unlink != 0) { perror("unlink"); exit(2); }
    return r_link;
}

int main(void)
{
    struct stat st;
    unlink("a"); unlink("b");
    close(open("a", O_CREAT | O_WRONLY, 0644));
    if (link("a", "b") != 0) { perror("link a b"); return 2; }

    for (long i = 1; i <= 1000000; i++) {
        if (race() == 0) {
            if (stat("a", &st) != 0) { perror("stat a"); return 2; }
            printf("attempt %ld: unlink(\"a\") and link(\"a\",\"a\")
both succeeded; "
                   "\"a\" exists again, st_nlink = %lu\n", i,
(unsigned long)st.st_nlink);
            unlink("a"); unlink("b");
            return 1;
        }
        /* put "a" back for the next attempt */
        if (stat("a", &st) != 0 && link("b", "a") != 0) {
perror("restore a"); return 2; }
    }
    printf("not reproduced in 1000000 attempts\n");
    unlink("a"); unlink("b");
    return 0;
}
