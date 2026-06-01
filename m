Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D63C13EE;
	Mon,  1 Jun 2026 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322254; cv=none; b=Xfax2wnm2a4WkrtFWLtLbNYaTVy0qf8Pm4LXRZwe0rIXtmqR4GP6G4JHqv2P/z5wpm20WU1QtkVrwC5tQQX+QFaJAhEEBdo3NbEp92bG0Tf2IdXQjv50VpA2TwsIJ3SCOpmBP7oqgAYAQ5Z6CLFFlCllj0fMf7mw1ATXqUIKp1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322254; c=relaxed/simple;
	bh=sG1OnJMLGiKQamYTDNXHSLkdyPOBWMPLChw0pAcgZEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OVa4Psq5O9vrhc9CYF+GNYH/0gI9pu/nsl7soMmmRLAo6l8jwmKZePpEDlpDmHrhSYPExySFk96l9UWT+ncSPDm8B0FJTYNuFOi/xEhuyJKI5xNk53OkXMFDCZKgxxyjiO059bkT6QlUFs1lIGwqVW2G+BhIkCIQ9PA5Bu52WOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBmmLUOi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBmmLUOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8E11F00898;
	Mon,  1 Jun 2026 13:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322253;
	bh=05sU105TIaoDreFNJcXDcP1f6QXqRrBkOs+MREOztjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gBmmLUOi6osocTxiDObVxeaw3IUvuVsQbQS9jglKi23j2YVwtWC0nsDpjpYEvVZot
	 yun3SPPLzv7vtnsmE47f/VVvNbnCeGvNuDQ4Onsjb4MeJot69swsd9l71D0848BOkt
	 dzEoNS3SuAzC7s1ZVPEWmabSGQMbjTQ+Lz54FnUEZPxo92Dn90m5fw2vxk4iWooTd0
	 RluBg/SgLAYWXzJVrUATZ4Pv2iv1FKPZqros9LopuIDJCIdVIYs8uzRlpi5kQa2BSD
	 NqFOlxlplWhF8Dff9RS6v+E9N4TvVJWad+r4A1VohMMtntEcwNyQrFt+rcnI95CbdH
	 ileRexGatJc6g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:50 +0200
Subject: [PATCH RFC v4 17/25] initramfs: use scoped_with_init_fs() for
 rootfs unpacking
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260601-work-kthread-nullfs-v4-17-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2433; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sG1OnJMLGiKQamYTDNXHSLkdyPOBWMPLChw0pAcgZEc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i9re5W17H9+t3Xv1LvvymVnxueJ/tNx3/0kVPz53
 3vxFkeFO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiyMjwhyc07OSLmOdJR3kZ
 VmoLz82tYl15/Ost6c7VAqmpFwtkfRn+u+2q6OAs/KzwdvocmVurs/juPs3PO216gvtz1L5Ta0T
 WswEA
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

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 init/initramfs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 58db15fb18fd..f3439e8e41c4 100644
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
@@ -708,7 +709,7 @@ static void __init populate_initrd_image(char *err)
 }
 #endif /* CONFIG_BLK_DEV_RAM */
 
-static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
+static void __init unpack_initramfs(async_cookie_t cookie)
 {
 	/* Load the built in initramfs */
 	char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
@@ -716,7 +717,7 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 		panic_show_mem("%s", err); /* Failed to decompress INTERNAL initramfs */
 
 	if (!initrd_start || IS_ENABLED(CONFIG_INITRAMFS_FORCE))
-		goto done;
+		return;
 
 	if (IS_ENABLED(CONFIG_BLK_DEV_RAM))
 		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
@@ -731,9 +732,14 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
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

