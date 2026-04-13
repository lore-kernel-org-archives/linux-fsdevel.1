Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4AE3C3BF1
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083057; cv=none; b=G0JWqvTpLxKQRPm0gVIPQ9ZomUjpnIX8VyR+gT5EWS+vF+U27v8pnKjESVgvzY+l9hpTc/fTefFZwxv3A4bY1UEUX7qH6lD/LMO1VtxnSHCzkcK4jFtt29GktNFnDLI+iBlt8ynS2zFCSYWTUh6CXab+BzYJFfc/x8q98JFaMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083057; c=relaxed/simple;
	bh=W6Yg4ksBDc415XgtlNd66ie2t44DTmR6Gl2MEOmu/4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lrj3G3TliQ5mCurqa8XuXpDlDzaauYa2sWGnJfX5fqf9qtR5XsCAM4mTPHMshsKDhdvpVbXVcwkXUY5mnqLd1WrB/STMzq3fmEkKekNP1Gmjn2wEpNLmWVVx2EiToTxfOf31BJLVnMxfwvEXD3Q3/ozZs+YsjPy4go7HnvLqROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d7b879691so64758f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 05:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083054; x=1776687854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+Lahrzrgk6CwlPElUw4Plq1IP8p7iTjH1OLtfPx/+c=;
        b=fL8CA3Vf9++cw4oippgpF1VjFTj+4Qa0mI0AMP/YlMPhtAp0Ih/bNooda/CV0+Gvbe
         z958NidH34PlXd5c7wr7wuIc/yBlyDmVKIzj2Ufrkbk6tnV360+kKnAz3R4wAqyLRlae
         0ZwnUcqj/LzOk/SqOnct5/KuXmY4cGPuTz+CgWseLf6McyXoiyOTCi8Qk4yTxhGPOmx3
         U+JzYHzbUgPDWJl8gYckorYDccNVSu6C5DNhNEYXuTzlVl1HfO4uNdi934e5GXfFsD+Y
         80xGPR1gcRouPNw1gM48slduVO842i7VaGqjKMkusukLvwE1vlU53bD/oua6Cqb4VcJC
         dmbg==
X-Gm-Message-State: AOJu0Yw1IKGUWtHuurZ2VVeyiikgEGpc0BZpFWSXq1YMe9VIkmjuVSDU
	0i25+97Nvogl3ZVXGVQQ2FD0+UgUn05sxpZivrYLDrvPucL6V+ZydOHohZAY8FIEToA=
X-Gm-Gg: AeBDiesgjhFSwJGt+AcIOjQVQ9VOTShhmioT1/Zyn5EQM3Bpk49VlEL0jxa3hwXiAH3
	WQcVd2nBzqmgInsyYxt8uUC9+3gI8NJnPPhH2GZKHvvW9bTLq+gZm7YEBpJOdt/p+DL21T66klg
	iQh0auk3OuH0Fc8f1lQEB8gZTTEFkUi0JIIO5doWFdHe2OALJvv87QgpE+KKc1jsQG7RJldSVlo
	qV0aQ59irt4Ex1qDVgn9gsdsJOktDVZ/VW22OFL7XRtz9b6qN90l9XZ0FV5udbMSGh9sC8v+lEk
	zefujNkzw0t9wp2Z1ja1Gevagm6ob6IMr84HgiBrTQEg0nucf+Ul1IbffItFihHdM1U2ZzkTeUZ
	bj7ZqQE7Is86owl2DcN/ZosxQBYrjG1vT3OMgX3T1iddKr5d58DmcR783tutZgvIzKb+n9ObsfQ
	Zjybue8OUpCU6hVezKhJhXRYtOjmvwKvCNy5oWNutg6ilhGA031JgqgibeKmtC1SUpRw==
X-Received: by 2002:a05:600c:630d:b0:488:a87e:dad8 with SMTP id 5b1f17b1804b1-488d6abed83mr95011265e9.8.1776083053453;
        Mon, 13 Apr 2026 05:24:13 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ed4dsm278260915e9.4.2026.04.13.05.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:24:13 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	aurelien@hackers.camp
Subject: [RFC PATCH 0/10] ftrfs: Fault-Tolerant Radiation-Robust Filesystem
Date: Mon, 13 Apr 2026 16:23:46 +0200
Message-ID: <20260413142357.515792-1-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aurélien DESBRIERES <aurelien@hackers.camp>

