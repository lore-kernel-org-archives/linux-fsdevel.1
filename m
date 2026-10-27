Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793135386;
	b=1ZRZEvl/k2/d5gmAJImd6U3oHHV2UfIQq5qZZnd+qtmAI9YyuaqiUvUacCMQbVYPG7b5
	 ed0fdEIwu3GKFO13CooCCbXRJYG8L8FK9c3Z0tMh2DEahet5GFpxNSjEzyrB1DTsXFRG4
	 YitxHFhP14oo2hlA3kXDhxc0c4MjGmeind+K8+FyISB2pQR1THcpTH2Ao0a3Kxqg88cwu
	 DhQjryp+KGXKB/8VEZMQeZ3cDvCfLfH/etdkNOe2M9DRN5BTtwqRt1Bs8DoFtC+SRsmhK
	 sUr+z+v0DbhX/qmNldume2lge3yiePfPr+L0/d5yDVJtCLcjriixK5DG4Sj0rqa/suQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=5yaV0MrGZjfbjClKYo8Ny4CNWoT1WKIK7K51uc+1CPs=;
	b=qarqybPFbnUst7NcDLcBZFCq6p216N09HLCcC0ac3shR9YfRePWof9ZOQHZONzNjjnmJ
	 MHQU9blycUzyW8GfhF5A2xZJggIP38aoazHwJckA7CHVzVHvcG8HOpElZTDT+rSDPECMO
	 aR2pF+ry7tVJAQI4wSp5G0Sb7Lpk/D6zGpFpd/boKx5Ajcxz/ocvgU2xDeyDcMrDgfJei
	 U+JAtuU7XGNRj3YGaUTlROOZePYBh5CU3SQuMY1pGxXHWG+/htvv3E9mKOpYryb6H+IFA
	 Q7EJND0AtUGDED6Nq/zohsli9JSbZ6uTohakpaeGM3e9eo4hf5IzaMMXwtLUG2y8RPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=RBotA6AM;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97716606A32A
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 21:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97716606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=RBotA6AM
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91b54d1e9cdso2820526d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 14:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793135384; x=1793740184; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5yaV0MrGZjfbjClKYo8Ny4CNWoT1WKIK7K51uc+1CPs=;
        b=RBotA6AMrY5SW4z7ZoMZxTZ13mjyqmrSaedFef1gawwn5x+0q28a7dBuM6gBzJinqI
         VtLhc/f5y72w/EoeH/t/yCTbASy+Pl5iW+eh6Ixb60pzGz0s79DL9lIXwngqLwWC9h8W
         3CSn1qyAWgAh44IIK5+iQ1ziFdFlGPyFGqMzTbZgTHFtx6CyHxc+qeVe0oL1l+aIbiDk
         IMyzp+XV+9v8LlusQ2paqxdSmed7+3YiZ+Lttgqf+KJ57+C3cFhMqQCDF4zAu2p2AXbc
         jl14UoPymgVRUJr/Ly1hSIhTbXf7QaVAmmpk2yr5v4BmJFT1CzQnzIfCsuwafT3PTxbl
         ASJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135384; x=1793740184;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5yaV0MrGZjfbjClKYo8Ny4CNWoT1WKIK7K51uc+1CPs=;
        b=UkvjTRHVB5lEBWAppuQKJF2MRMMLIu5OSAz6uvTjVxVMHVlgi4thxVMdoqowOcqqpz
         MqKhLd27nfu3uhTSyOuL96WtS0b9c1Z5PDCvXFBMjLv626fPnsXN4ZE4NK7FjUFjwyJT
         byzlxVyRZTLIIDfrmkTbva5KWEP/1ggZJ0Wn6qSQScGD+0TRSIQcuBM2zTOYekMpwFVw
         QstonzwyaDQlZCy6+N0/1hG8hkD/6XzNblqLdV1D+NyQuedTqYNNtTWCgSEO4gFvJMZ3
         tl8QEHctqidV4K+IP3ix7vzBLvB8G2j67wGgEoL4FSp3fQAq1c/dg3pNWxxtJW2/2z+D
         2eVg==
X-Forwarded-Encrypted: i=1; AKwUvBwFNUDx86BO1kn71ZpIzaiDglJLZJKtI3efANkjEoxB+e1SLBt4BmylBA0VWsc++1kF6yQOPv540UXSDesc@vger.kernel.org
X-Gm-Message-State: AFq9FYI7eNQ5FFLRbNayntWHF+ogYpKzgQV5BWP1H7jNlk9DywKGJSe2
	y1c5OSlCTPY7nsipk99nykIS9kZznolQ98pwzqqtoRIpns6/3mn8GqOfRw9jBub7vaw=
