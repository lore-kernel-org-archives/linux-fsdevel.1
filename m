Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE723EDAC6;
	Tue, 19 May 2026 22:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229624; cv=none; b=JXtR+yWCVk0KMv+mhRPDbWThMGZMQir34dElPSVuDH9Em3nWEA8wtsIdp0xAI9cqmOksjrHPTutyEP+di3ougAnwK72VOL4s70yf0Kf0CglPztRjYla9KPnqxxeq8dQAGt2BECjwcI2Tz1VzNMsygdswr82/4F76/kVqimPWsDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229624; c=relaxed/simple;
	bh=/VIk0aFd9FfR2/q8JEX5SDAWHjdoadmDiglSGrXzSAE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pucabDpoMJGP1hLA7lDzZmcr968q7ToIIs6/45LwEvaIb6t9sPN1Oz8RRnUIV6sO06IBA+H+Ar4OApftNyn7pGV5jPyQrs6x0Ka1+BknB/SImmBvi+h/Zd+EwnxxzxfdGJAT2ce0id4nMQ+ty6Mr2LlOq/GScSjeCVsdGaYBn0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrifLMwU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrifLMwU"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 01EF11F00893;
	Tue, 19 May 2026 22:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229623;
	bh=h8vnHX0aW/i2y+8rMo2/XxmiU/CYCIqdee1MKRYDzvQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=MrifLMwUWVo0swOfIAarBjp62ZO0RaANhR+nilMboDsXe8891Mp+rHSmC6czukM9a
	 82y/Z8w740MkEbU2b7b3bCETYZaw8CLYV+puwJDSGYIi77qElLOQaQvMkBjwgDdGxt
	 og9bErlX8RnxwWHsXHeYBJQTOpNa09zNbRZI9F0XE28Jo5B5PDp5xYU9xRWGjZdjEp
	 bo1fI6ScjzeiTOCZFz43D7TgEgsY4o15HsoI8M/K1GTRsAqc06VXAAUUvVlVv+tAwl
	 quWORUvc/HiBQmuTa2DNtWn2KTxWduXFw0IDm2vqsCwcvMgRAtL7L/0+p2Ng58t1i9
	 jIMpwQiLWiSSQ==
Date: Tue, 19 May 2026 15:27:02 -0700
Subject: [PATCH 02/11] fuse_trace: implement the basic iomap mechanisms
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945285.2436837.12912575526469053005.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_iomap_i.h |    6 +
 fs/fuse/fuse_trace.h   |  295 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c   |   15 ++
 3 files changed, 314 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_iomap_i.h b/fs/fuse/fuse_iomap_i.h
index 2897049637fad2..b9ab8ce140e8e1 100644
--- a/fs/fuse/fuse_iomap_i.h
+++ b/fs/fuse/fuse_iomap_i.h
@@ -10,16 +10,22 @@
 #if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
 # define ASSERT(condition) do {						\
 	int __cond = !!(condition);					\
+	if (unlikely(!__cond))						\
+		trace_fuse_iomap_assert(__func__, __LINE__, #condition); \
 	WARN(!__cond, "Assertion failed: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
 } while (0)
 # define BAD_DATA(condition) ({						\
 	int __cond = !!(condition);					\
+	if (unlikely(__cond))						\
+		trace_fuse_iomap_bad_data(__func__, __LINE__, #condition); \
 	WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
 })
 #else
 # define ASSERT(condition)
 # define BAD_DATA(condition) ({						\
 	int __cond = !!(condition);					\
+	if (unlikely(__cond))						\
+		trace_fuse_iomap_bad_data(__func__, __LINE__, #condition); \
 	unlikely(__cond);						\
 })
 #endif /* CONFIG_FUSE_IOMAP_DEBUG */
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 3b28ec736d4d60..2fcff2c46a9733 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -58,6 +58,8 @@
 	EM( FUSE_SYNCFS,		"FUSE_SYNCFS")		\
 	EM( FUSE_TMPFILE,		"FUSE_TMPFILE")		\
 	EM( FUSE_STATX,			"FUSE_STATX")		\
