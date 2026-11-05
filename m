Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891964;
	b=gltdJIndQGcU5t6gtohayLjl3LoVBRUsBQlOOaVKZs2yeKHlJIoHsjtopFjHFpMZkzO5
	 4Ca5Salkqf3VmblBntf0lcUgFZTlv8YRNpm8E+Q1nT9jGSKyJzMAQ/ZiWQZ6Gqgo+/9uA
	 s9w8K+Tp8uS3oOlxcwJFATXefU6r32yP/8JRtjC/ve1UZdhpHdQw+8AamYXqj8k+uYpn+
	 rNpmgGwzI6BhbgQvoI8l2MY7pcKF5lBl8PNCa13e1AfjhhDHo3Gi+76jZ6UD25NOobn4o
	 d3ppTA9uMO/RBEPHctIvVCrBAaYwk7em/DxNz0g27myI1KHLf7MyNB91bEoFUTrxVFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=zocf3hS+rm78Bl4vifeo4W5mElcrmUKwBzY+ChMT1a8=;
	b=oUveKXXl6Qkec0/ZGsYshKXCoWZj/3+AxWkIBIQspUUcviTXb0BFkEpxfNWwxHmN/1PU
	 8fJQ/xdO9buX5jSWlTjN+0FCmpnz3FmYiIyKiSZzMx7PR/iGJ3JnjsUW+GtxtA1kIXqu6
	 gEwjHIWIBX4p9GlovN7rP0Sr32w2YviEXDDoflBWgb6RBlsEtWtOafeO53LOIJMe2uoeF
	 WmVg2KwYYpXsxN0GLYMmeNW0yOsMx2rflXsmgWSi88VNd6Pd4uaCpjtedmZedxNe9q+TZ
	 gQjiNi+0Ip9rj+aEPUXNgCB/n5eH85FtAdCGhpinCChh+pSv8yb9tDzUKBAO2Nl68mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=S4w0p847;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D026606A32F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D026606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=S4w0p847
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91c719669a8so20172196d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891962; x=1794496762; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zocf3hS+rm78Bl4vifeo4W5mElcrmUKwBzY+ChMT1a8=;
        b=S4w0p847D19gm5SSH7mIuKctfl5zGa6gdKRHhQR5kbIlK4cfiq3zy/u7yPG2YGcd5w
         hJZteYOKV2XzQhYnMJY2ZBCx/QmHlzWLs1sjUkDJwhZzw+pyj7N39iSg3uolNnoetq1k
         ueEjdPM0hmZuuTEideYyQwbl7Qve8RqTiMq3wj+TY0p5m+kHbx5JS7gOEKt8EURwd023
         5Rzx3/fvhUayQNSZ3wdcLAWGYe5dCyXW7mI9wY/yYN6x+2fkcMImisJJ1eGpzDWaur6K
         LPtuFkZ8c4iMFuoaEN2FKUBiHYgWy8eKqNc/rpPpXr+0agQ0NJdRrP9B9y4rdUqgQPHP
         zFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891962; x=1794496762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zocf3hS+rm78Bl4vifeo4W5mElcrmUKwBzY+ChMT1a8=;
        b=q/IPCQusuFODeCdvFcSidoBLNnCCsCd/6bqFbWYI5zV+8VfyX6lENjqla7L4RE3peH
         /GlCSa+NPiOIRiE+vulmHwb2b9BK+9yO0u6HE66d0ZACoCGNRZR/6hdzGkgOLAcY+SlF
         sZgwtk7KU+cB1l5zMBV5qpU1QfgizEnWTV+Ykisc8XNDCWHXq2HSXvogY4ocmmwTGxK4
         O4g/y8hayVJYqRiXnqvPhCiFCuDQFiEZfseAgfwpc4434sn6UyT5tAeHI2GXKkMkIQZO
         MRyA25hKDNJozycjAXO7ukeFZHFpNChpWX24Pw+28WnOZykJWP/gUVky5jFWy1fw0mVn
         4qOA==
X-Gm-Message-State: APuU4Z9i9leL0AVN3H0yAB8T8Nt7LWaFsIXy0+0gP6l3kxY8LWs1E39o
	6Hvf+3SK8Mn394eCDoCPzN5wqhkBHluUr1H1lNh5IKkv+siQ58qpYXOs4qZkN3qYHIY=
