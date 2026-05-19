Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10262F7EF5;
	Tue, 19 May 2026 22:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229857; cv=none; b=EHMWLIxvIFEcC/v8UwjuTMAudNa1QYjhu+D8vpQO5lnEM9DO0ydO//xY0u8sELvygFezcEFXs5CjASS2jmmdWBpar2LX2XK53YnY//rpQdyGVb0djg8VGVwchjsX64S4fuy1ZgDI0d+YNqTi/kUrLWT3sZ5ikSZBRw5y/DyTJuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229857; c=relaxed/simple;
	bh=1cv5XllHb6+k6xgHx0ML1cB0WxSup9JdHmVfVuBKqfA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZU3DPj/k7Qlw6qgiqdL6pqVQTv6B4GEFz8rz4GnB+fRHCBKvzx+7IVcFLLHAX8yYy5jV0F8TXBmX14LBBr9Li6uZyHAyNmvW1z+K2551rQaCzGe6bMbeWLgeRziz0jDd/VpW2GGAV7h+fZHrFCldbqoYrxgLUpHKd1ae9+zWWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6F8h2ka; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6F8h2ka"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4822B1F000E9;
	Tue, 19 May 2026 22:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229856;
	bh=PnH/Ne7zRj9frcNs7YtbD/H0YETp1l+gstK6nvuJW0k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=J6F8h2kayu7niSo7ch43b1w7ZDIw5ixPlLOaLrS2BW7sKSsztDsqeL3FwKYs5y5S8
	 5UBz8ksfiSjoAIelZ1NyEHjCjbXHcqkSvgFHjMIeItOOVTCYCv5T5pegkqiXJzT+FK
	 6COffrSIO0aSVbJ6mpiXWWv+q/S5qC/qSYnNWJ4JwwKWMoXbBBHLlOZ4VT6McleSlA
	 4yGmpoVAuXCmLAk7us9KI2KcL5JOSMzhNDhLRseMMpvNNMEMFz3+w8Rd8z2x3K+BK4
	 gMznbi/5SncMTEyhOrGR7MJzgVnUERdTwIS6v7DcKDOPsVyyYFpbrZLyevZr6u71I7
	 j3Z9yMFavxXhw==
Date: Tue, 19 May 2026 15:30:55 -0700
Subject: [PATCH 6/6] fuse_trace: implement inline data file IO via iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945870.2437300.17267207577935090349.stgit@frogsfrogsfrogs>
In-Reply-To: <177922945706.2437300.14187386529698019759.stgit@frogsfrogsfrogs>
References: <177922945706.2437300.14187386529698019759.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   43 +++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c |    7 +++++++
 2 files changed, 50 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index f1dab22d41636f..62641046138a10 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -227,6 +227,7 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
 struct iomap_writepage_ctx;
 struct iomap_ioend;
+struct iomap;
 
 /* tracepoint boilerplate so we don't have to keep doing this */
 #define FUSE_IOMAP_OPFLAGS_FIELD \
@@ -1026,6 +1027,48 @@ TRACE_EVENT(fuse_iomap_fallocate,
 		  __entry->mode,
 		  __entry->newsize)
 );
+
+DECLARE_EVENT_CLASS(fuse_iomap_inline_class,
+	TP_PROTO(const struct inode *inode, loff_t pos, uint64_t count,
+		 const struct iomap *map),
+	TP_ARGS(inode, pos, count, map),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(uint64_t,		mapoffset)
+		__field(uint64_t,		maplength)
+		__field(bool,			has_buf)
+		__field(uint64_t,		validity_cookie)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	pos;
+		__entry->length		=	count;
+
+		__entry->mapoffset	=	map->offset;
+		__entry->maplength	=	map->length;
+
+		__entry->has_buf	=	map->inline_data != NULL;
+		__entry->validity_cookie=	map->validity_cookie;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() "offset 0x%llx length 0x%llx has_buf? %d cookie 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->mapoffset,
+		  __entry->maplength,
+		  __entry->has_buf,
+		  __entry->validity_cookie)
+);
+#define DEFINE_FUSE_IOMAP_INLINE_EVENT(name)	\
+DEFINE_EVENT(fuse_iomap_inline_class, name,	\
+	TP_PROTO(const struct inode *inode, loff_t pos, uint64_t count, \
+		 const struct iomap *map), \
+	TP_ARGS(inode, pos, count, map))
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_read);
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_write);
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_iomap);
+DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_srcmap);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 8d8a1bc2c4bfe5..01cb3b709ddbd5 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -464,6 +464,8 @@ static int fuse_iomap_inline_read(struct inode *inode, loff_t pos,
 	FUSE_ARGS(args);
 	ssize_t ret;
 
+	trace_fuse_iomap_inline_read(inode, pos, count, iomap);
+
 	args.opcode = FUSE_READ;
 	args.nodeid = fi->nodeid;
 	args.in_numargs = 1;
@@ -522,6 +524,8 @@ static ssize_t fuse_iomap_inline_write(struct inode *inode, loff_t pos,
 		args.out_args[0].size = sizeof(out);
 		args.out_args[0].value = &out;
 
+		trace_fuse_iomap_inline_write(inode, pos, written, iomap);
+
 		ret = fuse_simple_request(fm, &args);
 		if (ret == -ENOSYS)
 			ret = 0;
@@ -588,6 +592,9 @@ static int fuse_iomap_set_inline(struct inode *inode, unsigned opflags,
 			goto out_iomap;
 	}
 
+	trace_fuse_iomap_set_inline_iomap(inode, pos, count, iomap);
+	trace_fuse_iomap_set_inline_srcmap(inode, pos, count, srcmap);
+
 	return 0;
 
 out_srcmap:

