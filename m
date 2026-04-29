Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDE335A3AF;
	Wed, 29 Apr 2026 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473248; cv=none; b=iqikwyOqfdqGKDOfJb5uLl/d0PoCUFQ3ERT86ntc8I1ya8SDhspAAFurHxzhpttm2k9XeT9on1CzTpgesgx4WTKtp4tQDx1jTvaTIeHf/5/dKi1WIFyc3D3GbmUw0lX4whyAwtLi/2ATOip4yUmMFfUHBrai2Lhr62o4+MyY6W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473248; c=relaxed/simple;
	bh=HktYWAhIQohNIclt683aNaIMB8eqpiu8PpxWbxZZHV0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLWxIzW0cb6ZwYQidqyOEyabKNCw0k7wuz6/F1TeTE6iJNRbY1Mbj4Z3sJSPgEEv+nbYDHvsvVgYMG97OH0rzqWW6OeesPBsZYq6+8U2s58vumTO4w6OK0jjeOOLJHC3bJkseCOl3j2oD9Xf/sKs+tRuA172c9XeVNYvm2XnOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSiN8kie; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSiN8kie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08ABC2BCC6;
	Wed, 29 Apr 2026 14:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473247;
	bh=HktYWAhIQohNIclt683aNaIMB8eqpiu8PpxWbxZZHV0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YSiN8kieHxLBbUzHlIIn2AhtWKexrLh74Judff8iy1YdnP8xWMYRRNvh2jvqEkIP2
	 9N6BIpJDW8pn/ghmP0sEm1HkM/ZngCHexpKer2kQSuhJTZdyNrdAt91zNE2GrUGQgi
	 wVSDJ6QPBgZjDAoAqAGiBdH4u8Zyysxe8RkKyjujRKS49/VwJrp34Z8xSSfM8TpYmP
	 FdsSlkCStm+fmghSp3/I1HUeomcKbFyxad9WeASLjoY8sKcAYF1YIlybzGSkVQK3Oo
	 JzkHGlR8xEz/2/+B7qL+KBBCmaacll9ZhS0/KyMsw4JyVIWx9hhmVLVwkWg9EhuWsP
	 w2mtZ7Imtl9JA==
Date: Wed, 29 Apr 2026 07:34:07 -0700
Subject: [PATCH 4/9] fuse_trace: allow local filesystems to set some VFS
 iflags
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747206574.4103309.6818722250933117226.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   29 +++++++++++++++++++++++++++++
 fs/fuse/ioctl.c      |    7 +++++++
 2 files changed, 36 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 0016242ff34f62..7136ecf25e1f2b 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -179,6 +179,35 @@ TRACE_EVENT(fuse_request_end,
 		  __entry->unique, __entry->len, __entry->error)
 );
 
+DECLARE_EVENT_CLASS(fuse_fileattr_class,
+	TP_PROTO(const struct inode *inode, unsigned int old_iflags),
+
+	TP_ARGS(inode, old_iflags),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(unsigned int,		old_iflags)
+		__field(unsigned int,		new_iflags)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->old_iflags	=	old_iflags;
+		__entry->new_iflags	=	inode->i_flags;
+	),
+
+	TP_printk(FUSE_INODE_FMT " old_iflags 0x%x iflags 0x%x",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->old_iflags,
+		  __entry->new_iflags)
+);
+#define DEFINE_FUSE_FILEATTR_EVENT(name)	\
+DEFINE_EVENT(fuse_fileattr_class, name,		\
+	TP_PROTO(const struct inode *inode, unsigned int old_iflags), \
+	TP_ARGS(inode, old_iflags))
+DEFINE_FUSE_FILEATTR_EVENT(fuse_fileattr_update_inode);
+DEFINE_FUSE_FILEATTR_EVENT(fuse_fileattr_init);
+
 #ifdef CONFIG_FUSE_BACKING
 #define FUSE_BACKING_FLAG_STRINGS \
 	{ FUSE_BACKING_TYPE_PASSTHROUGH,	"pass" }, \
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index bd2caf191ce2e0..5180066678e8c1 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -4,6 +4,7 @@
  */
 
 #include "fuse_i.h"
+#include "fuse_trace.h"
 
 #include <linux/uio.h>
 #include <linux/compat.h>
@@ -530,12 +531,16 @@ static void fuse_fileattr_update_inode(struct inode *inode,
 		update_iflag(inode, S_APPEND, fa->fsx_xflags & FS_XFLAG_APPEND);
 	}
 
+	trace_fuse_fileattr_update_inode(inode, old_iflags);
+
 	if (old_iflags != inode->i_flags)
 		fuse_invalidate_attr(inode);
 }
 
 void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr)
 {
+	unsigned int old_iflags = inode->i_flags;
+
 	if (!fuse_inode_is_exclusive(inode))
 		return;
 
@@ -547,6 +552,8 @@ void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr)
 
 	if (attr->flags & FUSE_ATTR_APPEND)
 		inode->i_flags |= S_APPEND;
+
+	trace_fuse_fileattr_init(inode, old_iflags);
 }
 
 int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa)

