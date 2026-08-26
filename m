Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D79F483BC0
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780524; cv=none; b=Ij3tBRqZ1iHZkfiUpydHE6rGC62BEPfQZ8/2LgCggF5UaXfOQN/Iu3NRZTSee+MrY6+Lc9IqnYN6cssOJ8LJe9VFoFScmQmTRiNQF11CliC+vbqtHEFNVBU2dtmdS6KSjdto/lihjmMzmlI/5sF5dXNVx6CEZI/X6vRFs3VllQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780524; c=relaxed/simple;
	bh=qdbl4tS4znqtOBvivmpB37EDpPTAMeJAibHhx8BIKJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SrYsY+iP9sz7gOBl9pcPFJBQO9BAklswTud1lWOlG5A8XDroxYgFEcHIZFD+uDVAXBxlon0aIdFNfHL7ixu2i6oVsYGb8IGQjogbAHk78D8yOuFgTAw5XSCQthR0AWGlctjg+8xL4v6VGx+JIqMNkXmenWH2+dodUYADS9crDpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKpbw7Kb; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKpbw7Kb"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so644785a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 14:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787780522; x=1788385322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Zk7VlugDyGzxLjlwXgl2ZR+4w7uWEBNa3fcCWQx67Y=;
        b=MKpbw7KbpHU9jMnlazA3rX1HqdJuvI+yDtSIQ9vkd3uSTy4Wv1QUjKyiLlo7rqgr+U
         nSZcQ2o3UlImOPhrn6e7CY6DK707eSveRtXbe3GdTO4wri9gbQYvzOxelGP0vZEfszDR
         OYMNFOUmfxtsZAGMmA9JMHL8TEB4M8A2Mr5Gai8E4UwvTh6mWiMB2iYISNgf1ylDgQXG
         mTRtl3tiW/9q7UVrVDm+EjGk9vj9x+g3DuU7zyZDgxXl0+QTcLLDSwVRlC49tHF1bl+1
         KaVJvmyJUtDRiWYQJyTytJfoKbDW9UkfudNxCIPHE6vl9dxK5xdcRANsh+yOu1p8i7Ax
         1TzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787780522; x=1788385322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Zk7VlugDyGzxLjlwXgl2ZR+4w7uWEBNa3fcCWQx67Y=;
        b=M7i+PCLewT7v8Qlj/3Ds1ejkO24zUSmA2t6sBpw1AyEA+IRlke5baTm7slnl/drt8n
         sH9eliUH1lEh2lduogpDOyJXBI8q0xU4og8NzRJgmRi1mQxGWRBYHe3SfvXxY7NZsW9w
         vK6IyicHJAZOJ1uBuQs266Br6arLfyajwPr1+WJLUNbxe8bhASz1R1WUAh5CdI3Fbw2Q
         ecViIhTgJ+O3cn6M7pjPt66lshoTUz/gxP6Wuh4rmqyrf/rUIkZTeRE5bjwoMJB5AFaR
         z9AWMKgQq1uqRb6w3n1RXHm2ayrQA9KtqkBCZ+xuAM4ZHew4RoQMcc0AUCF41021xDze
         oC4g==
X-Gm-Message-State: AFuF++k2PyZx5oLpXaUTxLgE9EXHFJwsvmlCpbqOR3fxWUn80JMWJ2Lz
	6ql9DAJF4zY2v1mlgoCAIv9QnCA3C4I7I2WLHbM7jM2VhRoqgDS12FeVGC3eK0XC
X-Gm-Gg: AR+sD10lV8Sfkbyj8PZA/WEZ//Ch2RjFs7QDQ0/BQE/qaBuoMavCP49jfTLbXwv5iDe
	smnrITBqXcenBuM7w4wj8rEngQsFXxhF4NmYU19cBkhM2J6OwgTxTjJ/VsUzZvLbKHB0L/nWAbH
	uPAEjUCAalZTlH4gNyUB8QaBvXn11JUVAN6MONPSgOAQBGinboEf3BVN8AbkZunrX7HMaY9YKZn
	jfVk0R42yUlLqw5qXhz+IAHop1h0bluLIhS0sYx2IBVjwiJfxXhlx8LCrJk9NepT2WeVoh0kzPP
	j9F1Rtucwp83dWzVGhmy0lz4cUcT7GeV6vxY2FbqN+nn0IwSlqtvaXTCwi5RQTXwLVLc5S9RuhQ
	yF9A/54zRXp+vpxr03v9qxp2MjxruvHXI/USJ3s25JF2er8x0zl0RpKTuH+ZeW63fesqo/xhydt
	QMF2RtH8yebFba7Wn7Hz0Iy9/n0CHqw2mzTGo=
X-Received: by 2002:a17:90b:2e83:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-3966d160e93mr21873375a91.1.1787780522159;
        Wed, 26 Aug 2026 14:42:02 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396689f1419sm5628673a91.9.2026.08.26.14.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 14:42:01 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	djwong@kernel.org,
	viro@zeniv.linux.org.uk,
	hch@infradead.org,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH v4 0/3] minix: convert to iomap
Date: Wed, 26 Aug 2026 14:41:54 -0700
Message-ID: <cover.1787770110.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is version 4 of the minix iomap conversion patch series. Versions 1
and 2 had issues uncovered by syzbot. Version 3 fixed those and
addressed some critiques given by Darrick J. Wong, while in turn having
issues pointed out by Christoph Hellwig and Darrick J. Wong including 
having direct I/O in the patch series and proper testing. This version
addresses those criticisms.

