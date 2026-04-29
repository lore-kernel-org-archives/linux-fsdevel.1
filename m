Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB8E2F0680;
	Wed, 29 Apr 2026 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472622; cv=none; b=k5W5yUOhsnormjW0nLtUqBSofPvaic2Nupocuzi01IqleK2XwwQPBt4t5Lijtb2Ab4MwCYKDaUEr+DP+lK22GsKJV/3qvGzaD6CmmrgoKIeuob2ScdQhPeHMaMI7ccHqBq2RVsfqk5mxx8nObcEV8x+mrJ0cbsV4hfT7FWdpzFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472622; c=relaxed/simple;
	bh=IytVmE4pO4BPrH6h/7neOQU9xS9fu5UyQMn5loH/J30=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmfFCTlTjIDwUlWHqiPDK2tpe3CRGMTcF7JAvIE0O6hBO4niM05LpKrAPpLlwIu+a8u8OrjfEpUTi89QrCG6HZgaad+D85IByHcn0uwWLd5Rnyzskg7LjKuy4iH6U23IHTyQqkBeyjVs60F/Ro+J/AdLrn05GDiKL/MicN+3PWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlT7EUWM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlT7EUWM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F29C19425;
	Wed, 29 Apr 2026 14:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472622;
	bh=IytVmE4pO4BPrH6h/7neOQU9xS9fu5UyQMn5loH/J30=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UlT7EUWMtRX95PmMRBy4Nlicpde4QmeV4Gt4HLJ+kLy6wmG+BXVhn/aY13pqLJa0e
	 BXyv9OzUJC5HPLYJzhp5LIfizN3VOZCuQ3BeGBfGjmYkKPkQsCU1/wK6jmXqmzR4ZP
	 HGwS+vuO2fh6LvGrUJ9uJGYmgA/fRq6L9UeF/GNR8wSAgZ+UXCHVWuLTbtjtBZgCWD
	 QMlxW3h4NueZ1A9L9lzg1Yxica4KVx++6HkP6CCixI/uiNPDhPOB4DbADLj9b1/cMC
	 of2Q63yBsj98kY2OB+gCZWMi6hmn08yc5w9B/Pq3cD4vJfDtaKr5ekIu9+5r/SlLYT
	 x/5xuQNMKhqxQ==
Date: Wed, 29 Apr 2026 07:23:41 -0700
Subject: [PATCH 2/2] fuse_trace: move the passthrough-specific code back to
 passthrough.c
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, joannelkoong@gmail.com, neal@gompa.dev,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747204647.4101743.5488320024551450875.stgit@frogsfrogsfrogs>
In-Reply-To: <177747204594.4101743.18108570914300152558.stgit@frogsfrogsfrogs>
References: <177747204594.4101743.18108570914300152558.stgit@frogsfrogsfrogs>
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
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/fuse_trace.h |   35 +++++++++++++++++++++++++++++++++++
 fs/fuse/backing.c    |    5 +++++
 2 files changed, 40 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index bbe9ddd8c71696..286a0845dc0898 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -124,6 +124,41 @@ TRACE_EVENT(fuse_request_end,
 		  __entry->unique, __entry->len, __entry->error)
 );
 
+#ifdef CONFIG_FUSE_BACKING
+TRACE_EVENT(fuse_backing_class,
+	TP_PROTO(const struct fuse_conn *fc, unsigned int idx,
+		 const struct fuse_backing *fb),
+
+	TP_ARGS(fc, idx, fb),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(unsigned int,		idx)
+		__field(unsigned long,		ino)
+	),
+
+	TP_fast_assign(
+		struct inode *inode = file_inode(fb->file);
+
+		__entry->connection	=	fc->dev;
+		__entry->idx		=	idx;
+		__entry->ino		=	inode->i_ino;
+	),
+
+	TP_printk("connection %u idx %u ino 0x%lx",
+		  __entry->connection,
+		  __entry->idx,
+		  __entry->ino)
+);
+#define DEFINE_FUSE_BACKING_EVENT(name)		\
+DEFINE_EVENT(fuse_backing_class, name,		\
+	TP_PROTO(const struct fuse_conn *fc, unsigned int idx, \
+		 const struct fuse_backing *fb), \
+	TP_ARGS(fc, idx, fb))
+DEFINE_FUSE_BACKING_EVENT(fuse_backing_open);
+DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
+#endif /* CONFIG_FUSE_BACKING */
+
 #endif /* _TRACE_FUSE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index adb4d2ebb21379..d7e074c30f46cc 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -72,6 +72,7 @@ static int fuse_backing_id_free(int id, void *p, void *data)
 
 	WARN_ON_ONCE(refcount_read(&fb->count) != 1);
 
+	trace_fuse_backing_close((struct fuse_conn *)data, id, fb);
 	fuse_backing_free(fb);
 	return 0;
 }
@@ -145,6 +146,8 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 		fb = NULL;
 		goto out;
 	}
+
+	trace_fuse_backing_open(fc, res, fb);
 out:
 	pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
 
@@ -194,6 +197,8 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 	if (err)
 		goto out_fb;
 
+	trace_fuse_backing_close(fc, backing_id, fb);
+
 	err = -ENOENT;
 	test_fb = fuse_backing_id_remove(fc, backing_id);
 	if (!test_fb)