X-Gm-Gg: AYBFou3zlpyj21Z+RVfdcDQwUzvSRCg0Hs8ThbiGMb8RysQX2KNG2X155JLUmCR4ph9
	FqKWHIY7CNOVJk7xhcclJ3tEd37W4vuGsI6keesb0h1SFFM9LlzCXzzro20PoH+3SCSV33m18ER
	PP0MEBNq2avzi05UwgMtr4K2+iSMTJZiTOO6VxVS6n9aE97anFSgHTpX9GYfi/tLB8hnPLI/mh5
	pg3m5o2Y6n+3R7rNXFp+lqN77ZvNTiFE+fLJFFsomyn0VZErifisqTWyd08G0nb6OaDK5vb3sTh
	Yd4Lqfp5favPhJmAGp7wmDFJFHCoDWDYYmxOrdx3AtPx5KpZ7+5Vb7LcCPFO1qPBOCw1rxPZpwq
	5dfBJwpJZjbVTtyrKmVGuVYr5A6wBJ4Uyst/xpmVXU9TU2gfhpiZxirfWbyunXhglANbIT2g4KC
	r19vf7OGWCuBPYDQeEc1H5DHk87/y0PDCyjCCuVAgY90RuPuweLfKBKToTSAOw2sQr4CXb+9Leq
	fzRtiusmqqELGaZl1yJtKM63MBkWrOiSQdTtXCcppvAWwjn6HYBQ0U6zeyJ8c69O6um3An+
X-Received: by 2002:a05:6214:27cb:b0:91c:75ef:5532 with SMTP id 6a1803df08f44-91c7d1d3ademr5763756d6.39.1793135384460;
        Tue, 27 Oct 2026 14:09:44 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c6f3bcsm115390716d6.29.2026.10.27.14.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:09:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 00/10] ovl: only sync what was written through the overlay
Date: Tue, 27 Oct 2026 21:09:26 +0000
Message-Id: <20261027-b4-ovl-containerized-sync-v1-0-802e512379a6@toxicpanda.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAgT4WoC/22MwQrCMBBEf6Xs2UVTilB/RTxskq1dkY1k26KW/
 ruJXj3M4Q0zbwXjLGxwalbIvIhJ0gJu10AYSa+MEgtDe2iPrgR9h2m5Y0g6kWg5vzmivTSg63r
 P0dHAPUH5PzIP8vy6z5cf2+xvHKYqrAtPxugzaRhrVXH/Xw7b9gEmEA4UqwAAAA==
X-Change-ID: 20261026-b4-ovl-containerized-sync-149bed1afe9a
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Carlos Maiolino <cem@kernel.org>, 
 David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Chengguang Xu <charliecgxu@tencent.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793135381; l=5905;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=+crzd0tBMr/UBfX6IWY1ogoL1S7H36SezVAnEBaM4h4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLNA+g18G2UYQwcLgDAIZjnxe1y3YDkj2blf+cEZ1mNJj1wlMBGOCr6nzxrJ4/i8scm2uN0rurD
 a7WYNNeMrSgo=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Hello,

This picks up Chengguang Xu's "implement containerized syncfs for
overlayfs", last posted as RFC V6 in November 2021 [1].

syncfs() on an overlay and unmounting one call sync_filesystem() on the
upper file system, so they write every dirty inode on it no matter who
dirtied it. We run a lot of containers on one upper file system, and
stopping one of them writes out the dirty data of all the others. That
can take a very long time, and s_umount of the upper file system is held
the whole time, so anything that wants it exclusively queues up and then
everybody else queues up behind that.

With this an overlay only writes the upper inodes that were changed
through it, and then has the upper file system commit its metadata.

The V6 discussion ended with a direction but no V7, so that's what I
tried to follow:

 - V6 kept every overlay inode with an upper inode dirty for good. Jan
   and Amir didn't like the cost of walking them. Now an overlay inode
   is marked dirty when the upper inode is changed, mostly from
   ovl_copyattr() as Amir and Miklos suggested.
 - It never looks at the dirty flags of the upper inode, Miklos pointed
   out that they're cleared when writeback starts.
 - ->write_inode() goes through write_inode_now() on the upper inode,
   and keeps the overlay inode dirty while the upper inode is open for
   writing, which covers shared mappings.
 - V6 marked the inodes DONTCACHE, which Jan was worried about. This
   goes back to the v5 patch that keeps dirty overlay inodes cached.

