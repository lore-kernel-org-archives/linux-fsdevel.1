Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BE139657D
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114394; cv=none; b=Rtv3yG+EKSLkTfJuVTd1pFMcilohDtvQMyHpzC/RcJiHmc07qD+62yLFtQNVkvv63LP69F23hDiW8Hs0gKTaCbZXQ4Bh+K5YN/f4r6a4K/d0h1zzcoj+YMIasc1EWhG/KXbqJ9vyALzx44Fy58hMkfbegGoymmPYPoQeWLmEOGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114394; c=relaxed/simple;
	bh=NM6h5VZen3O0KT+su0g5zHL4pT4XZpgSFwSPr2NM+A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+/KRpszk2PAzxqoLMsEU9qA8z0xDhFsYxIw/S9oGzxYhNyEs1Zr8CIGghmLYzYMMBObXimGdFDlV9J3D/RcdFusJSNZS7vffnjXFYrRwki9XawmAlruRFtVuUtg3Nx6X4hdlgE/Gz5KFgZJADgog4ENnVgWbfM3mZ7WIRW8BJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4836fc075d2so6383855e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 14:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776114389; x=1776719189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YJ4L10geo68HXUJMfGUEOz6mGrj4VKfjz9eMj3DzSKw=;
        b=N3gVoLfCXAFVcDCid9vwBf8zAdif9r8cbssdVoRO7wL3ZIEUjvooHUeptsvDLkbpsf
         17x21k8xcP2KO5qWBUAPeVOvZhgX6eMy7svCfjPt/ryde7TzL69eL+hEZn9bLlMNjPhY
         4JgnFrlgtk6ffPj+IBQBj+6ku4++g23JqWQFtTuDwCMQXUMguA2Qa2pXFhmj2u2zHFFd
         qRxUsu+4T0BV3rHqsslhg7ET3tIKc09AqzT1KSTPw1RGS4Xd6RZFZUYt77wQgHuJiS+v
         sMz5iFOSq90lmvOLTlL1ZRaioPFmGrD1ul61VuFBJq7v/f9qnwmM4p2XUADpOdfTZk9B
         Uaow==
X-Gm-Message-State: AOJu0YwZWdpHbKkoe1E2hSvspv2QaFw2rlqxeNfOHS1U/NBnNdJeJgtm
	4mu269UEQJBGVIarcNcqfnlkxmOZdKB7sSOhNYQ63hobJ079fOOsRcQP/E7+Lqnck3U=
X-Gm-Gg: AeBDiev0rGzeduYczn7t2fXlFSp8ogBbg0DpmueMOC4hNt45+Nve/ZaG+KAAfrNtdIF
	bOzXw0Z3zjJqRBy5/nEA9vSY+X88dmuSiIl9e2UAlmkKO6veSPUWMKSDyNG52CbLdJUHlJD0bu9
	hU09GiwJ24LrfpTd0Eoc4XJ2XRmDK879QBzU6m7XQPEJkYnhigiYNqRZ90cfqVcDprQb83gBOsm
	TJKvoip0bJ+KIEyKmN8xoAE4l6bgXjrYSqXOc4rWPWtzD7i6eWq0hE/iQsiWtDvoH2U2qnIS6CH
	cWZDnTd6/bXO44KL2+mPoft8D1AW7BEOEWmnDGRgJf0C58e6KZUvBicZws9ePxraHbakHRr4h7Q
	bU1bMCthmpGremlODxof29DVR36x4kgwxBgCCjs6iebgOqCEzobbzaaDSyVCCEMptBbW1TE3+uw
	xa/vj9rUh4ZBLKmmlbq8aS9wkLzA56hjsL4BiM+NM8GGlwaWIWKvWiQERzDgj1gMuNLJEBub7AZ
	uCM
X-Received: by 2002:a05:600c:46c8:b0:488:9e7e:e1e3 with SMTP id 5b1f17b1804b1-488d67f5115mr115396145e9.2.1776114388943;
        Mon, 13 Apr 2026 14:06:28 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c98fsm35130020f8f.35.2026.04.13.14.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:06:28 -0700 (PDT)
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
Subject: [PATCH v2 09/11] ftrfs: add Kconfig, Makefile and fs/ tree integration
Date: Tue, 14 Apr 2026 01:05:50 +0200
Message-ID: <20260413230601.525400-10-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413230601.525400-1-aurelien@hackers.camp>
References: <20260413230601.525400-1-aurelien@hackers.camp>
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

