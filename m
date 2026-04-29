Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E3130E0CC
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458070; cv=none; b=Xv2FIPCB90TkCufX0WPKlUW11pofeFiktd3lP2rQBpV0XwqPZlxlv4Ye24MJtv7tu0TUmqhEIzpZ5qyLRibVOelz2h1AmIfoO0gT44R7y3GN+YxeJJBiXC4npSA21Iau829xs81J0pEiFpZtmtmkLp4fPs9gtVk61WYv0U4HEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458070; c=relaxed/simple;
	bh=s8PuXUAD4v8+M8M71hm/YKwJCjmy354+sEvPNjsURJg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=low4xX9JHZMnelGkh72DktHBd8/yYfVRUPAGf2AjpwOHjhAVXIVLF0/7r/Qr/IJ67IzIfJKCB9E6p/wpzNW7//KA3Rlf/twUg1PiMmpL+w1Wdj+WYmt8u36O4jjAPdNvXBiGhQVFOwlxBpwqwjgR2kuL1iQI13hovvLTx/n0/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVsDxpcv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JrX6yQN4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVsDxpcv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrX6yQN4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777458065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ab6SYn0kAMQckl4DZk9MsqmnKGcvztFs+MEtfUrdSPU=;
	b=fVsDxpcvr9Jx7t7jhh8lbxF2LzUbTUg5QD8RK8WnNPcct0vWaecoLjGxadLB0EdghNY4nN
	JeooLS9vXeWrKOFgUNl2UkqwyTRMbnBypYLbdAkgDdBPoAZ7aZhmjwKDMUudfbprKgZfD0
	m+Ieo6NaTLRUZt2Kz6G3NSFMBtX5pYA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-4jS1tPwxMU6uNoKHF0_uMg-1; Wed, 29 Apr 2026 06:21:03 -0400
X-MC-Unique: 4jS1tPwxMU6uNoKHF0_uMg-1
X-Mimecast-MFC-AGG-ID: 4jS1tPwxMU6uNoKHF0_uMg_1777458062
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43e52dc8a04so10674201f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 03:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777458062; x=1778062862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ab6SYn0kAMQckl4DZk9MsqmnKGcvztFs+MEtfUrdSPU=;
        b=JrX6yQN4GvZWZpt0qS9tDamcOvSRwtCvV3zQAOjZoVovx+UFwF1CdmDePLI9xx2oym
         SGITy3s2zUSbBaX6csU/pV28GnGVqKRw0otoDKLx73Cl2EisZG+vheaNPYXtVXfwPoi/
         joJja4lM1R8xXuH/mtM0TrEUDR3+gnv5pawHMvmWE0s7k4q6O+DgwPsOmOTFdl0ihjdq
         6wj8T3p2jXFbeu5SH26+TG+MELw0Ug7+B8hMXCijH4lWRoW8c0zz+4K/a4qI+mmhN+V9
         0Av8z7mjTJ3ix+VW/rJ1/WsFKy3p57zlhamcZOvzVg6aARXqTHQ6fKUN4JXHa3iJWWKW
         Aleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777458062; x=1778062862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ab6SYn0kAMQckl4DZk9MsqmnKGcvztFs+MEtfUrdSPU=;
        b=dlX2ceSHMBLRixbYXHBNX6gZYIZcjNgsU8gdZRllwtBkWIL2buIoM1/9sdQdxxTL3Y
         C4r3wnaWlkugD9OlicCQp2NookSyQGZDvLFgZtephy1Vg4FcT/jp0NPYnYEjSMol9xoR
         Y58f9BBD58CfQAtLHxfxGS43gxKnE+a8Droqy9wzn3wJ6R9hdPdTvjjO4SjokI5Z8/F6
         NZff75fdjHDTLkHMPfyi1VEMr2e9VvI0UVF+ABrysUU47qxmNApab5a0vR9l8DUUNhtN
         A/E599ZoLp4xwyBqrIQUDhU+EtPJMzujp5PevRY3lH/n8usn1szsGm7ARRQOTplEKgDz
         6rXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1h1AF0J9mxg68R76abdlsaACJ4QdfBxBH/LlHglK2jZeOItPnm7hugvdD/SpKmgz4oc2xptB8vWy78Qb+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2+a/Osy3rv05GohMbSzzuOyiHq8oYZmi1DIdOiKz8CviBEqxw
	rKN04b9mEdiq71DDiIFyK1udFgaC50wWFj5RWec3zkkBiw060CeAoNWduzcmQXuxePqCMsxv2GV
	06SGV8OrDjdK1xsC5i2cF/KuKWjG+pvqj1ddzRaYNuPfvlCXEONc0YO9J7ZzlePeF/DAuHEVVic
	k=
X-Gm-Gg: AeBDievmK1/Z59LSQ7NMwOPEz0K6DN9XsKs9B7wF1UTBj2LNrmJjdm5ScdlPLzIuy0Q
	APQ0epJEhDUqrjaABL+JXG+Vg8Z/qypN+cavCzUw/XumDbTASdHGVmtMwfU6VXTZPwuG9aCmG3m
	IfwvBxvM2RsrC8I6ZEEBgxfx9FXQUDZ/ceFzUx15V06jUP5BbM4Q5ejqyjSPie4sgQl5afpbipX
	e2Ptx1znMk6bvyV4/Izl9nQHTk71q6UBYSbhzDBVYcH4L6xHYZ4lRnHbeAnPP/Okk4gGLBfnGeH
	yqsx31aAqmP9Xsf8wkcO6qaMh6EG5ODkqsCG+f8M2MULViJIerJ51iut+UJe0TYZ351LRUg/EvH
	c8QeSC9G8Qs/tt1sEkG7WUggWdPcQj684GC65zQ0ETtRo7uKKSDXhOYwJCDflw+qIvOEEcOj4fW
	ppDqPjOurfPBgXeg==
X-Received: by 2002:a05:600c:4593:b0:489:c57:7836 with SMTP id 5b1f17b1804b1-48a7b5479dcmr62162935e9.27.1777458061140;
        Wed, 29 Apr 2026 03:21:01 -0700 (PDT)
