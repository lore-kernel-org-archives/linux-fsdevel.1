Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298DC3859D9
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114371; cv=none; b=ZrN3hLppJl/IeGBE6No5ylCJuOk3NmXRIh+I7sys8TehEp7xsFw99LkTZCXOXTwSdzQdsAAPgRgR1pyRqJUkaM3UfsMw05QOMxRXsXms9JG1ndmYhWZy62VuKcg1S17gBWp9U0ORU1g5h2u3zfqMBrko5SiunNdpw50LS8tkP5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114371; c=relaxed/simple;
	bh=dCg/CBsrEmS8tPKEILe0BhvdYm4UwNo8zhvEQG8Oy3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dnbi/RtE1Hn1TapcwSf94yXKahMHCeo+agSgwGJB+IBNZdai8v8q4hiVrD/S8p7x0CfNkYE6E+nu2+XONC9G/k3ZIiVQlLv1w61rxX71mC7O+YmiIcsheAyATielPyKzqZ9xuO9xsP/cFg4/HRcCssi6pOtTfQttxFS435Xms4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4832c8f9d87so7056605e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 14:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776114368; x=1776719168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqhOCQnqs5m2JcGY5qtRa4XZvTkfvkergxQG2U83TtI=;
        b=gz3ejQLtzX4y5JRk/FOFiQgRmNLUPlvjg3h7JoqUvUDh/QlUfcFxNR06DvsWbB83dc
         lymQRksuPozGAMQo2W/WY2EphNkrmmzCG3RPMGGUj1fWZR/9FUwpe0tojOyAwoZ2eh91
         du5Wh/1e/zCJCdteCrVImEBi9dsSdPUr2s3auvmlAUBdh+X5VIv5IyAl4XAvwra0Xhlm
         ke3YBAyxI11s8p8eisXjRFa0/j0VHmi/38U7+AtWwDoT6PYGEUvdjXxQ374tN2wbuDOv
         xAsNy9qzEL7E8x6ps0WK7JijA/zO3GlfizimR/xK6r0d+znxRs6e+rdYAc8n6Lb/j62B
         D69A==
X-Gm-Message-State: AOJu0YwrEIjdjbnQPdx978JAlo9zs+x/ZThCwm4wHEQdUuZOco6Av6Vy
	kjvZj8VjuySNGPoRUlJ4FB46uZqxF7OWG/IMxSrp4j3R64zEjDqPn67AmlSPC/1dD14=
X-Gm-Gg: AeBDieuRg2sLohNOTBbOS2Rpe86BFhVNyC6l2Y7k53gVe77Az0v/3w0BEpt4rv1Mx8w
	NN0kAgs2Y5AwxwAQUOt7RoNgIowNdOKAA0QDMKO3RCsVjA0h1AMQz6lqR3Ceh70zmoTsA8byN5Z
	P9+Do2Ob2fmI+ZZLr440zyeRcQ/yPQMkENE5NzWE4SHx9fYmyyTbSnlv7F1NN6MdTf8O618tlv4
	BrhfaiODR8aKAaKM6Q59jStpT4+9S4Cb7laCxURtohULFX2YJ4bYlEUMiC2wCFEgufePgXVYWfx
	PR2VJPxiCEVNeN7e5dyhkvT1r1jjvRPZ/qBhnSuKMHrEgpskDzTSvG2ThwgTM0BSLONPWHdbzrI
	+XHqnVV1M7tMydi7JRoibZeaIxT3sr5Nf0irkiJYv4I0BR8CadOch/i/Uk0Y4pZ22fLT2Yv2C10
	Rg7htK7VM9suB2XjqNZMbJgP5EvznAKguPyfTi7caexrVyzkEAkSmxdTwyDh2UmmREWNQWTLSua
	w5A
