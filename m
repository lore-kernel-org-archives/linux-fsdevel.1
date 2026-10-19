Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD234508F8
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 04:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792383511; cv=none; b=m5AqwERr5UxcoCV1GpsNAW1bIz6NSGatldboPsK1umHi6J+O4XeGuUhlltoeMUpqR7kyjoFtT9Kg7mueXYnxFZrYH1yo+fD1rbqlLMOGUOEZTC33tKCAEe6cenKmGqMH5vBAwwrstlOAaUAXX16Zdzw9Kz3EIuyFMnwAMGhWd38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792383511; c=relaxed/simple;
	bh=F1AW1mRUyOZdF1vbpqf0uKCHPTv+6Xa4tR7D27ZwYlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTyGzzkzLlaxjQoF4br2uBIoXy6se5Z1cTYYDNfKfU9DObmaSQuQxK4DxteePaasutac289G+i7zoa4AVyMpatpEOEhSHurpdnaM6kFkhKo+cyWE9Fpay/+DKBwkNYWlsJFV/IY/Pqj5P1xYVnwb3gIl68tX9Z/71f7ve+8dEiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dd3367198so105155f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 21:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792383503; x=1792988303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DWumRZ8fIVOXBqGubhtnofhszNvy7WgOk6sWlgkkbEM=;
        b=KEKKmzStDNjWHdCiX2JE9EFRo3l0RrR8keY9LXI81TQi8W+ya22Y2hTKVtRYI5OxyJ
         cwObRAHmD4M43L/UL9XPe3GgSHn4YLHL+cCkJUjQzDfOmNlvOZlS/A2FkglBmd6vcfeo
         JgjmhMr0ednVZ/Z0aMT2AbuvI02XFbsWs9WA2iItA1C1tlJJcP0xtKF2ARXROp/oih1X
         WjGh2BK0NiOBMFmQ6YYkI4iQtBpCca4eDoeXnJXPQ+9TjZrb9OhTMiUU46w3uGjTs/MP
         CJhvjglF+LCNYEeBxFNMS6NdzNlVd5zyht7sfdcw0ZVKO7g2RsK7dfpUhl1KoY7PDG5Q
         f1mQ==
X-Gm-Message-State: AFq9FYInsxnyDFLUVCp2VCBaBH0OBqpoWzIeahF6qK2aMnjOHRh9PHTI
	yEDbuESAwA9UcaDn3/9wWcdpwDD9mdbVmwJWmRxDgwaoZ5ZxtNGLHG4M
X-Gm-Gg: AYBFou1l6oVnzFk1Ea70ldY7tAReamuB1Ag3K58MNl5UbuC+FJktCU+a4/o9FnaxUue
	s8+DoFOW6i4R3NdYIjBuU3JaJOh3gK/QmQbTAx3U/On+Kc0coZSzaYmgc11Lwaka+5D6+esldn5
	qzNOkFa6YCcB/olW8yV0CaxshKCq9RV4HviqOsADW6/0nsVT1IKRrB8EYgJAn6kpSR2gxfuZtbP
	pPZrejRHLjQktvNL1UK8pG2PrQHWtmvLXJnteuADEHdWSPWglmQAFJP5xPb5ow35QF3WJ8o4qSC
	EfcoZVitepUlA8rxOHjYWodEBLmmoOxXhvszTGne4ld7lYj6plP46Wmh0tYm9LtkFJ2+2sBH/Es
	myhhJgEI8M3J+zw5SPlgzaj3XQWcxj962osr0aoqGDVoLYzF5EsFg6HfrO2ppGcXncodR92NhmJ
	VPBsnSbp5jOVAjBxV19tugc+Ui64swlMNTsoV81gDdv/e66fg58jIitKS3EnmeWxp76ZQ8gbzOa
	xR0UBWf6O8ilXPqwzaKNzf8u5/WSEyyBPbv
X-Received: by 2002:a05:6000:470c:b0:48a:f41d:83c with SMTP id ffacd0b85a97d-48e07926cf9mr12567213f8f.0.1792383502713;
        Sun, 18 Oct 2026 21:18:22 -0700 (PDT)
Received: from spartian.home ([2a01:cb1c:76:ed00:602f:c5f4:d108:b925])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd500e75sm20090449f8f.42.2026.10.18.21.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 21:18:21 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: Aurelien DESBRIERES <aurelien@hackers.camp>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	aurelien.desbrieres@gmail.com,
	linux-api@vger.kernel.org
Subject: [RFC PATCH 17/18] beamfs: add Kconfig and Makefile
Date: Mon, 19 Oct 2026 06:17:27 +0200
Message-ID: <20261019041728.327785-18-aurelien@hackers.camp>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019041728.327785-1-aurelien@hackers.camp>
References: <20261019041728.327785-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hook beamfs into fs/Kconfig, among the miscellaneous filesystems, and
into fs/Makefile.

Besides BEAMFS_FS there are two debugging options: BEAMFS_DEBUG_TREE
enables the tree checker, and BEAMFS_ORDERED_META writes metadata
blocks synchronously in dependency order, an experiment kept to
measure ordering questions. Both default to off.

