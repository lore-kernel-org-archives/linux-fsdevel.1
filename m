Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EF53ACEE2;
	Tue, 19 May 2026 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229717; cv=none; b=qf23PzDVC2ZAtYKFhosiVTXWIEDv8/9d4s3sVh2uQo0UO1FWNAsfrQsvARqEdLpAQ8sosnl/xP/CI0wPhg45r6C5iz51wED/0TO6QULiQZgLL6HGKJgwww5nTWT475NxOMdSciR2my3QZKAFfNrgPctekbNt9z8XL2LxPmGVP5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229717; c=relaxed/simple;
	bh=jK7xInK1KZeS94Gp80nZIewSQF11EWxTMHgmXKhBNVI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=js9bq4zn+2pj709s3B6U0DQScVPkYFJz+iLVr3ijdxMfZApAtrEpR3nePlmlRZlrT/8eXCxxAh8Kq/vtqFaGGS+DxInTGfRhUgYLLsNX4ujo1XzT/N5e7K7hIpW1otcV5iDjaDfBpoKq5EmO1vt6JpXXu5F2T63OHENUN6IiZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmGFgIIQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmGFgIIQ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5D31F1F000E9;
	Tue, 19 May 2026 22:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229716;
	bh=a6NBIN9GAtxUHuM7B7aA57pZ1YwNRreBtDWCPTOYGmg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=AmGFgIIQQwWOB0HL+jZerqgsPhzNyOj+XwdilVV0WFDfQY8Kzqno1xxTzIF+ilLkE
	 9NJn69eOn4T5lr9qtgigL/tU4x5e1PUV0ylE8ZFRaEs2V/1SKKQL5pb+f53z030svq
	 c2eC9TYC8VrAsxwi4tfU4VYTSxoEBaPuhKMbcbpHFTXgUcf1IfGijKzio6HCSFCZx/
	 3RNkxmQwBtjLVhkfU8s9xj67yfO4yBWXdY66yYOaqtXh8isVObJY76fFOs3G+iwbRE
	 aBtTrVO2PjDERl/d47S/5+aCA5yNz+4OgTDbQU13LCtOblL253NucnqPmLIuPwLbyq
	 EhzG0OYG4AdsQ==
Date: Tue, 19 May 2026 15:28:36 -0700
Subject: [PATCH 08/11] fuse_trace: create a per-inode flag for toggling iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945414.2436837.7617653091116584847.stgit@frogsfrogsfrogs>
In-Reply-To: <177922945175.2436837.10366841596277424226.stgit@frogsfrogsfrogs>
References: <177922945175.2436837.10366841596277424226.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c |    8 +++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index e942480b9d5841..21316c5fa890d6 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -299,6 +299,25 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 	{ FUSE_IOMAP_TYPE_UNWRITTEN,		"unwritten" }, \
 	{ FUSE_IOMAP_TYPE_INLINE,		"inline" }
 
+TRACE_DEFINE_ENUM(FUSE_I_ADVISE_RDPLUS);
+TRACE_DEFINE_ENUM(FUSE_I_INIT_RDPLUS);
+TRACE_DEFINE_ENUM(FUSE_I_SIZE_UNSTABLE);
+TRACE_DEFINE_ENUM(FUSE_I_BAD);
+TRACE_DEFINE_ENUM(FUSE_I_BTIME);
+TRACE_DEFINE_ENUM(FUSE_I_CACHE_IO_MODE);
+TRACE_DEFINE_ENUM(FUSE_I_EXCLUSIVE);
+TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
+
+#define FUSE_IFLAG_STRINGS \
+	{ 1 << FUSE_I_ADVISE_RDPLUS,		"advise_rdplus" }, \
+	{ 1 << FUSE_I_INIT_RDPLUS,		"init_rdplus" }, \
+	{ 1 << FUSE_I_SIZE_UNSTABLE,		"size_unstable" }, \
+	{ 1 << FUSE_I_BAD,			"bad" }, \
+	{ 1 << FUSE_I_BTIME,			"btime" }, \
+	{ 1 << FUSE_I_CACHE_IO_MODE,		"cacheio" }, \
+	{ 1 << FUSE_I_EXCLUSIVE,		"excl" }, \
+	{ 1 << FUSE_I_IOMAP,			"iomap" }
+
 DECLARE_EVENT_CLASS(fuse_iomap_check_class,
 	TP_PROTO(const char *func, int line, const char *condition),
 
@@ -463,6 +482,31 @@ TRACE_EVENT(fuse_iomap_end_error,
 		  __entry->written,
 		  __entry->error)
 );
+
+DECLARE_EVENT_CLASS(fuse_inode_state_class,
+	TP_PROTO(const struct inode *inode),
+	TP_ARGS(inode),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(unsigned long,		state)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->state		=	fi->state;
+	),
+
+	TP_printk(FUSE_INODE_FMT " state (%s)",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __print_flags(__entry->state, "|", FUSE_IFLAG_STRINGS))
+);
+#define DEFINE_FUSE_INODE_STATE_EVENT(name)	\
+DEFINE_EVENT(fuse_inode_state_class, name,	\
+	TP_PROTO(const struct inode *inode),	\
+	TP_ARGS(inode))
+DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_init_inode);
+DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_evict_inode);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 3e8eb9642f1adb..b6d2fe11c0e17b 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -675,15 +675,21 @@ void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr)
 		return;
 	}
 
-	if (!S_ISREG(inode->i_mode))
+	if (!S_ISREG(inode->i_mode)) {
+		trace_fuse_iomap_init_inode(inode);
 		return;
+	}
 
 	fuse_inode_set_iomap(inode);
+
+	trace_fuse_iomap_init_inode(inode);
 }
 
 void fuse_iomap_evict_inode(struct inode *inode)
 {
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_evict_inode(inode);
+
 	fuse_inode_clear_iomap(inode);
 }

