Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A091438B7B3;
	Wed,  1 Apr 2026 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775036985; cv=none; b=bfVXoWhnn9HjB8m+oAORR5+grGUB1LXsiUZIzGtHMGx5XxYpVPt6CUq6pqTSOtJlT5k5h0hYqVZ7wSUIz0Z8jfO2vX5+RLKm0RvQBTmDzVaxzdxw7f7Usnm6vcrFIBnPBGywvYJC7XcZxwfIo6F1V4P6+pchr7iNN+Id2Yvk+zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775036985; c=relaxed/simple;
	bh=aBtywUf+IokxXLs053OA/rCm1d8CyIrZ45lz2vsrSJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hdCU0kGtrCLZ6szIomukufNNPYZcUGM0jXcQZwS3uUtFS0Ad0JazsXka3o+NJK9nAQS26Lj0JITeYHlmhwNxnmabDws6snJICcnCB8aj1eh9s1JP/4p3Pd3K1PpfEpPz7saxGii2kRPir9sG3yayfcp5E+/oN6agfuhIhpr95o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=lZdbowJd; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lZdbowJd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1775036976;
	bh=aBtywUf+IokxXLs053OA/rCm1d8CyIrZ45lz2vsrSJo=;
	h=From:Date:Subject:To:Cc:From;
	b=lZdbowJdkUTjqWDTz7isDwRtGiYQRIy4DNlOz/rcgK9FqnG3fMHzqnBav9y++Xsty
	 uPcf9rZonbgN7DcYOncf2L7g3rebCPg6xjDa9GBYq8edCsi4RkNUkfpAXVFpSRXkp7
	 MTnTaz2SOH0WQnUmgO6a6uMDxEcrn+xBMwRUkXow=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 01 Apr 2026 11:49:34 +0200
Subject: [PATCH] fs: uapi: add a public linux/statfs.h header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260401-uapi-statfs-v1-1-fcd335bd4285@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwND3dLEgkzd4pLEkrRiXUsTE0NzUyOTFNMUEyWgjoKi1LTMCrBp0bE
 QfnFpUlZqcgnICKXaWgC4yYYybwAAAA==
X-Change-ID: 20260401-uapi-statfs-94417524d5d4
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775036975; l=1347;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=aBtywUf+IokxXLs053OA/rCm1d8CyIrZ45lz2vsrSJo=;
 b=t/ggQ56mFSVG1rh+XQIi8dtjLyGVusrcLcT9N0xaV/C07dV/1BUK9ByUt9/kYSYOUbel3qZWv
 63HPYNx/7HLDMOIjBzAh9drdbdPfwMFJM1Az1CMepWYEs3o/W88Z1i9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Currently the statfs UAPI definitions are only available from the
asm/ namespace, which is not meant to be used directly by applications.

Add a public UAPI header and adapt the internal linux/statfs.h to it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/statfs.h      | 3 ++-
 include/uapi/linux/statfs.h | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index 02c862686ea3..ee858f85299e 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -2,8 +2,9 @@
 #ifndef _LINUX_STATFS_H
 #define _LINUX_STATFS_H
 
+#include <uapi/linux/statfs.h>
+
 #include <linux/types.h>
-#include <asm/statfs.h>
 #include <asm/byteorder.h>
 
 struct kstatfs {
diff --git a/include/uapi/linux/statfs.h b/include/uapi/linux/statfs.h
new file mode 100644
index 000000000000..7ebf2eae7dab
--- /dev/null
+++ b/include/uapi/linux/statfs.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_STATFS_H
+#define _UAPI_LINUX_STATFS_H
+
+#include <asm/statfs.h>
+
+#endif /* _UAPI_LINUX_STATFS_H */

---
base-commit: dbf00d8d23b43a7a1d717e704c50651731d01d71
change-id: 20260401-uapi-statfs-94417524d5d4

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>