The Makefile adds the warnings the module is developed with; whether
they stop the build is left to CONFIG_WERROR.

Assisted-by: LLM
Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
---
 fs/Kconfig         |  1 +
 fs/Makefile        |  1 +
 fs/beamfs/Kconfig  | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/beamfs/Makefile | 21 +++++++++++++++
 4 files changed, 87 insertions(+)
 create mode 100644 fs/beamfs/Kconfig
 create mode 100644 fs/beamfs/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index 46313f65ee54..7c864b9549d4 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -313,6 +313,7 @@ source "fs/affs/Kconfig"
 source "fs/ecryptfs/Kconfig"
 source "fs/hfs/Kconfig"
 source "fs/hfsplus/Kconfig"
+source "fs/beamfs/Kconfig"
 source "fs/befs/Kconfig"
 source "fs/jffs2/Kconfig"
 # UBIFS File system configuration
diff --git a/fs/Makefile b/fs/Makefile
index 16f1108b64e1..632c15c85254 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -110,6 +110,7 @@ obj-$(CONFIG_XFS_FS)		+= xfs/
 obj-$(CONFIG_9P_FS)		+= 9p/
 obj-$(CONFIG_AFS_FS)		+= afs/
 obj-$(CONFIG_NILFS2_FS)		+= nilfs2/
+obj-$(CONFIG_BEAMFS_FS)		+= beamfs/
 obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-y				+= hostfs/
 obj-$(CONFIG_CACHEFILES)	+= cachefiles/
diff --git a/fs/beamfs/Kconfig b/fs/beamfs/Kconfig
new file mode 100644
index 000000000000..56be9beeb588
--- /dev/null
+++ b/fs/beamfs/Kconfig
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# beamfs filesystem configuration
+#
+
+config BEAMFS_FS
+	tristate "beamfs filesystem support"
+	depends on BLOCK
+	select BUFFER_HEAD
+	select FS_IOMAP
+	select CRC32
+	select REED_SOLOMON
+	select REED_SOLOMON_ENC8
+	select REED_SOLOMON_DEC8
+	help
+	  beamfs is a block-device filesystem that corrects corrupted bytes
+	  in place, on a single device, without a second copy to repair
+	  from. Data and directory blocks carry Reed-Solomon RS(255,239)
+	  parity over GF(2^8) inside the block, indirect blocks carry it in
+	  a region of their own, and every read decodes.
+
+	  Up to eight corrupted bytes per 255-byte codeword are corrected.
+	  A codeword the decoder reports as uncorrectable fails the read
+	  with -EIO. Nothing is guaranteed beyond eight bytes per codeword.
+
+	  It is meant for storage that takes bit flips the device does not
+	  correct itself, such as single-event upsets. See
+	  Documentation/filesystems/beamfs.rst.
+
+	  To compile this file system support as a module, choose M here:
+	  the module will be called beamfs.
+
+	  If unsure, say N.
+
+config BEAMFS_DEBUG_TREE
+	bool "beamfs: check the indirect tree invariant at every store"
+	depends on BEAMFS_FS
+	help
+	  Record every pointer installed in an indirect block and check
+	  each later store to the same slot against that record. A slot
+	  that held a live pointer and reads back as zero is reported
+	  with a stack trace at the instant it happens, instead of being
+	  counted by fsck long after.
+
+	  Costs one hash lookup and sixteen bytes per live pointer. Say
+	  N for production.
+
+config BEAMFS_ORDERED_META
+	bool "Write metadata in dependency order (slow, experimental)"
+	depends on BEAMFS_FS
+	default n
+	help
+	  Write every metadata block to the medium before anything names
+	  it: one synchronous write per level of indirection, up to four
+	  for a block reached through the triple indirect.
+
+	  This exists to answer a question, not to be enabled. beamfs
+	  relies on mark_buffer_dirty for ordering and mark_buffer_dirty
+	  gives none, and this forces the safe order at whatever cost in
+	  speed so that the hypothesis can be measured rather than
+	  argued. A journal is how the same property is had for one
+	  sequential write instead.
+
+	  Say N.
diff --git a/fs/beamfs/Makefile b/fs/beamfs/Makefile
new file mode 100644
index 000000000000..d01ad86a0c14
--- /dev/null
+++ b/fs/beamfs/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the beamfs filesystem.
+#
+
+obj-$(CONFIG_BEAMFS_FS) += beamfs.o
+
+beamfs-y := treecheck.o super.o inode.o dir.o dirent.o file.o \
+	    file_inline.o scrub.o indparity.o rsbench.o budget.o clock.o \
+	    alert.o edac.o alloc.o namei.o
+
+# define_trace.h includes beamfs_trace.h by name, from super.c.
+CFLAGS_super.o += -I$(src)
+
+# The warnings the module is developed with. Whether they stop the
+# build is left to CONFIG_WERROR.
+ccflags-y += -Wall -Wextra -Wformat=2 -Werror=format
+ccflags-y += -Wmissing-prototypes -Wmissing-declarations
+ccflags-y += -Wundef -Wstrict-prototypes
+# The VFS passes handlers more arguments than most of them use.
+ccflags-y += -Wno-unused-parameter
-- 
2.55.0

