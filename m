Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25D13BD625;
	Tue, 19 May 2026 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229577; cv=none; b=g2xXzceXpJ8UJwWuBog/y/wyRmq0yAtW0WDpCwZi1OmNkjN1zzxSqC6ro33MOtTNwI4HNGEgvebMMdhCeLAkHApkfjdZzboXrdAu6hp5fqolmqnEvygihsTLGNYhls20s4FTa3oPW69QTNloaWQbPhvKfuLV/6Sw/a6GVxM6Zbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229577; c=relaxed/simple;
	bh=YIivgQkxuWxiRvw5yVbQTrT4JUvHK+KLSanODrlg8RA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdOrFq+R3P6diw35YfgFOTJ7mzUFiSsSLsZxUy3aAHh6V+61uvgKzgNQc5XyKbV4eI3WVPI6jRJBf5eJVnEq47n+8KbhaBnUjm/RIIZspccM49dNp23V/rHfP5byzTRmVB1ei44t0EJ3UEmoz0NtdudPuflLOSd5nZpoMj8AxHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEfLAcCN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEfLAcCN"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 64E331F00893;
	Tue, 19 May 2026 22:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229576;
	bh=oktHHDic5XXn+y0yTaPVmPl7Bia//pVe/pc5hupEFuY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=bEfLAcCN1JPEAQpD1ayvYX5aA30pvBp34TPXCwik9dk/rdH86W/BEADK/5ARVP3ib
	 vcPBOcHKLAwsNbsvVbT1odVoPZ6d7ZzLmsu7rMKqdB7hhkLL09ykFT9LtCfkD78hSw
	 YgZF4qK+VCA9S0Eq9HBC0eqr7XubogPzBbQKPOpwGLI7vmXQy+xwNDKobdy4toGfW1
	 sXjfp9emU5QLTd1KHGgv6cMAFq5A0U1ptu/AUE7OIcqxBDhk9QuDt5W99kdqUpIWaY
	 U6N3I1dRoWxxM8spLTbVbO6pMuBxbdzYwqN4o3boXixwx5oWC37LgY0Sohhs5smIDU
	 k5vECsqTIYj2g==
Date: Tue, 19 May 2026 15:26:16 -0700
Subject: [PATCH 3/4] fuse_trace: move the passthrough-specific code back to
 passthrough.c
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
 bernd@bsbernd.com, joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922944887.2436629.2812989183574341979.stgit@frogsfrogsfrogs>
In-Reply-To: <177922944800.2436629.7011047808676668088.stgit@frogsfrogsfrogs>
References: <177922944800.2436629.7011047808676668088.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   33 +++++++++++++++++++++++++++++++++
 fs/fuse/backing.c    |    7 +++++++
 2 files changed, 40 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index bbe9ddd8c71696..3b28ec736d4d60 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -124,6 +124,39 @@ TRACE_EVENT(fuse_request_end,
 		  __entry->unique, __entry->len, __entry->error)
 );
 
+#ifdef CONFIG_FUSE_BACKING
+DECLARE_EVENT_CLASS(fuse_backing_class,
+	TP_PROTO(const struct fuse_conn *fc, const struct fuse_backing *fb),
+
+	TP_ARGS(fc, fb),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(int,			id)
+		__field(unsigned long,		ino)
+	),
+
+	TP_fast_assign(
+		struct inode *inode = file_inode(fb->file);
+
+		__entry->connection	=	fc->dev;
+		__entry->id		=	fb->id;
+		__entry->ino		=	inode->i_ino;
+	),
+
+	TP_printk("connection %u id %d ino 0x%lx",
+		  __entry->connection,
+		  __entry->id,
+		  __entry->ino)
+);
+#define DEFINE_FUSE_BACKING_EVENT(name)		\
+DEFINE_EVENT(fuse_backing_class, name,		\
+	TP_PROTO(const struct fuse_conn *fc, const struct fuse_backing *fb), \
+	TP_ARGS(fc, fb))
+DEFINE_FUSE_BACKING_EVENT(fuse_backing_open);
+DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
+#endif /* CONFIG_FUSE_BACKING */
+
 #endif /* _TRACE_FUSE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 217facf3f408a4..8bfc85a45642c0 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -89,6 +89,9 @@ static int fuse_backing_id_free(int id, void *p, void *data)
 	struct fuse_backing *fb = p;
 
 	WARN_ON_ONCE(refcount_read(&fb->count) != 1);
+
+	trace_fuse_backing_close((struct fuse_conn *)data, fb);
+
 	fuse_backing_free(fb);
 	return 0;
 }
@@ -163,6 +166,8 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 		fb = NULL;
 		goto out;
 	}
+
+	trace_fuse_backing_open(fc, fb);
 out:
 	pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
 
@@ -216,6 +221,8 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 	if (err)
 		goto out_fb;
 
+	trace_fuse_backing_close(fc, fb);
+
 	/* drop the backing id cache's refcount */
 	fuse_backing_put(fb);
 out_fb:

