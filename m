Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEE2380FF9
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075139; cv=none; b=rQaB4prCDx1zdJpM5uKcT+SDBxVWN+zfpGFsYXtZYka3dbn/ap/lCeWfiqwwEHitmkzvUhJno5/pJI3SB9i2XNTOzuInBPZTSKH+iFzlaS9m6kSs920zrcJuqe+L57G++7NuAOzRSBEa8XcMfWkq5dw1joA2wOGQ5Kxl35JtTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075139; c=relaxed/simple;
	bh=fK6xNyE6eDSHJQmEglHgdDrhfdST1Vppxfx5ZtL9Uqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+NzsufB6i3bULFCo9/H+eptxjC4qVdMsHt02nN5l19wOoCFiOh/tS7Tf+vYjNvjGp0p3afd84GaYkdWW1WLrIBN95LyPzqTYNXt1+cCH24eB8td2cGyEUMt8RJ/cKNVBXvV/QlS0TQbGNaJNPWrY7TR5dyuM9//FlOdRzRnb3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSNHAvf0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSNHAvf0"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so1325037f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780075136; x=1780679936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wZ8gF6/XO5oxB0yf+BvwEi0Q7rBPl4dd/tZzxFPNC8=;
        b=YSNHAvf0r0c5SFrSySJ/4dilw6r5S2YuJ3gPlyifsl+ePPHoARF41I4o94F1QdsZ1E
         Q9/EnxuIoKNOx5mnu4hqDjUTJqQ2ZSRS4slAGKYya4uUc0Ps4pDegY5SXgEbW+xEmG5n
         xA4AbEu33/JibHmn+myDW+VDB1yR/GBcaNVvMpOXisJzQnENeeGt8q9b61pMc15oQd7M
         3+aRtcd5LGRCWUwDhJcQgrDpZD+s5SER2soaYsdOLcOgqy6oOVIBn6xTWCb5TD4zJ0rf
         4D9oIbT+aratRcEm78kuR/TXGnVI8GYwVGEgMzPqk10Fg/lwoJoFrsmDdSDQi9JBkHLT
         c6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780075136; x=1780679936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8wZ8gF6/XO5oxB0yf+BvwEi0Q7rBPl4dd/tZzxFPNC8=;
        b=TGmDeq3+LF7Pzo9YSyApuXEXyfKLG38thPX4tzy7RSZ1fow18h/RHT2p4zBIqRSTP6
         4LOVo7gN3MyOculHbxnAOC+lkwQmZqgYteAGYNWKfwA5KxqlgjhUq5wn5+MJLeX/eGLo
         jGWBLJwK2XQ+qfkFA34k9GUTUKKVsDh+fTqbKQ0FQJyJ0K30V5/YLLVwDoxS+CcddOhG
         Xe46Ba+BStqQgfMAWm21O8O+YlBbEPKUx+pc6YtevKHqvJmn01G7WxxZv3PtR70btdwr
         5p4sryA7Cxy08EP9FJjE0EhzhTFcpjt8PFonaGJp6Y+aofH67hhU46ZMwtMmPylvIrgv
         JmCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Su6Rveage2atxNppcQNkUpokRQFwsGpozxv5OgsWSv06fpBIoTqfK0vLKsFYFQv02sqw/lTO91IUpnXOO@vger.kernel.org
X-Gm-Message-State: AOJu0YyrJ7uA4YXuAfy5AN0wxNKI1u7wkz6/PPB5sM6+5LbGBgpFj2ww
	bw6jBfUbFyH1UabDkR9vcrqKt1FVrAKHfGdOdwpq7rvIwedxzC1hC6Hx
X-Gm-Gg: Acq92OFdY/a8rHhijlAJLkFSAZ6nlYjd8UAYN/mrGb7xf7tDP1NqCWZiie5eSU+EkeI
	OORFXl3SJartObMgQeE2QA0XtdJFcjEV5L8r1ILproGXtCpWRGePg89zSsiO4d80xJ/hrPAw+Nn
	xuT4r+CUgS8WubAWDVEwtXfjW4cRaRXQ+aBfO+bkIY3CaeojbHBmvytcKhta5aWdBnd7Poxra8B
	sOt8akMXy7WVf5d0zLN8a4xsCuvuYxiZkQP2h1Z1UJqNkkSaj+11ZkM31HXb7/R9t5oe2/D4ln2
	zXjV3nS86g87LkJuPcx8ugfZcZjVRuFu1YjkXGlBBOijYCZC3qRMGkfMLgriT0dVvYOjNq9fAML
	MQe/QqJfrryMpjl8u9UoGgQWCQYXtG7vqRFapr05GPxbbNc7xvP7Xwr5XN+G+FThw8wl8+JQn1Y
	DRJYeX76TpRq3i8dB8jliCFeecMfT5AhrEpz/LSIEJN1MHPcX7pDgvHvQ61FNJ36lmnjWnyVM/1
	QjgKOaCpM2U