X-Received: by 2002:a05:600c:4593:b0:489:c57:7836 with SMTP id 5b1f17b1804b1-48a7b5479dcmr62161855e9.27.1777458060290;
        Wed, 29 Apr 2026 03:21:00 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (176-241-63-254.pool.digikabel.hu. [176.241.63.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7bc1cb91sm47754305e9.6.2026.04.29.03.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 03:20:59 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: add fusex filesystem
Date: Wed, 29 Apr 2026 12:20:57 +0200
Message-ID: <20260429102058.1362965-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This stands for "fuse extended/experimental".

The purpose is to provide a clean base for big features like the FUSE_IOMAP
api.

It's also a good way to try new stuff like file handles and compound
requests without the risk of breaking something in the large and complex
fuse codebase.

Whether these features will be migrated back into the main fuse codebase,
or fusex is going to end up as a major version update is still up in the
air.

Major differences from regular fuse:

 - local filesystem mode only
 - only synchronous FUSE_INIT is supported
 - only no-open mode
 - new requests:
   + FUSE_LOOKUP_ROOT - return nodeid of root
   + FUSE_LOOKUPX - FUSE_LOOKUP without the getattr
   + FUSE_MKOBJX - merged FUSE_MKNOD, MKDIR, SYMLINK and TMPFILE
   + FUSE_SETSTATX - extended version of FUSE_SETATTR

Missing features:

 - file handles / export ops
 - compound requests
 - xattr caching
 - fileattr
 - fiemap
 - ioctl
 - copy_file_range
 - lazy dir open

Test server can be found at:

  https://github.com/szmi/fuse-utils

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---

Patch is against

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next

 fs/fuse/Makefile          |    2 +-
 fs/fuse/args.h            |    1 +
 fs/fuse/dev.c             |   13 +-
 fs/fuse/dir.c             |    4 +-
 fs/fuse/fuse_i.h          |    8 +
 fs/fuse/fusex.c           | 1751 +++++++++++++++++++++++++++++++++++++
 fs/fuse/fusex.h           |    4 +
 fs/fuse/inode.c           |   16 +-
 include/uapi/linux/fuse.h |   36 +
 9 files changed, 1826 insertions(+), 9 deletions(-)
 create mode 100644 fs/fuse/fusex.c
 create mode 100644 fs/fuse/fusex.h

diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 245e67852b03..d9963e411b62 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
 fuse-y := trace.o	# put trace.o first so we see ftrace errors sooner
 fuse-y += dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o req_timeout.o req.o
-fuse-y += poll.o notify.o
+fuse-y += poll.o notify.o fusex.o
 fuse-y += iomode.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
 fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o backing.o
diff --git a/fs/fuse/args.h b/fs/fuse/args.h
index ecfe51a192af..1c1e0a25ea07 100644
--- a/fs/fuse/args.h
+++ b/fs/fuse/args.h
@@ -35,6 +35,7 @@ struct fuse_args {
 	bool out_pages:1;
 	bool user_pages:1;
 	bool out_argvar:1;
+	bool out_var_alloc:1;
 	bool page_zeroing:1;
 	bool page_replace:1;
 	bool may_block:1;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6fe0d8c263df..134572b1a9af 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1847,15 +1847,24 @@ int fuse_copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
 
 	reqsize += fuse_len_args(args->out_numargs, args->out_args);
 
-	if (reqsize < nbytes || (reqsize > nbytes && !args->out_argvar))
+	if (reqsize < nbytes)
 		return -EINVAL;
-	else if (reqsize > nbytes) {
+
+	if (args->out_argvar) {
 		struct fuse_arg *lastarg = &args->out_args[args->out_numargs-1];
 		unsigned diffsize = reqsize - nbytes;
 
 		if (diffsize > lastarg->size)
 			return -EINVAL;
 		lastarg->size -= diffsize;
+
+		if (args->out_var_alloc) {
+			lastarg->value = kvmalloc(lastarg->size, GFP_KERNEL);
+			if (!lastarg->value)
+				return -ENOMEM;
+		}
+	} else if (reqsize > nbytes) {
+		return -EINVAL;
 	}
 	return fuse_copy_args(cs, args->out_numargs, args->out_pages,
 			      args->out_args, args->page_zeroing);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index be41c14ef329..cbe0d4b65d49 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -542,7 +542,7 @@ int fuse_valid_type(int m)
 		S_ISBLK(m) || S_ISFIFO(m) || S_ISSOCK(m);
 }
 
-static bool fuse_valid_size(u64 size)
+bool fuse_valid_size(u64 size)
 {
 	return size <= LLONG_MAX;
 }
@@ -2485,7 +2485,7 @@ static int fuse_symlink_read_folio(struct file *null, struct folio *folio)
 	return err;
 }
 
-static const struct address_space_operations fuse_symlink_aops = {
+const struct address_space_operations fuse_symlink_aops = {
 	.read_folio	= fuse_symlink_read_folio,
 };
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 3a7ac74a23ed..fe66281b7554 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -69,6 +69,9 @@ extern struct mutex fuse_mutex;
 extern unsigned int max_user_bgreq;
 extern unsigned int max_user_congthresh;
 
+extern struct kmem_cache *fuse_inode_cachep;
+extern const struct address_space_operations fuse_symlink_aops;
+
 struct fuse_forget_link;
 
 /**
@@ -911,6 +914,8 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
 		     struct fuse_entry_out *outarg, struct inode **inode);
 
+void fuse_umount_begin(struct super_block *sb);
+
 /*
  * Initialize READ or READDIR request
  */
@@ -1102,6 +1107,7 @@ void fuse_ctl_remove_conn(struct fuse_conn *fc);
  * Is file type valid?
  */
 int fuse_valid_type(int m);
+bool fuse_valid_size(u64 size);
 
 bool fuse_invalid_attr(struct fuse_attr *attr);
 
@@ -1204,6 +1210,8 @@ struct posix_acl *fuse_get_acl(struct mnt_idmap *idmap,
 int fuse_set_acl(struct mnt_idmap *, struct dentry *dentry,
 		 struct posix_acl *acl, int type);
 
+void fuse_convert_statfs(struct kstatfs *stbuf, struct fuse_kstatfs *attr);
+
 /* readdir.c */
 int fuse_readdir(struct file *file, struct dir_context *ctx);
 
diff --git a/fs/fuse/fusex.c b/fs/fuse/fusex.c
new file mode 100644
index 000000000000..98e239e7e00e
--- /dev/null
+++ b/fs/fuse/fusex.c
@@ -0,0 +1,1751 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "fusex.h"
+#include "dev.h"
+#include "fuse_i.h"
+
+#include <linux/fs_context.h>
+#include <linux/miscdevice.h>
+#include <linux/xxhash.h>
+#include <linux/pagemap.h>
+#include <linux/exportfs.h>
+#include <linux/iversion.h>
+#include <linux/posix_acl_xattr.h>
+#include <linux/statfs.h>
+#include <linux/falloc.h>
+#include <linux/fs_parser.h>
+
+static void fusex_init_inode(struct inode *inode);
+
+#define ADD_IN_ARG(_args, _size, _value) \
+	(*NEXT_IN_ARG(&(_args)) = (struct fuse_in_arg) { .size = (_size), .value = (_value) })
+
+#define ADD_IN_ARG_S(args, ptr) \
+	ADD_IN_ARG(args, sizeof(*(ptr)), ptr)
+
+#define ADD_IN_ARG_ZERO(args) \
+	ADD_IN_ARG(args, 0, NULL)
+
+#define ADD_OUT_ARG(_args, _size, _value) \
+	(*NEXT_OUT_ARG(&(_args)) = (struct fuse_arg) { .size = (_size), .value = (_value) })
+
+#define ADD_OUT_ARG_S(args, ptr)			\
+	ADD_OUT_ARG(args, sizeof(*(ptr)), ptr)
+
+static struct fuse_in_arg *NEXT_IN_ARG(struct fuse_args *args)
+{
+	if (WARN_ON(args->in_numargs >= ARRAY_SIZE(args->in_args)))
+		return NULL;
+
+	return &args->in_args[args->in_numargs++];
+}
+
+static struct fuse_arg *NEXT_OUT_ARG(struct fuse_args *args)
+{
+	if (WARN_ON(args->out_numargs >= ARRAY_SIZE(args->out_args)))
+		return NULL;
+
+	return &args->out_args[args->out_numargs++];
+}
+
+struct fusex_id {
+	u64 nodeid;
+	/* will extend with file handle */
+};
+
+static int fusex_id_from_args(struct fuse_args *args, struct fusex_id *id)
+{
+	struct fuse_entryx_out *outarg = args->out_args[0].value;
+
+	/* will extract file handle */
+	id->nodeid = outarg->nodeid;
+	if (!id->nodeid)
+		return -EIO;
+
+	return 0;
+}
+
+static ssize_t fusex_inode_request(struct inode *inode, struct fuse_args *args)
+{
+	args->nodeid = get_node_id(inode);
+	/* will add file handle */
+	return fuse_simple_request(get_fuse_mount(inode), args);
+}
+
+static ssize_t fusex_id_request(struct inode *inode, const struct fusex_id *id,
+				struct fuse_args *args)
+{
+	args->nodeid = id->nodeid;
+	/* will add file handle */
+	return fuse_simple_request(get_fuse_mount(inode), args);
+}
+
+static ssize_t fusex_inode2_request(struct inode *inode, struct inode *inode2,
+				    struct fuse_args *args)
+{
+	/* will add file handle for both inodes */
+	return fusex_inode_request(inode, args);
+}
+
+static struct inode *fusex_alloc_inode(struct super_block *sb)
+{
+	struct fuse_inode *fi;
+	struct fuse_forget_link *forget __free(kfree) = fuse_alloc_forget();
+
+	if (!forget)
+		return NULL;
+
+	fi = alloc_inode_sb(sb, fuse_inode_cachep, GFP_KERNEL);
+	if (!fi)
+		return NULL;
+
+	/* Initialize private data (i.e. everything except fi->inode) */
+	BUILD_BUG_ON(offsetof(struct fuse_inode, inode) != 0);
+	memset((void *) fi + sizeof(fi->inode), 0, sizeof(*fi) - sizeof(fi->inode));
+
+	fi->forget = no_free_ptr(forget);
+	return &fi->inode;
+}
+
+static void fusex_free_inode(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	kfree(fi->forget);
+	kmem_cache_free(fuse_inode_cachep, fi);
+}
+
+static void fusex_evict_inode(struct inode *inode)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	truncate_inode_pages_final(&inode->i_data);
+	clear_inode(inode);
+	if (fi->forget) {
+		fuse_chan_queue_forget(fc->chan, fi->forget, fi->nodeid, 1);
+		fi->forget = NULL;
+	}
+}
+
+static int fusex_send_setstatx(struct inode *inode, struct fuse_setstatx_in *inarg)
+{
+	FUSE_ARGS(args);
+	struct fuse_statx_out outarg;
+
+	args.opcode = FUSE_SETSTATX;
+	ADD_IN_ARG_S(args, inarg);
+	ADD_OUT_ARG_S(args, &outarg);
+
+	return fusex_inode_request(inode, &args);
+}
+
+static void fusex_get_atime(const struct inode *inode, struct fuse_statx *sx)
+{
+	sx->mask |= STATX_ATIME;
+	sx->atime.tv_sec = inode->i_atime_sec;
+	sx->atime.tv_nsec = inode->i_atime_nsec;
+}
+
+static void fusex_get_mtime(const struct inode *inode, struct fuse_statx *sx)
+{
+	sx->mask |= STATX_MTIME;
+	sx->mtime.tv_sec = inode->i_mtime_sec;
+	sx->mtime.tv_nsec = inode->i_mtime_nsec;
+}
+
+static void fusex_get_ctime(const struct inode *inode, struct fuse_statx *sx)
+{
+	sx->mask |= STATX_CTIME;
+	sx->ctime.tv_sec = inode->i_ctime_sec;
+	sx->ctime.tv_nsec = inode->i_ctime_nsec;
+}
+
+static int fusex_write_inode(struct inode *inode, struct writeback_control *wbc)
+{
+	struct fuse_setstatx_in inarg;
+
+	memset(&inarg, 0, sizeof(inarg));
+
+	fusex_get_atime(inode, &inarg.stat);
+	fusex_get_mtime(inode, &inarg.stat);
+	fusex_get_ctime(inode, &inarg.stat);
+
+	return fusex_send_setstatx(inode, &inarg);
+}
+
+static int fusex_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	FUSE_ARGS(args);
+	struct fuse_statfs_out outarg;
+	int err;
+
+	args.opcode = FUSE_STATFS;
+	ADD_OUT_ARG_S(args, &outarg);
+	err = fusex_inode_request(d_inode(dentry), &args);
+	if (!err)
+		fuse_convert_statfs(buf, &outarg.st);
+	return err;
+}
+
+static const struct super_operations fusex_super_operations = {
+	.alloc_inode    = fusex_alloc_inode,
+	.free_inode     = fusex_free_inode,
+	.evict_inode	= fusex_evict_inode,
+	.write_inode	= fusex_write_inode,
+	.umount_begin	= fuse_umount_begin,
+	.statfs		= fusex_statfs,
+};
+
+static void fusex_set_times(struct inode *inode, struct fuse_statx *attr)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	/* Sanitize nsecs */
+	attr->atime.tv_nsec = min_t(u32, attr->atime.tv_nsec, NSEC_PER_SEC - 1);
+	attr->mtime.tv_nsec = min_t(u32, attr->mtime.tv_nsec, NSEC_PER_SEC - 1);
+	attr->ctime.tv_nsec = min_t(u32, attr->ctime.tv_nsec, NSEC_PER_SEC - 1);
+
+	inode_set_mtime(inode, attr->mtime.tv_sec, attr->mtime.tv_nsec);
+	inode_set_ctime(inode, attr->ctime.tv_sec, attr->ctime.tv_nsec);
+	inode_set_atime(inode, attr->atime.tv_sec, attr->atime.tv_nsec);
+
+	if (attr->mask & STATX_BTIME) {
+		set_bit(FUSE_I_BTIME, &fi->state);
+		fi->i_btime.tv_sec = attr->btime.tv_sec;
+		fi->i_btime.tv_nsec = attr->btime.tv_nsec;
+	}
+}
+
+static void fusex_set_attr(struct inode *inode, struct fuse_statx *attr)
+{
+	struct user_namespace *user_ns = i_user_ns(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	inode->i_mode = attr->mode;
+	inode->i_size = attr->size;
+	inode->i_blocks = attr->blocks;
+	inode->i_ino = fi->orig_ino = attr->ino;
+	inode->i_uid = make_kuid(user_ns, attr->uid);
+	inode->i_gid = make_kgid(user_ns, attr->gid);
+	fi->cached_i_blkbits = ilog2(attr->blksize);
+	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+		inode->i_rdev = MKDEV(attr->rdev_major, attr->rdev_minor);
+
+	if (S_ISDIR(attr->mode) && attr->nlink > 1)
+		attr->nlink = 1;
+	set_nlink(inode, attr->nlink);
+
+	fusex_set_times(inode, attr);
+}
+
+static int fusex_inode_eq(struct inode *inode, void *_id)
+{
+	struct fusex_id *id = _id;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	return id->nodeid == fi->nodeid;
+}
+
+static int fusex_inode_set(struct inode *inode, void *_id)
+{
+	struct fusex_id *id = _id;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	fi->nodeid = id->nodeid;
+
+	return 0;
+}
+
+static unsigned long fusex_hash_id(const struct fusex_id *id)
+{
+	return xxhash(&id->nodeid, sizeof(id->nodeid), 0);
+}
+
+static void fusex_fill_statx(struct fuse_args *args, struct fuse_statx_in *inarg,
+			     struct fuse_statx_out *outarg)
+{
+	memset(inarg, 0, sizeof(*inarg));
+	inarg->sx_mask = STATX_BASIC_STATS | STATX_BTIME;
+
+	args->opcode = FUSE_STATX;
+	ADD_IN_ARG_S(*args, inarg);
+	ADD_OUT_ARG_S(*args, outarg);
+}
+
+static int fusex_send_statx(struct inode *inode, struct fuse_statx_out *outarg)
+{
+	FUSE_ARGS(args);
+	struct fuse_statx_in inarg;
+	int err;
+
+	fusex_fill_statx(&args, &inarg, outarg);
+	err = fusex_inode_request(inode, &args);
+	if (err)
+		return err;
+
+	if (!fuse_valid_type(outarg->stat.mode) || !fuse_valid_size(outarg->stat.size))
+		return -EIO;
+
+	return 0;
+}
+
+static struct inode *fusex_iget(struct super_block *sb, struct fusex_id *id)
+{
+	return iget5_locked(sb, fusex_hash_id(id), fusex_inode_eq, fusex_inode_set, id);
+}
+
+static struct inode *fusex_get_inode(struct super_block *sb, struct fusex_id *id)
+{
+	struct inode *inode = fusex_iget(sb, id);
+	struct fuse_statx_out statx;
+	int err;
+
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	if (inode_state_read_once(inode) & I_NEW) {
+		inode_state_set(inode, I_DONTCACHE);
+		err = fusex_send_statx(inode, &statx);
+		if (err) {
+			discard_new_inode(inode);
+			return ERR_PTR(err);
+		}
+		fusex_set_attr(inode, &statx.stat);
+		fusex_init_inode(inode);
+		unlock_new_inode(inode);
+	}
+	return inode;
+}
+
+static void fusex_extend_file(struct inode *inode, loff_t old_size, loff_t new_size)
+{
+	WARN_ON(new_size > inode->i_size);
+
+	if (old_size < new_size)
+		truncate_pagecache_range(inode, old_size, new_size - 1);
+}
+
+static long fusex_file_fallocate(struct file *file, int mode, loff_t offset, loff_t length)
+{
+	struct inode *inode = file_inode(file);
+	FUSE_ARGS(args);
+	struct fuse_fallocate_in inarg = {
+		.offset = offset,
+		.length = length,
+		.mode = mode
+	};
+	off_t end = offset + length;
+	int err;
+
+	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
+		     FALLOC_FL_ZERO_RANGE))
+		return -EOPNOTSUPP;
+
+	guard(rwsem_write)(&inode->i_rwsem);
+
+	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)) {
+		err = filemap_write_and_wait_range(inode->i_mapping, offset, end - 1);
+		if (err)
+			return err;
+	}
+
+	if (!(mode & FALLOC_FL_KEEP_SIZE) && end > inode->i_size) {
+		err = inode_newsize_ok(inode, end);
+		if (err)
+			return err;
+	}
+
+	err = file_modified(file);
+	if (err)
+		return err;
+
+	args.opcode = FUSE_FALLOCATE;
+	args.in_numargs = 1;
+	ADD_IN_ARG_S(args, &inarg);
+	err = fusex_inode_request(inode, &args);
+	if (err)
+		return err;
+
+	if (!(mode & FALLOC_FL_KEEP_SIZE) && end > inode->i_size) {
+		loff_t old_size = inode->i_size;
+
+		i_size_write(inode, end);
+		fusex_extend_file(inode, old_size, inode->i_size);
+	}
+
+	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE))
+		truncate_pagecache_range(inode, offset, end - 1);
+
+	return 0;
+}
+
+static const struct file_operations fusex_file_operations = {
+	.read_iter	= generic_file_read_iter,
+	.write_iter	= generic_file_write_iter,
+	.splice_read	= filemap_splice_read,
+	.splice_write	= iter_file_splice_write,
+	.llseek		= generic_file_llseek,
+	.mmap_prepare	= generic_file_mmap_prepare,
+	.fsync		= simple_fsync_noflush,
+	.fallocate	= fusex_file_fallocate,
+};
+
+static int fusex_send_read(struct inode *inode, loff_t pos, struct file *file,
+			   struct folio *folio, unsigned int off, unsigned int len)
+{
+	struct fuse_args_pages ap = {};
+	struct fuse_folio_desc desc = { .offset = off, .length = len };
+	struct fuse_read_in inarg;
+	ssize_t res;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.offset = pos;
+	inarg.size = len;
+	inarg.flags = file->f_flags;
+	ap.args.opcode = FUSE_READ;
+	ADD_IN_ARG_S(ap.args, &inarg);
+	ADD_OUT_ARG(ap.args, len, NULL);
+	ap.args.out_argvar = true;
+	ap.args.out_pages = true;
+	ap.num_folios = 1;
+	ap.folios = &folio;
+	ap.descs = &desc;
+
+	res = fusex_inode_request(inode, &ap.args);
+	if (res < 0)
+		return res;
+
+	WARN_ON(res > len);
+	if (res < len)
+		folio_zero_segment(folio, off + res, off + len);
+
+	return 0;
+}
+
+static int fusex_do_read_folio(struct file *file, struct folio *folio)
+{
+	struct inode *inode = folio->mapping->host;
+	loff_t folio_start = folio_pos(folio);
+	loff_t i_size = i_size_read(inode);
+	size_t full_len = folio_size(folio), len = full_len;
+	int err;
+
+	WARN_ON(i_size <= folio_start);
+
+	if (i_size < folio_start + full_len) {
+		len = i_size - folio_start;
+		folio_zero_segment(folio, len, full_len);
+	}
+	err = fusex_send_read(inode, folio_start, file, folio, 0, len);
+	if (err)
+		return err;
+
+	folio_mark_uptodate(folio);
+
+	return 0;
+}
+
+static int fusex_read_folio(struct file *file, struct folio *folio)
+{
+	int err = fusex_do_read_folio(file, folio);
+
+	folio_unlock(folio);
+	return err;
+}
+
+static int fusex_send_write(struct inode *inode, loff_t pos,
+			     struct folio *folio, unsigned int off, unsigned int len)
+{
+	struct fuse_args_pages ap = {};
+	struct fuse_folio_desc desc = { .offset = off, .length = len };
+	struct fuse_write_in inarg;
+	struct fuse_write_out outarg;
+	int err;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.offset = pos;
+	inarg.size = len;
+
+	ap.args.opcode = FUSE_WRITE;
+	ADD_IN_ARG_S(ap.args, &inarg);
+	ADD_IN_ARG(ap.args, len, NULL);
+	ap.args.in_pages = true;
+	ap.num_folios = 1;
+	ap.folios = &folio;
+	ap.descs = &desc;
+	ADD_OUT_ARG_S(ap.args, &outarg);
+
+	err = fusex_inode_request(inode, &ap.args);
+	if (err)
+		return err;
+
+	if (outarg.size != len)
+		return -EIO;
+
+	return 0;
+}
+
+static int fusex_writepages(struct address_space *mapping, struct writeback_control *wbc)
+{
+	struct folio *folio = NULL;
+	int err;
+
+	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
+		struct inode *inode = folio->mapping->host;
+		loff_t folio_start = folio_pos(folio);
+		loff_t i_size = i_size_read(inode);
+		size_t full_len = folio_size(folio), len = full_len;
+
+		if (folio_start < i_size) {
+			if (i_size < folio_start + full_len)
+				len = i_size - folio_start;
+
+			err = fusex_send_write(inode, folio_start, folio, 0, len);
+		}
+		folio_unlock(folio);
+	}
+
+	return err;
+}
+
+static int fusex_write_begin(const struct kiocb *iocb, struct address_space *mapping,
+			     loff_t pos, unsigned int len,
+			     struct folio **foliop, void **fsdata)
+{
+	struct folio *folio;
+
+	folio = __filemap_get_folio(mapping, pos / PAGE_SIZE, FGP_WRITEBEGIN,
+				    mapping_gfp_mask(mapping));
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+
+	if (!folio_test_uptodate(folio) && (len != folio_size(folio))) {
+		if (folio->mapping->host->i_size <= folio_pos(folio)) {
+			folio_zero_segment(folio, 0, folio_size(folio));
+			folio_mark_uptodate(folio);
+		} else {
+			int err = fusex_do_read_folio(iocb->ki_filp, folio);
+			if (err) {
+				folio_unlock(folio);
+				folio_put(folio);
+				return err;
+			}
+		}
+	}
+	*foliop = folio;
+
+	return 0;
+}
+
+static int fusex_write_end(const struct kiocb *iocb, struct address_space *mapping,
+			    loff_t pos, unsigned int len, unsigned int copied,
+			    struct folio *folio, void *fsdata)
+{
+	struct inode *inode = folio->mapping->host;
+	loff_t old_size = inode->i_size;
+	loff_t end_pos = pos + copied;
+	int err = 0;
+
+	if (!folio_test_uptodate(folio)) {
+		if (copied < len) {
+			size_t off = offset_in_folio(folio, end_pos);
+
+			err = fusex_send_read(inode, end_pos, iocb->ki_filp, folio,
+					      off, len - copied);
+			if (err)
+				goto out;
+		}
+		folio_mark_uptodate(folio);
+	}
+	if (end_pos > old_size)
+		i_size_write(inode, end_pos);
+out:
+	folio_mark_dirty(folio);
+	folio_unlock(folio);
+	folio_put(folio);
+
+	if (!err)
+		fusex_extend_file(inode, old_size, pos);
+
+	return err ? err : copied;
+}
+
+static ssize_t fusex_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	loff_t old_size = i_size_read(inode);
+	loff_t pos = iocb->ki_pos;
+	int err = 0;
+
+	if (!iov_iter_count(iter) || (iov_iter_rw(iter) == READ && pos >= old_size))
+		return 0;
+
+	for (;;) {
+		struct page **pages = NULL;
+		struct folio *folio;
+		ssize_t len;
+		size_t off;
+
+		len = iov_iter_extract_pages(iter, &pages, PAGE_SIZE, 1, 0, &off);
+		if (len <= 0) {
+			err = len;
+			break;
+		}
+
+		folio = page_folio(pages[0]);
+		off += folio_page_idx(folio, pages[0]) * PAGE_SIZE;
+		kvfree(pages);
+
+		if (iov_iter_rw(iter) == WRITE) {
+			err = fusex_send_write(inode, pos, folio, off, len);
+		} else {
+			if (pos + len > old_size)
+				len = old_size - pos;
+
+			err = fusex_send_read(inode, pos, iocb->ki_filp, folio, off, len);
+			if (!err && user_backed_iter(iter))
+				folio_mark_dirty_lock(folio);
+		}
+		if (iov_iter_extract_will_pin(iter))
+			unpin_folio(folio);
+
+		if (err || !len)
+			break;
+		pos += len;
+	}
+	if (pos > iocb->ki_pos) {
+		if (iov_iter_rw(iter) == WRITE) {
+			if (pos > old_size)
+				i_size_write(inode, pos);
+			fusex_extend_file(inode, old_size, iocb->ki_pos);
+		}
+	}
+
+	return (pos - iocb->ki_pos) ?: err;
+}
+
+static const struct address_space_operations fusex_file_aops  = {
+	.read_folio	= fusex_read_folio,
+	.writepages	= fusex_writepages,
+	.write_begin	= fusex_write_begin,
+	.write_end	= fusex_write_end,
+	.direct_IO	= fusex_direct_IO,
+	.dirty_folio	= filemap_dirty_folio,
+	.migrate_folio	= filemap_migrate_folio,
+};
+
+static void fusex_dir_modified(struct inode *dir)
+{
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
+	inode_inc_iversion(dir);
+	__mark_inode_dirty(dir, I_DIRTY_SYNC);
+}
+
+static void fusex_update_ctime(struct inode *inode)
+{
+	inode_set_ctime_current(inode);
+	__mark_inode_dirty(inode, I_DIRTY_SYNC);
+}
+
+static struct inode *fusex_do_lookup(struct inode *base, const struct qstr *name)
+{
+	FUSE_ARGS(args);
+	struct fuse_entryx_out outarg;
+	struct fusex_id id;
+	int err;
+
+	args.opcode = FUSE_LOOKUPX;
+	ADD_IN_ARG_ZERO(args);
+	ADD_IN_ARG(args, name->len + 1, name->name);
+	ADD_OUT_ARG_S(args, &outarg);
+
+	err = fusex_inode_request(base, &args);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	if (outarg.flags & FUSE_ENTRYX_NEGATIVE) {
+		if (err > 0)
+			return ERR_PTR(-EIO);
+		return NULL;
+	}
+
+	err = fusex_id_from_args(&args, &id);
+	if (err)
+		return ERR_PTR(err);
+
+	return fusex_get_inode(base->i_sb, &id);
+}
+
+
+static struct dentry *fusex_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
+{
+	struct inode *inode = fusex_do_lookup(dir, &dentry->d_name);
+
+	return d_splice_alias(inode, dentry);
+}
+
+static int fusex_getattr(struct mnt_idmap *idmap, const struct path *path, struct kstat *stat,
+			 u32 request_mask, unsigned int flags)
+{
+	struct inode *inode = d_inode(path->dentry);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	generic_fillattr(idmap, request_mask, inode, stat);
+	stat->ino = fi->orig_ino;
+	stat->blksize = 1 << fi->cached_i_blkbits;
+	if (test_bit(FUSE_I_BTIME, &fi->state)) {
+		stat->btime = fi->i_btime;
+		stat->result_mask |= STATX_BTIME;
+	}
+
+	return 0;
+}
+
+static void *fusex_send_lgxattr(struct inode *inode, const char *name, size_t *sizep)
+{
+	FUSE_ARGS(args);
+	struct fuse_getxattr_in inarg;
+	ssize_t res;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.size = name ? XATTR_SIZE_MAX : XATTR_LIST_MAX;
+
+	args.opcode = name ? FUSE_GETXATTR : FUSE_LISTXATTR;
+	ADD_IN_ARG_S(args, &inarg);
+	if (name)
+		ADD_IN_ARG(args, strlen(name) + 1, name);
+	ADD_OUT_ARG(args, inarg.size, NULL);
+	args.out_argvar = true;
+	args.out_var_alloc = true;
+
+	res = fusex_inode_request(inode, &args);
+	if (res < 0) {
+		kfree(args.out_args[0].value);
+		if (res == -ENOSYS)
+			res = -EOPNOTSUPP;
+		return ERR_PTR(res);
+	}
+
+	*sizep = res;
+
+	return args.out_args[0].value;
+}
+
+static bool fusex_verify_xattr_list(char *list, size_t size)
+{
+	while (size) {
+		size_t thislen = strnlen(list, size);
+
+		if (!thislen || thislen == size)
+			return false;
+
+		size -= thislen + 1;
+		list += thislen + 1;
+	}
+	return true;
+}
+
+static char *fusex_send_listxattr(struct inode *inode, size_t *gotsize)
+{
+	char *list = fusex_send_lgxattr(inode, NULL, gotsize);
+
+	if (IS_ERR(list))
+		return list;
+
+	if (!fusex_verify_xattr_list(list, *gotsize)) {
+		kfree(list);
+		return ERR_PTR(-EIO);
+	}
+
+	return list;
+}
+
+static ssize_t fusex_listxattr(struct dentry *dentry, char *list, size_t size)
+{
+	struct inode *inode = d_inode(dentry);
+	ssize_t res;
+	char *gotlist __free(kfree) = fusex_send_listxattr(inode, &res);
+
+	if (IS_ERR(gotlist))
+		return PTR_ERR(gotlist);
+
+	if (size) {
+		if (size < res)
+			res = -ERANGE;
+		else
+			memcpy(list, gotlist, res);
+	}
+
+	return res;
+}
+
+static struct posix_acl *fusex_get_acl(struct inode *inode, int type, bool rcu)
+{
+	struct user_namespace *user_ns = i_user_ns(inode);
+	const char *name = posix_acl_xattr_name(type);
+	size_t size;
+	void *value __free(kfree) = fusex_send_lgxattr(inode, name, &size);
+	struct posix_acl *acl = NULL;
+
+	WARN_ON(rcu);
+
+	if (IS_ERR(value)) {
+		switch (PTR_ERR(value)) {
+		case -ENODATA:
+		case -EOPNOTSUPP:
+			value = NULL;
+			break;
+		default:
+			return ERR_CAST(value);
+		}
+	}
+	if (value)
+		acl = posix_acl_from_xattr(user_ns, value, size);
+
+	if (!IS_ERR(acl))
+		set_cached_acl(inode, type, acl);
+
+	return acl;
+}
+
+static void fusex_fill_setxattr(struct fuse_args *args, struct fuse_setxattr_in *inarg,
+				const char *name, const void *value, size_t size, int flags)
+{
+	if (value) {
+		memset(inarg, 0, sizeof(*inarg));
+		inarg->size = size;
+		inarg->flags = flags;
+
+		args->opcode = FUSE_SETXATTR;
+		ADD_IN_ARG_S(*args, inarg);
+		ADD_IN_ARG(*args, strlen(name) + 1, name);
+		ADD_IN_ARG(*args, size, value);
+	} else {
+		args->opcode = FUSE_REMOVEXATTR;
+		ADD_IN_ARG_ZERO(*args);
+		ADD_IN_ARG(*args, strlen(name) + 1, name);
+	}
+}
+
+
+static int fusex_send_setxattr(struct inode *inode, const char *name, const void *value,
+			       size_t size, int flags)
+{
+	FUSE_ARGS(args);
+	struct fuse_setxattr_in inarg;
+	int err;
+
+	fusex_fill_setxattr(&args, &inarg, name, value, size, flags);
+	err = fusex_inode_request(inode, &args);
+	if (err) {
+		if (err == -ENOSYS)
+			err = -EOPNOTSUPP;
+		return err;
+	}
+
+	fusex_update_ctime(inode);
+
+	return 0;
+}
+
+static int fusex_send_setacl(struct inode *inode, int type, struct posix_acl *acl)
+{
+	struct user_namespace *user_ns = i_user_ns(inode);
+	const char *name = posix_acl_xattr_name(type);
+	size_t size;
+
+	if (!acl)
+		return fusex_send_setxattr(inode, name, NULL, 0, 0);
+
+	void *value __free(kfree) = posix_acl_to_xattr(user_ns, acl, &size, GFP_KERNEL);
+	if (!value)
+		return -ENOMEM;
+
+	return fusex_send_setxattr(inode, name, value, size, 0);
+}
+
+static int fusex_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
+			 struct posix_acl *acl, int type)
+{
+	struct inode *inode = d_inode(dentry);
+	umode_t mode = inode->i_mode;
+	bool update_mode;
+	int err;
+
+	if (type == ACL_TYPE_ACCESS && acl) {
+		err = posix_acl_update_mode(idmap, inode, &mode, &acl);
+		if (err)
+			return err;
+		update_mode = true;
+	}
+
+	err = fusex_send_setacl(inode, type, acl);
+	if (err)
+		return err;
+
+	set_cached_acl(inode, type, acl);
+	inode_set_ctime_current(inode);
+	if (update_mode) {
+		struct fuse_setstatx_in inarg;
+
+		inode->i_mode = mode;
+		memset(&inarg, 0, sizeof(inarg));
+		inarg.stat.mask |= STATX_MODE;
+		inarg.stat.mode = inode->i_mode & 07777;
+		fusex_get_ctime(inode, &inarg.stat);
+
+		err = fusex_send_setstatx(inode, &inarg);
+	} else {
+		__mark_inode_dirty(inode, I_DIRTY_SYNC);
+	}
+
+	return err;
+}
+
+static int fusex_send_mkobjx(struct inode *dir, struct inode *inode,
+			     const struct qstr *name, const char *link_body, struct fusex_id *id)
+{
+	FUSE_ARGS(args);
+	struct fuse_mkobjx_in inarg;
+	struct fuse_entryx_out outarg;
+	struct user_namespace *u = i_user_ns(inode);
+	int flags = 0;
+	int err;
+
+	if (!name->len) {
+		WARN_ON((inode->i_mode & S_IFMT) != S_IFREG);
+		flags |= FUSE_MKOBJX_TMPFILE;
+	}
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.namesize = name->len + 1;
+	inarg.stat.mask = STATX_UID | STATX_GID | STATX_MODE | STATX_TYPE | STATX_BTIME;
+	inarg.stat.uid = from_kuid(u, inode->i_uid);
+	inarg.stat.gid = from_kgid(u, inode->i_gid);
+	inarg.stat.rdev_major = MAJOR(inode->i_rdev);
+	inarg.stat.rdev_minor = MINOR(inode->i_rdev);
+	inarg.stat.mode = inode->i_mode;
+	fusex_get_atime(inode, &inarg.stat);
+	fusex_get_mtime(inode, &inarg.stat);
+	fusex_get_ctime(inode, &inarg.stat);
+	inarg.stat.btime = inarg.stat.ctime;
+	inarg.flags = flags;
+
+	args.opcode = FUSE_MKOBJX;
+	ADD_IN_ARG_S(args, &inarg);
+	ADD_IN_ARG(args, inarg.namesize, name->name);
+	if (S_ISLNK(inode->i_mode))
+		ADD_IN_ARG(args, strlen(link_body) + 1, link_body);
+	ADD_OUT_ARG_S(args, &outarg);
+
+	err = fusex_inode_request(dir, &args);
+	if (err)
+		return err;
+
+	return fusex_id_from_args(&args, id);
+}
+
+static int fusex_set_initial_acl(struct inode *inode, const struct fusex_id *id, int type)
+{
+	struct posix_acl *acl = (type == ACL_TYPE_ACCESS) ? inode->i_acl : inode->i_default_acl;
+	if (!acl)
+		return 0;
+
+	FUSE_ARGS(args);
+	struct fuse_setxattr_in inarg;
+	size_t size;
+	const char *name = posix_acl_xattr_name(type);
+	const void *value __free(kfree) =
+		posix_acl_to_xattr(i_user_ns(inode), acl, &size, GFP_KERNEL);
+	if (!value)
+		return -ENOMEM;
+
+	fusex_fill_setxattr(&args, &inarg, name, value, size, 0);
+
+	return fusex_id_request(inode, id, &args);
+}
+
+static int fusex_do_mkobjx(struct inode *dir, struct inode *inode, const struct qstr *name,
+			     const char *link_body, struct fuse_statx_out *outarg_sx)
+{
+	FUSE_ARGS(args_sx);
+	struct fuse_statx_in inarg_sx;
+	struct inode *old;
+	struct fusex_id id;
+	int err;
+
+	err = fusex_send_mkobjx(dir, inode, name, link_body, &id);
+	if (err)
+		return err;
+
+	err = fusex_set_initial_acl(inode, &id, ACL_TYPE_ACCESS);
+	if (err)
+		return err;
+
+	err = fusex_set_initial_acl(inode, &id, ACL_TYPE_DEFAULT);
+	if (err)
+		return err;
+
+	fusex_fill_statx(&args_sx, &inarg_sx, outarg_sx);
+	err = fusex_id_request(inode, &id, &args_sx);
+	if (err)
+		return err;
+
+	old = inode_insert5(inode, fusex_hash_id(&id), fusex_inode_eq, fusex_inode_set, &id);
+	if (old != inode) {
+		iput(old);
+		return -EBUSY;
+	}
+	return 0;
+}
+
+static int fusex_setup_new_inode(struct inode *inode, struct fuse_statx *statx)
+{
+	struct fuse_inode *fi;
+
+	if (inode->i_mode != statx->mode)
+		return -EIO;
+	if (!uid_eq(inode->i_uid, make_kuid(i_user_ns(inode), statx->uid)))
+		return -EIO;
+	if (!gid_eq(inode->i_gid, make_kgid(i_user_ns(inode), statx->gid)))
+		return -EIO;
+	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
+		if (MKDEV(statx->rdev_major, statx->rdev_minor) != inode->i_rdev)
+			return -EIO;
+	}
+
+	fi = get_fuse_inode(inode);
+	inode->i_size = statx->size;
+	inode->i_blocks = statx->blocks;
+	inode->i_ino = fi->orig_ino = statx->ino;
+	fi->cached_i_blkbits = ilog2(statx->blksize);
+	fusex_set_times(inode, statx);
+
+	return 0;
+}
+
+static struct inode *fusex_new_inode(struct mnt_idmap *idmap, struct inode *dir,
+				     const struct qstr *name, umode_t mode, dev_t rdev,
+				     const char *link_body)
+{
+	struct inode *inode;
+	struct fuse_statx_out statx;
+	int err;
+
+	inode = new_inode(dir->i_sb);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	inode_init_owner(idmap, inode, dir, mode);
+	if (S_ISCHR(mode) || S_ISBLK(mode))
+		inode->i_rdev = rdev;
+
+	simple_inode_init_ts(inode);
+	fusex_init_inode(inode);
+	inode->i_size = 0;
+
+	err = posix_acl_create(dir, &inode->i_mode, &inode->i_default_acl, &inode->i_acl);
+	if (err)
+		goto iput_noforget;
+
+	err = fusex_do_mkobjx(dir, inode, name, link_body, &statx);
+	if (err)
+		goto iput_noforget;
+
+	err = fusex_setup_new_inode(inode, &statx.stat);
+	if (err) {
+		discard_new_inode(inode);
+		return ERR_PTR(err);
+	}
+
+	return inode;
+
+iput_noforget:
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	kfree(fi->forget);
+	fi->forget = NULL;
+	iput(inode);
+	return ERR_PTR(err);
+}
+
+static int fusex_mkobj(struct mnt_idmap *idmap, struct inode *dir,
+		       struct dentry *dentry, umode_t mode, dev_t rdev, const char *link_body)
+{
+	struct inode *inode = fusex_new_inode(idmap, dir, &dentry->d_name, mode, rdev, link_body);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	fusex_dir_modified(dir);
+	d_instantiate_new(dentry, inode);
+
+	return 0;
+}
+
+static int fusex_create(struct mnt_idmap *idmap, struct inode *dir,
+		       struct dentry *dentry, umode_t mode, bool excl)
+{
+	return fusex_mkobj(idmap, dir, dentry, mode, 0, NULL);
+}
+
+static int fusex_mknod(struct mnt_idmap *idmap, struct inode *dir,
+		       struct dentry *dentry, umode_t mode, dev_t rdev)
+{
+	return fusex_mkobj(idmap, dir, dentry, mode, rdev, NULL);
+}
+
+static struct dentry *fusex_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+		       struct dentry *dentry, umode_t mode)
+{
+	int err = fusex_mkobj(idmap, dir, dentry, S_IFDIR | mode, 0, NULL);
+
+	return ERR_PTR(err);
+}
+
+static int fusex_symlink(struct mnt_idmap *idmap, struct inode *dir,
+			 struct dentry *dentry, const char *link_body)
+{
+	return fusex_mkobj(idmap, dir, dentry, S_IFLNK | 0777, 0, link_body);
+}
+
+static int fusex_tmpfile(struct mnt_idmap *idmap, struct inode *dir, struct file *file,
+			 umode_t mode)
+{
+	struct inode *inode = fusex_new_inode(idmap, dir, &empty_name, mode, 0, NULL);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	d_tmpfile(file, inode);
+	unlock_new_inode(inode);
+	return finish_open_simple(file, 0);
+}
+
+static int fusex_remove(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+	FUSE_ARGS(args);
+	int err;
+
+	rwsem_assert_held_write(&inode->i_rwsem);
+
+	args.opcode = d_is_dir(dentry) ? FUSE_RMDIR : FUSE_UNLINK;
+	ADD_IN_ARG_ZERO(args);
+	ADD_IN_ARG(args, dentry->d_name.len + 1, dentry->d_name.name);
+
+	err = fusex_inode_request(dir, &args);
+	if (err)
+		return err;
+
+	drop_nlink(inode);
+	fusex_update_ctime(inode);
+	fusex_dir_modified(dir);
+
+	return 0;
+}
+
+static int fusex_setattr(struct mnt_idmap *idmap, struct dentry *dentry, struct iattr *iattr)
+{
+	struct inode *inode = d_inode(dentry);
+	struct user_namespace *user_ns = i_user_ns(inode);
+	struct fuse_setstatx_in inarg;
+	int err;
+
+	err = setattr_prepare(idmap, dentry, iattr);
+	if (err)
+		return err;
+
+	if ((iattr->ia_valid & ATTR_SIZE) && iattr->ia_size != inode->i_size)
+		iattr->ia_valid |= ATTR_MTIME | ATTR_CTIME;
+
+	memset(&inarg, 0, sizeof(inarg));
+	if (iattr->ia_valid & ATTR_SIZE) {
+		inarg.stat.mask |= STATX_SIZE;
+		inarg.stat.size = iattr->ia_size;
+	}
+	if (iattr->ia_valid & ATTR_UID) {
+		inarg.stat.mask |= STATX_UID;
+		inarg.stat.uid = from_kuid(user_ns, from_vfsuid(idmap, user_ns, iattr->ia_vfsuid));
+	}
+	if (iattr->ia_valid & ATTR_GID) {
+		inarg.stat.mask |= STATX_GID;
+		inarg.stat.gid = from_kgid(user_ns, from_vfsgid(idmap, user_ns, iattr->ia_vfsgid));
+	}
+	if (iattr->ia_valid & ATTR_MODE) {
+		inarg.stat.mask |= STATX_MODE;
+		err = posix_acl_chmod(idmap, dentry, iattr->ia_mode);
+		if (err)
+			return err;
+
+		inarg.stat.mode = iattr->ia_mode & 07777;
+	}
+	if (iattr->ia_valid & ATTR_ATIME) {
+		inarg.stat.mask |= STATX_ATIME;
+		inarg.stat.atime.tv_sec = iattr->ia_atime.tv_sec;
+		inarg.stat.atime.tv_nsec = iattr->ia_atime.tv_nsec;
+	}
+	if (iattr->ia_valid & ATTR_CTIME) {
+		inarg.stat.mask |= STATX_CTIME;
+		inarg.stat.ctime.tv_sec = iattr->ia_ctime.tv_sec;
+		inarg.stat.ctime.tv_nsec = iattr->ia_ctime.tv_nsec;
+	}
+	if (iattr->ia_valid & ATTR_MTIME) {
+		inarg.stat.mask |= STATX_MTIME;
+		inarg.stat.mtime.tv_sec = iattr->ia_mtime.tv_sec;
+		inarg.stat.mtime.tv_nsec = iattr->ia_mtime.tv_nsec;
+	}
+	err = fusex_send_setstatx(inode, &inarg);
+	if (err)
+		return err;
+
+	setattr_copy(idmap, inode, iattr);
+	if (iattr->ia_valid & ATTR_SIZE) {
+		loff_t old_size = inode->i_size;
+
+		i_size_write(inode, iattr->ia_size);
+		fusex_extend_file(inode, old_size, inode->i_size);
+		truncate_pagecache(inode, inode->i_size);
+	}
+
+	return 0;
+}
+
+static int fusex_rename(struct mnt_idmap *idmap, struct inode *olddir,
+			struct dentry *olddentry, struct inode *newdir,
+			struct dentry *newdentry, unsigned int flags)
+{
+	struct inode *oldinode = d_inode(olddentry);
+	struct inode *newinode = d_inode(newdentry);
+	struct fuse_rename2_in inarg;
+	FUSE_ARGS(args);
+	int err;
+
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+		return -EINVAL;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.newdir = get_node_id(newdir);
+	inarg.flags = flags;
+
+	args.opcode = FUSE_RENAME2;
+	ADD_IN_ARG_S(args, &inarg);
+	ADD_IN_ARG(args, olddentry->d_name.len + 1, olddentry->d_name.name);
+	ADD_IN_ARG(args, newdentry->d_name.len + 1, newdentry->d_name.name);
+
+	err = fusex_inode2_request(olddir, newdir, &args);
+	if (err)
+		return err;
+
+	fusex_update_ctime(oldinode);
+	if (newinode) {
+		if (!(flags & RENAME_EXCHANGE))
+			drop_nlink(newinode);
+		fusex_update_ctime(newinode);
+	}
+
+	fusex_dir_modified(olddir);
+	fusex_dir_modified(newdir);
+
+	return 0;
+}
+
+static int fusex_link(struct dentry *dentry, struct inode *newdir, struct dentry *newdentry)
+{
+	struct fuse_link_in inarg;
+	struct inode *inode = d_inode(dentry);
+	FUSE_ARGS(args);
+	int err;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.oldnodeid = get_node_id(inode);
+
+	args.opcode = FUSE_LINK;
+	ADD_IN_ARG_S(args, &inarg);
+	ADD_IN_ARG(args, newdentry->d_name.len + 1, newdentry->d_name.name);
+
+	err = fusex_inode2_request(newdir, inode, &args);
+	if (err)
+		return err;
+
+	ihold(inode);
+	inc_nlink(inode);
+	fusex_update_ctime(inode);
+	fusex_dir_modified(newdir);
+	d_instantiate(newdentry, inode);
+
+	return 0;
+}
+
+static const struct inode_operations fusex_file_inode_operations = {
+	.getattr	= fusex_getattr,
+	.setattr	= fusex_setattr,
+	.get_inode_acl	= fusex_get_acl,
+	.set_acl	= fusex_set_acl,
+	.listxattr	= fusex_listxattr,
+};
+
+static const struct inode_operations fusex_dir_inode_operations = {
+	.getattr	= fusex_getattr,
+	.setattr	= fusex_setattr,
+	.get_inode_acl	= fusex_get_acl,
+	.set_acl	= fusex_set_acl,
+	.listxattr	= fusex_listxattr,
+
+	.lookup		= fusex_lookup,
+	.create		= fusex_create,
+	.tmpfile	= fusex_tmpfile,
+	.mkdir		= fusex_mkdir,
+	.mknod		= fusex_mknod,
+	.symlink	= fusex_symlink,
+	.unlink		= fusex_remove,
+	.rmdir		= fusex_remove,
+	.rename		= fusex_rename,
+	.link		= fusex_link,
+};
+
+static const struct inode_operations fusex_symlink_inode_operations = {
+	.getattr	= fusex_getattr,
+	.get_link	= page_get_link,
+	.listxattr	= fusex_listxattr,
+};
+
+static struct fuse_file *fusex_file_alloc(void)
+{
+	struct fuse_file *ff;
+
+	ff = kzalloc(sizeof(*ff) + sizeof(*ff->args), GFP_KERNEL_ACCOUNT);
+	if (ff)
+		ff->args = (void *)(ff + 1);
+
+	return ff;
+}
+
+static int fusex_send_opendir(struct fuse_file *ff, struct inode *inode)
+{
+	struct fuse_open_in inarg;
+	struct fuse_open_out outarg;
+	FUSE_ARGS(args);
+	int err;
+
+	memset(&inarg, 0, sizeof(inarg));
+
+	args.opcode = FUSE_OPENDIR;
+	ADD_IN_ARG_S(args, &inarg);
+	ADD_OUT_ARG_S(args, &outarg);
+
+	err = fusex_inode_request(inode, &args);
+	if (!err) {
+		ff->fh = outarg.fh;
+		ff->open_flags = FOPEN_CACHE_DIR;
+	}
+	return err;
+}
+
+static int fusex_dir_open(struct inode *inode, struct file *file)
+{
+	struct fuse_file *ff __free(kfree) = fusex_file_alloc();
+	struct fuse_release_args *ra;
+	int err;
+
+	if (!ff)
+		return -ENOMEM;
+
+	ra = &ff->args->release_args;
+	ADD_IN_ARG_S(ra->args, &ra->inarg);
+
+	err = fusex_send_opendir(ff, inode);
+	if (err)
+		return err;
+
+	file->private_data = no_free_ptr(ff);
+	return 0;
+}
+
+static void fusex_release_end(struct fuse_args *args, int error)
+{
+	struct fuse_release_args *ra = container_of(args, typeof(*ra), args);
+	struct fuse_file *ff = (struct fuse_file *) ra - 1;
+
+	iput(ra->inode);
+	kfree(ff);
+}
+
+static int fusex_dir_release(struct inode *inode, struct file *file)
+{
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_file *ff = file->private_data;
+	struct fuse_release_args *ra = &ff->args->release_args;
+
+	ra->inarg.fh = ff->fh;
+
+	ra->args.opcode = FUSE_RELEASEDIR;
+	ra->args.force = true;
+	ra->args.nocreds = true;
+	ra->args.end = fusex_release_end;
+	ra->inode = igrab(inode);
+
+	if (fuse_simple_background(fm, &ra->args, GFP_KERNEL | __GFP_NOFAIL))
+		fusex_release_end(&ra->args, -ENOTCONN);
+
+	return 0;
+}
+
+static const struct file_operations fusex_dir_operations = {
+	.llseek		= generic_file_llseek,
+	.read		= generic_read_dir,
+	.iterate_shared	= fuse_readdir,
+	.open		= fusex_dir_open,
+	.release	= fusex_dir_release,
+	.fsync		= simple_fsync_noflush,
+};
+
+static int fusex_symlink_read_folio(struct file *null, struct folio *folio)
+{
+	struct inode *inode = folio->mapping->host;
+	struct fuse_folio_desc desc = { .length = folio_size(folio) - 1 };
+	struct fuse_args_pages ap = {};
+	ssize_t res;
+
+	ap.args.opcode = FUSE_READLINK;
+	ADD_IN_ARG_ZERO(ap.args);
+	ADD_OUT_ARG(ap.args, desc.length, NULL);
+	ap.args.out_pages = true;
+	ap.args.out_argvar = true;
+	ap.args.page_zeroing = true;
+	ap.num_folios = 1;
+	ap.folios = &folio;
+	ap.descs = &desc;
+	res = fusex_inode_request(inode, &ap.args);
+	if (res >= 0) {
+		folio_mark_uptodate(folio);
+		res = 0;
+	}
+	folio_unlock(folio);
+	return res;
+}
+
+static const struct address_space_operations fusex_symlink_aops = {
+	.read_folio	= fusex_symlink_read_folio,
+};
+
+static void fusex_init_inode(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFREG:
+		inode->i_op = &fusex_file_inode_operations;
+		inode->i_fop = &fusex_file_operations;
+		inode->i_data.a_ops = &fusex_file_aops;
+		mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
+		break;
+
+	case S_IFDIR:
+		spin_lock_init(&fi->rdc.lock);
+		inode->i_op = &fusex_dir_inode_operations;
+		inode->i_fop = &fusex_dir_operations;
+		break;
+
+	case S_IFLNK:
+		inode->i_op = &fusex_symlink_inode_operations;
+		inode->i_data.a_ops = &fusex_symlink_aops;
+		inode_nohighmem(inode);
+		break;
+
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
+		inode->i_op = &fusex_file_inode_operations;
+		init_special_inode(inode, inode->i_mode, inode->i_rdev);
+		break;
+
+	default:
+		WARN_ON(1);
+	}
+}
+
+static int fusex_xattr_get(const struct xattr_handler *handler, struct dentry *dentry,
+			   struct inode *inode, const char *name, void *buffer, size_t size)
+{
+	size_t attr_size;
+	void *value __free(kfree) =
+		fusex_send_lgxattr(inode, name - strlen(handler->prefix), &attr_size);
+
+	if (IS_ERR(value))
+		return PTR_ERR(value);
+
+	if (!size)
+		return attr_size;
+
+	if (size < attr_size)
+		return -ERANGE;
+
+	memcpy(buffer, value, attr_size);
+	return attr_size;
+
+}
+
+static int fusex_xattr_set(const struct xattr_handler *handler, struct mnt_idmap *idmap,
+			   struct dentry *dentry, struct inode *inode,
+			   const char *name, const void *value, size_t size, int flags)
+{
+	return fusex_send_setxattr(inode, name - strlen(handler->prefix), value, size, flags);
+}
+
+const struct xattr_handler fusex_xattr_user_handler = {
+	.prefix	= XATTR_USER_PREFIX,
+	.get	= fusex_xattr_get,
+	.set	= fusex_xattr_set,
+};
+
+const struct xattr_handler fusex_xattr_handler = {
+	.prefix	= "",
+	.get	= fusex_xattr_get,
+	.set	= fusex_xattr_set,
+};
+
+const struct xattr_handler *const fusex_xattr_handlers[] = {
+	&fusex_xattr_user_handler,
+	&fusex_xattr_handler,
+	NULL,
+};
+
+static int fusex_send_init(struct fuse_mount *fm, struct fusex_id *id,
+			   struct fuse_statx_out *statx)
+{
+	FUSE_ARGS(args_in);
+	FUSE_ARGS(args_lr);
+	FUSE_ARGS(args_sx);
+	struct fuse_init_in inarg_in;
+	struct fuse_init_out outarg_in;
+	struct fuse_entryx_out outarg_lr;
+	struct fuse_statx_in inarg_sx;
+	u64 flags = FUSE_INIT_EXT;
+	int err;
+
+	if (fuse_uring_enabled())
+		flags |= FUSE_OVER_IO_URING;
+
+	memset(&inarg_in, 0, sizeof(inarg_in));
+	inarg_in.major = FUSE_KERNEL_VERSION;
+	inarg_in.minor = FUSE_KERNEL_MINOR_VERSION;
+	inarg_in.flags = flags;
+	inarg_in.flags2 = flags >> 32;
+	args_in.opcode = FUSE_INIT;
+	ADD_IN_ARG_S(args_in, &inarg_in);
+	ADD_OUT_ARG_S(args_in, &outarg_in);
+	err = fuse_simple_request(fm, &args_in);
+	if (err)
+		return err;
+
+	flags = outarg_in.flags;
+	if (!(flags & FUSE_INIT_EXT))
+		return -EINVAL;
+
+	flags |= (u64) outarg_in.flags2 << 32;
+
+	fm->fc->minor = outarg_in.minor;
+	fm->fc->max_write = outarg_in.max_write;
+	fm->fc->max_pages = min_t(unsigned int, fm->fc->max_pages_limit,
+				  max_t(unsigned int, outarg_in.max_pages, 1));
+
+	args_lr.opcode = FUSE_LOOKUP_ROOT;
+	ADD_OUT_ARG_S(args_lr, &outarg_lr);
+	err = fuse_simple_request(fm, &args_lr);
+	if (err)
+		return err;
+
+	err = fusex_id_from_args(&args_lr, id);
+	if (err)
+		return err;
+
+	fusex_fill_statx(&args_sx, &inarg_sx, statx);
+	args_sx.nodeid = id->nodeid;
+	err = fuse_simple_request(fm, &args_sx);
+	if (err)
+		return err;
+
+	if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
+		fuse_chan_io_uring_enable(fm->fc->chan);
+
+	return 0;
+}
+
+static int fusex_fill_super(struct super_block *sb, struct fs_context *fsc)
+{
+	struct fuse_mount *fm = get_fuse_mount_super(sb);
+	struct fuse_conn *fc = fm->fc;
+	struct inode *inode;
+	struct fusex_id id;
+	struct fuse_statx_out statx;
+	struct fuse_chan_param cp;
+	int err;
+
+	/* Dropped in fuse_mount_destroy() */
+	fuse_conn_get(fc);
+	fm->sb = sb;
+	fc->dev = sb->s_dev;
+
+	scoped_guard(mutex, &fuse_mutex) {
+		list_add_tail(&fc->entry, &fuse_conn_list);
+		err = fuse_ctl_add_conn(fc);
+		if (err)
+			return err;
+	}
+
+	err = super_setup_bdi(sb);
+	if (err)
+		return err;
+
+	sb->s_magic = FUSE_SUPER_MAGIC;
+	sb->s_op = &fusex_super_operations;
+	sb->s_xattr = fusex_xattr_handlers;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_time_gran = 1;
+	sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
+	if (sb->s_user_ns != &init_user_ns)
+		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
+	sb->s_blocksize = PAGE_SIZE;
+	sb->s_blocksize_bits = PAGE_SHIFT;
+	sb->s_flags &= SB_RDONLY;
+	sb->s_flags |= SB_POSIXACL;
+
+	err = fusex_send_init(fm, &id, &statx);
+	if (err)
+		return err;
+
+	inode = fusex_iget(sb, &id);
+	if (inode) {
+		WARN_ON(!(inode_state_read_once(inode) & I_NEW));
+		fusex_set_attr(inode, &statx.stat);
+		fusex_init_inode(inode);
+		unlock_new_inode(inode);
+	}
+	sb->s_root = d_make_root(inode);
+	if (!sb->s_root)
+		return -ENOMEM;
+
+	fc->parallel_dirops = true;
+	fc->destroy = true;
+
+	cp.minor = fc->minor;
+	cp.max_write = fc->max_write;
+	cp.max_pages = fc->max_pages;
+	fuse_chan_set_initialized(fc->chan, &cp);
+
+	return 0;
+}
+
+static int fusex_get_tree(struct fs_context *fsc)
+{
+	struct fuse_dev *fud = fsc->fs_private;
+	struct fuse_conn *fc __free(kfree) = kmalloc_obj(*fc);
+	struct fuse_mount *fm __free(kfree) = kzalloc_obj(*fm);
+	struct fuse_chan *fch __free(fuse_chan_free) = fuse_dev_chan_new();
+
+	if (!fch || !fc || !fm)
+		return -ENOMEM;
+
+	fc->release = fuse_free_conn;
+	fsc->s_fs_info = fm;
+	fuse_conn_init(no_free_ptr(fc), no_free_ptr(fm), fsc->user_ns, fch);
+	fuse_chan_set_initialized(fch, NULL);
+	fuse_dev_install(fud, no_free_ptr(fch));
+
+	return get_tree_nodev(fsc, fusex_fill_super);
+}
+
+enum {
+	FUSEX_OPT_FD,
+};
+
+static const struct fs_parameter_spec fusex_fs_parameters[] = {
+	fsparam_fd("fd", FUSEX_OPT_FD),
+	{}
+};
+
+static int fusex_parse_param(struct fs_context *fsc, struct fs_parameter *param)
+{
+	struct fs_parse_result result;
+	struct fuse_dev *fud;
+	int opt;
+
+	if (fsc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
+		return invalfc(fsc, "No changes allowed in reconfigure");
+
+	opt = fs_parse(fsc, fusex_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case FUSEX_OPT_FD:
+		if (param->type != fs_value_is_file)
+			return invalfc(fsc, "FSCONFIG_SET_FD is required for fd");
+		if (param->file->f_op != &fuse_dev_operations)
+			return invalfc(fsc, "fd is not a fuse device");
+		if (param->file->f_cred->user_ns != fsc->user_ns)
+			return invalfc(fsc, "wrong user namespace for fuse device");
+
+		fud = fuse_dev_grab(param->file);
+		if (!fuse_dev_is_sync_init(fud)) {
+			fuse_dev_put(fud);
+			return invalfc(fsc, "synchronous INIT is mandatory");
+		}
+		fsc->fs_private = fud;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void fusex_free_fsc(struct fs_context *fsc)
+{
+	struct fuse_dev *fud = fsc->fs_private;
+
+	if (fud)
+		fuse_dev_put(fud);
+}
+
+static const struct fs_context_operations fusex_context_ops = {
+	.get_tree	= fusex_get_tree,
+	.parse_param	= fusex_parse_param,
+	.free		= fusex_free_fsc,
+};
+
+static int fusex_init_fs_context(struct fs_context *fsc)
+{
+	fsc->ops = &fusex_context_ops;
+	return 0;
+}
+
+static void fusex_kill_sb_anon(struct super_block *sb)
+{
+	struct fuse_mount *fm = get_fuse_mount_super(sb);
+
+	kill_anon_super(sb);
+	fuse_conn_destroy(fm);
+	fuse_mount_remove(fm);
+	fuse_mount_destroy(fm);
+}
+
+static struct file_system_type fusex_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "fusex",
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
+	.init_fs_context = fusex_init_fs_context,
+	.kill_sb	= fusex_kill_sb_anon,
+};
+
+int __init fusex_init(void)
+{
+	return register_filesystem(&fusex_fs_type);
+}
+
+void __exit fusex_cleanup(void)
+{
+	unregister_filesystem(&fusex_fs_type);
+}
diff --git a/fs/fuse/fusex.h b/fs/fuse/fusex.h
new file mode 100644
index 000000000000..c7b7c6f8b442
--- /dev/null
+++ b/fs/fuse/fusex.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+int fusex_init(void);
+void fusex_cleanup(void);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 0897f8e62b4d..2f129f7c168c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -8,6 +8,7 @@
 
 #include "dev.h"
 #include "fuse_i.h"
+#include "fusex.h"
 
 #include <linux/dax.h>
 #include <linux/pagemap.h>
@@ -31,7 +32,7 @@ MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
 MODULE_DESCRIPTION("Filesystem in Userspace");
 MODULE_LICENSE("GPL");
 
-static struct kmem_cache *fuse_inode_cachep;
+struct kmem_cache *fuse_inode_cachep;
 struct list_head fuse_conn_list;
 DEFINE_MUTEX(fuse_mutex);
 
@@ -605,7 +606,7 @@ void fuse_unlock_inode(struct inode *inode, bool locked)
 		mutex_unlock(&get_fuse_inode(inode)->mutex);
 }
 
-static void fuse_umount_begin(struct super_block *sb)
+void fuse_umount_begin(struct super_block *sb)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
@@ -631,7 +632,7 @@ static void fuse_send_destroy(struct fuse_mount *fm)
 	}
 }
 
