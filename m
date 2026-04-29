Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5647C33D4E8;
	Wed, 29 Apr 2026 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472966; cv=none; b=PK9YwlHZfj/3JjrsHzWf7k/h4BQ5YDx/ZL4VNvdegf1zJjdg0/tdNCxJBnzkvgRlP+ywU9xhNYVu4ThTYtaADLSangfO/qt8euVmqMZnc0+vvNmykzXCn/5Kz+STB57PPzx1EfuQiTGLJjGZCML+w+JvZx7RvxRDA0J/es27Fe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472966; c=relaxed/simple;
	bh=WyFOz4ZUbeAoE3OiaPQ3zOOGuVceItkvbgEvh5ckqkU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stk6CtaQ2KCCsCZZyL1Ul8yNcA5lDVPsWcjoXB5tXhCdAGhmzoOt/1kZ7d76STWyO41t+TSpVOBSw8qFSJ8QJTHQnsbtQYLTg5O+IbisUc/ysWThx+hGDwaNjsxfvAuqPwFFfj+sUSlNRE4O7a9n2V+mhjU/dKnCbPObOsybiOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWKWLsDa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWKWLsDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB2BC19425;
	Wed, 29 Apr 2026 14:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472966;
	bh=WyFOz4ZUbeAoE3OiaPQ3zOOGuVceItkvbgEvh5ckqkU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NWKWLsDawTLlVjEtk2OooQ7rPp4SJ6NlPD7eOgJ3imu1oWD7T15sWGIMDu0X47jFQ
	 RGL+MVeumInE3CKYCuYN3Fo53oqdSZDxFvDZ/fypVd02U4mSJQxjcOyG0Q4DKltlyA
	 RE2+QvjwnSthQzyMyOSR6yXNPMQcx/tZPxP/jf89wgt7sGrqW4lewCNQZ3aEd7lJx7
	 qIb+MPXUj/P+7J8Kc6wD0MO7nOm0zQh3K2RwFBg3jRMjn5zGfCVIKoAhzPFQPW10A+
	 yxgfQ/9mnPmLhnhrAlGTq11I8TcJmnmc7dRvz8NUItm3kYNFMixFR/AtiZrMaMxiai
	 cCadvZrW69CYA==
Date: Wed, 29 Apr 2026 07:29:25 -0700
Subject: [PATCH 22/33] fuse_trace: query filesystem geometry when using iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205622.4101881.13167523785815327361.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c |    2 ++
 2 files changed, 50 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index c832fb9012d983..96c4db84c7106a 100644
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
@@ -345,6 +346,14 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
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
 
@@ -1005,6 +1014,45 @@ TRACE_EVENT(fuse_iomap_fallocate,
 		  __entry->mode,
 		  __entry->newsize)
 );
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
+		  __print_flags(__entry->flags, "|", FUSE_IOMAP_CONFIG_STRINGS),
+		  __entry->blocksize, __entry->max_links, __entry->time_gran,
+		  __entry->time_min, __entry->time_max, __entry->maxbytes,
+		  __entry->uuid_len)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index cd74497ceb3f42..9a856617234f78 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -742,6 +742,8 @@ static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
 		return error;
 	}
 
+	trace_fuse_iomap_config(fm, outarg);
+
 	if (outarg->flags & ~FUSE_IOMAP_CONFIG_ALL)
 		return -EINVAL;
 