X-Received: by 2002:a05:600c:3e8c:b0:490:3d48:6cb9 with SMTP id 5b1f17b1804b1-490a2a02b06mr5226445e9.3.1780075136000;
        Fri, 29 May 2026 10:18:56 -0700 (PDT)
Received: from f.. (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909caa7faasm56255375e9.11.2026.05.29.10.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:18:55 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	adobriyan@gmail.com
Subject: [PATCH v4 2/3] fs: RCU-ify filesystems list
Date: Fri, 29 May 2026 19:18:39 +0200
Message-ID: <20260529171840.2576445-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529171840.2576445-1-mjguzik@gmail.com>
References: <20260529171840.2576445-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

The drivers list was protected by an rwlock; every mount, every open
of /proc/filesystems and the legacy sysfs(2) syscall walked a
hand-rolled singly-linked list under it. /proc/filesystems is
especially hot because libselinux causes programs as mundane as
mkdir, ls and sed to open and read it on every invocation.

Convert the list to an RCU-protected hlist and switch the writer side
to a plain spinlock. Writers keep their existing non-sleeping
section while readers walk under rcu_read_lock() with no lock traffic:

  - register_filesystem()/unregister_filesystem() take
    file_systems_lock, publish via hlist_{add_tail,del_init}_rcu()
    and invalidate the cached /proc/filesystems string.
    unregister_filesystem() keeps its synchronize_rcu() after
    dropping the lock so in-flight readers are drained before the
    module (and its embedded file_system_type) can go away.

  - __get_fs_type(), list_bdev_fs_names() and the
    fs_index()/fs_name()/fs_maxindex() helpers walk the list under
    rcu_read_lock(). fs_name() continues to drop the read-side
    lock after try_module_get() and accesses ->name outside the RCU
    section; the module reference pins the embedded file_system_type
    across the boundary.

struct file_system_type::next becomes struct hlist_node list; no
in-tree caller references the old ->next field outside
fs/filesystems.c.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/filesystems.c   | 179 +++++++++++++++++++--------------------------
 fs/ocfs2/super.c   |   1 -
 include/linux/fs.h |   2 +-
 3 files changed, 75 insertions(+), 107 deletions(-)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 0c7d2b7ac26c..7976366d4197 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -17,22 +17,19 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/fs_parser.h>
+#include <linux/rculist.h>
 
 /*
- * Handling of filesystem drivers list.
- * Rules:
- *	Inclusion to/removals from/scanning of list are protected by spinlock.
- *	During the unload module must call unregister_filesystem().
- *	We can access the fields of list element if:
- *		1) spinlock is held or
- *		2) we hold the reference to the module.
- *	The latter can be guaranteed by call of try_module_get(); if it
- *	returned 0 we must skip the element, otherwise we got the reference.
- *	Once the reference is obtained we can drop the spinlock.
+ * Read-mostly filesystem drivers list.
+ *
+ * Readers walk under rcu_read_lock(); writers take file_systems_lock
+ * and publish via _rcu hlist primitives.  unregister_filesystem()
+ * synchronize_rcu()s after unlock so the embedded file_system_type
+ * can't go away under a reader.  To keep using a filesystem after
+ * the RCU section ends, take a module reference via try_module_get().
  */
-
-static struct file_system_type *file_systems;
-static DEFINE_RWLOCK(file_systems_lock);
+static HLIST_HEAD(file_systems);
+static DEFINE_SPINLOCK(file_systems_lock);
 
 /* WARNING: This can be used only if we _already_ own a reference */
 struct file_system_type *get_filesystem(struct file_system_type *fs)
@@ -46,14 +43,15 @@ void put_filesystem(struct file_system_type *fs)
 	module_put(fs->owner);
 }
 