-static void convert_fuse_statfs(struct kstatfs *stbuf, struct fuse_kstatfs *attr)
+void fuse_convert_statfs(struct kstatfs *stbuf, struct fuse_kstatfs *attr)
 {
 	stbuf->f_type    = FUSE_SUPER_MAGIC;
 	stbuf->f_bsize   = attr->bsize;
@@ -667,7 +668,7 @@ static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
 	args.out_args[0].value = &outarg;
 	err = fuse_simple_request(fm, &args);
 	if (!err)
-		convert_fuse_statfs(buf, &outarg.st);
+		fuse_convert_statfs(buf, &outarg.st);
 	return err;
 }
 
@@ -2160,6 +2161,10 @@ static int __init fuse_init(void)
 	if (res)
 		goto err_sysfs_cleanup;
 
+	res = fusex_init();
+	if (res)
+		goto err_ctl_cleanup;
+
 	fuse_dentry_tree_init();
 
 	sanitize_global_limit(&max_user_bgreq);
@@ -2167,6 +2172,8 @@ static int __init fuse_init(void)
 
 	return 0;
 
+err_ctl_cleanup:
+	fuse_ctl_cleanup();
  err_sysfs_cleanup:
 	fuse_sysfs_cleanup();
  err_dev_cleanup:
@@ -2182,6 +2189,7 @@ static void __exit fuse_exit(void)
 	pr_debug("exit\n");
 
 	fuse_dentry_tree_cleanup();
