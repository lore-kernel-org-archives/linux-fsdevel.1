Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4242A80
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581333; cv=none; b=ZyW5I3cHUh0nrElMX054Tr9Vc1H0m1vaWlNTTa37NMt3KyK0P2FtWRktUbqOs/EsQl0JB2d5WFGppbSd13BO4embHKIpcvLwzOTNBMEaHc44ArvzE+1MnLF7QEvE8uunswP3bQphXEI7cp5GKyJQ3XdgHYSursvXgrpRBWeDQkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581333; c=relaxed/simple;
	bh=Hz+Z2JyFyfxjZbPIJeXp/Yd73bMzTFkDjsyGeDyOc6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKZJfYX0uIjJf56iHpssl2bCgA4fnCYHnhQspuqup8Uk1IBDwGqm0fXh5RYzeyLG7Y54HB/R6HwHyVMmnb89/2pDafDvXSPraZAzV1IDZNL3nO2Bkg28n/neLiFPV9t9D+biPU4QJPZ28ku8nSQsGj5br7FjtQYP5wzHXi4NHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEUz9k9q; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEUz9k9q"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ccf2360620so65377525ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581331; x=1785186131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pVzt+Rs65/uDATxOyUgU4i/ymqAoSrY8SaqMeq10Nvg=;
        b=DEUz9k9qgdBGWJS05KnJ/9tewWGPN9Xw0HdgkRJ+DYRKIxKq4qGLSYDA/bduNbsMZm
         yfnIS1zUawWyyisQb5h9rNJFHPXz3AbIm3HGORuOENH4o89nyPtUIRv5mO3YIHNuHeyj
         BTEHcRic1c5JKqvbePB5a4J1zJRrFY/yqLDB6LBw+3X/bNLQzzqURubN7FENo5x7aPRR
         QPhWC0oONIN2TgSmkh31NGZJ9V1MVMy+eu1i4NkDlJEj+RZgDW7vASx9+R74ODFgHsC/
         8xkzOZ8NLWXdYsNV37y18+oFQMkxnC0cvAPQxwpX0r3v3EI4A5BpEgKrqfQzc9SbyVus
         755g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581331; x=1785186131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pVzt+Rs65/uDATxOyUgU4i/ymqAoSrY8SaqMeq10Nvg=;
        b=TAXmP2PP8ic/lujdnSUtiTymTGT+NKTT1GAEzjW2ANxB1AM0bQh3U9hmZweh91dvsI
         dF4giLU9QvsYg9C8vU6Dlkl7KsdMfe6Q0+wDccrbsXy2EM5RFRtE5SjyJ0L2ZUJck86o
         AIOiUjev0e4NkiMvVuDL6jWbSITo+q9LXwDfdsRM97KKzxWmJmcTuBF3eVWK0rZqto1R
         mn3WInHFzndot2zbCZltJX54wF7Q3XCr1bRCVrdagyMqb4ZneNprndg5pbu8nkPX0gso
         O+Vpzxa3sE4IJmq2qEk/PWYMZmtIK9f3wXa+Zx8GAjkUfQyNg1PwUGhjVZx8CaRHVcIZ
         eirg==
X-Forwarded-Encrypted: i=1; AHgh+RqhvT0xcJ2c/VmfjcgrT5rkkLGe1CdjQlbi18KjHvaYNtMh+Q0gJ5mRt0laaqLp0Rdi/dAXk2mRFA4/VIFy@vger.kernel.org
X-Gm-Message-State: AOJu0YxdXi0decVCaCyy44sGRlBnKpUE/VIlqy/7aOgiwB5t6IMgWWa1
	whujNdSuu6TCgLmzxjBgPFc0mv/HqHzGRFv8CYu+W0F6DYrlyQCHHvYs
X-Gm-Gg: AR+sD12jx+BcIx7oNLQ8k9+krnCscRBfk36pOdZ1qVX4svQj9SA+z9lCd21VitoijEX
	mPbDv87JOILKfifdwxfzdFB5IJt5lcNOwcvpkb7LRZXoca3Gkvr86ib4gZm/pD+sh0d19E+8pJa
	kzBcp79e3PP4Os0S4IasYo1ADqpEmBvXPcusJKnVfFdx0g93VdhoaxvpTsBNd/1Gtws8HEfA7xz
	+CcATyVLu1KmipnUbpmzyf+KOz0KExrA3NiHI+KE+Ukd8sT9RnYLX8EfbmMQq4kYgyT8RBNGUrF
	EPgBMVT+cUL84Kuy19+Y2ZiXpXC5dZubHT/eYaNxh+KclhHkzcMmjYtwQM7+iCt2ToyhV0LcjnI
	voE57KXDMaVIZ5FWbT/FhvFglhcC0vQ3ovBP0rZGWbtfVeU78EcdrpRc7sd2wN841Xdl9HJWlSH
	yR6v2T2PipXHq50cDxIoOI8Hr+YsnuXB8qeFhbpLvPr+q4xwzQ6RR7CqX5RWqMfSE=
