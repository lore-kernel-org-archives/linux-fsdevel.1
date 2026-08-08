Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3893A3CA483
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Aug 2026 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786195398; cv=none; b=kmbVQ6ynsNzdar2Dy54RSDmedqfk2uB77hWOkl68bp1A86AsORZSJ8YxVozjQet3VYyFL0YmBnwKH58xd8Q2P4o9IFJzQRQYwigCOHvr1QJoOH0f37F2ANnkLm4nZvDkZUqCkvPNu5Xgza5Kx+a1Kw2WCdrD5v8Z2byvKu0tjeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786195398; c=relaxed/simple;
	bh=r/qwnNRvpRuRUGmnujDseEOKtVd/4UKE65cNO8sZQDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZwQdRkfOr5gx3luJdZJ0xJeuTdb3wFpBVYa9dwCHoyBrNJbLPQy9th4C0aCsDVXJ9wN0xmcwv9C22KarHy54zJdlaMQmrpDHtdLk6mSXROBxp6Ho5iT4+PNxjzCGedYMCbxcYppx8Yx4PjW/4id1IAHLphYa0/Nb/pb2hR1TWcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfowj6GU; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfowj6GU"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3810f0aba07so255087a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Aug 2026 06:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786195396; x=1786800196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+sknT3Bnd1z/bdO/Te85NKEmZKwHC4jbouDq5lsiEnQ=;
        b=cfowj6GU50LwU/4+3S1smz3bJ2YvB4F+zqznVybE7v43MRVxFvzo1V8k1ivV+ldhk9
         XQAa5eH4TU4BfVvYUm0nA3yQHDmBJ8HO5y+N6nNCFNvYhrrhRNm9dtjU2vuT/3AHuFDZ
         OWKIY31c39hzo/lD4ITGrrbMzbraZxCHbX01Yn+JoxXu6jDuOyGXugvYbU6MhzUw0Ovu
         4rP5S1xLF2GmucQOWpqguAo8h3ajLO9+7m84lxkkMbbl6GC5rCYKJxjiqd9ycgtmgCc/
         +CslR9sC0zfCk1vfbVWUFRkgEJAdrnkg64qlDdXPVLQaUHonToB5gxD3Vt6uXSc91GCc
         ZR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786195396; x=1786800196;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+sknT3Bnd1z/bdO/Te85NKEmZKwHC4jbouDq5lsiEnQ=;
        b=FkAwS/7zjiqJBMECMSaXGZZUpKWi+s35Ut3rMpikqEgADBtA9KBBQZLG9egWU6EbIO
         pMMSvBai5HqWeJx5qG8A1m57Hob+a5hdIXkEOXqk9iYgQ5pzlvgugFCaFu/DWXCr0sK2
         U4LCzaMEJWm/ywAsB0A1usEUpneRwoD+q0Wwihh5M4fr3nglKsnvJMIo4bVMqHLw2mDw
         jyOJa/RF4USzkaqRdOYfveA88/gkh1ICrIyGyVzRCLbA9S/7ccV+W9ed13Twr43HAIBp
         zc2I+6psjHvngKyHP+T2RQYLWcoVA3v77TMKRQmqaXsAJv0+bQBe6gPktaBlwyHoqFFt
         blFQ==
X-Gm-Message-State: AOJu0YweaeFR0882gi37B88vEBFiA68S6qlptaPcliFrWhs/vAuSP04F
	q+RGjFBWin1iM3sKFwxHC01ZTjJgyZgIvztGdNueD49fm2dpSZffa949OuqHRa1oMq1jB18yAXN
	vZg==
X-Gm-Gg: AR+sD11QEj38NMnu1egHNj+pc1OW/yamDUVHz9ZWd7A3+ZdZ/SIApuGEhF360sDZ5w3
	xAp0RkTvIiOERWLfSUZ4NnGwC+MbnRuwurmy7mbRuyVrDkr6Hy/xBhREWLYENFJu44amSjAoyPK
	79IU5RAZEQE+od5DyxN/9QevIqR1TNyBht/y/7GJ+TkZMUSj2tByThXWG+QygfJGFK6CB3S1a2z
	bE6JlL/0LbO1Y9Qx4esv6TBSPRSfyYZwiQkxx0BYtnaRF4BpcG6Vyv6ItttD5ijMdhduq8rB6tI
	bEe+ncsJNnBCR0K9oNTsUsfJHlkvnRYNsqIJ72D1gA54kblQmVsJuNYMykJdqvslaqF2UlwpLty
	hOI7+sGsLpQEnB4yJzrIJrYsQjdit/Up00z7ELVR9WM/Jv1qSxAxg50BUvwtoMvQe0vM+4+Qc2/
	NgAT9sPvRkWtRXXCkp4ybC44eG8sihH0gktXWCtnoH7UAWNayylGJkWoLvK2uN29udLZVZQB3+s
	3I6yNYqWJW2V4kx5w==
X-Received: by 2002:a17:90b:2dc1:b0:38f:de97:b06 with SMTP id 98e67ed59e1d1-3903c535d79mr34761030a91.5.1786195396004;
        Sat, 08 Aug 2026 06:23:16 -0700 (PDT)
Received: from xiaomip5p-elish-armbian.. ([2408:8220:6b4b:bb0:6a24:98cc:3eee:6983])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dbe349sm8681959a91.4.2026.08.08.06.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 06:23:15 -0700 (PDT)
From: GuLingguang <liu83783@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	containers@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexey Gladkov <legion@kernel.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	GuLingguang <liu83783@gmail.com>
Subject: [RFC] mnt_already_visible(): should regular-file mountpoints participate in the visibility check?
Date: Sat,  8 Aug 2026 21:23:09 +0800
Message-ID: <20260808132309.35924-1-liu83783@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

I have a question about the child-mount check in mnt_already_visible()
in fs/namespace.c, and I would like to understand the intended
invariant before proposing anything.

Background

The check considers an existing proc mount "not fully visible" when
it has a locked child mount whose mountpoint is not a permanently
empty directory:

        list_for_each_entry(child, &mnt->mnt_mounts, mnt_child) {
                struct inode *inode = child->mnt_mountpoint->d_inode;
                /* Only worry about locked mounts */
                if (!(child->mnt.mnt_flags & MNT_LOCKED))
                        continue;
                /* Is the directory permanently empty? */
                if (!is_empty_dir_inode(inode))
                        goto next;
        }

is_empty_dir_inode() returns false for regular files, so a locked
file mount under /proc (e.g. /proc/uptime) makes the whole proc mount
"not fully visible", and mounting a fresh proc instance inside a user
namespace is rejected with EPERM:

        bwrap: Can't mount proc on /newroot/proc: Operation not permitted

Real-world impact

This affects established workloads:

 * lxcfs (since 2014) overmounts /proc/meminfo and /proc/uptime with
   FUSE files; lxc reported in March 2016 that this blocked running
   an unprivileged container inside a privileged one
   (LKML: "user namespace and fully visible proc and sys mounts").
 * systemd-nspawn can mask paths under /proc (via --inaccessible=,
   overmounting them with inaccessible placeholder nodes);
   flatpak/bwrap inside the container then fails with the EPERM
   above (systemd issue #34226, still open).
 * droidspaces virtualizes /proc/uptime and /proc/loadavg the same
   way today.
 * Kubernetes works around mount_too_revealing() by mounting proc
   from an empty pid namespace (noted in the 2025 procfs pidns API
   series, merge 46582a15c174).

The invariant

The check's stated purpose, in Eric Biederman's own words
(commit 7236c85e1be5), is that fresh mounts of proc and sysfs must
give the mounter:

        "no more access to proc and sysfs than if they could have
         by creating a bind mount"

The original commit (e51db73532955) phrased it as verifying that
"the mounted filesystem is not covered in any significant way".

For a regular-file mountpoint, does a fresh proc mount violate this
invariant?  It seems not, on three counts:

 1. Content.  The only thing a fresh mount reveals beyond the covered
    file is the kernel-generated value of that file, which is already
    reachable through other means -- e.g. the real uptime is available
    from /proc/stat's btime and from the uptime(2) syscall, which are
    not affected by the overmount.  No new information becomes
    accessible.

 2. Structure.  A file mountpoint never covers a directory tree, so
    the directory hierarchy of the fresh mount matches what a bind
    mount of the existing proc would show.

 3. Permissions.  The files themselves remain subject to their own
    permission checks; a fresh mount does not bypass them.
    (One theoretical caveat: an overmount could in principle replace
    a proc file with a bind of a less permissive file (e.g. mode
    0600), which a fresh mount would undo, potentially giving
    non-root users in the namespace access they did not have before.
    I am not aware of any real deployment doing this -- the overmounts
    I know of virtualize read-only values such as uptime/loadavg/
    meminfo with unchanged permissions -- but I would like the
    maintainers' view on whether this caveat is a concern.)

Directory mountpoints are a different matter: a locked directory
mount can hide an entire subtree (hidepid-style masking), which is
what the check is designed to catch.  The question is whether file
mountpoints belong in the same determination.

Historical record

The behaviour for file mountpoints has been unchanged since the check
was introduced in 2013 (rejected then, rejected now), and I could not
find any record -- commit message, mailing list discussion, or code
comment -- in which file mountpoints were discussed.  For example,
the commit message of the 2015 rewrite (7236c85e1be5) speaks only of
directories.  If the rejection of file mountpoints is intentional,
could you point to where that intention was recorded?

Related upstream work

The check was relaxed earlier this year for restricted proc variants
(subset=pid) on the grounds that "almost all container
implementations override part of procfs to hide certain directories"
(merge a76640171b29, April 2026), and the 2016 LKML thread already
discussed the same problem, ending with a userspace workaround rather
than a kernel change.

Questions

 1. Should regular-file mountpoints participate in the "not fully
    visible" determination at all?
 2. Is the invariant the check protects about the presence/type of
    mounts on proc, or about the visibility of procfs's directory
    tree?
 3. Is there a recorded intent for rejecting file mountpoints, and
    does it still apply given the above?

I am deliberately not proposing an implementation yet; I would like
to understand the intended invariant first.

Thanks,
GuLingguang <liu83783@gmail.com>
