Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2C21922F5;
	Wed, 29 Apr 2026 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472700; cv=none; b=gnJ6cwjNA8SkT0xs2/t0Lfh0WriGtBHUFZ4XKBFMtdMCT2eLTcsRQMKjsYwbo9wBG2qGX5Y/23Wh240PhJAb8F2eGD+0UyCsc3/gw2SiFuau2NDuCpM6EHLk4RLQyBF17I7p2Ig4PfI3ucrJbU1IiC7HGp2mxYua90kVSPKUFK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472700; c=relaxed/simple;
	bh=oEs8w5qVI3UZn4t0lpcf/tU0UDILxYde96tBRJcCCzU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1BFntZ3lWYdoSLqS70tJRpvPvKjo0u57ROEk/zWGNiJP8ZXeC1O1zQ3Qn4k1d+uQN7agxNh4hpsY/mebZwoeuj8j8lbeWDJ2d4Xt/ToNf6eJj6O//01cSg3yumQ1SBGVcQvur4MJnsRCGQZ74FIwnq4QNJbyK3yWChsstVR8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEX+5Gtf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEX+5Gtf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321AFC2BCC7;
	Wed, 29 Apr 2026 14:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472700;
	bh=oEs8w5qVI3UZn4t0lpcf/tU0UDILxYde96tBRJcCCzU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=WEX+5Gtfaa7KmIfEFSj+oo8Y8Kn3cQO9zhOJl2b/D1E9hiRwkaCGjRuPzOAapUsHQ
	 QppRuiJfFfQ8UWGfEC+OPDarblJMkBho1omEr5ekSvZ3dt+FZqKt98TgL1EnHPORSz
	 j8YKOUeMkTf5l28rFZx0A5VYe4Dsj/+skDx86xQ5oyTb1qQiv+21fw0n8QEoucnPga
	 ICKGWRp3I+DxzLKeE4a0S0nE4FO0Ru9dRNwpGgPq6qYVPfz4afsCUiygmZijKVKW41
	 6+ZOnapd81gyjj0EA1iFg4EKF7Yyz5exUT1RhgkvRHWNAO1dCYR3lsy19fdJbAgFAY
	 i4thRK0+u3a1Q==
Date: Wed, 29 Apr 2026 07:24:59 -0700
Subject: [PATCH 05/33] fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to
 add new iomap devices
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205257.4101881.13478229792507749668.stgit@frogsfrogsfrogs>
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

Enhance the existing backing file tracepoints to report the subsystem
that's actually using the backing file.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index c0878253e7c6ad..af21654d797f45 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -175,6 +175,10 @@ TRACE_EVENT(fuse_request_end,
 );
 
 #ifdef CONFIG_FUSE_BACKING
+#define FUSE_BACKING_FLAG_STRINGS \
+	{ FUSE_BACKING_TYPE_PASSTHROUGH,	"pass" }, \
+	{ FUSE_BACKING_TYPE_IOMAP,		"iomap" }
+
 TRACE_EVENT(fuse_backing_class,
 	TP_PROTO(const struct fuse_conn *fc, unsigned int idx,
 		 const struct fuse_backing *fb),
@@ -184,7 +188,9 @@ TRACE_EVENT(fuse_backing_class,
 	TP_STRUCT__entry(
 		__field(dev_t,			connection)
 		__field(unsigned int,		idx)
+		__field(unsigned int,		type)
 		__field(unsigned long,		ino)
+		__field(dev_t,			rdev)
 	),
 
 	TP_fast_assign(
@@ -193,12 +199,19 @@ TRACE_EVENT(fuse_backing_class,
 		__entry->connection	=	fc->dev;
 		__entry->idx		=	idx;
 		__entry->ino		=	inode->i_ino;
+		__entry->type		=	fb->ops->type;
+		if (fb->ops->type == FUSE_BACKING_TYPE_IOMAP)
+			__entry->rdev	=	inode->i_rdev;
+		else
+			__entry->rdev	=	0;
 	),
 
-	TP_printk("connection %u idx %u ino 0x%lx",
+	TP_printk("connection %u idx %u type %s ino 0x%lx rdev %u:%u",
 		  __entry->connection,
 		  __entry->idx,
-		  __entry->ino)
+		  __print_symbolic(__entry->type, FUSE_BACKING_FLAG_STRINGS),
+		  __entry->ino,
+		  MAJOR(__entry->rdev), MINOR(__entry->rdev))
 );
 #define DEFINE_FUSE_BACKING_EVENT(name)		\
 DEFINE_EVENT(fuse_backing_class, name,		\
@@ -210,7 +223,6 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 #endif /* CONFIG_FUSE_BACKING */
 
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
-
 /* tracepoint boilerplate so we don't have to keep doing this */
 #define FUSE_IOMAP_OPFLAGS_FIELD \
 		__field(unsigned,		opflags)
@@ -452,6 +464,30 @@ TRACE_EVENT(fuse_iomap_end_error,
 		  __entry->written,
 		  __entry->error)
 );
+
+TRACE_EVENT(fuse_iomap_dev_add,
+	TP_PROTO(const struct fuse_conn *fc,
+		 const struct fuse_backing_map *map),
+
+	TP_ARGS(fc, map),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(int,			fd)
+		__field(unsigned int,		flags)
+	),
+
+	TP_fast_assign(
+		__entry->connection	=	fc->dev;
+		__entry->fd		=	map->fd;
+		__entry->flags		=	map->flags;
+	),
+
+	TP_printk("connection %u fd %d flags 0x%x",
+		  __entry->connection,
+		  __entry->fd,
+		  __entry->flags)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */

