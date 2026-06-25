Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4D33002A9
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424092; cv=none; b=QDAC0Ryh6YdxR51fGZBYusFOypAz9EfnSDyUoVSzQoKJRvUDa41vEzUGrrrBiGzlg4sQivOKO6KVHQ8u+VnHQtgPQFUitH6ImFEgqcnUMWrghkaMvZVRjOcQ9seOmT+QmfBiqveX0jZWOQ1gDVM1nWsc1oJVyPD36g9vCjebkys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424092; c=relaxed/simple;
	bh=OPNccpRHSYSBLidTqRYfSBcEOWR/G93sxzXp4gvivy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i+MV3/jhAatiJhwzy5fRV0wIwjMypd1LPvE6NK1oNn3lqwxGiEr01mc416g+06qhqN+4VlgdHniUjZyk4Xrq8DJAxcHCTrEL2bosSbiqrfHGPUgW0QJIKawxfJlajYowSbFzCnU0o9A74gLpr2NSaXUl+qIjxIRoFX04MHuVds4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXbqHa0S; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXbqHa0S"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c88e3e82d81so144260a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 14:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782424090; x=1783028890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ASYoiMDL7EOic1DM8a3ID9PrBKttY8w+hXsFtVlG58=;
        b=mXbqHa0SPewHv1ECO83nqjCbbhES1ZV/Zqm9KkcEWFD9O9bSP4IwjrmxV/HZLWg7Nq
         wyZrWPTbMdFAgq7jg9uUHegQdu/BXtOKT3Ar+hccq303jLahijdnxmXBhcKuDfFL+kx+
         O6OKDIoUh1AQn8itiVSCZ94LVPYcbM0vCXA7Uv1965E/eoiHS6KLVGCVB3fa6YgQnZls
         9dbJRt/tOarcngKgCOrxCgxWZ6eoeABfiuZ98LIRBVXxjCCNcqld7b15rKdcHFXcHamE
         xJMuJXLCYisrOX7jYvMtKXQojFQq0idod56BnmTF+IBWqYC06j+iiq7w+jwYNHGF0xFW
         erSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782424090; x=1783028890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ASYoiMDL7EOic1DM8a3ID9PrBKttY8w+hXsFtVlG58=;
        b=UFLA3g7CUf1EaFzMLi61GeCxF4EOGQPeG3UQqJ1VR1haYgJp5kljGNd+Ncjgps6DDM
         kVeiCmD8HQMlsKaYmx13zIF4IctOtd4tTU3tO8M4/5MhpG+61NvwTxTTbTZDtLhgPX57
         d85NPwXg8vVXy9ddYUNPApCVNwkm79PJpnmIXzl4BRqzVpxkd1I+6BM0L9licpLAcFd6
         VfWS+FXcgkvas9sPZBSTrV0L8u41VMNu7tR+Sp8heLZ9r7U6F16zfykbvX5ARj2QUAlc
         pSifjIDJk8Gd9/yTfwj9u9waB+jrgOGocXMInzbNXtX+GlaolaI5jVsyY2/4yu52ZsX0
         pvyw==
X-Gm-Message-State: AOJu0Yw9BpbCS4HWZSgVdKXMPt4jjoLCqR2vnyYC428bG0iFgtZkl2Nc
	1Y9BlDWLnkCempHVc1Y/d8S/O7dfqs/U8gwbCn2KKDwUlZi4s5zin/emauUHuA==
X-Gm-Gg: AfdE7cnL4aBZu0AmyxhnzPsdA0VtnN7c8AjfLDDW9axVy0op5ddncO7WIIZrYN99ZhJ
	i+/hVIgW71a/PSSvAfrT4rIG3fcb31hAuTjcOCGbUrp6M7gIzBUMfJ3WMu8Jkb3KHtbfTKuSfSj
	HRrR6FpEFCLxmSZUNBzNJsUP68smf4COSTqIfgDtz4say4r9JBvIchBTKprq9CG+Vc2hPTIBLHt
	XCNkbvmEMik8xB15+GasivF6qAIruljwvU5POlPwkcKItexSNK7wxd9XWX4W50d23dK0KDNK9f5
	GcVlfsCX4uQJ4FuLZEqePwSTapmeGJ5kDBdH1soAx4V7rwa9FMV29FINRIE3OvxkxJXfGMHJDjT
	WggIzpHwiLEXHYHnMoeIhM+ki+zonw4NlmHX/CHzIkFbl8IsEvly42ZjjYrJpeWI=
X-Received: by 2002:a05:6a20:a110:b0:3b9:5efb:cb2b with SMTP id adf61e73a8af0-3bd4b2d0759mr4684350637.44.1782424090338;
        Thu, 25 Jun 2026 14:48:10 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a413c39fsm6192134b3a.55.2026.06.25.14.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:48:09 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH 0/3] minix: convert to iomap and add direct I/O
Date: Thu, 25 Jun 2026 14:48:02 -0700
Message-ID: <cover.1782422707.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts the minix filesystem from the buffer_head-based
I/O path to the iomap API, and adds direct I/O support in the process.

The conversion is straightforward: minix's indirect block tree mapping
logic (from itree_common.c) is reworked into an iomap_begin/iomap_end
implementation.  The iomap_end callback is a no-op since minix has no
extents or transactions to finalize.

Patch 1 adds the iomap infrastructure: the new iomap.c file, wrapper
functions and iomap_ops structs in itree_v1.c and itree_v2.c, and the
relevant declarations in minix.h.

The iomap.c file is #include'd into itree_v1.c and itree_v2.c rather
than compiled as a standalone translation unit.  This is because the
minix filesystem versions (V1 vs V2/V3) have different block_t sizes
(16-bit vs 32-bit) and different indirect tree depths.  This follows
the existing pattern in minix where itree_common.c is included into
both itree_v1.c and itree_v2.c.  Each version provides a thin wrapper
and a corresponding iomap_ops struct.

Patch 2 converts the regular file address space operations to iomap:
read_folio, readahead, writepages (with a writeback callback), bmap,
and folio lifecycle helpers.  Directory inodes continue to use
buffer_head-based operations via a new minix_dir_aops, since directory
handling still relies on buffer head chunks for prepare/write_begin.

Patch 3 converts the file_operations: replacing the generic read/write
iterators with iomap-aware versions, adding direct I/O read/write paths
using iomap_dio_rw, and setting FMODE_CAN_ODIRECT in the open handler.

The minix iomap implementation was adapted from the out-of-tree xiafs
iomap conversion. The xiafs module itself borrowed heavily from the
modernized minix kernel module.  The exfat iomap changes were an
additional reference for both conversions.

This has been compile-tested and put through basic runtime testing:
creating files, creating directories, writing and reading files,
removing files and directories, and files and directory structures
persisting after unmounting and remounting all work for all versions
of the minix filesystem. 

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>

Jeremy Bingham (3):
  minix: add iomap infrastructure
  minix: convert address space operations to iomap
  minix: convert file operations to iomap and add direct I/O

 fs/minix/file.c     | 153 ++++++++++++++++++++++++++++++++++++++++++--
 fs/minix/inode.c    |  83 ++++++++++++++++++++++--
 fs/minix/iomap.c    | 114 +++++++++++++++++++++++++++++++++
 fs/minix/itree_v1.c |  25 +++++++-
 fs/minix/itree_v2.c |  17 ++++-
 fs/minix/minix.h    |  22 ++++++-
 6 files changed, 398 insertions(+), 16 deletions(-)
 create mode 100644 fs/minix/iomap.c

-- 
2.47.3