This RFC introduces FTRFS, a new Linux filesystem designed for dependable
storage in radiation-intensive environments, targeting embedded Linux systems
operating in space or other harsh conditions.

FTRFS was originally described in:

  Fuchs, C.M., Langer, M., Trinitis, C. (2015).
  FTRFS: A Fault-Tolerant Radiation-Robust Filesystem for Space Use.
  ARCS 2015, LNCS vol 9017, Springer.
  https://doi.org/10.1007/978-3-319-16086-3_8

This implementation is an independent open-source realization of the
concepts described in that paper, developed for the Linux kernel.

== Design ==

FTRFS provides three layers of data integrity:

  - CRC32 per block and per inode (hardware-accelerated via crc32_le)
  - Reed-Solomon FEC (encoder implemented, decoder planned)
  - EDAC-compatible error tracking

On-disk layout:

  Block 0        : superblock (magic 0x46545246, CRC32-protected)
  Block 1..N     : inode table (128 bytes/inode, CRC32 per inode)
  Block N+1..end : data blocks (CRC32 + RS FEC per block)

Inodes use direct addressing (12 direct block pointers) plus single
and double indirection. Directory entries are fixed-size (268 bytes)
stored in direct blocks.

== Current Status ==

  - Superblock: mount/umount, CRC32 validation            [done]
  - Inodes: read with CRC32 verification                  [done]
  - Directories: readdir, lookup                          [done]
  - Files: read via generic page cache helpers            [done]
  - Allocator: in-memory bitmap for blocks and inodes     [done]
  - Write path: create, mkdir, unlink, rmdir, link        [done]
  - Reed-Solomon: encoder done, decoder planned           [partial]
  - xattrs / SELinux                                      [planned]
  - fsck.ftrfs                                            [planned]
  - Indirect block support for large files                [planned]

== Validation ==

FTRFS has been validated on arm64 (cortex-a57) running Linux 7.0-rc7,
built with Yocto Styhead (5.1), deployed as a data partition in a
3-node Slurm HPC cluster on KVM/QEMU:

  insmod ftrfs.ko  ->  module loaded
  mount -t ftrfs /dev/vdb /mnt  ->  success
  ls /mnt  ->  returns empty directory correctly

Compile-tested on x86_64 with Linux 7.0 (this series).
checkpatch.pl: 0 errors on all patches.

== Feedback Requested ==

This is an RFC. Feedback is welcome on:

  1. On-disk format: is the superblock/inode layout reasonable?
  2. Directory entry design: fixed 268-byte entries vs. variable length
  3. Reed-Solomon: use lib/reed_solomon or keep custom GF(2^8) tables?
  4. Allocator: in-memory bitmap vs. dedicated on-disk bitmap block
  5. Any VFS API misuse or missing locking

The code is also available at:
  https://github.com/roastercode/FTRFS

Aurélien DESBRIERES (10):
  ftrfs: add on-disk format and in-memory data structures
  ftrfs: add superblock operations
  ftrfs: add inode operations
  ftrfs: add directory operations
  ftrfs: add file operations
  ftrfs: add block and inode allocator
  ftrfs: add filename and directory entry operations
  ftrfs: add CRC32 checksumming and Reed-Solomon FEC skeleton
  ftrfs: add Kconfig, Makefile and fs/ tree integration
  MAINTAINERS: add entry for FTRFS filesystem

 MAINTAINERS          |   6 +
 fs/Kconfig           |   1 +
 fs/Makefile          |   1 +
 fs/ftrfs/Kconfig     |  49 +++
 fs/ftrfs/Makefile    |  16 +
 fs/ftrfs/alloc.c     | 251 +++++++++++++++
 fs/ftrfs/dir.c       | 132 ++++++++
 fs/ftrfs/edac.c      |  84 +++++
 fs/ftrfs/file.c      |  25 ++
 fs/ftrfs/ftrfs.h     | 168 ++++++++++
 fs/ftrfs/inode.c     | 103 +++++++
 fs/ftrfs/namei.c     | 428 +++++++++++++++++++++++++++
 fs/ftrfs/super.c     | 274 ++++++++++++++++
 13 files changed, 1538 insertions(+)

Signed-off-by: Aurélien DESBRIERES <aurelien@hackers.camp>