One thing is new. V6 called wait_sb_inodes() on the upper file system to
catch writeback that was started but not finished, which waits for
everybody's writeback. Instead ->write_inode() keeps the overlay inode
dirty while the upper inode has pages tagged dirty or under writeback.
The tags don't have the problem the inode flags have, the writeback tag
is set before the dirty tag is cleared. So a clean overlay inode means
its data is on disk, and syncfs() only waits for its own inodes.

That takes care of the data. Metadata is harder, a lot of what is
changed on the upper file system has no overlay inode that could be on
the dirty list: the root of the overlay isn't hashed, and whiteouts,
index entries, the work directories and their parent have none. File
systems that log their metadata don't care, ->sync_fs() commits it. ext2
does, there a whiteout was gone after a crash. I first had overlayfs
write all of those itself and kept finding more of them, the last one
was the link count of the shared whiteout when a whiteout is removed.

So patch 1 adds a superblock flag, SB_I_OVL_USE_SYNC_FS, by which a file
system says that ->sync_fs() commits all of its metadata, and patches 2
to 4 set it for ext4 with a journal, xfs and btrfs. Without the flag on
the upper file system nothing changes, no inode is marked dirty and
syncfs() and unmount call sync_filesystem() like they always did.

Patches 5, 7, 8 and 10 are Chengguang's with changes noted in them,
patches 6 and 9 are new. I dropped Jan's Reviewed-by tags from V6 since
the patches changed.

lazytime on the upper file system needs its own handling. The flusher
leaves the timestamps in memory for up to 12 hours, so the overlay inode
can't be clean, but it can't stay dirty and pinned for that long either.
Patch 9 gives it I_DIRTY_TIME like the upper inode has, and forwards
->sync_lazytime() to the upper inode.

Things I know about:

 - An overlay inode that loses its last reference while it is dirty is
   kept until it has been written and then sits on the LRU, like with
   any other file system. Clean and unlinked ones are still freed right
   away.
 - Every overlay on such an upper file system gets a bdi.
 - I haven't measured syncfs() with a very large number of dirty inodes.

For testing I put several overlays on one upper file system and dirty
192M next to the overlay under test, through another overlay and
directly. Then syncfs() or unmount the one overlay, copy the block
device as it is at that moment, mount the copy, and check that
everything that was changed through the overlay is in it and that the
192M aren't. That passes with ext4, xfs and btrfs as the upper file
system. With KASAN and lockdep on, syncfs() goes from 239-284ms to
45-48ms and unmount from 126-234ms to 39-44ms. With ext2 and ext4
without a journal the 192M are written as before.

fstests with -overlay, the auto groups of generic and overlay, gives the
same results with and without the series on ext4 and on xfs.

[1] https://lore.kernel.org/r/20211122030038.1938875-1-cgxu519@mykernel.net

Thanks,

Josef

---
Chengguang Xu (4):
      ovl: setup overlayfs' private bdi
      ovl: implement overlayfs' own ->write_inode operation
      ovl: cache dirty overlayfs' inode
      ovl: implement containerized syncfs for overlayfs

Josef Bacik (6):
      fs: add SB_I_OVL_USE_SYNC_FS
      ext4: set SB_I_OVL_USE_SYNC_FS if there is a journal
      xfs: set SB_I_OVL_USE_SYNC_FS
      btrfs: set SB_I_OVL_USE_SYNC_FS
      ovl: mark the overlay inode dirty on modification
      ovl: handle lazytime on the upper filesystem

 fs/btrfs/super.c               |   2 +-
 fs/ext4/super.c                |   1 +
 fs/overlayfs/copy_up.c         |   2 +
 fs/overlayfs/dir.c             |   1 +
 fs/overlayfs/file.c            |   8 ++-
 fs/overlayfs/inode.c           |  21 +++++-
 fs/overlayfs/overlayfs.h       |  28 ++++++++
 fs/overlayfs/super.c           | 145 ++++++++++++++++++++++++++++++++++++++---
 fs/overlayfs/util.c            |  14 +++-
 fs/xfs/xfs_super.c             |   2 +-
 include/linux/fs/super_types.h |   1 +
 11 files changed, 211 insertions(+), 14 deletions(-)
---
base-commit: 2c8a968b488c134d05ccefff890270ac8ab899a8
change-id: 20261026-b4-ovl-containerized-sync-149bed1afe9a

