Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397183358AF;
	Wed, 29 Apr 2026 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473045; cv=none; b=PHL3yye7FuhfsqiCOUgAG6GP5bQlwELsDzD4uZxBeYXc46L1bIVg7rAxbuoDT+3pfx+9og3Hjms5mM1gVPzf2g6wrr/YrAX6NUbTMlOfQ8ZH6GNp5ycPkjKGQ6+ts7Mr6Y1HnQ4dTiRUmVHlL47rWkvm8sEHbWzIc/vdXQnXsWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473045; c=relaxed/simple;
	bh=sLj9WKEkcPbzZXgSYrrzoDZC7gXIfrFoqQtxT+IbyJ4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+xFtV2fWb2RmgM0wAGOZdwLbaDsS0IU9x0UJvYQ1lB2Ciz5oCx3Z3c5HPEivTeHXJHN/i0u3baFmcNdL68H7XKRMdIRsTA8OPzYc4Qi61NiA6m6MqG5DIbC/npUMOgvRnrWuk+mEbWmcbqBEbGXtN84WSklTsergHmwbSyAcZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvHFA5Mh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvHFA5Mh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1389CC19425;
	Wed, 29 Apr 2026 14:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473045;
	bh=sLj9WKEkcPbzZXgSYrrzoDZC7gXIfrFoqQtxT+IbyJ4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=IvHFA5MhxdLSa4shXhh6NFHjfSNUcKKSVZvN70cPbidw+v67//ru1/IoQAuIU2jdP
	 6QP8yz7FDzBYf4ew67zz7+nQpGLTo6WcBnSc8oe8ymsqqCOW46dWVOCR2lYd+6c3kn
	 khIlTqg10Rv/8O9VjJSQCImFFHOyTe3SZzL8/30PIr2zoN652j+jI1/Zv5QChbvYVt
	 qv+07EAEEHA5MB9UZBpRMG8i7xcJ06KCuIquQiA65Cdy67M5JEJfs0UFn/+FvLUixN
	 EzROSE/Lyz2OwXv7q1gb1HJUFwSN3aZSAiBvOQmxG/kihfcKP9FrgCACIvvd3O8N0X
	 vzo/MoGuJLSKg==
Date: Wed, 29 Apr 2026 07:30:43 -0700
Subject: [PATCH 27/33] fuse_trace: implement inline data file IO via iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205728.4101881.16330195918071123208.stgit@frogsfrogsfrogs>
In-Reply-To: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c |    7 +++++++
 2 files changed, 52 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 0e4be645802055..d3352e75fa6bdf 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -230,6 +230,7 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
 struct iomap_writepage_ctx;
 struct iomap_ioend;
+struct iomap;
 
 /* tracepoint boilerplate so we don't have to keep doing this */
 #define FUSE_IOMAP_OPFLAGS_FIELD \
@@ -1079,6 +1080,50 @@ TRACE_EVENT(fuse_iomap_dev_inval,
 		  __entry->offset,
 		  __entry->length)
 );
+
+DECLARE_EVENT_CLASS(fuse_iomap_inline_class,
+	TP_PROTO(const struct inode *inode, loff_t pos, uint64_t count,
+		 const struct iomap *map),
+	TP_ARGS(inode, pos, count, map),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		FUSE_IOMAP_MAP_FIELDS(map)
+		__field(bool,			has_buf)
+		__field(uint64_t,		validity_cookie)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	pos;
+		__entry->length		=	count;
+
+		__entry->mapdev		=	FUSE_IOMAP_DEV_NULL;
+		__entry->mapaddr	=	map->addr;
+		__entry->mapoffset	=	map->offset;
+		__entry->maplength	=	map->length;
+		__entry->maptype	=	map->type;
+		__entry->mapflags	=	map->flags;
+
+		__entry->has_buf	=	map->inline_data != NULL;
+		__entry->validity_cookie=	map->validity_cookie;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT() FUSE_IOMAP_MAP_FMT() " has_buf? %d cookie 0x%llx",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(map),
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
index b9531ad5ab5180..8be8e49605bb85 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -435,6 +435,8 @@ static int fuse_iomap_inline_read(struct inode *inode, loff_t pos,
 		return -EFSCORRUPTED;
 	}
 
+	trace_fuse_iomap_inline_read(inode, pos, count, iomap);
+
 	args.opcode = FUSE_READ;
 	args.nodeid = fi->nodeid;
 	args.in_numargs = 1;
@@ -482,6 +484,8 @@ static int fuse_iomap_inline_write(struct inode *inode, loff_t pos,
 	if (BAD_DATA(!iomap_inline_data_valid(iomap)))
 		return -EFSCORRUPTED;
 
+	trace_fuse_iomap_inline_write(inode, pos, count, iomap);
+
 	args.opcode = FUSE_WRITE;
 	args.nodeid = fi->nodeid;
 	args.in_numargs = 2;
@@ -545,6 +549,9 @@ static int fuse_iomap_set_inline(struct inode *inode, unsigned opflags,
 			return err;
 	}
 
+	trace_fuse_iomap_set_inline_iomap(inode, pos, count, iomap);
+	trace_fuse_iomap_set_inline_srcmap(inode, pos, count, srcmap);
+
 	return 0;
 }
 

