Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.30.189.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794869015;
	b=mkHYwcBDiKyeB72fC57wvUc8ABx9Juz/ZLdJ4ACcxm8BNRuRpUx1RiCVx8SGtK9wyKHE
	 4rXTAzGnWXKGh5LMMiyyj9ia25cDXtcdQFSDPEd0yccvaUhwKiMkL7hIE7uxR+rs83FlB
	 bAdsfqyPdj0bVi3fdOI3pwMqcxbvOaoLReDR8cCo06xI2ULvHVRi1NB2GR14EGe85yAYL
	 dGerL8BigoJCKwrcXy1BNMD0PTxgxIXhf2+Dc7I1vJtn6WjyVRdjvcRhomkilERtSXaje
	 S8eBcTnHEauNob/+0ohrszCLCJRwoCkIhhS26rgTpvI9U2pxPgkO5CXUTCCd+xPuxcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869015;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RI2I0K6jbVCh/K449T6prvNDKlTyoHgfMjf3B13RKuY=;
	b=HIkCw7pyd/xEDm6tAw2IznS2ZQRfqVrkkn1QRAKG1I8uLae2gAGs5Wax/089wnbteTZy
	 0E/U7fZ2ONh3j5kRoBOpAE5nS82+86J0qEESgrNmQQYulXSxRL+KzTenkZq8Pr9qy7PB/
	 KP7zESvxGp5o3h7ZkHuPN/CKt/jHvn6euM2eYIvjj32mUd4axaxmFKiQDOwOcvoDSyw2S
	 14WMH5A56+jtGFhL1xz0oZkQz1D1kxtYlaoZ+b5AfXuGriAJMofBSXHeyndXcDCMEYR76
	 hQDNct7W43HMiWS7uAN7Gs++LkP7H8M29V25RzPy43u218PkLkUJjvTz4PiB9+zI7RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iodev.co.uk;
	spf=pass smtp.mailfrom=iodev.co.uk;
	arc=none smtp.remote-ip=46.30.189.100
Received: from iodev.co.uk (iodev.co.uk [46.30.189.100])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B21606A332;
	Mon, 16 Nov 2026 22:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47B21606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iodev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iodev.co.uk
Received: from localhost (unknown [79.116.217.174])
	by iodev.co.uk (Postfix) with ESMTPSA id 85E525E22D5;
	Mon, 16 Nov 2026 23:43:34 +0100 (CET)
From: Ismael Luceno <ismael@iodev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Ismael Luceno <ismael@iodev.co.uk>,
	Ismael Luceno <iluceno@suse.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Subject: [PATCH 3/8] init: let filesystems ask whether they are mounting the root device
Date: Mon, 16 Nov 2026 23:43:19 +0100
Message-ID: <20261116224316.11237-13-ismael@iodev.co.uk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116224316.11237-10-ismael@iodev.co.uk>
References: <20261116224316.11237-10-ismael@iodev.co.uk>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A filesystem that wants to treat the root mount differently from any
other mount has no way to tell which one it is being asked for, and no
way to find out how long the user is willing to wait for it.  Expose
both.

root_wait becomes a global so a filesystem can read the value the user
gave rootwait=, and is_root_dev() reports whether a device is the one
the root filesystem is being mounted from.  mount_root() is the only
thing that mounts from /dev/root, and that name exists for the root
mount alone, so a filesystem handed that device is being asked to be
the root filesystem.

No behaviour changes.  This is here so a filesystem can act on the
root mount, which btrfs does next.

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
Signed-off-by: Ismael Luceno <iluceno@suse.de>
---
 include/linux/root_dev.h | 14 ++++++++++++++
 init/do_mounts.c         | 18 +++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/linux/root_dev.h b/include/linux/root_dev.h
index 847c9a06101b..b5a0181d1967 100644
--- a/include/linux/root_dev.h
+++ b/include/linux/root_dev.h
@@ -15,4 +15,18 @@ #define _ROOT_DEV_H_
 
 extern dev_t ROOT_DEV;
 
+/*
+ * Milliseconds to wait for the root device, from the rootwait= parameter.
+ * Negative means wait indefinitely, zero means do not wait.
+ */
+extern int root_wait;
+
+/*
+ * True if @dev is the device the root filesystem is being mounted from, or
+ * was mounted from.  The root mount names the device /dev/root, which is
+ * created for it alone, so a filesystem can tell the root mount from any
+ * other it is asked to do.
+ */
+bool is_root_dev(dev_t dev);
+
 #endif
diff --git a/init/do_mounts.c b/init/do_mounts.c
index febcc37f9128..f1dcb18201eb 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -30,9 +30,9 @@
 
 int root_mountflags = MS_RDONLY | MS_SILENT;
 static char __initdata saved_root_name[64];
-static int root_wait;
 
 dev_t ROOT_DEV;
+int root_wait;
 
 static int __init readonly(char *str)
 {
@@ -372,10 +372,26 @@ #define CIFSROOT_RETRY_MAX	5
 		pr_emerg("Failed to create /dev/root: %d\n", err);
 	mount_root_generic("/dev/root", root_device_name, root_mountflags);
 }
+
+/*
+ * Was the filesystem on @dev mounted as the root filesystem?  mount_root()
+ * above is the only thing that mounts from /dev/root, and that name is given
+ * to the root mount alone, so a filesystem being handed that device is being
+ * asked to be the root filesystem.
+ */
+bool is_root_dev(dev_t dev)
+{
+	return dev && dev == ROOT_DEV;
+}
 #else
 static inline void mount_block_root(char *root_device_name)
 {
 }
+
+static inline bool is_root_dev(dev_t dev)
+{
+	return false;
+}
 #endif /* CONFIG_BLOCK */
 
 void __init mount_root(char *root_device_name)
