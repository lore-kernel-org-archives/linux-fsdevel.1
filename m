Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A590390CB2;
	Wed, 11 Mar 2026 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773267880; cv=none; b=Lu0SOgQhUTFUNytMOe1bqFdX8Vuul1+YJsC8NzDsZviy3D7XQs9FxDOCTqYpXOvsUzKRDrQPoD6in7DzzFswdhPSPBNodHB2mNa1ZCEqzG4dFFOCV5LUKPF+pCpbPPtp7MKR93NtjibAu5vBS/hi+nzMfpHkej3RgXbfNbrxdS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773267880; c=relaxed/simple;
	bh=tqRXBf6DpqkEc0mIBTnLExF0Gh4b3XlTIWNDNYeyae4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PIp1Z4T2ujT2il05Sz6PdWEZWCmZLdk3nTXJmgy/s9WlSA1DBxP/+VY6oWjGG+aX0/ZqXo9fbq0Vizkl+z7m9xwHmZbt9IdvfWusnA8ZQPS8gKwVR84Xk+fYdDyfS4DFNUI9EjgI6YceXGwQ+RBDZfL4ULfBBMWdXRRlA18WgP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=VDudn5/q; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="VDudn5/q"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 63D4E1CBC0;
	Wed, 11 Mar 2026 22:24:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 63D4E1CBC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1773267871; bh=tqRXBf6DpqkEc0mIBTnLExF0Gh4b3XlTIWNDNYeyae4=;
	h=From:To:Cc:Subject:Date:From;
	b=VDudn5/qEcwYlXFsHl5HtdGIpOFaytDqSS4VnuBejOw3GEisz7A1e4GIzdl8xlgEy
	 PA8G8BFw+rrEAYRwhIr0z6giH8+8kUVRzhIH2Hzb9lcInDEeSAYV+e+Agw8rVT2uqv
	 26UqVzUIlmpA1ZIB0gQSN0ERpx6jAg8kO4GH/208=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id gFKJBJ3rsWltqgQA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Wed, 11 Mar 2026 22:24:29 +0000
From: David Timber <dxdt@dev.snart.me>
To: corbet@lwn.net,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	almaz.alexandrovich@paragon-software.com
Cc: skhan@linuxfoundation.org,
	yuezhang.mo@sony.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v3 1/2] fs: reserve a new ioctl magic for exfat and ntfs
Date: Thu, 12 Mar 2026 07:24:20 +0900
Message-ID: <20260311222421.2008639-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ntfs and ntfs3 had no ioctl magic assigned to them. A decision to share
the new ioctl magic(0xEF) between ntfs and exfat has been made

  1. due to the similarities in API design
  2. because they're maintained by the same group devs
  3. to delay the eventual exhaustion of ioctl number namespace

Also, the uapi header file is named ntfs.h, not ntfs3.h to cater the
on-going work of reviving ntfs classic and potentially consolidating
it with ntfs3.

Link: https://lore.kernel.org/linux-fsdevel/72446d20-f3ae-4acc-86cc-bd8fa3d86f41@dev.snart.me/
Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 .../userspace-api/ioctl/ioctl-number.rst         |  1 +
 MAINTAINERS                                      |  2 ++
 fs/ntfs3/file.c                                  |  6 ------
 fs/ntfs3/ntfs_fs.h                               |  1 +
 include/uapi/linux/exfat.h                       |  3 ++-
 include/uapi/linux/ntfs.h                        | 16 ++++++++++++++++
 6 files changed, 22 insertions(+), 7 deletions(-)
 create mode 100644 include/uapi/linux/ntfs.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 331223761fff..1c81f1f030ca 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -410,6 +410,7 @@ Code  Seq#    Include File                                             Comments
                                                                        <mailto:nchatrad@amd.com>
 0xF9  00-0F  uapi/misc/amd-apml.h                                      AMD side band system management interface driver
                                                                        <mailto:naveenkrishna.chatradhi@amd.com>
+0xEF  00-0F  uapi/linux/exfat.h and uapi/linux/ntfs3.h
 0xFD  all    linux/dm-ioctl.h
 0xFE  all    linux/isst_if.h
 ====  =====  ========================================================= ================================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 55af015174a5..59a722414e09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9597,6 +9597,7 @@ L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
 F:	fs/exfat/
+F:	include/uapi/linux/exfat.h
 
 EXPRESSWIRE PROTOCOL LIBRARY
 M:	Duje Mihanović <duje.mihanovic@skole.hr>
@@ -18876,6 +18877,7 @@ W:	http://www.paragon-software.com/
 T:	git https://github.com/Paragon-Software-Group/linux-ntfs3.git
 F:	Documentation/filesystems/ntfs3.rst
 F:	fs/ntfs3/
+F:	include/uapi/linux/ntfs.h
 
 NTSYNC SYNCHRONIZATION PRIMITIVE DRIVER
 M:	Elizabeth Figura <zfigura@codeweavers.com>
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 7eecf1e01f74..2dd15af0255c 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -21,12 +21,6 @@
 #include "ntfs.h"
 #include "ntfs_fs.h"
 
-/*
- * cifx, btrfs, exfat, ext4, f2fs use this constant.
- * Hope this value will become common to all fs.
- */
-#define NTFS3_IOC_SHUTDOWN _IOR('X', 125, __u32)
-
 /*
  * Helper for ntfs_should_use_dio.
  */
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index daf5a1f47275..633d8472fa1f 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -26,6 +26,7 @@
 #include <linux/time64.h>
 #include <linux/types.h>
 #include <linux/uidgid.h>
+#include <uapi/linux/ntfs.h>
 #include <asm/div64.h>
 #include <asm/page.h>
 
diff --git a/include/uapi/linux/exfat.h b/include/uapi/linux/exfat.h
index 46d95b16fc4b..050dcea0aa12 100644
--- a/include/uapi/linux/exfat.h
+++ b/include/uapi/linux/exfat.h
@@ -12,7 +12,8 @@
  * exfat-specific ioctl commands
  */
 
-#define EXFAT_IOC_SHUTDOWN _IOR('X', 125, __u32)
+#define EXFAT_IOCTL_MAGIC	0xEF			/* shared with ntfs3 */
+#define EXFAT_IOC_SHUTDOWN	_IOR('X', 125, __u32)
 
 /*
  * Flags used by EXFAT_IOC_SHUTDOWN
diff --git a/include/uapi/linux/ntfs.h b/include/uapi/linux/ntfs.h
new file mode 100644
index 000000000000..f00428af6901
--- /dev/null
+++ b/include/uapi/linux/ntfs.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _UAPI_LINUX_NTFS_H
+#define _UAPI_LINUX_NTFS_H
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define NTFS_IOCTL_MAGIC	0xEF			/* shared with exfat */
+
+/*
+ * cifx, btrfs, exfat, ext4, f2fs use this constant.
+ * Hope this value will become common to all fs.
+ */
+#define NTFS3_IOC_SHUTDOWN	_IOR('X', 125, __u32)
+
+#endif /* _UAPI_LINUX_NTFS_H */
-- 
2.53.0.1.ga224b40d3f.dirty

