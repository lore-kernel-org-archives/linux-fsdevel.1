Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EAE38E113;
	Wed, 11 Mar 2026 21:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266214; cv=none; b=glNlElyg44pXzzMS2NkBef8EO7BgNEWRKWbeiGlxlxd4v/Fkv9LmJb/zkYhV0iQl87KqNAffV44fHYV+2JPKMRF5kzU3YnN0HFYQnE6A+44etlP3crcVoskx9Z4vdfR9v1WG2qS2ubRVFnI5UiKFPP05GVPd+xDaMHWywi1r2us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266214; c=relaxed/simple;
	bh=ct4MC2RNc9/k+XVDf4PqnJGPg0ODKqXqu8HrTiNpPn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXUKIj9N0RZ38ox/80vV2MuMFTDbz/gdV9ODP71eafyljC9dvBgB9coPjaqaWn+R3cP3depgrh46GhJ8MJzvzUlRSEKXlYTa2XLFg7faCxH1k6jcVupdfVIssdrtEuTGXPGplttDLuTwBPSCOt3AeOn8vZukIDDI+FYmS09MEYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbtXavPf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbtXavPf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF5CC4CEF7;
	Wed, 11 Mar 2026 21:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266213;
	bh=ct4MC2RNc9/k+XVDf4PqnJGPg0ODKqXqu8HrTiNpPn0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TbtXavPfIftSKdivO5+bsHWgEPSmeCwKToS+5KpoYBQqpNEBQq0MYzdzGkMy5wVvl
	 R0zxhMl6da0JSwv1b3C2AQUoBvAGsSxzBXtEkhAh75n02GZUu0zFJcWJGIGcFl++XH
	 mTI5sOX58ESL5L34E0XMe1GbeVFBzrwrfBCl0OZazbReEixEEtPWbTJCvondd578WV
	 HhwyQ62uh5TlBZZUdg7BaZDjph3zS8KsSWGxOv3g4M/jzHf3u6eBpfYhxurbtne52h
	 8SeQrfLzh2kcUmaOt8C4gCUbdp8g6reBBReE6w+NmBUEnDT/8H/wGtScZkn2+8yftt
	 Fii/DlFgQU+ng==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:44:00 +0100
Subject: [PATCH RFC v3 17/26] initramfs: use scoped_with_init_fs() for
 rootfs unpacking
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-work-kthread-nullfs-v3-17-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2422; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ct4MC2RNc9/k+XVDf4PqnJGPg0ODKqXqu8HrTiNpPn0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPJThseJZc9xqQC97JR7RenTDi4TuT4t9rLO5wut6
 WrPQg2+dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEeyfD/zKdn1WbkgUC9Tv3
 M70pjZjnEF0n+atj7sd5fVp/Pvpc3cbwv2BjjKHDxcv8JcXrDy69xDO74tttuxZf2cQ/whIKqr4
 JHAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Extract the initramfs unpacking code into a separate
unpack_initramfs() function and wrap its invocation from
do_populate_rootfs() with scoped_with_init_fs(). This ensures all
file operations during initramfs unpacking (including filp_open()
calls in do_name() and populate_initrd_image()) happen in init's
filesystem context.

Note that security_initramfs_populated() needs the scope as well since
it does use current->fs to derive the initramfs superblock.

do_populate_rootfs() ← async_schedule_domain() ← kworker (async
workqueue)

May also run synchronously from PID 1 in case async workqueue is
considered full. Overriding in that case is fine as well.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 init/initramfs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 139baed06589..3faa2045b9cf 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -3,6 +3,7 @@
 #include <linux/async.h>
 #include <linux/export.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
@@ -715,7 +716,7 @@ static void __init populate_initrd_image(char *err)
 }
 #endif /* CONFIG_BLK_DEV_RAM */
 
-static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
+static void __init unpack_initramfs(async_cookie_t cookie)
 {
 	/* Load the built in initramfs */
 	char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
@@ -723,7 +724,7 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 		panic_show_mem("%s", err); /* Failed to decompress INTERNAL initramfs */
 
 	if (!initrd_start || IS_ENABLED(CONFIG_INITRAMFS_FORCE))
-		goto done;
+		return;
 
 	if (IS_ENABLED(CONFIG_BLK_DEV_RAM))
 		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
@@ -738,9 +739,14 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 		printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
 #endif
 	}
+}
 
-done:
-	security_initramfs_populated();
+static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
+{
+	scoped_with_init_fs() {
+		unpack_initramfs(cookie);
+		security_initramfs_populated();
+	}
 
 	/*
 	 * If the initrd region is overlapped with crashkernel reserved region,

-- 
2.47.3

