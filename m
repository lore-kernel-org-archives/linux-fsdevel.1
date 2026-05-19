Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012BC367B90;
	Tue, 19 May 2026 22:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229904; cv=none; b=ctUqZSZe6rIT/GU9MSdxXTLvc5zSv5lZPgcHK79qHnyTLUWQAn3N2Pk+ejzEB7bfbZifWarAI+XVa6jA9BjMDxuMJz6LNCC5N473RcAPeN/CIsWWKrMkwdFF2xz4sIRz1WJ2Zh28PwdCarmKqK+ZXraHG9xi0GlG8I/uA1bVNEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229904; c=relaxed/simple;
	bh=SHkGFTpJIh7kwULIrSgKeBUwnGbPTZfo8VJjF6f8TUc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJT2fz8X12GJ/gWSQZzit/Itco5p+CGEBUTwp1An8+6kveR2HIYpDp4LZRzqvRjcXdw86Q+q5MbT/u6s6vwpyfKyBVCUhvsvx+g9Egy6vuXr0/1XJmVfWVoAX1GB938ehS7drJR/2TNcAhdOVQ8ApP54rSHD3PlKU3H/jXfhnKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wwn9QgIc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wwn9QgIc"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C962B1F000E9;
	Tue, 19 May 2026 22:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229902;
	bh=whOC3M0c3oxKtdFrfysl9IBNUaLE/xCv+3bOaLUCubo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=Wwn9QgIckcNjyoLEQFM2cxjjR8io6ICqla9FNL7l9CMylcV3QpEmpBKEGI8NdQfjY
	 Z2DPN/fbxrNGUDHR43EGJSutPUn0WtEgrHrRBaHhiYHlwP2f6+Ct5WqF8Y+dsR8bDb
	 tDmEwXJ+ZDC4yWqBSpr7lJUY7dAw/37C6/xPE4LCUIYZpIsopTdqac272cCQAhb4Fh
	 0M+1QSMWWuhIH8MCudHbBWpzP7aWjB2ZDcm5yXIJVNeElPfbonMKMOq/4aJVVberRP
	 YRoBhQoBQwv74Yr1S6A6WxJmymC9GdkUoEzQiCv/CFO1XND/mb9GaxyENLC+zalrsL
	 4E/LKz6zxW5hQ==
Date: Tue, 19 May 2026 15:31:42 -0700
Subject: [PATCH 3/9] fuse_trace: query filesystem geometry when using iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922946242.2439242.14349517198977327633.stgit@frogsfrogsfrogs>
In-Reply-To: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs>
References: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c |    2 ++
 2 files changed, 50 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 62641046138a10..38fa54e4af731d 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -58,6 +58,7 @@
 	EM( FUSE_SYNCFS,		"FUSE_SYNCFS")		\
 	EM( FUSE_TMPFILE,		"FUSE_TMPFILE")		\
 	EM( FUSE_STATX,			"FUSE_STATX")		\
+	EM( FUSE_IOMAP_CONFIG,		"FUSE_IOMAP_CONFIG")	\
 	EM( FUSE_IOMAP_BEGIN,		"FUSE_IOMAP_BEGIN")	\
 	EM( FUSE_IOMAP_END,		"FUSE_IOMAP_END")	\
 	EM( FUSE_IOMAP_IOEND,		"FUSE_IOMAP_IOEND")	\
@@ -344,6 +345,14 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
 	{ IOMAP_IOEND_BOUNDARY,			"boundary" }, \
 	{ IOMAP_IOEND_DIRECT,			"direct" }
 
+#define FUSE_IOMAP_CONFIG_STRINGS \
+	{ FUSE_IOMAP_CONFIG_SID,		"sid" }, \
+	{ FUSE_IOMAP_CONFIG_UUID,		"uuid" }, \
+	{ FUSE_IOMAP_CONFIG_BLOCKSIZE,		"blocksize" }, \
+	{ FUSE_IOMAP_CONFIG_MAX_LINKS,		"max_links" }, \
+	{ FUSE_IOMAP_CONFIG_TIME,		"time" }, \
+	{ FUSE_IOMAP_CONFIG_MAXBYTES,		"maxbytes" }
+
 DECLARE_EVENT_CLASS(fuse_iomap_check_class,
 	TP_PROTO(const char *func, int line, const char *condition),
 
@@ -1069,6 +1078,45 @@ DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_read);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_write);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_iomap);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_srcmap);
+
+TRACE_EVENT(fuse_iomap_config,
+	TP_PROTO(const struct fuse_mount *fm,
+		 const struct fuse_iomap_config_out *outarg),
+	TP_ARGS(fm, outarg),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+
+		__field(uint64_t,		flags)
+		__field(uint32_t,		blocksize)
+		__field(uint32_t,		max_links)
+		__field(uint32_t,		time_gran)
+
+		__field(int64_t,		time_min)
+		__field(int64_t,		time_max)
+		__field(int64_t,		maxbytes)
+		__field(uint8_t,		uuid_len)
+	),
+
+	TP_fast_assign(
+		__entry->connection	=	fm->fc->dev;
+		__entry->flags		=	outarg->flags;
+		__entry->blocksize	=	outarg->s_blocksize;
+		__entry->max_links	=	outarg->s_max_links;
+		__entry->time_gran	=	outarg->s_time_gran;
+		__entry->time_min	=	outarg->s_time_min;
+		__entry->time_max	=	outarg->s_time_max;
+		__entry->maxbytes	=	outarg->s_maxbytes;
+		__entry->uuid_len	=	outarg->s_uuid_len;
+	),
+
+	TP_printk("connection %u flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u",
+		  __entry->connection,
+		  __print_flags_u64(__entry->flags, "|", FUSE_IOMAP_CONFIG_STRINGS),
+		  __entry->blocksize, __entry->max_links, __entry->time_gran,
+		  __entry->time_min, __entry->time_max, __entry->maxbytes,
+		  __entry->uuid_len)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 06d8832401de8f..ac45a0912c9065 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1028,6 +1028,8 @@ static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
 		return error;
 	}
 
+	trace_fuse_iomap_config(fm, outarg);
+
 	if (BAD_DATA(outarg->flags & ~FUSE_IOMAP_CONFIG_ALL))
 		return -EINVAL;
 