+	EM( FUSE_IOMAP_BEGIN,		"FUSE_IOMAP_BEGIN")	\
+	EM( FUSE_IOMAP_END,		"FUSE_IOMAP_END")	\
 	EMe(CUSE_INIT,			"CUSE_INIT")
 
 /*
@@ -77,6 +79,54 @@ OPCODES
 #define EM(a, b)	{a, b},
 #define EMe(a, b)	{a, b}
 
+/* tracepoint boilerplate so we don't have to keep doing this */
+#define FUSE_INODE_FIELDS \
+		__field(dev_t,			connection) \
+		__field(uint64_t,		ino) \
+		__field(uint64_t,		nodeid) \
+		__field(loff_t,			isize)
+
+#define FUSE_INODE_ASSIGN(inode, fi, fm) \
+		const struct fuse_inode *fi = get_fuse_inode(inode); \
+		const struct fuse_mount *fm = get_fuse_mount(inode); \
+\
+		__entry->connection	=	(fm)->fc->dev; \
+		__entry->ino		=	(fi)->orig_ino; \
+		__entry->nodeid		=	(fi)->nodeid; \
+		__entry->isize		=	i_size_read(inode)
+
+#define FUSE_INODE_FMT \
+		"connection %u ino %llu nodeid %llu isize 0x%llx"
+
+#define FUSE_INODE_PRINTK_ARGS \
+		__entry->connection, \
+		__entry->ino, \
+		__entry->nodeid, \
+		__entry->isize
+
+#define FUSE_FILE_RANGE_FIELDS(prefix) \
+		__field(loff_t,			prefix##offset) \
+		__field(loff_t,			prefix##length)
+
+#define FUSE_FILE_RANGE_FMT(prefix) \
+		" " prefix "pos 0x%llx length 0x%llx"
+
+#define FUSE_FILE_RANGE_PRINTK_ARGS(prefix) \
+		__entry->prefix##offset, \
+		__entry->prefix##length
+
+/* combinations of boilerplate to reduce typing further */
+#define FUSE_IO_RANGE_FIELDS(prefix) \
+		FUSE_INODE_FIELDS \
+		FUSE_FILE_RANGE_FIELDS(prefix)
+
+#define FUSE_IO_RANGE_FMT(prefix) \
+		FUSE_INODE_FMT FUSE_FILE_RANGE_FMT(prefix)
+
+#define FUSE_IO_RANGE_PRINTK_ARGS(prefix) \
+		FUSE_INODE_PRINTK_ARGS, \
+		FUSE_FILE_RANGE_PRINTK_ARGS(prefix)
+
 TRACE_EVENT(fuse_request_send,
 	TP_PROTO(const struct fuse_req *req),
 
@@ -157,6 +207,251 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_open);
 DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 #endif /* CONFIG_FUSE_BACKING */
 
+#if IS_ENABLED(CONFIG_FUSE_IOMAP)
+
+/* tracepoint boilerplate so we don't have to keep doing this */
+#define FUSE_IOMAP_OPFLAGS_FIELD \
+		__field(unsigned,		opflags)
+
+#define FUSE_IOMAP_OPFLAGS_FMT \
+		" opflags (%s)"
+
+#define FUSE_IOMAP_OPFLAGS_PRINTK_ARG \
+		__print_flags(__entry->opflags, "|", FUSE_IOMAP_OP_STRINGS)
+
+#define FUSE_IOMAP_MAP_FIELDS(prefix) \
+		__field(uint64_t,		prefix##offset) \
+		__field(uint64_t,		prefix##length) \
+		__field(uint64_t,		prefix##addr) \
+		__field(uint32_t,		prefix##dev) \
+		__field(uint16_t,		prefix##type) \
+		__field(uint16_t,		prefix##flags)
+
+#define FUSE_IOMAP_MAP_FMT(prefix) \
+		" " prefix "offset 0x%llx length 0x%llx type %s dev %u addr 0x%llx mapflags (%s)"
+
+#define FUSE_IOMAP_MAP_PRINTK_ARGS(prefix) \
+		__entry->prefix##offset, \
+		__entry->prefix##length, \
+		__print_symbolic(__entry->prefix##type, FUSE_IOMAP_TYPE_STRINGS), \
+		__entry->prefix##dev, \
+		__entry->prefix##addr, \
+		__print_flags(__entry->prefix##flags, "|", FUSE_IOMAP_F_STRINGS)
+
+/* combinations of boilerplate to reduce typing further */
+#define FUSE_IOMAP_OP_FIELDS(prefix) \
+		FUSE_INODE_FIELDS \
+		FUSE_IOMAP_OPFLAGS_FIELD \
+		FUSE_FILE_RANGE_FIELDS(prefix)
+
+#define FUSE_IOMAP_OP_FMT(prefix) \
+		FUSE_INODE_FMT FUSE_IOMAP_OPFLAGS_FMT FUSE_FILE_RANGE_FMT(prefix)
+
+#define FUSE_IOMAP_OP_PRINTK_ARGS(prefix) \
+		FUSE_INODE_PRINTK_ARGS, \
+		FUSE_IOMAP_OPFLAGS_PRINTK_ARG, \
+		FUSE_FILE_RANGE_PRINTK_ARGS(prefix)
+
+/* string decoding */
+#define FUSE_IOMAP_F_STRINGS \
+	{ FUSE_IOMAP_F_NEW,			"new" }, \
+	{ FUSE_IOMAP_F_DIRTY,			"dirty" }, \
+	{ FUSE_IOMAP_F_SHARED,			"shared" }, \
+	{ FUSE_IOMAP_F_MERGED,			"merged" }, \
+	{ FUSE_IOMAP_F_BOUNDARY,		"boundary" }, \
+	{ FUSE_IOMAP_F_ANON_WRITE,		"anon_write" }, \
+	{ FUSE_IOMAP_F_ATOMIC_BIO,		"atomic" }, \
+	{ FUSE_IOMAP_F_WANT_IOMAP_END,		"iomap_end" }, \
+	{ FUSE_IOMAP_F_SIZE_CHANGED,		"append" }, \
+	{ FUSE_IOMAP_F_STALE,			"stale" }
+
+#define FUSE_IOMAP_OP_STRINGS \
+	{ FUSE_IOMAP_OP_WRITE,			"write" }, \
+	{ FUSE_IOMAP_OP_ZERO,			"zero" }, \
+	{ FUSE_IOMAP_OP_REPORT,			"report" }, \
+	{ FUSE_IOMAP_OP_FAULT,			"fault" }, \
+	{ FUSE_IOMAP_OP_DIRECT,			"direct" }, \
+	{ FUSE_IOMAP_OP_NOWAIT,			"nowait" }, \
+	{ FUSE_IOMAP_OP_OVERWRITE_ONLY,		"overwrite" }, \
+	{ FUSE_IOMAP_OP_UNSHARE,		"unshare" }, \
+	{ FUSE_IOMAP_OP_DAX,			"fsdax" }, \
+	{ FUSE_IOMAP_OP_ATOMIC,			"atomic" }, \
+	{ FUSE_IOMAP_OP_DONTCACHE,		"dontcache" }
+
+#define FUSE_IOMAP_TYPE_STRINGS \
+	{ FUSE_IOMAP_TYPE_PURE_OVERWRITE,	"overwrite" }, \
+	{ FUSE_IOMAP_TYPE_HOLE,			"hole" }, \
+	{ FUSE_IOMAP_TYPE_DELALLOC,		"delalloc" }, \
+	{ FUSE_IOMAP_TYPE_MAPPED,		"mapped" }, \
+	{ FUSE_IOMAP_TYPE_UNWRITTEN,		"unwritten" }, \
+	{ FUSE_IOMAP_TYPE_INLINE,		"inline" }
+
+DECLARE_EVENT_CLASS(fuse_iomap_check_class,
+	TP_PROTO(const char *func, int line, const char *condition),
+
+	TP_ARGS(func, line, condition),
+
+	TP_STRUCT__entry(
+		__string(func,			func)
+		__field(int,			line)
+		__string(condition,		condition)
+	),
+
+	TP_fast_assign(
+		__assign_str(func);
+		__assign_str(condition);
+		__entry->line		=	line;
+	),
+
+	TP_printk("func %s line %d condition %s", __get_str(func),
+		  __entry->line, __get_str(condition))
+);
+#define DEFINE_FUSE_IOMAP_CHECK_EVENT(name)	\
+DEFINE_EVENT(fuse_iomap_check_class, name,	\
+	TP_PROTO(const char *func, int line, const char *condition), \
+	TP_ARGS(func, line, condition))
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
+DEFINE_FUSE_IOMAP_CHECK_EVENT(fuse_iomap_assert);
+#endif
+DEFINE_FUSE_IOMAP_CHECK_EVENT(fuse_iomap_bad_data);
+
+TRACE_EVENT(fuse_iomap_begin,
+	TP_PROTO(const struct inode *inode, loff_t pos, loff_t count,
+		 unsigned opflags),
+
+	TP_ARGS(inode, pos, count, opflags),
+
+	TP_STRUCT__entry(
+		FUSE_IOMAP_OP_FIELDS()
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	pos;
+		__entry->length		=	count;
+		__entry->opflags	=	opflags;
+	),
+
+	TP_printk(FUSE_IOMAP_OP_FMT(),
+		  FUSE_IOMAP_OP_PRINTK_ARGS())
+);
+
+TRACE_EVENT(fuse_iomap_begin_error,
+	TP_PROTO(const struct inode *inode, loff_t pos, loff_t count,
+		 unsigned opflags, int error),
+
+	TP_ARGS(inode, pos, count, opflags, error),
+
+	TP_STRUCT__entry(
+		FUSE_IOMAP_OP_FIELDS()
+		__field(int,			error)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	pos;
+		__entry->length		=	count;
+		__entry->opflags	=	opflags;
+		__entry->error		=	error;
+	),
+
+	TP_printk(FUSE_IOMAP_OP_FMT() " err %d",
+		  FUSE_IOMAP_OP_PRINTK_ARGS(),
+		  __entry->error)
+);
+
+DECLARE_EVENT_CLASS(fuse_iomap_mapping_class,
+	TP_PROTO(const struct inode *inode, const struct fuse_iomap_io *map),
+
+	TP_ARGS(inode, map),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		FUSE_IOMAP_MAP_FIELDS(map)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->mapoffset	=	map->offset;
+		__entry->maplength	=	map->length;
+		__entry->mapdev		=	map->dev;
+		__entry->mapaddr	=	map->addr;
+		__entry->maptype	=	map->type;
+		__entry->mapflags	=	map->flags;
+	),
+
+	TP_printk(FUSE_INODE_FMT FUSE_IOMAP_MAP_FMT(),
+		  FUSE_INODE_PRINTK_ARGS,
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(map))
+);
+#define DEFINE_FUSE_IOMAP_MAPPING_EVENT(name)	\
+DEFINE_EVENT(fuse_iomap_mapping_class, name,	\
+	TP_PROTO(const struct inode *inode, const struct fuse_iomap_io *map), \
+	TP_ARGS(inode, map))
+DEFINE_FUSE_IOMAP_MAPPING_EVENT(fuse_iomap_read_map);
+DEFINE_FUSE_IOMAP_MAPPING_EVENT(fuse_iomap_write_map);
+
+TRACE_EVENT(fuse_iomap_end,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_end_in *inarg),
+
+	TP_ARGS(inode, inarg),
+
+	TP_STRUCT__entry(
+		FUSE_IOMAP_OP_FIELDS()
+		__field(size_t,			written)
+		FUSE_IOMAP_MAP_FIELDS(map)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->opflags	=	inarg->opflags;
+		__entry->written	=	inarg->written;
+		__entry->offset		=	inarg->pos;
+		__entry->length		=	inarg->count;
+
+		__entry->mapoffset	=	inarg->map.offset;
+		__entry->maplength	=	inarg->map.length;
+		__entry->mapdev		=	inarg->map.dev;
+		__entry->mapaddr	=	inarg->map.addr;
+		__entry->maptype	=	inarg->map.type;
+		__entry->mapflags	=	inarg->map.flags;
+	),
+
+	TP_printk(FUSE_IOMAP_OP_FMT() " written %zd" FUSE_IOMAP_MAP_FMT(),
+		  FUSE_IOMAP_OP_PRINTK_ARGS(),
+		  __entry->written,
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(map))
+);
+
+TRACE_EVENT(fuse_iomap_end_error,
+	TP_PROTO(const struct inode *inode,
+		 const struct fuse_iomap_end_in *inarg, int error),
+
+	TP_ARGS(inode, inarg, error),
+
+	TP_STRUCT__entry(
+		FUSE_IOMAP_OP_FIELDS()
+		__field(size_t,			written)
+		__field(int,			error)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	inarg->pos;
+		__entry->length		=	inarg->count;
+		__entry->opflags	=	inarg->opflags;
+		__entry->written	=	inarg->written;
+		__entry->error		=	error;
+	),
+
+	TP_printk(FUSE_IOMAP_OP_FMT() " written %zd error %d",
+		  FUSE_IOMAP_OP_PRINTK_ARGS(),
+		  __entry->written,
+		  __entry->error)
+);
+#endif /* CONFIG_FUSE_IOMAP */
+
 #endif /* _TRACE_FUSE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 9650c6452126ea..201577812d007f 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -338,6 +338,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	FUSE_ARGS(args);
 	int err;
 
+	trace_fuse_iomap_begin(inode, pos, count, opflags);
+
 	/* Not very useful until we can cache mappings in the kernel */
 	if (opflags & IOMAP_NOWAIT)
 		return -EAGAIN;
@@ -351,8 +353,13 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	args.out_args[0].size = sizeof(outarg);
 	args.out_args[0].value = &outarg;
 	err = fuse_simple_request(fm, &args);
-	if (err)
+	if (err) {
+		trace_fuse_iomap_begin_error(inode, pos, count, opflags, err);
 		return err;
+	}
+
+	trace_fuse_iomap_read_map(inode, &outarg.read);
+	trace_fuse_iomap_write_map(inode, &outarg.write);
 
 	err = fuse_iomap_begin_validate(inode, opflags, pos, &outarg);
 	if (err)
@@ -419,6 +426,8 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 
 		fuse_iomap_to_server(&inarg.map, iomap);
 
+		trace_fuse_iomap_end(inode, &inarg);
+
 		args.opcode = FUSE_IOMAP_END;
 		args.nodeid = get_node_id(inode);
 		args.in_numargs = 1;
@@ -432,8 +441,10 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 			 */
 			err = 0;
 		}
-		if (err)
+		if (err) {
+			trace_fuse_iomap_end_error(inode, &inarg, err);
 			return err;
+		}
 	}
 
 	return 0;