-static struct file_system_type **find_filesystem(const char *name, unsigned len)
+static struct file_system_type *find_filesystem(const char *name, unsigned len)
 {
-	struct file_system_type **p;
-	for (p = &file_systems; *p; p = &(*p)->next)
-		if (strncmp((*p)->name, name, len) == 0 &&
-		    !(*p)->name[len])
-			break;
-	return p;
+	struct file_system_type *fs;
+
+	hlist_for_each_entry_rcu(fs, &file_systems, list,
+				 lockdep_is_held(&file_systems_lock))
+		if (strncmp(fs->name, name, len) == 0 && !fs->name[len])
+			return fs;
+	return NULL;
 }
 
 /**
@@ -64,33 +62,26 @@ static struct file_system_type **find_filesystem(const char *name, unsigned len)
  *	is aware of for mount and other syscalls. Returns 0 on success,
  *	or a negative errno code on an error.
  *
- *	The &struct file_system_type that is passed is linked into the kernel 
+ *	The &struct file_system_type that is passed is linked into the kernel
  *	structures and must not be freed until the file system has been
  *	unregistered.
  */
- 
-int register_filesystem(struct file_system_type * fs)
+int register_filesystem(struct file_system_type *fs)
 {
-	int res = 0;
-	struct file_system_type ** p;
-
 	if (fs->parameters &&
 	    !fs_validate_description(fs->name, fs->parameters))
 		return -EINVAL;
 
 	BUG_ON(strchr(fs->name, '.'));
-	if (fs->next)
+	if (!hlist_unhashed_lockless(&fs->list))
 		return -EBUSY;
-	write_lock(&file_systems_lock);
-	p = find_filesystem(fs->name, strlen(fs->name));
-	if (*p)
-		res = -EBUSY;
-	else
-		*p = fs;
-	write_unlock(&file_systems_lock);
-	return res;
-}
 
+	guard(spinlock)(&file_systems_lock);
+	if (find_filesystem(fs->name, strlen(fs->name)))
+		return -EBUSY;
+	hlist_add_tail_rcu(&fs->list, &file_systems);
+	return 0;
+}
 EXPORT_SYMBOL(register_filesystem);
 
 /**
@@ -100,94 +91,78 @@ EXPORT_SYMBOL(register_filesystem);
  *	Remove a file system that was previously successfully registered
  *	with the kernel. An error is returned if the file system is not found.
  *	Zero is returned on a success.
- *	
+ *
  *	Once this function has returned the &struct file_system_type structure
  *	may be freed or reused.
  */
- 
-int unregister_filesystem(struct file_system_type * fs)
+int unregister_filesystem(struct file_system_type *fs)
 {
-	struct file_system_type ** tmp;
-
-	write_lock(&file_systems_lock);
-	tmp = &file_systems;
-	while (*tmp) {
-		if (fs == *tmp) {
-			*tmp = fs->next;
-			fs->next = NULL;
-			write_unlock(&file_systems_lock);
-			synchronize_rcu();
-			return 0;
-		}
-		tmp = &(*tmp)->next;
+	scoped_guard(spinlock, &file_systems_lock) {
+		if (hlist_unhashed(&fs->list))
+			return -EINVAL;
+		hlist_del_init_rcu(&fs->list);
 	}
-	write_unlock(&file_systems_lock);
-
-	return -EINVAL;
+	synchronize_rcu();
+	return 0;
 }
-
 EXPORT_SYMBOL(unregister_filesystem);
 
 #ifdef CONFIG_SYSFS_SYSCALL
-static int fs_index(const char __user * __name)
+static int fs_index(const char __user *__name)
 {
-	struct file_system_type * tmp;
+	struct file_system_type *p;
 	char *name __free(kfree) = strndup_user(__name, PATH_MAX);
-	int err, index;
+	int index = 0;
 
 	if (IS_ERR(name))
 		return PTR_ERR(name);
 
-	err = -EINVAL;
-	read_lock(&file_systems_lock);
-	for (tmp=file_systems, index=0 ; tmp ; tmp=tmp->next, index++) {
-		if (strcmp(tmp->name, name) == 0) {
-			err = index;
-			break;
-		}
+	guard(rcu)();
+	hlist_for_each_entry_rcu(p, &file_systems, list) {
+		if (strcmp(p->name, name) == 0)
+			return index;
+		index++;
 	}
-	read_unlock(&file_systems_lock);
-	return err;
+	return -EINVAL;
 }
 
-static int fs_name(unsigned int index, char __user * buf)
+static int fs_name(unsigned int index, char __user *buf)
 {
-	struct file_system_type * tmp;
-	int len, res = -EINVAL;
-
-	read_lock(&file_systems_lock);
-	for (tmp = file_systems; tmp; tmp = tmp->next, index--) {
-		if (index == 0) {
-			if (try_module_get(tmp->owner))
-				res = 0;
+	struct file_system_type *p, *found = NULL;
+	int len, res;
+
+	scoped_guard(rcu) {
+		hlist_for_each_entry_rcu(p, &file_systems, list) {
+			if (index--)
+				continue;
+			if (try_module_get(p->owner))
+				found = p;
 			break;
 		}
 	}
-	read_unlock(&file_systems_lock);
-	if (res)
-		return res;
+	if (!found)
+		return -EINVAL;
 
 	/* OK, we got the reference, so we can safely block */
-	len = strlen(tmp->name) + 1;
-	res = copy_to_user(buf, tmp->name, len) ? -EFAULT : 0;
-	put_filesystem(tmp);
+	len = strlen(found->name) + 1;
+	res = copy_to_user(buf, found->name, len) ? -EFAULT : 0;
+	put_filesystem(found);
 	return res;
 }
 
 static int fs_maxindex(void)
 {
-	struct file_system_type * tmp;
-	int index;
+	struct file_system_type *p;
+	int index = 0;
 
-	read_lock(&file_systems_lock);
-	for (tmp = file_systems, index = 0 ; tmp ; tmp = tmp->next, index++)
-		;
-	read_unlock(&file_systems_lock);
+	guard(rcu)();
+	hlist_for_each_entry_rcu(p, &file_systems, list)
+		index++;
 	return index;
 }
 
 /*
- * Whee.. Weird sysv syscall. 
+ * Whee.. Weird sysv syscall.
  */
 SYSCALL_DEFINE3(sysfs, int, option, unsigned long, arg1, unsigned long, arg2)
 {
@@ -216,8 +191,8 @@ int __init list_bdev_fs_names(char *buf, size_t size)
 	size_t len;
 	int count = 0;
 
-	read_lock(&file_systems_lock);
-	for (p = file_systems; p; p = p->next) {
+	guard(rcu)();
+	hlist_for_each_entry_rcu(p, &file_systems, list) {
 		if (!(p->fs_flags & FS_REQUIRES_DEV))
 			continue;
 		len = strlen(p->name) + 1;
@@ -230,24 +205,20 @@ int __init list_bdev_fs_names(char *buf, size_t size)
 		size -= len;
 		count++;
 	}
-	read_unlock(&file_systems_lock);
 	return count;
 }
 
 #ifdef CONFIG_PROC_FS
 static int filesystems_proc_show(struct seq_file *m, void *v)
 {
-	struct file_system_type * tmp;
+	struct file_system_type *p;
 
-	read_lock(&file_systems_lock);
-	tmp = file_systems;
-	while (tmp) {
+	guard(rcu)();
+	hlist_for_each_entry_rcu(p, &file_systems, list) {
 		seq_printf(m, "%s\t%s\n",
-			(tmp->fs_flags & FS_REQUIRES_DEV) ? "" : "nodev",
-			tmp->name);
-		tmp = tmp->next;
+			   (p->fs_flags & FS_REQUIRES_DEV) ? "" : "nodev",
+			   p->name);
 	}
-	read_unlock(&file_systems_lock);
 	return 0;
 }
 
@@ -263,11 +234,10 @@ static struct file_system_type *__get_fs_type(const char *name, int len)
 {
 	struct file_system_type *fs;
 
-	read_lock(&file_systems_lock);
-	fs = *(find_filesystem(name, len));
+	guard(rcu)();
+	fs = find_filesystem(name, len);
 	if (fs && !try_module_get(fs->owner))
 		fs = NULL;
-	read_unlock(&file_systems_lock);
 	return fs;
 }
 
@@ -291,5 +261,4 @@ struct file_system_type *get_fs_type(const char *name)
 	}
 	return fs;
 }
-
 EXPORT_SYMBOL(get_fs_type);
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index b875f01c9756..4870e680c4e5 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1224,7 +1224,6 @@ static struct file_system_type ocfs2_fs_type = {
 	.name           = "ocfs2",
 	.kill_sb        = kill_block_super,
 	.fs_flags       = FS_REQUIRES_DEV|FS_RENAME_DOES_D_MOVE,
-	.next           = NULL,
 	.init_fs_context = ocfs2_init_fs_context,
 	.parameters	= ocfs2_param_spec,
 };
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 748c29fa679c..2c4ffc0bb8c7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2300,7 +2300,7 @@ struct file_system_type {
 	const struct fs_parameter_spec *parameters;
 	void (*kill_sb) (struct super_block *);
 	struct module *owner;
-	struct file_system_type * next;
+	struct hlist_node list;
 	struct hlist_head fs_supers;
 
 	struct lock_class_key s_lock_key;
-- 
2.48.1

