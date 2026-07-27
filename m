Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1458E3F8EB3
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149334; cv=none; b=oMdFHFp6cfE7Kd2l/YQlI64nx6sSAKHzHUWqQeMpeRpirK4vQMKc1yn/g2xABO9X8rduXOR4u0YT7DtXcoXoVjKiKLq0n44deiKxLkoYBKPOaOd2xgdSMiB+RVogFdgPWJBeDrMpHLXbBIzh4F+ZB45WHfWfc5K4ybhnTu/hFas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149334; c=relaxed/simple;
	bh=655bTJ1sc9/kDIB9ONrFluoEdQiiCweFjmu556zwULE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zf2s2K+4comxxzfqQwHOyw8bNE/RJL4NMg4nuNB+hZwNZHSBrLB52S0E/Ht/mDX82imys8A+zrdf8jo1PFhztqitfpebBQ0tK7ZOBiURUXe3GAJQaStenOCYpPV3r7l6GQaIvtdvJuwyR6RPNEo0JAfM1AwhqMqcnETFe3RvM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JexGsh5D; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JexGsh5D"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f7854678cso1427104f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 03:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785149329; x=1785754129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b0xlGLz0lZUV4g4ovfTp8rb9hxeTp6x+hKCx+BsbNZA=;
        b=JexGsh5DEn7Zr7DYH9WvIAv0a2UQiKY/IMdMkbpufyOTrHOCMakVv39ZfiFwzSh8td
         AV2gWR29wOzr+DWC15qwiow+t6y6qgxWFPej9MtzGLBRifvj0PyGE/sEEJ/3AZ6MDICL
         zD+6XgM19PH3rbY0C3TQ4xIJ8O/WmiKpHZZSf4DLAteCrgr5M1kWsLcCHH8p6WGsJQmu
         4v7a0OrUNQMavmuWAl/nPhj3i5TjX5C+S7xUBAFzcMvJ7hYD1BhyxUgCOrYbkm+6+IWH
         qDERZRrtOcUHRJq2hpWzA1Qj5qIFX+YM6zI7v2rGQiYqtD8y544YWtp4sw13chVBdxXv
         Tk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785149329; x=1785754129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b0xlGLz0lZUV4g4ovfTp8rb9hxeTp6x+hKCx+BsbNZA=;
        b=iTPcgSCzNadpAazXXgRDpkOOvC4oFRZj4hqb8oo7qoW6otaeujwO7BqlzrlsMywJxy
         xZKo3oJmQujcYugnFsHmph6DkpzyQgvwAwS+yuKi6FmJAVRiXCcaATeQmzalJauLyXmt
         SsNmZuOCtCwjCTBV1rEDwYaCxJqnGmiwqlgzDZzP6NRNk2ML0qkx+weYQGeHIRl5OM4g
         1jdK2MjpBLI5BzPfL1qPfCk9QFyXEt2FRJgVSbiWnIFiTaqgBkacLJKzOOoJeeIi0zlX
         A/k3Q4Jt/RESicVFz1+CVidlKmdEFtyJ29RCrAfzzNkzbaqESsuotN6Oez7x8V82EeZn
         xwNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7Yu+LFkbA7bZ6PP/t0+x25bZqrkdof/gWN3qpXuP1bvM3oYahCimtRgPMEhh88Vo4bdk7THE/hg/urCn9@vger.kernel.org
X-Gm-Message-State: AOJu0YzEdMFJ1TvJ4UQ5QtcXSWM2WaVZ0oXQgIuHv4EqbnV9+VYReZbQ
	5sYmd/G9hnYossDuMP2C0bGBKfxH3er6CCnc7qFNX/iLfPzz3ATigppl
