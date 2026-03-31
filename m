Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB7363C47
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973346; cv=none; b=Dt0rSYqu8c+ZqanSrsYjYRWVxto0SpuXWv5WvfSWdjMg8F2JhVz2ijnwFBfDFJhXtHl+O64rnomVTPPitGJZFfShfombtDEuu/uavOuCGOUnQ6rRtBiscTrQB6wuD57Qr0YdNK4ETBrYStcgji30gcPffRee0TXznbH2Y5O3l4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973346; c=relaxed/simple;
	bh=8NiHJoWnyGoLZ8HlXI8Q5nWgT65wTTBn8F+eVynsvFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ryqSy3eHySPkUCgOubobZ25SIjgxpCGDjrTGRXGF0pKXpwhgnXRDuh3rrfisStUfZmgAK7gjjTkDiQml3Z9jbPjfi6mcDUIq0kvPm9VagBMFdS0lqKxvoY0yHnHEbQv7/Abhcmm19/z0R+Wgf+FdRT6sdJV783+1XJ6t1FmCdhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwE+ZFkd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwE+ZFkd"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so1972816f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774973344; x=1775578144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z6nIkg+M4Ho56ulVSYXGONPVGSrDDqFsxVsA34jDwtk=;
        b=iwE+ZFkdOR4VYxDL8E50EcZJNNvyiV9mcApXuaOc5IeWOkPiZr3BL5oqsSHqEoinS+
         9rsFThrKKJs0KMgdVadxT+6IGhcaq8b2Z/YSUgtMId2vodDhLtqc3jAlsKGALCaV9XFk
         ifZOHeOriMVIcs/pUK57zSmLDl3CBKcteS06Y6VT3zhEuD6gNZ+hDmVeQJ5zWbVDrIhs
         HgPRVlM3QHTHQHC/7kKyQLnebvn6hTFiUjhctHHzOHVRTdn9whOso5ovs8Ybj85zHZSY
         jKeS1w3NBb0kPIWR7U6fQK1Yqj4n5pmTWOUZSnj4SJpRbrUqRzTZ6XAkZYhTXdYP5o/q
         RDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774973344; x=1775578144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6nIkg+M4Ho56ulVSYXGONPVGSrDDqFsxVsA34jDwtk=;
        b=Uqpnfs0lrfIVVBNZxMLGS8S+DDlD/vK5wzjVizjSRFL47QGtonyrGHaDVImDfImbCJ
         TeZo29StUtmb0lIxE1kvnHQlco3oMH4o9gd6xIWxZK/z+eFxJIkQSZP8OG9gitJ0aLvc
         NxuJGq121F588lsam8pd55yUoL8WMLz87Omneu3un4Cc4QMYO0sjeKnS28YUKTrTlD0R
         UZ7p56PxH5x2RWdZGHcizjMk+kRfKHGqMWgLWT+OEwRRgvj4OoNcYe424r5Fp2xgGAug
         Oq5qFyWdVLaXMc7PZDV1Pz1VcwEH7zChBDk0yxKA0GrZCtIGi/KxcZMFvWvowxRK8kxW
         YmUA==
X-Forwarded-Encrypted: i=1; AJvYcCUGJiOiLS8E/OFaVQJ7DPhjOB20F9GiZzznE1OOeJgfwx/vL8Yyn3rkkraSmVgPX+34L16sUfqT7b9xA9U/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8UbMfYE9ybpGwRbYh5LzJ7NGHhlV/DSF/XOgFDvTUU7hVL/74
	F2W3uDwjSy2Gtz9Lr+JfHUgX8PbQwSeU/Lx/7sl1XFw49FkQj4GE0Ay+oA/Gng==