X-Received: by 2002:a17:902:e844:b0:2cc:307c:51fc with SMTP id d9443c01a7336-2cf348b2545mr175409445ad.21.1784581330936;
        Mon, 20 Jul 2026 14:02:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34783112sm63948965ad.79.2026.07.20.14.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:10 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	hch@lst.de,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: changfengnan@bytedance.com,
	kbusch@kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>,
	Dan Williams <djbw@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v3 00/20] iomap: convert to in-iter iomap_next() model
Date: Mon, 20 Jul 2026 14:01:42 -0700
Message-ID: <20260720210202.1163861-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements a suggestion by Christoph for finishing the conversion
of iomap to an iterator model. This revives Matthew's previous RFC [1], which
had the same intention.

Every iomap operation currently drives its iteration through a struct
iomap_ops, which contains two callbacks, ->iomap_begin() and ->iomap_end().
iomap_iter() only ever sees these as pointers, so every step of every
iteration is an indirect call, including on the hottest paths. 

This series replaces the begin/end pair with a single ->iomap_next() callback
that finishes the previous mapping (if any) and produces the next one.
Collapsing to one callback lets a performance-critical caller inline its
iteration loop and pass its ->iomap_next() function as a compile-time
constant, where the compiler can devirtualize the callback into a direct and
inlineable call rather than an indirect one. It also allows future callers
more flexibility in expressing custom logic in the IO path for driving the
iteration forward.

This series has no functional changes intended. The patches are broken down as
follows:

1) Patch 1: refactors existing iomap_iter() logic into an iomap_iter_next()
function. Sets up DEFINE_IOMAP_ITER_NEXT/DEFINE_IOMAP_ITER_NEXT_END macro.

2) Patch 2: has iomap_iter() and iomap_dio_simple() paths support
->iomap_next() in addition to ->iomap_begin()/->iomap_end() callbacks

3) Patch 3: (from Fengnan) optimizes dio simple path for callers who will use
->iomap_next() who do not need an iomap_end() callback

4) Patches 4 to 17: converts each filesystem to ->iomap_next() model

5) Patch 18: Removes the legacy ->iomap_begin()/->iomap_end() path

6) Patch 19: At this point, struct iomap_ops only has one item in it, the
->iomap_next() callback. Gets rid of struct iomap_ops and passes
iomap_iter_next_fn directly.

7) Patch 20: Updates the iomap documentation to match.

