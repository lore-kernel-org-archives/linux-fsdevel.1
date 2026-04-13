Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F22C3C8709
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083066; cv=none; b=Y2OQc7vAF8RfE9WGAuOuzTY9uO2zyJgsPoVaE8VpWrQ2elKJzLAz1Z/J+cP6UPLYPw8O4lYqquzuYWPzu3t+1jzTz8JC1G/vXHxlE0W2Natn8IPuFwmEV+EoHepCxTk1u4bVd8IbdvBKrl3NhjKsXKKWASE+O6H984hhpb/5BTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083066; c=relaxed/simple;
	bh=ABJ3YrP25VWUHHH5hLJfB1K47EQFZfvSyClRfydzd7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBuCiObyYdkpi4xWPkT2uGsE1HaHZbHnYr6HQULB+Y0vfQZYIk4VRDH1pTzWliO3lMSVpvk4LY5/fOY5IkAomoHOhEwAU9CCZOq/megMewYseSFYOcyAjb8fQo50dHasHsSVkzsxVWBMmks+F7n2ZBncKQ6rSaSjwY8z8zHIVwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48880947b7dso5890345e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 05:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083063; x=1776687863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x+ZMjdv11cJ8492YNrGjD4isO/++CXxkJuOfHfrJFck=;
        b=lDWPIJ7NLA5fFWhKVZmrtQtLdGul4ULwfpY715rrh/6tPcqQp1yfyqYouyzGFYvZsy
         YBjqQHVWEQr6vh3x1G9nuoauFYQhUFXHHwO2evSjCKUvlrHvFX8HhWiwnbfUSZVsj98Z
         7H5AbpCQCzzjv6xBjnjWnZVJbWKTJZFiarzJEo7KC/YAhEViVLcjx2Wobmp/mzSlqtiZ
         gSsYJ3kHSTp77IDgqV5FDjRmskYO2WMsurPs76+G+/sQ4wFQW5RX7nL5JU4B8LbDIpyS
         0+hHMUV0cog+6d+P0GgxWpdwgYI5ryJv0eLdABU9yWCCA2ztSYoFUFKSTd9pLm26o5eH
         YsXA==
X-Gm-Message-State: AOJu0Yy7PuR5GJRcf4Zilr0BSNyCTWZeJFff81nIx1joPh9YeHFzqQKk
	8hdZQBtA4oUsnGwdls2yPJghXo8yAEzjJyfhKOqkEtDSxBle69qf2NWC9ouYDcuP2Tw=
X-Gm-Gg: AeBDievZ58y2/QK4YLEwjcTWzWMCCxewdQOrpH6Ud5evjceFPtNa+2wKR65qvkKXav2
	/B90XVeYb2HRP2uirXt/mNUbCMiAJcarD7mnAiL76Zsl0LqKoBZ9Gydw9VkhMXqS+3BpcUHKndv
	TDzwDfPeEFcKLbS7cMU//l6ERoJn3/HWT/ouoz6y93t0teKSJH8nBLb1Ux1aAjdy7QJ3Tpd4a4X
	Uq7z10jvtqwp8pnA1qtfI1vaZuymnQizfUHVv+QyoQbuEZbOsY1ZsMDnNm0481uhkbRxe5RQ9CF
	nF+t71O95/5nanOoYueHIv6N4xfVRlPQmC1gR9G4qS0eTpQnuLyFjDZPWKoPxvX0DZcIZiAihlC
	j9hcT7dOaNlubw41FJH3WIEFKyxn6vT6foJ77nMhuB2NM98/JusJn4MPliq6SrOw5ZmuWgc525u
	IQhruexwwOdIFbhlkWI8YpS63Elb/poGOk6Iz9vkm06iKijUV8mMFJkwwB17pNXWaTGg==
X-Received: by 2002:a05:600c:3ba8:b0:488:7fd3:5cd5 with SMTP id 5b1f17b1804b1-488d7eac3bemr96856175e9.1.1776083063302;
        Mon, 13 Apr 2026 05:24:23 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ed4dsm278260915e9.4.2026.04.13.05.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:24:22 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	aurelien@hackers.camp
Subject: [RFC PATCH 09/10] ftrfs: add Kconfig, Makefile and fs/ tree integration
Date: Mon, 13 Apr 2026 16:23:55 +0200
Message-ID: <20260413142357.515792-10-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413142357.515792-1-aurelien@hackers.camp>
References: <20260413142357.515792-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aurélien DESBRIERES <aurelien@hackers.camp>

