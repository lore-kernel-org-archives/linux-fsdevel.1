Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440639;
	b=FUTmaj4Cr639afFzHn3eNf/f14r+LpADUO4YU98BHXQOQtOO23O5HFb4qMhboI8s+4J8
	 o1YYCrsL31SZUGjcrmfe2sqbOmS1rpAMIHjPfH0BaOYoadrM5TZPqxQ+jVlxM6W9kFDDe
	 rvj3fR9VSDcgzzg5F3KC+lYAi9RbXpKigoyxbyjlC8XQ1MZq5w8ekMEqr7yvIQZJCT7C8
	 aWMmPb1D6V6SJJlC7MMaDyI3MURdhX/hBlZqPYrIr/TTD64sylIjKColLEAsUMqI46Q3D
	 jBAfr1U4/2MRRnuuCZsQr8yhtgIV+WWIvBo5wHJXm5AyTXreHUDcydGLZnV3YH4rGtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OsyNUXVXYVasBHvigfoIW6Ne0ad3jx5r3liNsbVXCQA=;
	b=0QGhXiwYGi+C8DxSgkX6ipsAx6Y1cXbksEsDg+HBWRNnhDpS309wq0HZ0qsowl9GZOih
	 7wOJb2MVV31rXQJgDXfxf1mXWqLR+D4Ggo2YgcGmX3gfoZNDZe/3G7brlbOvjXhrJQrUs
	 q8BoZeRYx2rggSRF81m4kV+3U+e9RL0bTl2HpLG3IpesO95fxLv3u0BbiFllClm5oAMyz
	 GoXUBIuA7dJZQgDYFcOlX12vw5nSq9sdsP7BUkLBbMD0LaCkhDiimSdjOU8wuR/QkHalI
	 9GccnfYADOfGEyM22rnQzr/mqwmOIaWclVGJRCrl9gozpG27AfNg4OZB8/zBLJvSDhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XnTL5T+D;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8033E606A31C
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 09:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8033E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XnTL5T+D
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1f31c63ebso4175922a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 02:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793440638; x=1794045438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OsyNUXVXYVasBHvigfoIW6Ne0ad3jx5r3liNsbVXCQA=;
        b=XnTL5T+DL2phlNXmbqkLLhvirOg7giMe+mzsT6jZ3P8q/gtVkvtsUMetvI3WeBSUvk
         llwG/hhPLVMRmIyp8d5tgkbOZoBBQIuLCegr9vGom7SruDl1DB179AUZ/Yhhfxjzf7c7
         CxwW9/z1nouoKL6XVjZYisWJa+bfFOXecphWR9/tI5EnH739xdz7+xgWS5H71GI5KCAd
         nIdiHLJGUT8eLmrYRG9E2+VcvEy9Ru36X6uVFpmK7yOe6qdRHTjuMFHgVpM+Dy6CQgMv
         SyHcR9mvXrE9s3dzRZVY4TJ9SDpnQTzTYsZRKuGZqj4rI1QiINkvSJasKRJ0GPmbEcEb
         sXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793440638; x=1794045438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OsyNUXVXYVasBHvigfoIW6Ne0ad3jx5r3liNsbVXCQA=;
        b=luOHRczlmnxGcTza/lC4qEFOjxZHObpuSdpIxklQPZIJ5piR6h4nbh31YdwhDYTZR6
         FdNRbmPg/GLSirKhS6Yb5nGNIwcbTAxTfuYgShmZEeLBr/oAVdScVLwLi/a0HeXiCvpF
         l5IDk/LZOfmD/HYnCUxeJVObeZ5o80YPYsk8UdRCrNZSbP30taXFwWU5G+BHPgNWfSCd
         TSC5MoucxNyjgmSCYV/C3Z9F6RokN7XSQXT2MdPgrxK4AZ8UqRD4Me1UXgohmAlgIPc1
         0ius7vsDyoQYaf513Ep3m3VZ/gob1xS6Nf6C33i9etmmWhVXg0QW8GA4d7Ayu7PzMkBE
         O4fw==
X-Forwarded-Encrypted: i=1; AKwUvBxdq1QJNSHWQz0qgBPWKI35+vcx47lXZtLvF+Z6tOrd2gGwWZhTq5+yr5Or1g5Qm7YRDE6bj/68SZGBZdec@vger.kernel.org
X-Gm-Message-State: AFq9FYLV8O8RDyO88lllvixG4tjV3IMSSx7tL6DFy7ctSFdbxKcO5hQc
	4WesTQb9R9NvdvRbbcQSribO7jXDuBiQWBbDjvpTjY1OgV3iK33+eOYj