The rationale for converting minix to use iomap instead of buffer heads
is pretty simple: it both provides a very basic example of a filesystem
using iomap, and it makes it easier to keep the minix filesystem in the
kernel in the future. It is a rarely used bit of computer history, but
it's one that's significant to Linux's early history. Plus, filesystems
are a hard subject to approach. Having a very simple filesystem in the
mainline kernel tree as an example for aspiring kernel filesystem
hackers would be good to help them learn.

Per Christoph Hellwig's remarks in the previous version of this patch
series, the direct I/O support has been removed. The iomap_symlink_write
function has also been reworked to be more useful for symlinks. The
original implementation of that function was proposed by Darrick J. Wong
as an alternative to the custom buffer head implementation symlink
function I had previously that sidestepped iomap for symlinks entirely.

One thing reviewers may find in here that seems very odd is the way that
iomap.c is included in itree_v1.c and itree_v2.c. This is in common with
how itree_common.c is included in those files and minix has been like
this at least as far back as the git history goes, and probably back
into the 90s. Not including iomap.c in itree_v1.c and itree_v2.c is
technically possible, but ended up being a massive headache to make
iomap.c stand by itself while itree_common.c is included in itree_v1.c
and itree_v2.c. Re-architecting minix to not require these separate
itree files with different versions of basic functions depending on the
version of the filesystem in question is possible, but definitely out of
scope for this patch series. If there is interest I could pick up a
patch series I made a little while back, dust it off, and give it
another go, but it's a pretty big change for a rarely touched
filesystem. I will defer to the collective wiser heads on that.

It is not possible to run xfstests against the minix filesystems with a
vanilla xfstests-dev repository because mkfs.minix and fsck.minix do not
support the proper options. There were some changes required in
'common/rc' to sidestep that issue, which fortunately did not require
any changes to mkfs.minix or fsck.minix. Once the tests were able to
run, there are also many tests that fail miserably because of inherent
limitations in all versions of the minix filesystems. Since these
failures aren't "bugs" as such, I then updated xfstests to skip the
tests that would never pass so I could focus on actual potential
failures and regressions.

Across all versions of the minix filesystems, there are 81 tests
skipped. Sixty-eight of them are unique to the minix V1 filesystem,
while an additional 13 are common to all versions. The exact breakdown
of skipped tests will be given at the end of this cover letter. I have
created a git repository forked from the main xfstests-dev repository to
share these changes for running minix tests. The minix branch can be
found at https://github.com/ctdk/xfstests-dev/tree/minix.

Leaving the skipped tests out, the iomap patch does not introduce any
new failures compared to the baseline in the master linux branch. The
iomap patches do fix a test that fails on v1 and v3 (but not v2):
generic/472, which tests swapfiles. After the patch, v1 and v3 will
properly report that swapfiles are not supported and the test is
skipped. Other than that, everything is the same and there are no
regressions.

This patch series has also been verified to build between each patch
being applied. Additionally, the minix module continues to function
between each patch.

======

The breakdown of the skipped xfstests:

13 tests skipped for all minix versions:

003, 075, 112, 127, 169, 249, 338, 347, 363, 563, 616, 676, 759

These failures relate to atime/ctime semantics, fallocate not being
supported, copy_file_range not being supported, sendfile not being
supported, FS_IOC_GETXATTR not being supported, not supporting dm-thin
cleanup properly, not supporting cgroup2 writeback accounting, not
handling I/O errors while unmounting, and not supporting filenames long
enough to be able to run the test.

These tests test features that no version of minix supports.

68 skipped only for minix v1. Of those, 52 are skipped because the 64MB
minix v1 filesystem fills up while the test is running:

013, 035, 074, 080, 087, 089, 100, 126, 131, 215, 245, 246, 248, 257,
309, 310, 313, 346, 394, 409, 410, 411, 430, 431, 432, 433, 434, 438,
443, 464, 471, 564, 565, 585, 589, 632, 633, 637, 638, 639, 650, 696,
712, 713, 715, 718, 719, 723, 724, 725, 732, 736, 741, 742, 754, 763

2 are skipped because minix v1 does not support fallocate at all.

749, 758

4 fail because fallocate is unsupported and the 64MB filesystem limit.

340, 344, 345, 354

Another 6 tests fail for their own reasons:

124: An aligned vector rw pattern test. Fails with output mismatch.
132: Another aligned vector rw test. Fails because the v1 fs is too
small for large writes.
192: An atime persistence test. Fails because v1 atime/ctime is wonky.
428: DAX mmap test. Minix does not support DAX.
706: A seek sanity check. Fails for v1.
707: Testing directory modification race condition during rename. The v1
directory link limit is too small to run the test.

======

Jeremy Bingham (3):
  iomap: add iomap_symlink_write
  minix: add iomap functions and definitions
  minix: finish wiring in iomap functions

 fs/iomap/buffered-io.c  |  34 +++++++++++
 fs/minix/file.c         |  30 +++++++++-
 fs/minix/inode.c        |  85 ++++++++++++++++++++++++----
 fs/minix/iomap.c        | 122 ++++++++++++++++++++++++++++++++++++++++
 fs/minix/itree_common.c |  10 +++-
 fs/minix/itree_v1.c     |  25 +++++++-
 fs/minix/itree_v2.c     |  17 +++++-
 fs/minix/minix.h        |  23 +++++++-
 fs/minix/namei.c        |   7 ++-
 include/linux/iomap.h   |   3 +
 10 files changed, 336 insertions(+), 20 deletions(-)
 create mode 100644 fs/minix/iomap.c

-- 
2.47.3