X-Received: by 2002:a5d:5f44:0:b0:43c:ff6f:d76 with SMTP id ffacd0b85a97d-43d65265c13mr8950834f8f.1.1776114368058;
        Mon, 13 Apr 2026 14:06:08 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c98fsm35130020f8f.35.2026.04.13.14.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:06:07 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aurelien DESBRIERES <aurelien@hackers.camp>,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	willy@infradead.org,
	djwong@kernel.org,
	adilger@dilger.ca,
	pfalcato@suse.de
Subject: [PATCH v2 00/11] ftrfs: Fault-Tolerant Radiation-Robust Filesystem
Date: Tue, 14 Apr 2026 01:05:41 +0200
Message-ID: <20260413230601.525400-1-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

FTRFS is an out-of-tree Linux filesystem designed for embedded systems
operating in radiation-intensive environments. It provides per-block
CRC32 checksumming and a Reed-Solomon FEC encoder (decoder planned for
v3) for in-place correction of silent data corruption caused by
single-event upsets (SEU).

FTRFS does not compete with ext4 for general-purpose use. The target
is embedded critical systems where DO-178C (avionics), ECSS-E-ST-40C
(space), or IEC 61508 (nuclear) certification is a hard requirement.
These standards require complete code auditability. No existing Linux
filesystem can realistically be certified under these frameworks due to
code complexity. FTRFS is designed to stay under 5000 lines of auditable
code with RS FEC as a first-class design constraint.

Changes since v1:
- Implement address_space_operations (Matthew Wilcox)
  ftrfs_get_block now allocates blocks (create=1), returns -EIO for
  holes on read. Set bh_result->b_size correctly.
  Add ftrfs_write_begin, ftrfs_write_end, ftrfs_readahead, ftrfs_bmap,
  dirty_folio, invalidate_folio.
- Fix inode lifecycle: use insert_inode_locked() instead of
  insert_inode_hash(). new_inode() does not set I_NEW.
  Move unlock_new_inode() to callers after d_instantiate().
- On-disk format: inode 128 -> 256 bytes, uid/gid __le16 -> __le32,
  add i_tindirect (~512 GiB), remove i_blocks, BUILD_BUG_ON enforces
  structure sizes at compile time.
- Directory: skip . and .. in readdir data blocks (dir_emit_dots).
- Add ftrfs_inode_is_new compat macro for inode_state_read_once API.
- i_size __le64 is intentional: future-proof for growing MRAM densities.
  The real limit is the block pointer scheme (~512 GiB with tindirect).
  BUILD_BUG_ON documents the structure sizes explicitly (Darrick J. Wong).

Known gaps to be addressed in v3:
- IO path: migrate from buffer_head to iomap (Matthew Wilcox)
- rename: not yet implemented
- xfstests: no test run yet
- RS FEC decoder: encoder present, decoder skeleton only

Tested on arm64 kernel 7.0-rc7 (Yocto KVM, Slurm HPC cluster):
  mount, write, mkdir, read: functional
  0 BUG/WARN/Oops in dmesg

Yocto integration: https://github.com/roastercode/yocto-hardened/tree/arm64-ftrfs
RFC paper: https://doi.org/10.1007/978-3-319-16086-3_8

Aurelien DESBRIERES (11):
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
  ftrfs: v2 fixes — write path, inode lifecycle, on-disk format

 MAINTAINERS            |   6 +
 fs/ftrfs/Kconfig       |  18 ++
 fs/ftrfs/Makefile      |   9 +
 fs/ftrfs/alloc.c       | 251 ++++++++++++++++++
 fs/ftrfs/dir.c         | 126 +++++++++
 fs/ftrfs/edac.c        |  84 ++++++
 fs/ftrfs/file.c        | 110 ++++++++
 fs/ftrfs/ftrfs.h       | 168 ++++++++++++
 fs/ftrfs/inode.c       | 103 ++++++++
 fs/ftrfs/namei.c       | 428 +++++++++++++++++++++++++++++++
 fs/ftrfs/super.c       | 276 ++++++++++++++++++++
 11 files changed, 1579 insertions(+)

-- 
2.49.0