X-Gm-Gg: AYBFou2Dv6o2rPwHW7GzMqRB50rDscIzqYSymIAk25gMPg8kx/AdoWNqmiZYb2FqPtL
	AGNJmDHAwZ5z3xDLi+QOIBnNuhkFDd3qxAqJ5CD2/tkDH82YkMVu5Z+V7ZdNPCMZh+9TNcQSWs6
	TYcnt7e4TQl1EVw224desUU10MBN8+ZZhkJeaxHHH1eSIA7hAdleDU44eY1rV3Pk1roE8OaVv3C
	IH4bYO5dGbNCdMIx/H+MCBX4K4U9Hdha7QscbJKrgunVag7C826j72uJ0UXt2nWmzlZsH2tMGqQ
	rAiY4unek67jKKmGDLd5MLXDwhexsQrwG0T4p7sEaVhRDQqDchUPssF9Mvfx7r+N/v9c//GTQo+
	EiXlZBaZyRKNHfjLXifmLGHQJj5NZc8KnSfmFRWl4KJ4j1l6uLGq0wdEEnN6DSM/yX2qcJQBtqk
	NPm5AxHhzjLpx1aQOVHYwYZX2vSVa+mt7Mj3D8lzwHqh/3V/fWv88y/pg+BTiKwzoWo8AqXs/zB
	BEDDpHPqdv6Jx3Q89znMrQmsjZ9OTuXedvymfKZgqgVmJtNcy0j+TDdLK1Hmzj/4kSc3Vu3WSMv
	AkSYTazF+Tj9QylKkiuCNkGEh8evq6vnjcNUrrGS+qD+
X-Received: by 2002:a05:620a:688f:b0:940:f224:5a67 with SMTP id af79cd13be357-944217f0782mr3247448485a.69.1793891962471;
        Thu, 05 Nov 2026 07:19:22 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4898a06sm482160385a.42.2026.11.05.07.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:19:20 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:44 +0000
Subject: [PATCH RFC v3 52/90] kernfs: let a filesystem refuse a change to a
 node
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-cells-v3-52-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890934; l=6397;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=cV092EsOpAAG8NDCOxwaLI5LnoLWUM05AD95cGuuS6I=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QF+VuW+GCcKorqd6L61DKaGyLokKpzJMG30qlREQ7V60anQvdJUawkX7SvULbDfKBCpfIv8DTuU
 2ZlNnio1mdAA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Whether a node of a kernfs based filesystem may be changed is decided by
its mode and owner, in the VFS and in kernfs. The filesystem on top of
kernfs sees some of the changes, such as a write to a file or a mkdir. It
never sees others: chmod, chown, a timestamp update, an extended
attribute. If it has a rule that is based on something other than mode and
owner, it can only enforce that rule for the first kind.

Add a may_change() callback to kernfs_syscall_ops. It is called in
addition to the mode check, everywhere a change can come from:

  - when write permission is checked, which covers opening a file for
    writing and creating, removing or renaming a directory entry
  - on every write to a file, because the writer may not be the task that
    opened it
  - before an attribute or an extended attribute is set or removed

The callback is told whether the change is to the content of the node or
to its attributes. A filesystem may want to let a task create entries in a
directory without letting it change the mode of that directory.

Truncating a file counts as a change to its content. That is what an open
with O_TRUNC does, which every shell redirection uses, and kernfs ignores
the size anyway.

No filesystem implements the callback yet.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/kernfs/file.c            |  5 +++++
 fs/kernfs/inode.c           | 25 +++++++++++++++++++++++++
 fs/kernfs/kernfs-internal.h | 11 +++++++++++
 include/linux/kernfs.h      | 15 +++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index cca9f83fc9b5..27e234c4aea0 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -307,6 +307,11 @@ static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t len = iov_iter_count(iter);
 	const struct kernfs_ops *ops;
 	char *buf;