X-Gm-Gg: AYBFou36cAqksC+hXYQYyOFYOn247fAViViTut1+SgH1KpU1/3ULbRf5yjnF7Q0IDZ4
	Op8CKVlp/5/TgR0ndzyU6ultC7ocCJlqJtYwazEhMIbvlmMolJsFeyIJS5CyFpSf+2x2sknTqz/
	AfbSePoMoihogXyJLgz9+x+Hl1jhjg5Z+JMPApy+7+/kjLwR57xgpsPTYCsPp1j8MROml0WdECr
	eS9LHGMaPYCF08ZOVlQs1pC0F22h4WHgMyEO7qKx6ueMy4qnXkSLtBvRqAGq0VtGq4oCPhSFqxN
	mdyG6UIoTvB8gxGGacrDfvSFm0FvVN4bArT0DeJG2+LI2BULQhCozsYoBjd+bKQg5N++7NnIlxK
	VQaS7J8w4AxXpvqLVVc2YNIvJ5yXBtuDDDQ/9l8jamOtCgAnatJPSE/cEyvGFrEWuGFakdVAwL8
	DkwgnAfIN4ywBk6+NgnvlJ3IDlwSKsZUyAyUfeFBoU5yOj8GNi0QN49N0wAyrlEAHurHDtOr4Ay
	vHeRGjHaMnVZj2u0LxvRD7IuZ9lRFfB3LPl334jpfQbQn3aKT4/DbrF73b/dozyi/1HsccwPaki
	8iTUaHYEd6mTulIfog5ataXO5502PMhAymr4Glay8xnvm442OrNjYXEGnLXXLNGTO/h281SRlix
	lyyRnI7bgrF7mlKemeiN90mRYt9iGaK6FlQ==
X-Received: by 2002:a17:907:940f:b0:c2e:1b6b:8b19 with SMTP id a640c23a62f3a-c49d142cb22mr731014066b.23.1793440637746;
        Sat, 31 Oct 2026 02:57:17 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe1002asm162304466b.45.2026.10.31.02.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 02:57:17 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 7.3
Date: Sat, 31 Oct 2026 10:57:16 +0100
Message-ID: <20261031095716.3030288-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull overlayfs fixes for 7.3.

- Was in linux-next overnight

- Gone through the usual overlayfs test routines

- Includes one change in vfs code, factor out helper
  try_take_dentry_name_snapshot() with RVB from Christian

- Merges cleanly with master branch of the moment

Note that commit 8457ca071faba ("selftests/ovl: fix detached layer
mountinfo expectations") was already merged via Christain's vfs.fixes
PR from earlier today is duplicate and also on my branch.

Standard maintainers race and miscommunication. No merge conflict.
Let me know if you want me to drop this patch from my branch.

Thanks,
Amir.

----------------------------------------------------------------
The following changes since commit 214897acc8c2e5d6b63189d23ccaed6fa2af45a9:

  Revert "namei: don't reveal overmounted entries in refwalk" (2026-10-16 10:50:57 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-7.3

for you to fetch changes up to 1d27da7de3f74405b1de85ad26c5ea90f826114b:

  ovl: check the casefold flag of directories only (2026-10-29 13:40:31 +0100)

----------------------------------------------------------------
overlayfs fixes for 7.3

- Fixes for bugs found by Chris Mason's AI review, several of them
  reachable by unprivileged users: an info leak, use-after-free and NULL
  deref bugs, an RCU walk stall with remote layers and data loss with
  nfs_export

- Fix copy up of files with an empty security.capability xattr, which
  any user could set to block copy up

- Fix a regression from v6.16 with the override_creds mount option

- Two casefold fixes

----------------------------------------------------------------
Amir Goldstein (6):
      ovl: fortify ovl_copy_xattr() against underlying layer modifications
      ovl: add assertions in dir cache code
      vfs: add try_take_dentry_name_snapshot()
      ovl: skip copy up of empty security.capability
      selftests/ovl: fix detached layer mountinfo expectations
      ovl: fix mount setup failing when override_creds drops CAP_SYS_ADMIN

Chris Mason (13):
      ovl: do not copy up an xattr value that was never read
      ovl: set OVL_WHITEOUTS before publishing the upper dir
      ovl: check that the parents of volatile/dirty are dirs
      ovl: take a snapshot of the name for copy up
      ovl: do not take a name snapshot in RCU walk
      ovl: use the pinned upper dir in ovl_fix_origin()
      ovl: hold a reference on the parent in readdir
      ovl: do not copy up a dentry that was removed
      ovl: fix a torn path in ovl_get_redirect()
      ovl: read the nlink xattr of every indexed non-dir
      ovl: always encode the origin fh when index is enabled
      ovl: set the revalidate flags after d_instantiate()
      ovl: check the casefold flag of directories only

Hungyu Lin (1):
      ovl: reserve space for the casefolded name terminator

 fs/dcache.c                                        |  29 +++++-
 fs/overlayfs/copy_up.c                             | 110 +++++++++++++--------
 fs/overlayfs/dir.c                                 |  22 ++++-
 fs/overlayfs/inode.c                               |  16 ++-
 fs/overlayfs/namei.c                               |  11 ++-
 fs/overlayfs/overlayfs.h                           |   8 +-
 fs/overlayfs/readdir.c                             |  65 +++++++++---
 fs/overlayfs/super.c                               |  39 ++++++--
 include/linux/dcache.h                             |   1 +
 .../filesystems/overlayfs/set_layers_via_fds.c     |  18 ++--
 10 files changed, 233 insertions(+), 86 deletions(-)
