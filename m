Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833E83E3D96;
	Tue, 19 May 2026 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229764; cv=none; b=EBVYAf1xw9k55jYL0f/jIS8Cemizco1Mpc/QW4VDtazAGq/WB36hceMgvTysF8GJfAbIXXCYjGzxEcXxAjeOAwfsxC5YAnCL0uufL2H4HC/EQss5FJiD0XunQDD4BMFcLKTb6u+e5b5lqwGH/4J7x7n+MpfggKf6ef/AEn5kMuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229764; c=relaxed/simple;
	bh=w27PbJ9BOWtYHd7ZDTtQz1K/nJOnd3oZYlCftQqsFHY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHKSiTCJypnqlDgMLxkLy1OVgypsjPTM9gnMUBrrwarejMP8HHSxAXtsYLdN8J4sozztOkwGB6/y/1QIawEkn4T9zw58BQTaZsGrGTm02jpA3noX007uCusWasj3KHyi+JEP4q5g2gseEl7btvtw6y8i3QxItEIwEtb9J1Mwq0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDnBDaf7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDnBDaf7"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 169D61F000E9;
	Tue, 19 May 2026 22:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229763;
	bh=29bniuCBizg14pTh0H5G5W94oQFavim/xF78ESU1Qjg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=BDnBDaf7zZuLfKjvlOdzEZvYYTsD834CAOEtytGgHJCW/TXt5lU+/whoAUOJ5nYVx
	 NYfy7mS/b78bPXn8CrKq87pK6qVFI5v9lGoUf7Yn+J6m5xoNS3bMkF5kIojUJqQjkh
	 T2LLxiLJf2Y27Yzp5p0MJ3RVJLGeMUxwJtKEXt6CLSBjPCSTjD1GhooLmuEAxYclmz
	 p3XpseJcKZkJ6UTgng4lb6b8BhdBZXuctup7fTLl41ko1RnzuZfiZVxulY7klnhSKf
	 HOTKP3nf9WPvvc8lEucBTINIAh7N+nUPCo62k/6NNfJQFo3Ss1IzsIQwoJzpX8GG/P
	 g+c47OqoXvpKA==
Date: Tue, 19 May 2026 15:29:22 -0700
Subject: [PATCH 11/11] fuse_trace: implement basic iomap reporting such as
 FIEMAP and SEEK_{DATA,HOLE}
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945478.2436837.14224740679039785168.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c |    4 ++++
 2 files changed, 50 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 21316c5fa890d6..10e263732305c0 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -507,6 +507,52 @@ DEFINE_EVENT(fuse_inode_state_class, name,	\
 	TP_ARGS(inode))
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_init_inode);
 DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_evict_inode);
+
+TRACE_EVENT(fuse_iomap_fiemap,
+	TP_PROTO(const struct inode *inode, u64 start, u64 count,
+		unsigned int flags),
+
+	TP_ARGS(inode, start, count, flags),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned int,		flags)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	start;
+		__entry->length		=	count;
+		__entry->flags		=	flags;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT("fiemap") " flags 0x%x",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->flags)
+);
+
+TRACE_EVENT(fuse_iomap_lseek,
+	TP_PROTO(const struct inode *inode, loff_t offset, int whence),
+
+	TP_ARGS(inode, offset, whence),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(loff_t,			offset)
+		__field(int,			whence)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->whence		=	whence;
+	),
+
+	TP_printk(FUSE_INODE_FMT " offset 0x%llx whence %d",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->offset,
+		  __entry->whence)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 9ac3fc86ceb623..3c6bf865ff4d43 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -717,6 +717,8 @@ int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!fuse_allow_current_process(fc))
 		return -EACCES;
 
+	trace_fuse_iomap_fiemap(inode, start, count, fieinfo->fi_flags);
+
 	inode_lock_shared(inode);
 	error = iomap_fiemap(inode, fieinfo, start, count, &fuse_iomap_ops);
 	inode_unlock_shared(inode);
@@ -745,6 +747,8 @@ loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
 	if (!fuse_allow_current_process(fc))
 		return -EACCES;
 
+	trace_fuse_iomap_lseek(inode, offset, whence);
+
 	switch (whence) {
 	case SEEK_HOLE:
 		offset = iomap_seek_hole(inode, offset, &fuse_iomap_ops);

