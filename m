Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.30.189.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794869023;
	b=e+txBPdbK2lkc4HsFOX04VSz+OwmcU/I0j+ZUWIVIi68POAJJ5bdRJpVFdpWxScQmSlH
	 UPoVU6/y1BMefSTPwjxuzi0eI0vGLZmnBUhpfk9x/U3rOhMAM/3LiPV1dBRZ88QVxRp9B
	 HF5ElpswKXJ4ELnNCliqgxIPmui1CXJAeQ0at7TVN5AQ/mDVEqwMcEp7aGKVuKEc/ENQg
	 AFWVD/aXri1dnKMAcd7unZJTZk/tFDgKwYF8YPPLW87zHb2pzvEuhTZUeNGyH+eogxomr
	 Kp2z0IFiENJ8dzeRJo2HYq/ZXafX+LpyScll/LeUzVrJCAIKKQ5w/LgZ9taYW1NQy1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869023;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5o8AUouEpSgz/UpjkoFKHJWs5fYYiFvXN3dYugxLjEM=;
	b=l70jc6JkfSgn/QscO044eGAbaQfTXnUolg48dtxLI/1uwNxpT/EXDgqb37o2MsPrWyP3
	 nNLBRni/YtTfbyJ5EO8uLV+A7hz9+BNbht+lYD1yb8yXibew0joXyx0hYU89ncwPHFjOH
	 rOdurjt4m7EqNLJGD0sVHGQxOFxmnA8Kr2Ta4sEE0HEXgIideHe3HN14JyVcPKHjgKLBN
	 4iZA94NQL2QOczwgYPV6tIjcGRqqZcKz2neBYPB5Q/iq+yinCun1fgFrygdWxl9PoyHBJ
	 xuSEiDyfqBYMz1q+5cSxZDaHiLWjLMeSysiIQEklCRPeJ/wbglFdps4wvqorcsVa5+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iodev.co.uk;
	spf=pass smtp.mailfrom=iodev.co.uk;
	arc=none smtp.remote-ip=46.30.189.100
Received: from iodev.co.uk (iodev.co.uk [46.30.189.100])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D31606A8B1;
	Mon, 16 Nov 2026 22:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80D31606A8B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iodev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iodev.co.uk
Received: from localhost (unknown [79.116.217.174])
	by iodev.co.uk (Postfix) with ESMTPSA id B7B405E22DE;
	Mon, 16 Nov 2026 23:43:41 +0100 (CET)
From: Ismael Luceno <ismael@iodev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Ismael Luceno <ismael@iodev.co.uk>,
	Ismael Luceno <iluceno@suse.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Subject: [PATCH 7/8] init: let a filesystem resolve a root device by UUID or label
Date: Mon, 16 Nov 2026 23:43:23 +0100
Message-ID: <20261116224316.11237-17-ismael@iodev.co.uk>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

root= takes PARTUUID= and PARTLABEL=, both of which come from the
partition table, and so can be resolved by the block layer alone.
UUID= and LABEL= name the filesystem, and a filesystem UUID and label
live in its superblock.  Nothing outside the filesystem can recognise
one, so without this a "root=UUID=..." is taken for a device name,
fails to resolve, and — because that failure is indistinguishable
from a bad device name — takes rootwait down with it on the way past.

Let each registered filesystem look for its own UUID or label, and ask
them in turn until one claims the value.  Filesystems that do not
implement it cost nothing, so this is inert for every filesystem that
has no use for it.

The lookup opens and reads devices, so it can sleep; take a module
reference for as long as the filesystem is in use, as the comment on
file_systems describes.

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
Signed-off-by: Ismael Luceno <iluceno@suse.de>
---
 fs/filesystems.c   | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/fs.h | 10 ++++++++++
 init/do_mounts.c   | 19 +++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 3083d904df9b..13e509e027d6 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -240,6 +240,43 @@ SYSCALL_DEFINE3(sysfs, int, option, unsigned long, arg1, unsigned long, arg2)
 	return count;
 }
 
