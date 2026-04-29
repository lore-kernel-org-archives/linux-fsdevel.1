Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B12D8DD6;
	Wed, 29 Apr 2026 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473452; cv=none; b=CJe2RWuox6CcYtAiUUcTJOiBHqKc2NgS149rrUy9M6S+w/k0bdrZUF0NnB6bC57SCMpKlYo6LPpY3mVvIBMmHVjx9mLxw9tAysRfdr2KwraFI1D4wT0XBfluP+ZUh8OpGUIJo+3VePwpBbn0FQRKsePTdADsSafLFsfVfLGWvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473452; c=relaxed/simple;
	bh=UsN13AakElsARPlSi9oeUBmDEkHmLt3qtF9vmDtAO5I=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6Dee+UTBZecToKOyLhk8N/PBCYz8nyX867y7KoYoDGQ7josBiFZO9JgN9tYlkdLxltD2wpWOl2v8cVynDv67UfHYD7kriC0+uLDmGgTYKuPASQGa5k0YV6yChZ0qaQ+lcj8JfZ2ItELJY8AJiLI7SIygavt6pLM7zZfI6ebKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwyt7xIr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwyt7xIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920BFC19425;
	Wed, 29 Apr 2026 14:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473451;
	bh=UsN13AakElsARPlSi9oeUBmDEkHmLt3qtF9vmDtAO5I=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fwyt7xIr5WH5A3vAlr9nKS4jVNGHQwKKzFxGH21ZA9t93EdSEjroGOwRBf5Ah2pPm
	 WZI6WxKITNPPykBcP3uqoOuKnnoSIw6dX4EhzO1wJRsVtmccdE8hI7TORYulaLXwYQ
	 JtjrgwijFZCBfE3NzeET2NDzSYUMVMtmaWnDHQeBpzCX+hnWuPq/UO5oNF6ZGVhsJq
	 +S+drUo+i+x6wmV7YErbRg2+GJk9uRzQBWNYrwyYlR4vA1W2hn2goxMo89AEuqKnHd
	 CFpiGpiIDdM0Vb46VkzC2FVQrtLH4e3YYClnZEfmsqzuMs/xkAPtMVP/H4rl6Wb6JS
	 5UjH7V3Axf/eg==
Date: Wed, 29 Apr 2026 07:37:31 -0700
Subject: [PATCH 08/12] fuse_trace: enable iomap cache management
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747207170.4103699.16847913218365817386.stgit@frogsfrogsfrogs>
In-Reply-To: <177747206929.4103699.18256961856283014867.stgit@frogsfrogsfrogs>
References: <177747206929.4103699.18256961856283014867.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c |    4 +++
 2 files changed, 71 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index ddcbefd33a4024..09da9bce61b98c 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -405,6 +405,7 @@ struct fuse_iomap_lookup;
 #define FUSE_IOMAP_TYPE_STRINGS \
 	{ FUSE_IOMAP_TYPE_PURE_OVERWRITE,	"overwrite" }, \
 	{ FUSE_IOMAP_TYPE_RETRY_CACHE,		"retry" }, \
+	{ FUSE_IOMAP_TYPE_NOCACHE,		"nocache" }, \
 	{ FUSE_IOMAP_TYPE_HOLE,			"hole" }, \
 	{ FUSE_IOMAP_TYPE_DELALLOC,		"delalloc" }, \
 	{ FUSE_IOMAP_TYPE_MAPPED,		"mapped" }, \
@@ -1563,6 +1564,72 @@ TRACE_EVENT(fuse_iomap_invalid,
 		  __entry->old_validity_cookie,
 		  __entry->validity_cookie)
 );
+
+TRACE_EVENT(fuse_iomap_upsert_mappings,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_upsert_mappings_out *outarg),
+	TP_ARGS(inode, outarg),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(uint64_t,		attr_ino)
+
+		FUSE_IOMAP_MAP_FIELDS(read)
+		FUSE_IOMAP_MAP_FIELDS(write)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->attr_ino	=	outarg->attr_ino;
+		__entry->readoffset	=	outarg->read.offset;
+		__entry->readlength	=	outarg->read.length;
+		__entry->readaddr	=	outarg->read.addr;
+		__entry->readtype	=	outarg->read.type;
+		__entry->readflags	=	outarg->read.flags;
+		__entry->readdev	=	outarg->read.dev;
+		__entry->writeoffset	=	outarg->write.offset;
+		__entry->writelength	=	outarg->write.length;
+		__entry->writeaddr	=	outarg->write.addr;
+		__entry->writetype	=	outarg->write.type;
+		__entry->writeflags	=	outarg->write.flags;
+		__entry->writedev	=	outarg->write.dev;
+	),
+
+	TP_printk(FUSE_INODE_FMT " attr_ino 0x%llx" FUSE_IOMAP_MAP_FMT("read") FUSE_IOMAP_MAP_FMT("write"),
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->attr_ino,
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(read),
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(write))
+);
+
+TRACE_EVENT(fuse_iomap_inval_mappings,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_inval_mappings_out *outarg),
+	TP_ARGS(inode, outarg),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(uint64_t,		attr_ino)
+
+		FUSE_FILE_RANGE_FIELDS(read)
+		FUSE_FILE_RANGE_FIELDS(write)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->attr_ino	=	outarg->attr_ino;
+		__entry->readoffset	=	outarg->read.offset;
+		__entry->readlength	=	outarg->read.length;
+		__entry->writeoffset	=	outarg->write.offset;
+		__entry->writelength	=	outarg->write.length;
+	),
+
+	TP_printk(FUSE_INODE_FMT " attr_ino 0x%llx" FUSE_FILE_RANGE_FMT("read") FUSE_FILE_RANGE_FMT("write"),
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->attr_ino,
+		  FUSE_FILE_RANGE_PRINTK_ARGS(read),
+		  FUSE_FILE_RANGE_PRINTK_ARGS(write))
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 8e747084d81b28..075fa62f856495 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -2792,6 +2792,8 @@ int fuse_iomap_upsert_mappings(struct fuse_conn *fc,
 		goto out_sb;
 	}
 
+	trace_fuse_iomap_upsert_mappings(inode, outarg);
+
 	fi = get_fuse_inode(inode);
 	if (BAD_DATA(fi->orig_ino != outarg->attr_ino)) {
 		ret = -EINVAL;
@@ -2879,6 +2881,8 @@ int fuse_iomap_inval_mappings(struct fuse_conn *fc,
 		goto out_sb;
 	}
 
+	trace_fuse_iomap_inval_mappings(inode, outarg);
+
 	fi = get_fuse_inode(inode);
 	if (BAD_DATA(fi->orig_ino != outarg->attr_ino)) {
 		ret = -EINVAL;