This series is submitted against the vfs tree on top of the vfs-7.3.iomap
branch (head commit e1b77fb85836 "Merge patch series "iomap: add simple dio
path..."). The changes can also be found in this github link [2]. This series
was run through an ai review system for sanity-checking.

As discussed in v2 about the merge logistics [3], the plan is for patches 1 to
17 to be merged in the v7.3-rc1 cycle and for patches 18 to 20 to be merged
after v7.3-rc1 has been tagged, in order to minimize disruption to filesystems
that are currently landing iomap conversions during the 7.3 merge window.
Patches 18 to 20 are included in this series for upstream review, so that
hopefully they are all approved and ready to go when the 7.3 merge window
closes.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20200728173216.7184-1-willy@infradead.org/T/#u
[2] https://github.com/joannekoong/linux/tree/iomap_iter_next_v3
[3] https://lore.kernel.org/linux-fsdevel/20260703-nachrangig-gegeben-befestigen-8219a53648c7@brauner/ 

Changelog
---------
v2: https://lore.kernel.org/linux-fsdevel/20260701000949.1666714-1-joannelkoong@gmail.com/
v2 -> v3:
* Rename iomap_next_fn to iomap_iter_next_fn and iomap_process() to
  iomap_iter_next() (Darrick)
* Add integration with dio simple path, add Fengnan's patch
* Reconstruct patch that adds iomap_iter_next() logic as a refactoring of
  existing code (Christoph)
* Add DEFINE_IOMAP_ITER_NEXT{_END} macro, which nicely simplifies things
  (Christoph)
* Make documentation wording changes and a rename from dops -> next (Darrick)
* Update tracepoint in patch 19 to reflect taking iomap_iter_next_fn instead
  of ops. iomap tracepoints are explicitly called out as non-stable ABI so I
  kept Christoph's reviewed-by for this, but if that should be revoked, please
  let me know
* Add reviewed-bys

v1: https://lore.kernel.org/linux-fsdevel/20260625024723.1611000-1-joannelkoong@gmail.com/
v1 -> v2:
* Implement conversion for all callers

Fengnan Chang (1):
  iomap: skip the finishing iomap_iter() on the simple DIO read fast
    path

Joanne Koong (19):
  iomap: split iomap_iter() logic into iomap_iter_next()
  iomap: add ->iomap_next()
  xfs: convert iomap ops to ->iomap_next()
  btrfs: convert iomap ops to ->iomap_next()
  ntfs3: convert iomap ops to ->iomap_next()
  ntfs: convert iomap ops to ->iomap_next()
  ext4: convert iomap ops to ->iomap_next()
  erofs: convert iomap ops to ->iomap_next()
  zonefs: convert iomap ops to ->iomap_next()
  ext2: convert iomap ops to ->iomap_next()
  block: convert iomap ops to ->iomap_next()
  f2fs: convert iomap ops to ->iomap_next()
  gfs2: convert iomap ops to ->iomap_next()
  hpfs: convert iomap ops to ->iomap_next()
  fuse: convert iomap ops to ->iomap_next()
  exfat: convert iomap ops to ->iomap_next()
  iomap: remove ->iomap_begin()/->iomap_end() legacy path
  iomap: pass iomap_iter_next_fn directly instead of struct iomap_ops
  Documentation: iomap: update docs to reflect iomap_iter_next model

 Documentation/filesystems/iomap/design.rst    | 140 +++++++++++----
 .../filesystems/iomap/operations.rst          |  68 ++++----
 Documentation/filesystems/iomap/porting.rst   |  16 +-
 block/fops.c                                  |  10 +-
 fs/btrfs/direct-io.c                          |  10 +-
 fs/dax.c                                      |  48 +++---
 fs/erofs/data.c                               |  30 ++--
 fs/erofs/internal.h                           |   3 +-
 fs/erofs/zmap.c                               |   4 +-
 fs/exfat/file.c                               |  20 +--
 fs/exfat/inode.c                              |   6 +-
 fs/exfat/iomap.c                              |  12 +-
 fs/exfat/iomap.h                              |   6 +-
 fs/ext2/ext2.h                                |   3 +-
 fs/ext2/file.c                                |   4 +-
 fs/ext2/inode.c                               |   7 +-
 fs/ext4/ext4.h                                |   6 +-
 fs/ext4/extents.c                             |   8 +-
 fs/ext4/file.c                                |  15 +-
 fs/ext4/inode.c                               |  14 +-
 fs/f2fs/data.c                                |   4 +-
 fs/f2fs/f2fs.h                                |   3 +-
 fs/f2fs/file.c                                |   4 +-
 fs/fuse/dax.c                                 |  12 +-
 fs/fuse/file.c                                |  10 +-
 fs/fuse/virtio_fs.c                           |   3 +-
 fs/gfs2/aops.c                                |   6 +-
 fs/gfs2/bmap.c                                |   7 +-
 fs/gfs2/bmap.h                                |   3 +-
 fs/gfs2/file.c                                |   6 +-
 fs/gfs2/inode.c                               |   6 +-
 fs/hpfs/file.c                                |   6 +-
 fs/internal.h                                 |   1 -
 fs/iomap/buffered-io.c                        |  40 ++---
 fs/iomap/direct-io.c                          |  57 +++---
 fs/iomap/fiemap.c                             |   8 +-
 fs/iomap/iter.c                               | 122 ++++++-------
 fs/iomap/seek.c                               |   8 +-
 fs/iomap/swapfile.c                           |   4 +-
 fs/iomap/trace.h                              |  15 +-
 fs/ntfs/aops.c                                |   6 +-
 fs/ntfs/file.c                                |  26 +--
 fs/ntfs/inode.c                               |   2 +-
 fs/ntfs/iomap.c                               |  34 ++--
 fs/ntfs/iomap.h                               |  15 +-
 fs/ntfs3/file.c                               |  16 +-
 fs/ntfs3/inode.c                              |  11 +-
 fs/ntfs3/ntfs_fs.h                            |   3 +-
 fs/remap_range.c                              |   6 +-
 fs/xfs/xfs_aops.c                             |   8 +-
 fs/xfs/xfs_file.c                             |  48 +++---
 fs/xfs/xfs_iomap.c                            |  48 ++----
 fs/xfs/xfs_iomap.h                            |  24 ++-
 fs/xfs/xfs_iops.c                             |   4 +-
 fs/xfs/xfs_reflink.c                          |   6 +-
 fs/zonefs/file.c                              |  23 ++-
 include/linux/dax.h                           |  18 +-
 include/linux/fs.h                            |   7 +-
 include/linux/iomap.h                         | 163 +++++++++++++-----
 59 files changed, 680 insertions(+), 543 deletions(-)

-- 
2.52.0