+	fusex_cleanup();
 	fuse_ctl_cleanup();
 	fuse_sysfs_cleanup();
 	fuse_fs_cleanup();
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c13e1f9a2f12..f5d90be821ae 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -663,6 +663,10 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
+	FUSE_LOOKUP_ROOT	= 54,
+	FUSE_LOOKUPX		= 55,
+	FUSE_MKOBJX		= 56,
+	FUSE_SETSTATX		= 58,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -700,6 +704,20 @@ struct fuse_entry_out {
 	struct fuse_attr attr;
 };
 
+/*
+ * entryx flags
+ * FUSE_ENTRYX_NEGATIVE: file does not exist, can cache this result
+ */
+#define FUSE_ENTRYX_NEGATIVE	(1 << 0)
+
+struct fuse_entryx_out {
+	uint64_t	nodeid;
+	uint64_t	entry_valid;
+	uint32_t	entry_valid_nsec;
+	uint32_t	flags;
+	uint64_t	spare;
+};
+
 struct fuse_forget_in {
 	uint64_t	nlookup;
 };
@@ -754,6 +772,17 @@ struct fuse_mknod_in {
 	uint32_t	padding;
 };
 
+enum fuse_mkobjx_flags {
+	FUSE_MKOBJX_TMPFILE = 1 << 0,
+};
+
+struct fuse_mkobjx_in {
+	struct fuse_statx stat;
+	uint32_t	namesize;
+	uint32_t	flags;
+	uint64_t	spare[7];
+};
+
 struct fuse_mkdir_in {
 	uint32_t	mode;
 	uint32_t	umask;
@@ -792,6 +821,13 @@ struct fuse_setattr_in {
 	uint32_t	unused5;
 };
 
+struct fuse_setstatx_in {
+	uint64_t	fh;
+	uint32_t	flags;
+	uint32_t	reserved;
+	struct fuse_statx stat;
+};
+
 struct fuse_open_in {
 	uint32_t	flags;
 	uint32_t	open_flags;	/* FUSE_OPEN_... */
-- 
2.53.0