+	int ret;
+
+	ret = kernfs_may_change(of->kn, KERNFS_CHANGE_CONTENT);
+	if (ret)
+		return ret;
 
 	if (of->atomic_write_len) {
 		if (len > of->atomic_write_len)
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 6630b29d7c07..efefd40161d6 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -112,12 +112,21 @@ int kernfs_iop_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	struct kernfs_node *kn = inode->i_private;
+	enum kernfs_change what = KERNFS_CHANGE_ATTRS;
 	struct kernfs_root *root;
 	int error;
 
 	if (!kn)
 		return -EINVAL;
 
+	/* Truncating a file is writing to it, which is what O_TRUNC is for. */
+	if ((iattr->ia_valid & ATTR_SIZE) &&
+	    !(iattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
+		what = KERNFS_CHANGE_CONTENT;
+	error = kernfs_may_change(kn, what);
+	if (error)
+		return error;
+
 	root = kernfs_root(kn);
 	down_write(&root->kernfs_iattr_rwsem);
 	error = setattr_prepare(&nop_mnt_idmap, dentry, iattr);
@@ -283,6 +292,12 @@ int kernfs_iop_permission(const struct mnt_idmap *idmap,
 	kn = inode->i_private;
 	root = kernfs_root(kn);
 
+	if (mask & MAY_WRITE) {
+		ret = kernfs_may_change(kn, KERNFS_CHANGE_CONTENT);
+		if (ret)
+			return ret;
+	}
+
 	down_read(&root->kernfs_iattr_rwsem);
 	kernfs_refresh_inode(kn, inode);
 	ret = generic_permission(&nop_mnt_idmap, inode, mask);
@@ -349,6 +364,11 @@ static int kernfs_vfs_xattr_set(const struct xattr_handler *handler,
 {
 	const char *name = xattr_full_name(handler, suffix);
 	struct kernfs_node *kn = inode->i_private;
+	int ret;
+
+	ret = kernfs_may_change(kn, KERNFS_CHANGE_ATTRS);
+	if (ret)
+		return ret;
 
 	return kernfs_xattr_set(kn, name, value, size, flags);
 }
@@ -362,10 +382,15 @@ static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
 	const char *full_name = xattr_full_name(handler, suffix);
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_iattrs *attrs;
+	int ret;
 
 	if (!(kernfs_root(kn)->flags & KERNFS_ROOT_SUPPORT_USER_XATTR))
 		return -EOPNOTSUPP;
 
+	ret = kernfs_may_change(kn, KERNFS_CHANGE_ATTRS);
+	if (ret)
+		return ret;
+
 	attrs = kernfs_iattrs(kn);
 	if (!attrs)
 		return -ENOMEM;
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index f1e93b09e27d..5d1d4e282556 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -127,6 +127,17 @@ static inline const char *kernfs_rcu_name(const struct kernfs_node *kn)
 				     kernfs_rename_is_locked(kn));
 }
 
+/* See kernfs_syscall_ops::may_change. */
+static inline int kernfs_may_change(struct kernfs_node *kn,
+				    enum kernfs_change what)
+{
+	struct kernfs_syscall_ops *scops = kernfs_root(kn)->syscall_ops;
+
+	if (scops && scops->may_change)
+		return scops->may_change(kn, what);
+	return 0;
+}
+
 static inline struct kernfs_node *kernfs_parent(const struct kernfs_node *kn)
 {
 	/*
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 73786b567ccd..62bdb77961e3 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -243,6 +243,12 @@ struct kernfs_node {
  * the exact operation requested.  An active reference is held for each
  * kernfs_node parameter.
  */
+/* What kernfs_syscall_ops::may_change is asked about. */
+enum kernfs_change {
+	KERNFS_CHANGE_CONTENT,	/* what a file holds, size included, the entries of a directory */
+	KERNFS_CHANGE_ATTRS,	/* mode, owner, times, extended attributes */
+};
+
 struct kernfs_syscall_ops {
 	int (*show_options)(struct seq_file *sf, struct kernfs_root *root);
 
@@ -253,6 +259,15 @@ struct kernfs_syscall_ops {
 		      const char *new_name);
 	int (*show_path)(struct seq_file *sf, struct kernfs_node *kn,
 			 struct kernfs_root *root);
+	/*
+	 * May the caller change @kn? Asked on top of what the mode says, and
+	 * before it: when permission to write is asked for, which is what
+	 * opening a file for writing and making, removing or renaming an entry
+	 * of a directory take, for every write to a file, whoever opened it, and
+	 * before an attribute or an extended attribute is set or removed. No
+	 * active reference is held on @kn. Returns 0 or a negative error.
+	 */
+	int (*may_change)(struct kernfs_node *kn, enum kernfs_change what);
 };
 
 struct kernfs_node *kernfs_root_to_node(struct kernfs_root *root);

-- 
2.55.0

