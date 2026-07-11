Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F04830E84E
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783803558; cv=none; b=BSa7M3tRaRe24uFXtASj18uW7HRxuVSrgOR5Z+Gwr5iU8rgXQZABcAlQfUxRiy0jDm6V9mvcYVnbLzl9sw/Y4tT4uC0rqcxqAwFHL66OcS53pq6B32vX19NWPldXAP5iRziYo0ig84co2oFlud2v7JxBH4Xp6L/Erb7iP+ol8Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783803558; c=relaxed/simple;
	bh=BdLjvl43qJKYBtpROXoommgDtCOwVioxXPtKnE5U+1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UekYBMsmiMtdvTuyI4xuqlocme6M8d/llGg7VUJoxJ4MsAMRJ0PAa70Zd6SQYnNXKMZkElHe1V6w+bfxJ/3+bI8cS4nHA6S3i0O3ttVQyYNgHzpFITqvcIR3lArE1xVNceqojlrl7sIr961ncwltIBtvKMiBd3YViGHw8TCWVMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7MQMv+n; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7MQMv+n"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-848882fdb18so1031587b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 13:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783803557; x=1784408357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jXbhO14ydDUZIjKR+B3+/kUtANGjzLqAnvpoUD+k32Q=;
        b=Q7MQMv+nV3ADb9M7RrrMmK2Jp5njqJzv3rvddtwIPKeNRqqkqPBniXslUs5UC8SFOl
         PcW98CO5u8uy3981972DWpC6xit+dp6Tfnaj1CVBoQ0Zv+7DE7HA4WIushvthZyfrNyc
         GcxUSJDfgz+88va4KPGsGqdGDAwHl3C8hgiy7JUlswH8KgC6+H+A8Grh9+54AFQsuGiW
         Gb84Vs1K0EXs5Cx34DF3p5x0Gf3qOx/nXLHyOry21FW0dbcVME3BkdfJ75BwUkVlCtZf
         59lxdeiahFKTMMJ95f/f24GC5CGBfN7nhYcnsOuR1Bp40EqF56N5ljQ8gxwLbwHXPBBk
         ee2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783803557; x=1784408357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jXbhO14ydDUZIjKR+B3+/kUtANGjzLqAnvpoUD+k32Q=;
        b=fGIKlBtMAvlSLXwFNDikW1gYAU/jJvi8b9OcODUN4E0AMibkgs05s53YBKjO11nE3a
         k3iUgBVLTZzuPyvX1Om9UKOVrwz2O/076JLumGXamW//xxU6uz3fsD4dSCHXahYZLgqf
         aqbClA+U/RYA4QNMa0/uwSzoKCkMArhq3acGESU4T+hknaLhH9BrfD63Vn5cxZucqYd9
         xRq7NWS+6RPIQYBOx0F6Txsyf81MYnPgLsEnb18XMXQB7Bk1gyRRVXNyO/XKUtxrQtc2
         1kMm3sCpyyZkL1bgl1JjtvXwYGvGpdJO+DOvc7ELzvtoaljDXTU0Bwp4nTt46190uoPS
         qQKw==
X-Gm-Message-State: AOJu0YyQiiILdlU55QOsl+EbSoA31yAFfOHd7+dlqHU/i5cFyd/mJ2Z+
	QlaCLpS7wxS3YjL0y4T+0OPzMlquY8ZNhLOMkxOeBgvnh1NomJG/rbUGxxqF4w==
X-Gm-Gg: AfdE7ckB833WL9gQghOrucyfXH5DS0cfQmUm3E7hbH8+Y5IXHruSFmsuVgkx8EmiV5A
	LYoQ9sh+zJvxODkxNL6YdtrQfQZqV1XrQLMMpFJPgY1zuJQmdTj410qvnPgY5K3LE1l0qJXvdWz
	l+VMIJWuL2cIFyBrZZuwSRAayZgkH/kt+g14LlTHu18lN36owqFTW1DO5cDB7udVTAVe3qudfDO
	2X0d8df3xJh2oL6pEef7DnEDK8PCZfXIGQPKMb1kky1nq3vNKeSiBo5092PdtgedAej8+CwD32j
	aVm26UBh15ASeQ39JN++/DLlSv9XbjeJn9UbyJtAMOtU3OoNMFS9MX0AA3WZOgCtZHWOX70fhrA
	ZAy7HkDVC4fJ4H5eINf9BmQSmFhPjwX81uWDUI4n/mpup7lEi5+yS3LmYF81Ox7c=
