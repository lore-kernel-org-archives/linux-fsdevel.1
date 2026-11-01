Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793498244;
	b=SVO1tWerJbYJLRJ6ohFz6e+QB38JfGLZrvLj+b0mz9rG6Gam8Q+I6JFwH5quFJxXH4no
	 JDWF7foHt8WL8UKOIn+ZFYL9Xlm4lQ/0YQi2ZluDCNRzm/XUlHNTJhl182S/J1+vCM51o
	 kgBlfXObJuXH3b+BV/tn6NrUx/9pN0ag0cvxMNMEXF5mCX57hD6lN6sjnU9VWf5piR7Ll
	 i1ShKEeRjkz1fGw8Lxm6T5dfUUTntNiPE7vah3iV0gwEuV52viYDPhZ3127y5QGsmMtxX
	 xjRHl6JGQsouWc2WD5+I4IyLFguXJ++YSbbAQeTB6SzNadSXI4g6CmpJgklj5fR1gog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793498244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HjxZWeiY3BNoKLFLjn9gfnGpTfHowaS1Ix4espIgNNc=;
	b=kwPnkAMSR+Gl9PRGDOJ9GtPB/iOS3Jr/IJ1lqv3f35AqvqFmTNJNmheO96IuA/HhUN0z
	 9iT1mXZMohr1yCNFrdvpQEeCKlTyftcPxGbhaT3QTPAwNAS+Dkans7PRDLeTvQwS9cRYN
	 wQJxpp+7SXRK83HQoExQyjE0VL+CQqYk2efO0e3ROJbLvSLUVb5dKAJtAzkTSzNsQjBAk
	 3NwfTXFBzlVgjfhC+/GJhKcJqSY4fx+TdAlf27Q1rUhCMoIDHsXNAqe/srmNqILXvlvIT
	 Y6xSLtvhZdHTpEZ9SvA1ALT2Cn11vSKI+ZCdZvbIvztKmEQSm6TZkE7hXFHRDLItSfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E6U1aYpw;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C229960A2600
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 01:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C229960A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E6U1aYpw
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso16770855e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 18:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793498242; x=1794103042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HjxZWeiY3BNoKLFLjn9gfnGpTfHowaS1Ix4espIgNNc=;
        b=E6U1aYpw3eifXJWi/HI54PDUOjXJwFSKQwOxY5GtSo71wT73Gy6pzoeeoVFSQWZ/7B
         3fPct60jWxxCuDYzUnvtpXIxUjHj8FdBOLXuO13qds94Z3cNr5tXMet8DSQFOA/m3zPf
         eeqU8cst1mUCVtwdkSGJ5yzvt5Pqriqu/Me3dzck7L2/D46HlQFnXyuv9jEjHfXcRKTx
         kTpxe3JntdV6yxcGBm1DYHQLakOJyrnnjV0V5hGllH8CyaS8M13PgxfkK8fP9rK7cFlB
         AChF2tEHoAEU3WefLHmXQePfBXyA8dJ7+DZKdwqRibs4j9mxt8lA4hcARjqHk6KLU5Jl
         eiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793498242; x=1794103042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HjxZWeiY3BNoKLFLjn9gfnGpTfHowaS1Ix4espIgNNc=;
        b=XFZPulxFfnvSzP5rdJQZSvVXczLf/vqWr33ftt57u1Rq/4jQ6sG+zeBROorEVyDV5k
         VmpE0yv4A2RZiBgq37lNLe5jLmngzdum9puASYofQKXde5c9+hY9gT8r+Hy0mqYAswbD
         mVF+4eCGim7d/BnCwbVl4jQ+ArmmeV0dP8aCBpPYGIXGAaAGsRaRhuUutW7yqHPHXgag
         mRkKNRVdaqNalQpTEo0ojKKyYYUPJaS5nrtBgWzwSY8qnHmwDo1NBx/12SlxNIXPEFih
         miGXNBnjjWNn1BPWIUzCGKPh6slluhqFzu5v3AI3xPMEGz6hGPKOfCfrqgcXaA4U6KBl
         NytA==
