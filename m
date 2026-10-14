Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C4B535FB0
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984714; cv=pass; b=pcs03oWmsIYqBeEdBOw94LRs/2TG9vyorOcFqSOFfZkvtV8d7dI5Bqqjad8bflrX7Qo7vVD+QziyYdXu0qbSEZmSIm1K2d0wg0h/G++PjYTE4vLK0Nvab6EXwEOfJpvZHI57YWCa2TDhP5I8qOeLfOuWWat+9c/5MDLVoMEr4r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984714; c=relaxed/simple;
	bh=l8M9wQ3E23+IJRAwBWROiBwXA5zkS3zg6HFNxxkgIiA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=B4dnTC4vNGiLPl1XLzu1vhwcfxEI7ymDf54LGTb0DrPnVpaDj/6MAIO5Po6qADS20DTg9AtBWUvvOw8ESwndDBPFJUN1k3cPtxH5uqDQ3g4hlfBLo9dFbC0zchZCIi52A8rzpRjt4W5barzUcgRcD2SmaX6TZanjNvKapB1f3wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=studiomoob.com; spf=pass smtp.mailfrom=studiomoob.com; dkim=pass (2048-bit key) header.d=studiomoob-com.20251104.gappssmtp.com header.i=@studiomoob-com.20251104.gappssmtp.com header.b=rzyWzff5; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=studiomoob.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=studiomoob.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=studiomoob-com.20251104.gappssmtp.com header.i=@studiomoob-com.20251104.gappssmtp.com header.b="rzyWzff5"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-930c0f9c1b1so431351585a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 06:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791984705; cv=none;
        d=google.com; s=arc-20260327;
        b=Cq0eyJYYnAai4G20zDHQkSJ8b2o0YUVuOX07hffcdMmFhFOj0yrrRSN79oTxb/jqFM
         aVxzvPWMxMbGEdOsuaeTC0mJC1x+DppBosgRcmfB1KaUTJ2gOOL5Rkkcg7Qhrq3d+jsT
         87KqHcaUrf8F6/HVHLGiEkE33fNmM+HxVURXye+KsDJumhgOzHOCr0RuANIQBsjOcgkj
         2bTpLnqGccZSfy9h0MxfiL/c7/PfP+dzKDML24Bw1qR52VqZVDY5Ny0PPJrKPNmqKkbC
         Hk5O/nyLK5qBMPre3MJFlyMKZQN5XQBFg5iZgG1w6ZnAtWrZ/0P4NJs/MBZNL0WrhTLv
         IylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=fbkYUyGuzH3nskEVzwC6BL6xE0LYrhC+eXilhfDCRIM=;
        fh=on5so1iZ1tYm751VXv8x5u+l+XerJy9A4qWb/XOx/D0=;
        b=arWMV6bf7jkPqOh3+36SLrUkhOBqJzI5DsnBcyczXf0kjFqdfD1zaBe1r0eXCQYUaO
         iF0PteOjwJSt/UZtHfTEUDaLJ5VMMSqtL56C6pS/yaZW9RHAdJHY8AV7PuYAaXpUIpIi
         EAwNdgPatKqKAJcavEIwJHL+W5nZMfb6fvYJPXsgCzpSUAEPX1fDXswrWzBa3ezBnOGP
         oT4LQkfqmSgjAKRV4F7QOUpF2ttD3G8UP4pXqOajjFBKyqnQlzUJBBZIxWtxzYNRmrL3
         iWc8Zx8x+FzKzez2pndH8TgvOTumscgTlMgy3+WXM/40yfy6zo4a+/wFeJqMAv/xbA/Y
         xLQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=studiomoob-com.20251104.gappssmtp.com; s=20251104; t=1791984705; x=1792589505; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fbkYUyGuzH3nskEVzwC6BL6xE0LYrhC+eXilhfDCRIM=;
        b=rzyWzff560htshYqOgduROB4JC3+C2K7lOZ98YvPMrvI+jd4zHWVQhTcOrx4smDT+K
         GeYMEjkgviIYwcyy4iyHNnH9Cq6m60qSnUcrNDblnfzvZ/oNYhTnwRJ2OJ2pk13GmcfS
         zBFBjZg1GzvhSl9IZHEUH1nEnZeXNEiLRqwh3bCu/i/vQz8kwRcJuRs0gcwy0j6+4GxL
         Rw+g/y0K7h+zjW79JxNzaJpB5EA1lVLEu6jP8FPQxwKN/inqdnDmeCX8yApAi6m76L+3
         bkW7i+Yx/qzcUKLBC3zsMENSKf2l7t4HeNSHTD63xTwnoVKDDR3f4XWXYR9qirZeJ+8Q
         Vv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984705; x=1792589505;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fbkYUyGuzH3nskEVzwC6BL6xE0LYrhC+eXilhfDCRIM=;
        b=g3PV8HhqJgXDaBKwnC6Kn7G5VzAT6Tt6XVJ/gPa/RQSkMDoTkdUfo0iUxM70K/2NZq
         s4b1yL553WujKkaGHmgh0RhRnJlEnAGkl5b6xqygnkGHa+qavACTa/l4FE03g3IBGK6f
         z2uTo7lS+tRvXeMCzdibPjoScccQei/0dmchMaz3b8ZHHrYRI3jLE4AgAi1FUauT7GaP
         TI1sZR4NIehrgpZGnuplo13tc1jpQj5mUBxza0jXbsBEk7+KnlY7lds/1ARQArEhMoZq
         2hcb1wMboZUx0+apD0s4RjU5ZRa2zAGGvT/ZJV9a+xnPkgfsYjyi4CGf3lnmaJ0NQIzf
         Yv8g==
X-Gm-Message-State: AFq9FYLAfnAn0U7Upi4vylu9S2MS+OJXH2t4u21KaUsn5UkPtGh+UP/B
	8FAYlA1Y3QaLddeezq9/+069+YbK3u979xBV8vLRw//VMAJwgD87CAWP3aQBPVZYPEtSp48r42J
	LoUt4fQ4cTtBe0/P4FXi05NqYPxoZeulCOE77VPjFz3yTPeKZoP8mZZ0=
X-Gm-Gg: AYBFou22kx8zZxwiWUoRbxL8BddtG1Yiz2SiYiAcqmp8qPETvxicFhWJM5nXZ2N5ikd
	kGMCH6Tp0MgtAxh0iwGREFA50gql/+MgZN8uMPRRVR+KonHksXg4mgcOUOoMv7r41TUhbYgoAD5
	rbjRs3Ks8VfsSA81Fk8QXdnJOslw5sEoJc5wOBXJHfm0CQIvMEOF+GjyK0Pev/hFMZXYBiOkTAH
	yrEGZ9GV4mf09C7c/ACAQ5efAfkb/lQLtvfbCKcB9Oy+f+dec6T3PeWQgod8V6oEqIQU/8mj9ok
	bY7DQK7UzBB73UKAkuI+8Qr4j8LuGZilBWjY1Mbd/KfKL+hoomnXTgs6JiXchHuQigwIvRFJkEa
	s/aDau8Aaq3PH
X-Received: by 2002:a05:620a:1726:b0:93e:b00f:1ed1 with SMTP id
 af79cd13be357-93ebd1e013emr2611916785a.20.1791984705010; Wed, 14 Oct 2026
 06:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Cl=C3=A1udio_Fernando_Pinto?= <claudio@studiomoob.com>
Date: Wed, 14 Oct 2026 10:31:33 -0300
X-Gm-Features: AclHuK9cCgujIt8GxdpLxyfZ-MZdmilmby0zaluMhklWCby5xVCG0fRK0rJXqGA
Message-ID: <CACU5Mh9zba5qFLKxB8-YtyULzd33rdT31wDGgruaMQeZ_Ndovw@mail.gmail.com>
Subject: [RFC] Stacked fs: indexing a backing subtree while it is written
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I maintain MoobFS, an out-of-tree, experimental GPL-2.0 stacked
filesystem for 6.12 over one writable backing filesystem (ext4, btrfs
or XFS). It is not proposed for merging and this is not a patch. It
was developed with AI coding assistants; I review and test the
result, and it has had no outside review of this part.

The layer keeps an in-memory index of typed extended attributes of the
backing files, partitioned by subtree ("domain"). It used to be built
by a scan at mount, before anyone could write. Now the index of one
domain is built by the first query on it, while that domain stays
writable, and released again under memory pressure. I would like to
know whether the method has a hole I am not seeing.

Building (an online index build after Mohan and Narang, SIGMOD 1992):

  - the scan walks the backing subtree with the mounter's credentials
    (iterate_dir, lookup_one_len_unlocked). For each file it puts the
    inode number on a list of "files being read", reads the
    attributes with no lock of ours held (vfs_listxattr,
    vfs_getxattr), then takes the index rwsem and stores them only if
    no write path touched that same inode meanwhile; otherwise it
    reads the file again (16 tries, then EAGAIN);
  - every index update from the layer's own write paths runs under
    the rwsem after the backing operation returned, and marks the
    inode on that list;
  - a directory renamed during the build is put on a side list of the
    domain, and the build scans those directories again, in rename
    order, before declaring the domain built;
  - where a file sits (its depth and its domain directory) is read by
    walking the layer's d_parent chain with READ_ONCE under
    rcu_read_lock() inside a read_seqbegin(&rename_lock) section,
    taking a reference only on the domain directory
    (lockref_get_not_dead); a write recomputes it if a rename or link
    completed meanwhile;
  - a write to an inode with i_nlink == 0 is not indexed;
  - after the build, a directory rename inside the domain marks it
    stale and the next query builds it again, since the homogeneity
    rule of the index depends on the directories above each file.

Releasing:

  - one shrinker per mount. scan_objects returns SHRINK_STOP without
    __GFP_FS; otherwise it picks the least recently queried domain not
    used in the last N seconds (mount option, default 60) and takes
    the domain's build mutex, a "queries running" rwsem and the index
    rwsem, each with a trylock, giving up if any is held. The index
    rwsem is also taken from ->evict_inode, and all allocations under
    it run in a memalloc_nofs scope;
  - a build that does not fit the mount's index budget releases the
    least recently queried domains first: trylock on their build
    mutex, then the two rwsems taken blocking, from process context
    only.

The backing tree is assumed to change only through the layer, as
overlayfs assumes for its layers.

Questions:

1. Is a per-inode "touched while being read" flag, set by the write
   paths under the index lock, enough to make the read-then-store
   safe, given that the write paths update the index only after the
   backing operation returned? Or is there an ordering against the
   backing filesystem's own xattr locking that I should not rely on?

2. Is the walk above (READ_ONCE of d_parent under RCU, retried on
   read_seqretry(&rename_lock), lockref_get_not_dead on the one
   dentry kept) the accepted way to get a consistent ancestor chain,
   or does it miss a case that d_path or path walk handle?

3. For a filesystem-private cache whose lock is also taken from
   ->evict_inode: is "SHRINK_STOP without __GFP_FS, trylock
   everything otherwise" the right shape, or is there a rule I should
   read first?

Code: https://github.com/studiomoob/llmoobfs/blob/4500de4307e7f40d4bc9dd4867223c935f90c672/layer/index.c
Design record: https://github.com/studiomoob/llmoobfs/blob/4500de4307e7f40d4bc9dd4867223c935f90c672/docs/decisions/0012-index-on-demand-and-reclaimable.md
Tests: a build racing three writer threads per domain (writes,
renames into and out of a subdirectory, unlink and re-create,
directory renames), the same with a drop_caches loop releasing
domains, and fail-nth fault injection over the build, under KASAN,
UBSAN and lockdep.

Thank you for any pointer, including "read X first".

Claudio