X-Received: by 2002:a05:6a00:1248:b0:848:4f38:b76f with SMTP id d2e1a72fcca58-8488971cf8amr4051433b3a.43.1783803556655;
        Sat, 11 Jul 2026 13:59:16 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84880a44feasm2092057b3a.20.2026.07.11.13.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 13:59:15 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	djwong@kernel.org,
	viro@zeniv.linux.org.uk,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH v3 0/5] minix: convert to iomap and add direct I/O
Date: Sat, 11 Jul 2026 13:59:04 -0700
Message-ID: <cover.1783707063.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is version 3 of the minix iomap conversion patch series. Versions 1
and 2 both had issues that syzbot found while testing, while Darrick J.
Wong gave some critiques of the version 2 patches that I have addressed
here.

This patch series converts the minix filesystem module from using the
buffer_head based path to the iomap API, and adds direct I/O support in
the process.

Patch 1 adds a new iomap_symlink_write function to
fs/iomap/buffered-io.c. This allows minix's symlinks to be written and
read without bypassing iomap entirely. (I considered whether this ought
to be broken out as its own patch since it's outside of fs/minix, but
decided that since it was suggested as part of this and is a necessary
piece that I would include it unless told otherwise.) This was suggested
by Darrick J. Wong, who also provided an initial implementation that I
only had to modify slightly.

Patch 2 adds the base iomap functions in fs/minix/iomap.c. This provides
the iomap begin/end functions which sit at the base of the rest of this.

Patch 3 wires iomap.c into the itree*.c files, adds version specific
helper functions, and moves the old buffer_head based functions over to
new names to support directory operations.

Patch 4 adds the new iomap file operations functions to file.c,
including the direct i/o functions.

Patch 5 updates the inode operations to use iomap, except for directory
operations which work the old way. The minix_symlink function in namei.c
is also updated to use the new iomap_write_symlink function.

Changes since v2:
  * Reorganized the patches entirely.
  * Addressed Darrick Wong's critiques of v2:
    - Added a new iomap_symlink_write function per his suggestion.
    - Removed the minix custom __page_symlink function that replaced the
      usual page_symlink function and the changes to minix_get_link that
      allowed symlinks to be written and read by bypassing iomap
      entirely. This ended up also removing both the issue syzbot found
      in v2 of the patch and the fix for it.
    - Reworked minix_iomap_begin to remove the nest of gotos inherited
      from get_block to use helper functions instead.
    - Pared down some unnecessary comments.
    - Dropped bmap entirely.
    - Dropped IOMAP_F_MERGED in minix_iomap_begin since there aren't any
      merged blocks to worry about.
    - Removed unneeded manual page cache invalidation.

This patch series has been verified to compile cleanly between each
patch and has been tested with a script that exercises mounting,
unmounting, file creation/writing/reading/verification, directory
creation and listing, symlink creation/reading/following, hard links,
file truncation (both shrinking and growing), deep directory nesting,
large files that span multiple blocks and indirect blocks for both size
and content, deleting files and directories, persistence, and that
fsck.minix behaves as expected for all versions of the minix filesystem.

Unfortunately, no version of the minix fs module can support an xfstests
run; all of the tests either fail (seemingly for reasons unrelated to
the module itself) or aren't run because minix doesn't support the
features in question. Getting xfstests to run would be nice, but either
requires or would be greatly helped by making changes to minix's mkfs
and fsck programs. It would definitely be a nice-to-have, but is outside
the scope of this series.

Jeremy Bingham (5):
  iomap: add iomap_symlink_write
  minix: add base iomap begin/end functions
  minix: update itree* files to add iomap functions
  minix: add file operation functions
  minix: iomap inode operations

 fs/iomap/buffered-io.c  |  31 ++++++++
 fs/minix/file.c         | 153 ++++++++++++++++++++++++++++++++++++++--
 fs/minix/inode.c        |  87 +++++++++++++++++++----
 fs/minix/iomap.c        | 122 ++++++++++++++++++++++++++++++++
 fs/minix/itree_common.c |  11 ++-
 fs/minix/itree_v1.c     |  25 ++++++-
 fs/minix/itree_v2.c     |  17 ++++-
 fs/minix/minix.h        |  24 ++++++-
 fs/minix/namei.c        |   8 ++-
 include/linux/iomap.h   |   4 ++
 10 files changed, 457 insertions(+), 25 deletions(-)
 create mode 100644 fs/minix/iomap.c

-- 
2.47.3