X-Forwarded-Encrypted: i=1; AKwUvBxo8xbrA8O3/j1DPzA43++rYlWgb4RC6noq/6X05qTGlCpVwL5NbELNxYnhTIXJMkCyOqG9ZjRSIF72nC7W@vger.kernel.org
X-Gm-Message-State: AFq9FYL46L1jRa5RirE7ti6TKp/nUGwTDOZ+yji7eGeAeKAEW1eXiAcN
	O1JbtwXOcC03bmuxhXHZ/HVW7oSBN7+jy0Pa0HPnc83rlCIxq7/Qyv7u
X-Gm-Gg: AYBFou2VVjKC8N1dpovdykkW4kpzZrLi+dcxsGBQFu5iiSFQpLPUY6EX2y8Pk4v9nyI
	ANHUr3/Ze9nSPxVas9VAmS64MIQbdmaP5/bIl09yFxeLFOPQ0mbM3ecpl/op2uWo50Ta5oBjfdu
	9l2m/ThWhtriXyO7Mb625fnDpswOBNYpXqnzVF2F+BQI31CN2J3tvxt+jWhZDeonQXG6lbiQF4n
	GxBnJ4eMM8HrQXijk9YrJSg7G+Evlh+Nj7n3JDJp+BdSK8OC4cMsj+87qIazZO4o1Uo/ZcrGfNC
	Jt8fvWsyayXDcCI1NZyEQS9B+b979weDqtf2uL0vkBqD2cj9tS0KhYT917QK/UcohdATlQnpPmw
	9I9wcc745OLacKubhcscvIvDtFguIYEEXd1cNkZMhqSVj2vXZh7r+qNoMCkiTzQQvWlTa2nDIjn
	139SiuXXVd398WCQosDiWZms158/GretmQeXlua/IfXadFhXsISku+a4Lg8XjDBSo+PRMbJDLx9
	eonBi4vnrdcbyD5ejn9fpRt/COAleFy18wBTs9+4nxLwP1Hphi5YhZt7GU+s5tQ4Y62Jd2JHfDA
	/3+Y6iVGwGwAWDBv0FN/eZ8+
X-Received: by 2002:a05:600c:3f0f:b0:4a2:1612:636e with SMTP id 5b1f17b1804b1-4ac16bc4645mr143132385e9.5.1793498242131;
        Sat, 31 Oct 2026 18:57:22 -0700 (PDT)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81b7fe80sm273532835e9.11.2026.10.31.18.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 18:57:21 -0700 (PDT)
From: koraynilay <koray.fra@gmail.com>
To: David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Chris Mason <mason@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chuck Lever <cel@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Sean Smith <defendthedisabled@gmail.com>,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Amir Goldstein <amir73il@gmail.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	exfat@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-api@vger.kernel.org,
	koraynilay <koray.fra@gmail.com>
Subject: [RFC PATCH v3 1/5] vfs: add provenance time (ptime)
Date: Sun,  1 Nov 2026 02:55:47 +0100
Message-ID: <20261101015551.786044-2-koray.fra@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101015551.786044-1-koray.fra@gmail.com>
References: <20261101015551.786044-1-koray.fra@gmail.com>
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

Add provenance time (ptime), indicating the time when a file or
directory was created. This is user-settable via file_setattr() and
retrievable via statx(2) (using STATX_PTIME) or file_getattr().

The semantics of when to preserve this new timestamp are the same as
mtime, the idea being that there is a correspondence like this:

ctime <-> btime
mtime <-> ptime

so every operation (copying, moving, ...) that currently preserves mtime
should also preserve ptime.

Furthermore, in order to avoid the legacy FS_IOC_FSSETXATTR accepting
FS_XFLAG_PTIME, add an FS_FILE_ATTR_XFLAGS_MASK mask to support new
xflags, and use it in fileattr_to_file_attr()/file_attr_to_fileattr() to
allow ptime to be used with the file_setattr()/file_getattr() syscalls.

[ This is a re-implementation of the initial patch[1] by Sean Smith
  <defendthedisabled@gmail.com>, following the advice[2] from Darrick J.
  Wong <djwong@kernel.org> of using file_setattr() instead of updating
  utimensat() ]