+/**
+ * find_dev_by_fs_spec - find the block device holding a filesystem by UUID or label
+ * @key: what @value is, "UUID" or "LABEL"
+ * @value: the filesystem UUID, or its label
+ *
+ * A filesystem UUID and label live in the superblock rather than in the
+ * partition metadata, so unlike PARTUUID= and PARTLABEL= they cannot be
+ * resolved from the partition table: the filesystem that knows them has to be
+ * asked.  Offer the value to each registered filesystem until one claims it.
+ *
+ * Return the dev_t found, or 0 if no filesystem recognised it.
+ */
+dev_t find_dev_by_fs_spec(const char *key, const char *value)
+{
+	struct file_system_type *p;
+	dev_t dev = 0;
+
+	guard(rcu)();
+	hlist_for_each_entry_rcu(p, &file_systems, list) {
+		if (!(p->fs_flags & FS_REQUIRES_DEV) || !p->find_by_spec)
+			continue;
+		/*
+		 * The lookup reads devices and so may sleep; hold a module
+		 * reference for as long as we use p, as the comment on
+		 * file_systems above describes.
+		 */
+		if (!try_module_get(p->owner))
+			continue;
+		if (p->find_by_spec(key, value, &dev) && dev)
+			break;
+		module_put(p->owner);
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL_GPL(find_dev_by_fs_spec);
+
 #ifdef CONFIG_PROC_FS
 static void invalidate_filesystems_string(void)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5b3a100aba77..9267ae28dc36 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2308,6 +2308,15 @@ #define FS_USERNS_DELEGATABLE	1024	/* Can be mounted inside userns from outside
 #define FS_DISALLOW_NOTIFY	2048	/* No fsnotify marks on its objects */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
+	/*
+	 * Look for the block device holding the filesystem that @key
+	 * identifies as @value, for "root=UUID=" and "root=LABEL=".  Both live
+	 * in the superblock rather than in the partition metadata, so unlike
+	 * PARTUUID= and PARTLABEL= it is the filesystem that has to recognise
+	 * them.  @key is "UUID" or "LABEL".  Set *dev and return 0 on a
+	 * match, or return an error if there is none.
+	 */
+	int (*find_by_spec)(const char *key, const char *value, dev_t *dev);
 	const struct fs_parameter_spec *parameters;
 	void (*kill_sb) (struct super_block *);
 	struct module *owner;
@@ -3579,6 +3588,7 @@ #define DEFINE_SIMPLE_ATTRIBUTE_SIGNED(__fops, __get, __set, __fmt)	\
 				 size_t len, loff_t *ppos);
 
 int __init list_bdev_fs_names(char *buf, size_t size);
+dev_t find_dev_by_fs_spec(const char *key, const char *value);
 
 #define __FMODE_EXEC		((__force int) FMODE_EXEC)
 
diff --git a/init/do_mounts.c b/init/do_mounts.c
index f1dcb18201eb..3845b1e67f46 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -453,6 +453,25 @@ #define CIFSROOT_RETRY_MAX	5
 		return Root_NFS;
 	if (strcmp(root_device_name, "/dev/cifs") == 0)
 		return Root_CIFS;
+
+	/*
+	 * A filesystem UUID or label is in the superblock, not in the
+	 * partition table, so it is the filesystem that has to recognise it.
+	 * Try that before early_lookup_bdev(), which would take "UUID=..." for
+	 * a device name and fail.
+	 */
+	if (!strncmp(root_device_name, "UUID=", 5)) {
+		dev = find_dev_by_fs_spec("UUID", root_device_name + 5);
+		if (dev)
+			return dev;
+		return 0;
+	}
+	if (!strncmp(root_device_name, "LABEL=", 6)) {
+		dev = find_dev_by_fs_spec("LABEL", root_device_name + 6);
+		if (dev)
+			return dev;
+		return 0;
+	}
 	if (strcmp(root_device_name, "/dev/ram") == 0)
 		return Root_RAM0;
 