X-Gm-Gg: AR+sD12zHLcGMRBAPF0jmcsEAHHfIkA7tluxmpHfrgrSZ0xHPccIptgWmG4PI/0R5qS
	99H9NUh8v0tueYuO1wMePUd26MvMhK4J0qKVfStQkpa6cxqsy1arP3XGyRsvpHZb7rSXAbKn6p3
	gDC3cxuk+ApBwQLg1EaeUA6MlIHvFCRGtIpXrcyc4Vndq9KxjN4sEiFYoOXRQhUs8fnP1/e+rYy
	MHOZut5O4qbWE4XzoO3I2HlC/cdX4R/4pSiB+ibH1GxxQ+4XGM2mHtXJ1c2IvDLSq3HfXR+PJBo
	IkzNQLwOPyI3x9NLyC3gUgkOqcR4E2lytbETd6vb0TOIE9fM8CT0mDxMXrm/c0/GUXY4gWw8Sap
	UOIODIu2tyr9qgkp3+29msG258EVwKO2BnYOGp4v/a88mbarjQQZNEusgalXmCiWap+qJXhUJh0
	QyQ6qrxg==
X-Received: by 2002:a05:6000:4029:b0:47f:84b2:2671 with SMTP id ffacd0b85a97d-47f9fc8d144mr10155626f8f.7.1785149329056;
        Mon, 27 Jul 2026 03:48:49 -0700 (PDT)