X-Gm-Gg: ATEYQzw3dw/e4TVhuorOlfs8Ktvu1piGbFuU+q9HfY4qJmawhAUmxJjFD/sO/lUYHIy
	6fvMwsU0P8yHs8B+BrBeqB6cahxbdYgYm1h562BHsR9rLe+NSrTO5qWbdubBM+jS4sKiq/CM0mA
	KiqwEUInlgkcR/6UYef+Ziyve314GSMBgjMMQTezBB1sg5hUMhNS1lz/0uYRjpT3OxN4oX/ccDv
	zXIqF8WG+kkT99T/H9M78aPd3tjFEu7v99SuY+4GSbmzq76jbdrdpXh88FoWzhHi4x5/rHCwF6/
	wvUiwmaYKWaBIqvlDw+2kX7PPZG7ivAf989tVpKuXyNe7/Uh0Cm7kDIYLNR9qHNZWr+hUeWzfgI
	ardGJiGKY2TtXylm7HsFKxleMXIaC060CRK2Pr9+IiuuVHD3r8+JzQf3sJbz60olKZvlEhq83Gl
	Q0sGTGNGICPOiqGexo+jhLXTbHHFuw3rT8x9U7Ug9mgtBr528UJc17fNV89yi0q9DO3pxpPcLpH
	w==
X-Received: by 2002:a05:6000:1a89:b0:43c:fbde:3101 with SMTP id ffacd0b85a97d-43d150e0f1cmr394102f8f.41.1774973343541;
        Tue, 31 Mar 2026 09:09:03 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e3602sm28792632f8f.4.2026.03.31.09.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:09:02 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v5 0/4] assorted ->i_count changes + extension of lockless handling
Date: Tue, 31 Mar 2026 18:08:47 +0200
Message-ID: <20260331160851.3854954-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stock kernel support partial lockless in handling in that iput() can
decrement any value > 1. Any ref acquire however requires the spinlock.

With this patchset ref acquires when the value was already at least 1
also become lockless. That is, only transitions 0->1 and 1->0 take the
lock.

I verified when nfs calls into the hash taking the lock is typically
avoided. Similarly, btrfs likes to igrab() and avoids the lock.
However, I have to fully admit I did not perform any benchmarks. While
cleaning stuff up I noticed lockless operation is almost readily
available so I went for it.

Clean-up wise, the icount_read_once() stuff lines up with inode_state_read_once().
The prefix is different but I opted to not change it due to igrab(), ihold() et al.

There is a future-proofing change in iput_final(). I am not going to
strongly insist on it, but at the very least the problem it sorts out
needs to be noted in a comment.

v5:
- reword some commentary
- add unlikely to the new icount check in iput_final()

v4:
- squash icount_read patches
- use icount_read_once in the new ihold assert, reported by syzbot
- squash lockless ref acquire patches, rewrite new comments

v3:
- tidy up ihold
- add lockless handling to the hash

Mateusz Guzik (4):
  fs: add icount_read_once() and stop open-coding ->i_count loads
  fs: relocate and tidy up ihold()
  fs: handle potential filesystems which use I_DONTCACHE and drop the
    lock in ->drop_inode
  fs: allow lockless ->i_count bumps as long as it does not transition
    0->1

 arch/powerpc/platforms/cell/spufs/file.c |   2 +-
 fs/btrfs/inode.c                         |   2 +-
 fs/ceph/mds_client.c                     |   2 +-
 fs/dcache.c                              |   4 +
 fs/ext4/ialloc.c                         |   4 +-
 fs/hpfs/inode.c                          |   2 +-
 fs/inode.c                               | 122 ++++++++++++++++++-----
 fs/nfs/inode.c                           |   4 +-
 fs/smb/client/inode.c                    |   2 +-
 fs/ubifs/super.c                         |   2 +-
 fs/xfs/xfs_inode.c                       |   2 +-
 fs/xfs/xfs_trace.h                       |   2 +-
 include/linux/fs.h                       |  13 +++
 include/trace/events/filelock.h          |   2 +-
 security/landlock/fs.c                   |   2 +-
 15 files changed, 130 insertions(+), 37 deletions(-)

-- 
2.48.1

