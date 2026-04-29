Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8B735CB87;
	Wed, 29 Apr 2026 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473295; cv=none; b=N94kOtjTji6au3oXoxZ2UXAXeQtUcJv4uq3/cKN4agTctYMbQk/Z/0vQWMBxyefoKo1/3oKJz8z1pT7bfLt5NoK8jlpRyB7B9+tNgzECzyH3l1R/hXRHkMSOCI4JJQwr2djVbG1bY8TDzzDQhu2g9+wNrWW22oArInAjgTf3qCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473295; c=relaxed/simple;
	bh=SQfWGY6x3blwLCBxMiZWKomoq1dNl/Q40yQC2nau7AI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQb8GDL0KgpuNJymXCHDqGbxD13N+BwkwTIZOYX3AkIXiIKp48Em6z1mbtjFOUpH2N7Cooeg9AIuLTufcT6K4s45CtsYPwGeqOUwsi7M40LqRYYVzIxfr62qrPyOFMytp9VEGr0LdR1mbRE/hxXwOJu0dgX4SQdBbw765I9hd54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HN7USfzX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HN7USfzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB342C19425;
	Wed, 29 Apr 2026 14:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473294;
	bh=SQfWGY6x3blwLCBxMiZWKomoq1dNl/Q40yQC2nau7AI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HN7USfzXfx8weIho/NxwBd0UQsIn+QiBsctkUhtrqMP79AmrE50V2oASNkaVO1Lwy
	 5tEiLtS1NBZAMmUa8BP8a5yRF0RMZmBRltJKqc8rkuSNny8fcbstgDK70W99h8FgOs
	 mb6G8QEpORwiGYy+gXTNInt/sdOYiMHljkE75/37ePr8ut/jbzBzz5Yx87Wz6ODFf6
	 0mLuHQdgxOSjeCoaCWYubqRpdxDcClgtM6WMY4czuFPgmjcuCLK3DgF3wR9K/CIfwA
	 KJ7BRFWQIfNplr6S1dZmcEyJC6YwdN0fdEc+iXmxP7CCTGHUbkYlG+3rtvzLwqoyUT
	 rHz1qhXeu1d0w==
Date: Wed, 29 Apr 2026 07:34:54 -0700
Subject: [PATCH 7/9] fuse_trace: let the kernel handle KILL_SUID/KILL_SGID for
 iomap filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747206638.4103309.8411512653073787254.stgit@frogsfrogsfrogs>
In-Reply-To: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c        |    5 ++++
 2 files changed, 63 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 7136ecf25e1f2b..a6374d64a62357 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -208,6 +208,64 @@ DEFINE_EVENT(fuse_fileattr_class, name,		\
 DEFINE_FUSE_FILEATTR_EVENT(fuse_fileattr_update_inode);
 DEFINE_FUSE_FILEATTR_EVENT(fuse_fileattr_init);
 
+TRACE_EVENT(fuse_setattr_fill,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_setattr_in *inarg),
+	TP_ARGS(inode, inarg),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(umode_t,		mode)
+		__field(uint32_t,		valid)
+		__field(umode_t,		new_mode)
+		__field(uint64_t,		new_size)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->mode		=	inode->i_mode;
+		__entry->valid		=	inarg->valid;
+		__entry->new_mode	=	inarg->mode;
+		__entry->new_size	=	inarg->size;
+	),
+
+	TP_printk(FUSE_INODE_FMT " mode 0%o valid 0x%x new_mode 0%o new_size 0x%llx",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->mode,
+		  __entry->valid,
+		  __entry->new_mode,
+		  __entry->new_size)
+);
+
+TRACE_EVENT(fuse_setattr,
+	TP_PROTO(const struct inode *inode,
+		 const struct iattr *inarg),
+	TP_ARGS(inode, inarg),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(umode_t,		mode)
+		__field(uint32_t,		valid)
+		__field(umode_t,		new_mode)
+		__field(uint64_t,		new_size)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->mode		=	inode->i_mode;
+		__entry->valid		=	inarg->ia_valid;
+		__entry->new_mode	=	inarg->ia_mode;
+		__entry->new_size	=	inarg->ia_size;
+	),
+
+	TP_printk(FUSE_INODE_FMT " mode 0%o valid 0x%x new_mode 0%o new_size 0x%llx",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->mode,
+		  __entry->valid,
+		  __entry->new_mode,
+		  __entry->new_size)
+);
+
 #ifdef CONFIG_FUSE_BACKING
 #define FUSE_BACKING_FLAG_STRINGS \
 	{ FUSE_BACKING_TYPE_PASSTHROUGH,	"pass" }, \
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e664a60200ee26..716f3e893dda66 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -8,6 +8,7 @@
 
 #include "fuse_i.h"
 #include "fuse_iomap.h"
+#include "fuse_trace.h"
 
 #include <linux/pagemap.h>
 #include <linux/file.h>
@@ -2205,6 +2206,8 @@ static void fuse_setattr_fill(struct fuse_conn *fc, struct fuse_args *args,
 			      struct fuse_setattr_in *inarg_p,
 			      struct fuse_attr_out *outarg_p)
 {
+	trace_fuse_setattr_fill(inode, inarg_p);
+
 	args->opcode = FUSE_SETATTR;
 	args->nodeid = get_node_id(inode);
 	args->in_numargs = 1;
@@ -2486,6 +2489,8 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 	if (!fuse_allow_current_process(get_fuse_conn(inode)))
 		return -EACCES;
 
+	trace_fuse_setattr(inode, attr);
+
 	if (!is_iomap &&
 	    (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))) {
 		attr->ia_valid &= ~(ATTR_KILL_SUID | ATTR_KILL_SGID |