[1]: https://lore.kernel.org/20260405195007.1306-2-DefendTheDisabled@gmail.com
[2]: https://lore.kernel.org/20260407014129.GC6192@frogsfrogsfrogs

Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.4.7
Signed-off-by: koraynilay <koray.fra@gmail.com>
---
 fs/file_attr.c            | 33 +++++++++++++++++++++++++++++++--
 fs/stat.c                 |  2 ++
 include/linux/fileattr.h  |  5 +++++
 include/linux/stat.h      |  1 +
 include/uapi/linux/fs.h   |  8 +++++++-
 include/uapi/linux/stat.h |  7 ++++++-
 6 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 833e03810b24..c0645cb22bf3 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -102,7 +102,7 @@ EXPORT_SYMBOL(vfs_fileattr_get);
 static void fileattr_to_file_attr(const struct file_kattr *fa,
 				  struct file_attr *fattr)
 {
-	__u32 mask = FS_XFLAGS_MASK;
+	__u32 mask = FS_FILE_ATTR_XFLAGS_MASK;
 
 	memset(fattr, 0, sizeof(struct file_attr));
 	fattr->fa_xflags = fa->fsx_xflags & mask;
@@ -110,6 +110,8 @@ static void fileattr_to_file_attr(const struct file_kattr *fa,
 	fattr->fa_nextents = fa->fsx_nextents;
 	fattr->fa_projid = fa->fsx_projid;
 	fattr->fa_cowextsize = fa->fsx_cowextsize;
+	fattr->fa_ptime_sec = fa->fsx_ptime.tv_sec;
+	fattr->fa_ptime_nsec = fa->fsx_ptime.tv_nsec;
 }
 
 /**
@@ -141,15 +143,20 @@ EXPORT_SYMBOL(copy_fsxattr_to_user);
 static int file_attr_to_fileattr(const struct file_attr *fattr,
 				 struct file_kattr *fa)
 {
-	__u64 mask = FS_XFLAGS_MASK;
+	__u64 mask = FS_FILE_ATTR_XFLAGS_MASK;
 
 	if (fattr->fa_xflags & ~mask)
 		return -EINVAL;
 
+	if (fattr->fa_pad != 0)
+		return -EINVAL;
+
 	fileattr_fill_xflags(fa, fattr->fa_xflags & ~FS_XFLAG_RDONLY_MASK);
 	fa->fsx_extsize = fattr->fa_extsize;
 	fa->fsx_projid = fattr->fa_projid;
 	fa->fsx_cowextsize = fattr->fa_cowextsize;
+	fa->fsx_ptime.tv_sec = fattr->fa_ptime_sec;
+	fa->fsx_ptime.tv_nsec = fattr->fa_ptime_nsec;
 
 	return 0;
 }
@@ -232,6 +239,20 @@ static int fileattr_set_prepare(struct inode *inode,
 	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
 		return -EINVAL;
 
+	if (fa->fsx_xflags & FS_XFLAG_PTIME) {
+		if (!(old_ma->fsx_xflags & FS_XFLAG_PTIME))
+			return -EOPNOTSUPP;
+
+		if ((unsigned long)fa->fsx_ptime.tv_nsec >= NSEC_PER_SEC)
+			return -EINVAL;
+
+		fa->fsx_ptime = timestamp_truncate(fa->fsx_ptime, inode);
+
+		if (!timespec64_equal(&old_ma->fsx_ptime, &fa->fsx_ptime) &&
+		    (fa->flags & old_ma->flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL))
+			return -EPERM;
+	}
+
 	/*
 	 * It is only valid to set the DAX flag on regular files and
 	 * directories on filesystems.
@@ -293,6 +314,7 @@ int vfs_fileattr_set(const struct mnt_idmap *idmap, struct dentry *dentry,
 			fa->fsx_nextents = old_ma.fsx_nextents;
 			fa->fsx_projid = old_ma.fsx_projid;
 			fa->fsx_cowextsize = old_ma.fsx_cowextsize;
+			fa->fsx_ptime = old_ma.fsx_ptime;
 		} else {
 			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
 		}
@@ -423,6 +445,10 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 		return error;
 
 	fileattr_to_file_attr(&fa, &fattr);
+
+	if (usize < FILE_ATTR_SIZE_VER1)
+		fattr.fa_xflags &= ~FS_XFLAG_PTIME;
+
 	error = copy_struct_to_user(ufattr, usize, &fattr,
 				    sizeof(struct file_attr), NULL);
 
@@ -459,6 +485,9 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
 	if (error)
 		return error;
 
+	if ((fattr.fa_xflags & FS_XFLAG_PTIME) && usize < FILE_ATTR_SIZE_VER1)
+		return -EINVAL;
+
 	error = file_attr_to_fileattr(&fattr, &fa);
 	if (error)
 		return error;
diff --git a/fs/stat.c b/fs/stat.c
index a2e63c6c45b7..e426f41253f6 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -728,6 +728,8 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_ctime.tv_nsec = stat->ctime.tv_nsec;
 	tmp.stx_mtime.tv_sec = stat->mtime.tv_sec;
 	tmp.stx_mtime.tv_nsec = stat->mtime.tv_nsec;
+	tmp.stx_ptime.tv_sec = stat->ptime.tv_sec;
+	tmp.stx_ptime.tv_nsec = stat->ptime.tv_nsec;
 	tmp.stx_rdev_major = MAJOR(stat->rdev);
 	tmp.stx_rdev_minor = MINOR(stat->rdev);
 	tmp.stx_dev_major = MAJOR(stat->dev);
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 09e32b84e02a..0b93f9609284 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -35,6 +35,10 @@
 	(FS_XFLAG_COMMON | FS_XFLAG_RDONLY_MASK | FS_XFLAG_VALUES_MASK | \
 	 FS_XFLAG_DIRONLY_MASK | FS_XFLAG_MISC_MASK)
 
+/* Flags only for fa_ fields */
+#define FS_FILE_ATTR_XFLAGS_MASK \
+	(FS_XFLAGS_MASK | FS_XFLAG_PTIME)
+
 /*
  * Merged interface for miscellaneous file attributes.  'flags' originates from
  * ext* and 'fsx_flags' from xfs.  There's some overlap between the two, which
@@ -49,6 +53,7 @@ struct file_kattr {
 	u32	fsx_nextents;	/* nextents field value (get)	*/
 	u32	fsx_projid;	/* project identifier (get/set) */
 	u32	fsx_cowextsize;	/* CoW extsize field value (get/set)*/
+	struct timespec64 fsx_ptime; /* provenance (settable birth) time */
 	/* selectors: */
 	bool	flags_valid:1;
 	bool	fsx_valid:1;
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 9c5709132862..69d2ecfd1bf2 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -48,6 +48,7 @@ struct kstat {
 	struct timespec64 mtime;
 	struct timespec64 ctime;
 	struct timespec64 btime;			/* File creation time */
+	struct timespec64 ptime;	/* File provenance (user-settable creation) time */
 	u64		blocks;
 	u64		mnt_id;
 	u64		change_cookie;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index a46c33692aa2..c00e72fcfa3e 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -229,10 +229,14 @@ struct file_attr {
 	__u32 fa_nextents;	/* nextents field value (get)   */
 	__u32 fa_projid;	/* project identifier (get/set) */
 	__u32 fa_cowextsize;	/* CoW extsize field value (get/set) */
+	__s64 fa_ptime_sec;	/* provenance (settable birth) time (seconds) */
+	__u32 fa_ptime_nsec;	/* provenance (settable birth) time (nanoseconds) */
+	__u32 fa_pad;
 };
 
 #define FILE_ATTR_SIZE_VER0 24
-#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER0
+#define FILE_ATTR_SIZE_VER1 40
+#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER1
 
 /*
  * Flags for the fsx_xflags field
@@ -261,6 +265,8 @@ struct file_attr {
  */
 #define FS_XFLAG_CASEFOLD	0x00040000	/* case-insensitive lookups */
 #define FS_XFLAG_CASENONPRESERVING 0x00080000	/* case not preserved */
+
+#define FS_XFLAG_PTIME		0x00100000	/* provenance time */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 1686861aae20..f3a1013ba022 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -187,7 +187,11 @@ struct statx {
 	__u32	__spare2[1];
 
 	/* 0xc0 */
-	__u64	__spare3[8];	/* Spare space for future expansion */
+	/* Data provenance (creation) time */
+	struct statx_timestamp	stx_ptime;
+
+	/* 0xd0 */
+	__u64	__spare3[6];	/* Spare space for future expansion */
 
 	/* 0x100 */
 };
@@ -219,6 +223,7 @@ struct statx {
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
 #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
 #define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
+#define STATX_PTIME		0x00040000U	/* Want/got stx_ptime */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
-- 
2.56.0

