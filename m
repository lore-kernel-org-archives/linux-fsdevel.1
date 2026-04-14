Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06173CB2EC
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161262; cv=none; b=oQ1z4Hf6m7uhlDLz6lJKFb9Zdyw7tbieF21eIw444T/SQHPnN5Y5M2crhiMn17Dml4KiKu40FeKEMUmBeR8WQdF43kBY96UC5tNeswAYU9PvC3H9nD5G378TVpW8a90lKnFnJT4ZA5J/c39pxP6vjpyGQ+v+XigBKvJXyFOwBq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161262; c=relaxed/simple;
	bh=hMaIZFhC0Qq5n3nLpuTUKzpgOWEDdEMtpfCkU3VWc/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkO2YQ3/ivX+X9kLYpnqDjd3mRI90KCYiURcx/YzFI8YCr1GqYKUc5fVDudx4YJ8yaKfI8+ZPHQeK+9f0H/0ZKfqanYbWnB+dGmv9eV71M+uThVud8bobn9YkEy5y4mQcAEeUNM4JQGaYoN9Vjfo8Syz+2smNUbLGz34HYIQywY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483708b697cso8693305e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 03:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776161259; x=1776766059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K/PS/iPj83KlqJXElwiqqFPyNMNlzYn8kL+JR6PR3/w=;
        b=XFkb+9ppm1L7Py+yc92kkJsZ9Hy3/0Edqq2MXL+M65dAaB23g0etjI1NP6xGwrhLNS
         oROWUdaXkK2F/J/qFHedScAcbDVh9z94Y6lB/pK7axoLae9kZNhvtn5WUCFj41x9Opv0
         vleteHASO3MssYVcUZZq1mTI8dbrRFoNQi05ivYt1tIx7gGjLilWrqOc8kxxUGbk78hU
         ZhbzOIr9u430FEYCD20MwPZ6MKU8poFe1ImJemOKm2DbAH/UyGSyb2dcvbOgdiIlWqsW
         K7tD7yieG1Ytv81HERt/AXs17fBdNA6M43HP3cKGRkkm0KjTWmjv9BhXUK/IDqHDDz7M
         wtag==
X-Gm-Message-State: AOJu0YwQUltEFIC7/DqO+9DkkepGzKkGwa2SRh9g/9UAZLoBwpAINDz0
	Zi1l09Kr+O+tqCqUvp/7BIL0ATSRiimrLCb4Of+q6PYVjokVsRzAJUfvJicWCHiT
X-Gm-Gg: AeBDievlC1yOfSV7KF2WCLGbssbmVMHM/Ln0xlSBr8P/ER7NcT6657wvHqmxD0/vr+o
	Z1k5GpnUZdkHc7Rfd97+spZkFrcWCAqngpcmVXqg3YiRE85spYOw8Tjz+SuAwokbW7FxUEh4Q4s
	dekE89fkhuXL3y99zRd45VOeIuUrnaMxZqmQ1BXreYNIPFH9bYUWt/zfgSHdThcnPRhAm0TOuq1
	gMD/lSda7EPzgIZar29jvr6d4Prpbv9nf2QEM0nS8hl0HI3aABPlYrZ/b4MXZ0oge/+26OQfTDq
	Ijwbmf5VGU3y2ZwAolCxsMwZwAeyYZg9awqZLZmkZlVtLWiuQvy3CS8TKEIRD5j/taXNzhpryKp
	LmyZqeKhk0ohGj8xv0mdEEH3yu1jajs+O2kPrAN5SKTM0NK+uZGjlybFeybOnxEpKBNMwmV4cuB
	4rem0Rwj77NyZZwIk1tkc5V35DK2F24FO6rzmgWarBc1M2ZNcSA5ole85khk2e+Xnu0wA9Bf/i+
	wU=
X-Received: by 2002:a05:600c:4f95:b0:488:abe9:86 with SMTP id 5b1f17b1804b1-488d688dcc5mr125044035e9.7.1776161258764;
        Tue, 14 Apr 2026 03:07:38 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e050sm65870545e9.5.2026.04.14.03.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:07:38 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	willy@infradead.org,
	djwong@kernel.org,
	adilger.kernel@dilger.ca,
	pedro.falcato@gmail.com,
	xiang@kernel.org,
	Aurelien DESBRIERES <aurelien@hackers.camp>
Subject: [PATCH v3 09/12] ftrfs: add Kconfig, Makefile and fs/ tree integration
Date: Tue, 14 Apr 2026 14:07:22 +0200
Message-ID: <20260414120726.5713-10-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260414120726.5713-1-aurelien@hackers.camp>
References: <20260413230601.525400-1-aurelien@hackers.camp>
 <20260414120726.5713-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
---
 fs/ftrfs/Kconfig  | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ftrfs/Makefile | 46 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 fs/ftrfs/Kconfig
 create mode 100644 fs/ftrfs/Makefile

diff --git a/fs/ftrfs/Kconfig b/fs/ftrfs/Kconfig
new file mode 100644
index 000000000000..e23fea923488
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
index 000000000000..a792286ec822
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