Kconfig:
- CONFIG_FTRFS_FS: tristate, depends on BLOCK
- selects CRC32, REED_SOLOMON, REED_SOLOMON_ENC8/DEC8
- CONFIG_FTRFS_FS_XATTR: extended attributes (SELinux support)
- CONFIG_FTRFS_FS_SECURITY: security labels

Makefile:
- ftrfs.o composed of super.o, inode.o, dir.o, file.o,
  edac.o, alloc.o, namei.o
- xattr.o conditionally compiled via CONFIG_FTRFS_FS_XATTR

fs/Kconfig: source fs/ftrfs/Kconfig (after ext2)
fs/Makefile: obj-$(CONFIG_FTRFS_FS) += ftrfs/

Signed-off-by: Aurélien DESBRIERES <aurelien@hackers.camp>
---
 fs/ftrfs/Kconfig  | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ftrfs/Makefile | 46 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 fs/ftrfs/Kconfig
 create mode 100644 fs/ftrfs/Makefile

diff --git a/fs/ftrfs/Kconfig b/fs/ftrfs/Kconfig
new file mode 100644
index 000000000..e23fea923
--- /dev/null
+++ b/fs/ftrfs/Kconfig
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# FTRFS filesystem configuration
+#
+
+config FTRFS_FS
+	tristate "FTRFS fault-tolerant radiation-robust filesystem"
+	depends on BLOCK
+	select CRC32
+	select REED_SOLOMON
+	select REED_SOLOMON_ENC8
+	select REED_SOLOMON_DEC8
+	help
+	  FTRFS is a POSIX-compatible filesystem designed for dependable
+	  storage in radiation-intensive environments. It provides:
+
+	    - CRC32 checksumming per block and per inode
+	    - Reed-Solomon forward error correction (FEC)
+	    - EDAC-compatible error tracking
+
+	  Originally described in:
+	  Fuchs, Langer, Trinitis - ARCS 2015, TU Munich.
+	  Targeting embedded Linux on MRAM/NOR flash for space applications.
+
+	  To compile this filesystem support as a module, choose M here.
+	  The module will be called ftrfs.
+
+	  If unsure, say N.
+
+config FTRFS_FS_XATTR
+	bool "FTRFS extended attributes"
+	depends on FTRFS_FS
+	help
+	  Extended attributes are name:value pairs associated with inodes.
+	  They are required for SELinux, POSIX ACLs, and other security
+	  frameworks that store per-file metadata outside the inode.
+	  FTRFS xattrs follow the same namespace model as ext2/ext4.
+
+	  If you are not using SELinux or POSIX ACLs, say N.
+config FTRFS_FS_SECURITY
+	bool "FTRFS Security Labels"
+	depends on FTRFS_FS_XATTR
+	help
+	  Extended attributes are name:value pairs associated with inodes.
+	  They are required for SELinux, POSIX ACLs, and other security
+	  frameworks that store per-file metadata outside the inode.
+	  FTRFS xattrs follow the same namespace model as ext2/ext4.
+
+	  If you are not using SELinux or POSIX ACLs, say N.
diff --git a/fs/ftrfs/Makefile b/fs/ftrfs/Makefile
new file mode 100644
index 000000000..a792286ec
--- /dev/null
+++ b/fs/ftrfs/Makefile
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# FTRFS — Fault-Tolerant Radiation-Robust Filesystem
+#
+
+obj-$(CONFIG_FTRFS_FS) += ftrfs.o
+
+ftrfs-y := super.o \
+            inode.o \
+            dir.o   \
+            file.o  \
+            edac.o  \
+            alloc.o \
+            namei.o
+
+ftrfs-$(CONFIG_FTRFS_FS_XATTR) += xattr.o
+
+ifneq ($(KERNELRELEASE),)
+else
+
+ifneq ($(KERNEL_SRC),)
+  KERNELDIR := $(KERNEL_SRC)
+else
+  KERNELDIR ?= /lib/modules/$(shell uname -r)/build
+endif
+
+ifneq ($(O),)
+  KBUILD_OUTPUT := O=$(O)
+else
+  KBUILD_OUTPUT :=
+endif
+
+PWD := $(shell pwd)
+
+all:
+	$(MAKE) -C $(KERNELDIR) $(KBUILD_OUTPUT) M=$(PWD) \
+		CONFIG_FTRFS_FS=m CONFIG_FTRFS_FS_XATTR=n CONFIG_FTRFS_FS_SECURITY=n \
+		modules
+
+clean:
+	$(MAKE) -C $(KERNELDIR) $(KBUILD_OUTPUT) M=$(PWD) clean
+
+modules_install:
+	$(MAKE) -C $(KERNELDIR) $(KBUILD_OUTPUT) M=$(PWD) modules_install
+
+endif
-- 
2.52.0