Received: from spark.Home ([2001:8a0:7280:4000:53fe:effd:424:fa7e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a659sm49056188f8f.6.2026.07.27.03.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 03:48:48 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	fsverity@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Curtin <ericcurtin17@gmail.com>
Subject: [RFC PATCH v2 1/4] fs: allow in-kernel mounters to hand filesystems an already-open source file
Date: Mon, 27 Jul 2026 11:48:42 +0100
Message-ID: <20260727104845.2607444-2-ericcurtin17@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727-gepaukt-eislauf-waran-7c03f0e47609@brauner>
References: <20260727-gepaukt-eislauf-waran-7c03f0e47609@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_new_mount() and its path_mount() wrapper only ever let a filesystem's
->get_tree() resolve its own source, either from a path string that the
kernel translates to fc->source via vfs_parse_fs_param_source(), or from
whatever the filesystem's own ->parse_param() does with it. There is no
way for a caller that already has an open, already-validated struct file
in hand to mount from *that exact file*: the best it can do is hand the
filesystem a path and hope nothing about the target changed by the time
the filesystem re-resolves it, which is not a guarantee the VFS can make.

Add struct fs_context::source_file alongside the existing ::source, set
via a new vfs_parse_fs_param_file() instead of the string parameter
path, and a new path_mount_file() / init_mount_file() pair mirroring
path_mount() / init_mount() that use it. This is deliberately not wired
up to the fsconfig(FSCONFIG_SET_FD) uAPI: it is for in-kernel callers
only, so no existing filesystem's ->parse_param() needs to change to
avoid misinterpreting it, and none is affected by this patch.

Filesystems that support being mounted from a plain file and want to
accept exactly the file a caller hands them, instead of independently
re-resolving fc->source (unset in this case), check fc->source_file
from their ->get_tree(). erofs is converted to do so in the next patch;
the immediate motivation is letting init/do_mounts.c mount an fsverity-
checked root image from the same struct file it just checked, instead
of a path that erofs would then look up again on its own.

Signed-off-by: Eric Curtin <ericcurtin17@gmail.com>
---
 Documentation/filesystems/mount_api.rst | 18 +++++
 fs/fs_context.c                         | 39 +++++++++-
 fs/init.c                               | 18 +++++
 fs/internal.h                           |  2 +
 fs/namespace.c                          | 96 ++++++++++++++++++++++++-
 include/linux/fs_context.h              |  4 ++
 include/linux/init_syscalls.h           |  2 +
 7 files changed, 175 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index e8b94357b4df..7b799f61c39d 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -138,6 +138,24 @@ The fs_context fields are as follows:
      This specifies the source.  It may be a block device (e.g. /dev/sda1) or
      something more exotic, such as the "host:/path" that NFS desires.
 
+   * ::
+
+       struct file *source_file
+
+     An alternative to ``source`` for in-kernel mounters only (there is no
+     userspace-visible way to set this): an already-open file to use as the
+     source, set by vfs_parse_fs_param_file() instead of parsing a path
+     string.  At most one of ``source`` and ``source_file`` is ever set.
+
+     Filesystems that support being mounted from a plain file (as opposed to
+     a block device) and want to let such an in-kernel caller hand them an
+     exact, already-validated file - rather than a path they would then have
+     to re-resolve themselves, with no way to guarantee the two refer to the
+     same thing - should check this field in their ``get_tree`` and use it
+     directly instead of falling back to opening ``source``.  See
+     fs/erofs/super.c:erofs_fc_get_tree() for reference, and
+     init/do_mounts.c:mount_root_image() for the in-kernel caller.
+
    * ::
 
        char *subtype
diff --git a/fs/fs_context.c b/fs/fs_context.c
index 23ad66cd94e1..ab853147b87b 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -85,7 +85,7 @@ int vfs_parse_fs_param_source(struct fs_context *fc, struct fs_parameter *param)
 	if (param->type != fs_value_is_string)
 		return invalf(fc, "Non-string source");
 
-	if (fc->source)
+	if (fc->source || fc->source_file)
 		return invalf(fc, "Multiple sources");
 
 	fc->source = param->string;
@@ -94,6 +94,36 @@ int vfs_parse_fs_param_source(struct fs_context *fc, struct fs_parameter *param)
 }
 EXPORT_SYMBOL(vfs_parse_fs_param_source);
 
+/**
+ * vfs_parse_fs_param_file - Set an already-open file as the mount source
+ * @fc: The filesystem context to modify
+ * @key: Parameter name; only "source" is currently supported
+ * @file: The file to use as the mount source
+ *
+ * In-kernel callers (see path_mount_file()) can use this to hand a
+ * filesystem an already-opened struct file as its source, instead of a
+ * path string for the filesystem to resolve on its own.  A reference is
+ * taken; it is released when @fc is freed.
+ *
+ * This deliberately has no fsconfig(FSCONFIG_SET_FD) counterpart: it is
+ * not reachable from userspace, so no filesystem needs to opt in to
+ * receive it and existing ->parse_param() implementations are unaffected.
+ * Filesystems that want to use the file directly (rather than silently
+ * ignoring it and falling back to re-resolving fc->source, which is not
+ * set in this case) check fc->source_file from their ->get_tree().
+ */
+int vfs_parse_fs_param_file(struct fs_context *fc, const char *key,
+			    struct file *file)
+{
+	if (strcmp(key, "source"))
+		return -EINVAL;
+	if (fc->source || fc->source_file)
+		return invalf(fc, "Multiple sources");
+	fc->source_file = get_file(file);
+	return 0;
+}
+EXPORT_SYMBOL(vfs_parse_fs_param_file);
+
 /**
  * vfs_parse_fs_param - Add a single parameter to a superblock config
  * @fc: The filesystem context to modify
@@ -376,6 +406,7 @@ struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
 	fc->fs_private	= NULL;
 	fc->s_fs_info	= NULL;
 	fc->source	= NULL;
+	fc->source_file	= NULL;
 	fc->security	= NULL;
 	get_filesystem(fc->fs_type);
 	get_net(fc->net_ns);
@@ -504,6 +535,8 @@ void put_fs_context(struct fs_context *fc)
 	put_fc_log(fc);
 	put_filesystem(fc->fs_type);
 	kfree(fc->source);
+	if (fc->source_file)
+		fput(fc->source_file);
 	kfree(fc);
 }
 EXPORT_SYMBOL(put_fs_context);
@@ -543,6 +576,10 @@ void vfs_clean_context(struct fs_context *fc)
 	security_free_mnt_opts(&fc->security);
 	kfree(fc->source);
 	fc->source = NULL;
+	if (fc->source_file) {
+		fput(fc->source_file);
+		fc->source_file = NULL;
+	}
 	fc->exclusive = false;
 
 	fc->purpose = FS_CONTEXT_FOR_RECONFIGURE;
diff --git a/fs/init.c b/fs/init.c
index 33e312d74f58..d896d937e3e2 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -44,6 +44,24 @@ int __init init_mount(const char *dev_name, const char *dir_name,
 	return ret;
 }
 
+/*
+ * Like init_mount(), but the source is an already-open file rather than a
+ * path for the filesystem to resolve on its own; see path_mount_file().
+ */
+int __init init_mount_file(struct file *file, const char *dir_name,
+		const char *type_page, unsigned long flags, void *data_page)
+{
+	struct path path;
+	int ret;
+
+	ret = kern_path(dir_name, LOOKUP_FOLLOW, &path);
+	if (ret)
+		return ret;
+	ret = path_mount_file(file, &path, type_page, flags, data_page);
+	path_put(&path);
+	return ret;
+}
+
 int __init init_umount(const char *name, int flags)
 {
 	int lookup_flags = LOOKUP_MOUNTPOINT;
diff --git a/fs/internal.h b/fs/internal.h
index d77578d66d42..04fb75383024 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -91,6 +91,8 @@ extern bool may_mount(void);
 
 int path_mount(const char *dev_name, const struct path *path,
 		const char *type_page, unsigned long flags, void *data_page);
+int path_mount_file(struct file *file, const struct path *path,
+		const char *type_page, unsigned long flags, void *data_page);
 int path_umount(const struct path *path, int flags);
 int path_pivot_root(struct path *new, struct path *old);
 
diff --git a/fs/namespace.c b/fs/namespace.c
index fe919abd2f01..31bf263d1efc 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3783,10 +3783,14 @@ static int do_new_mount_fc(struct fs_context *fc, const struct path *mountpoint,
 /*
  * create a new mount for userspace and request it to be added into the
  * namespace's tree
+ *
+ * @name is the source given as a path string, as usual; @file is an
+ * alternative, already-open source (see path_mount_file()).  At most one
+ * of the two is ever set by callers.
  */
-static int do_new_mount(const struct path *path, const char *fstype,
-			int sb_flags, int mnt_flags,
-			const char *name, void *data)
+static int do_new_mount_2(const struct path *path, const char *fstype,
+			  int sb_flags, int mnt_flags,
+			  const char *name, struct file *file, void *data)
 {
 	struct file_system_type *type;
 	struct fs_context *fc;
@@ -3826,6 +3830,8 @@ static int do_new_mount(const struct path *path, const char *fstype,
 		err = vfs_parse_fs_string(fc, "subtype", subtype);
 	if (!err && name)
 		err = vfs_parse_fs_string(fc, "source", name);
+	if (!err && file)
+		err = vfs_parse_fs_param_file(fc, "source", file);
 	if (!err)
 		err = parse_monolithic_mount_data(fc, data);
 	if (!err && !mount_capable(fc))
@@ -3837,6 +3843,14 @@ static int do_new_mount(const struct path *path, const char *fstype,
 	return err;
 }
 
+static int do_new_mount(const struct path *path, const char *fstype,
+			int sb_flags, int mnt_flags,
+			const char *name, void *data)
+{
+	return do_new_mount_2(path, fstype, sb_flags, mnt_flags, name, NULL,
+			      data);
+}
+
 static void lock_mount_exact(const struct path *path,
 			     struct pinned_mountpoint *mp, bool copy_mount,
 			     unsigned int copy_flags)
@@ -4155,6 +4169,82 @@ int path_mount(const char *dev_name, const struct path *path,
 			    data_page);
 }
 
+/**
+ * path_mount_file - Mount a new filesystem sourced from an already-open file
+ * @file: The already-open source file
+ * @path: The mountpoint
+ * @type_page: Filesystem type
+ * @flags: MS_* flags
+ * @data_page: Filesystem-specific mount data
+ *
+ * Like path_mount(), except the source is an already-open struct file
+ * rather than a path for the filesystem to look up on its own.  This is
+ * only usable for a plain new mount: bind/move/remount/propagation-change
+ * requests, which path_mount() distinguishes by inspecting @dev_name, make
+ * no sense for an anonymous open file and are rejected.
+ *
+ * @file is not consumed; the fs_context takes its own reference (see
+ * vfs_parse_fs_param_file()).
+ *
+ * This has no io_uring/syscall-visible counterpart: it exists so that
+ * in-kernel mounters (see init_mount_file()) can hand a filesystem the
+ * exact file they resolved and validated, instead of a path that the
+ * filesystem then re-resolves independently, which is the only way to
+ * guarantee the two refer to the same thing.
+ */
+int path_mount_file(struct file *file, const struct path *path,
+		    const char *type_page, unsigned long flags,
+		    void *data_page)
+{
+	unsigned int mnt_flags = 0, sb_flags;
+
+	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
+		flags &= ~MS_MGC_MSK;
+
+	if (data_page)
+		((char *)data_page)[PAGE_SIZE - 1] = 0;
+
+	if (flags & (MS_NOUSER | MS_REMOUNT | MS_BIND | MS_MOVE |
+		     MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
+		return -EINVAL;
+
+	if (!may_mount())
+		return -EPERM;
+	if (flags & SB_MANDLOCK)
+		warn_mandlock();
+
+	if (!(flags & MS_NOATIME))
+		mnt_flags |= MNT_RELATIME;
+	if (flags & MS_NOSUID)
+		mnt_flags |= MNT_NOSUID;
+	if (flags & MS_NODEV)
+		mnt_flags |= MNT_NODEV;
+	if (flags & MS_NOEXEC)
+		mnt_flags |= MNT_NOEXEC;
+	if (flags & MS_NOATIME)
+		mnt_flags |= MNT_NOATIME;
+	if (flags & MS_NODIRATIME)
+		mnt_flags |= MNT_NODIRATIME;
+	if (flags & MS_STRICTATIME)
+		mnt_flags &= ~(MNT_RELATIME | MNT_NOATIME);
+	if (flags & MS_RDONLY)
+		mnt_flags |= MNT_READONLY;
+	if (flags & MS_NOSYMFOLLOW)
+		mnt_flags |= MNT_NOSYMFOLLOW;
+
+	sb_flags = flags & (SB_RDONLY |
+			    SB_SYNCHRONOUS |
+			    SB_MANDLOCK |
+			    SB_DIRSYNC |
+			    SB_SILENT |
+			    SB_POSIXACL |
+			    SB_LAZYTIME |
+			    SB_I_VERSION);
+
+	return do_new_mount_2(path, type_page, sb_flags, mnt_flags, NULL,
+			     file, data_page);
+}
+
 int do_mount(const char *dev_name, const char __user *dir_name,
 		const char *type_page, unsigned long flags, void *data_page)
 {
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 0d6c8a6d7be2..b35d7583f0bd 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -16,6 +16,7 @@
 
 struct cred;
 struct dentry;
+struct file;
 struct file_operations;
 struct file_system_type;
 struct mnt_namespace;
@@ -99,6 +100,7 @@ struct fs_context {
 	const struct cred	*cred;		/* The mounter's credentials */
 	struct p_log		log;		/* Logging buffer */
 	const char		*source;	/* The source name (eg. dev path) */
+	struct file		*source_file;	/* Already-open source file, in-kernel only */
 	void			*security;	/* LSM options */
 	void			*s_fs_info;	/* Proposed s_fs_info */
 	unsigned int		sb_flags;	/* Proposed superblock flags (SB_*) */
@@ -148,6 +150,8 @@ extern int vfs_get_tree(struct fs_context *fc);
 extern void put_fs_context(struct fs_context *fc);
 extern int vfs_parse_fs_param_source(struct fs_context *fc,
 				     struct fs_parameter *param);
+int vfs_parse_fs_param_file(struct fs_context *fc, const char *key,
+			    struct file *file);
 extern void fc_drop_locked(struct fs_context *fc);
 
 extern int get_tree_nodev(struct fs_context *fc,
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index 28776ee28d8e..ac937cdb9d46 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -2,6 +2,8 @@
 
 int __init init_mount(const char *dev_name, const char *dir_name,
 		const char *type_page, unsigned long flags, void *data_page);
+int __init init_mount_file(struct file *file, const char *dir_name,
+		const char *type_page, unsigned long flags, void *data_page);
 int __init init_umount(const char *name, int flags);
 int __init init_chdir(const char *filename);
 int __init init_chroot(const char *filename);
-- 
2.43.0

