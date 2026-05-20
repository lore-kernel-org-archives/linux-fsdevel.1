Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E94535957;
	Wed, 20 May 2026 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779257753; cv=none; b=Dpw8AQqERMlAl4BEZdol1ELWtoi5tV5OaeGnaJomLxyt1aB4gwpIfpeD/n0EQZFRG5Az+lZIgXC600YvkVYz+wBXvNi/tNmDXPN5NSbYDFmtHO3mE6XC34poury7ivXTqZ50RoyIhrRR0t0jOMwFPCx0OrpzmcLjVemKbC5EFss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779257753; c=relaxed/simple;
	bh=uwsKpoGRYrZDc30AnIe1LVD8eeog2wcmw6HJs7sc6iM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rf5s+tL2fV5za7ERdUHB0pggPSUj855GJ73gDrPYcJcvKF5BUfGetqTiSG6R7kK1TshbfSJSN+OE2fu/Qka4gVcWkfHNQHqF6etOpCkhpMn7oTbXwx3xTULPzTiY32Z+ncURERU3rUF8JsWR9lG1ITN7XeySk4dkRvQ9GaW/TPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VF4/y4lq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VF4/y4lq"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D57121F000E9;
	Wed, 20 May 2026 06:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779257751;
	bh=sEk73V78jvdM2btpe+cD8/dpK2rWMlSoeT4xE779f+o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=VF4/y4lqEARr08DT4/1nuKmMb+J710p36ev80BJ94KQcMxrJUXWYlZtkgckEHjLOx
	 K5JNCKe43nApnu7XQ+UOdZg1X+Nx4lZESEi8nw3q5K+GfuFxrLKuDNPL3BXpOL98kZ
	 NLAGA1Kg39GPOI84O0GccPk0Ka/OGeIcWD1TxGcLvoxJs53YeZEFoqlnzI80zUrB1a
	 GpB9pEVCssL676KVYuvag0pKUkXJ3e0gZqDSvgjpnRZxJpU52NGlZbkHBt22a44jON
	 /2U6giGDGlt3cG41RykQHotMK5JkMlcSJh9C27aaNTkf2/m3Wlfghu/kbpzb5QK9ON
	 tv/mmlLJMMaMw==
Date: Tue, 19 May 2026 23:15:51 -0700
Subject: [PATCH 2/4] fuse_trace: allow fuse servers to upload stripe maps
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: fuse-devel@lists.linux.dev, bernd@bsbernd.com, neal@gompa.dev,
 linux-fsdevel@vger.kernel.org, hch@infradead.org, joannelkoong@gmail.com,
 john@groves.net
Message-ID: <177925767727.2711065.14182720958500282791.stgit@frogsfrogsfrogs>
In-Reply-To: <177925767662.2711065.15846161331592459171.stgit@frogsfrogsfrogs>
References: <177925767662.2711065.15846161331592459171.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   44 +++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/backing.c    |    1 +
 fs/fuse/fuse_iomap.c |    2 ++
 3 files changed, 46 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index c36bd62bc450fd..caaa19ac4687bf 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -275,7 +275,8 @@ TRACE_EVENT(fuse_setattr,
 #ifdef CONFIG_FUSE_BACKING
 #define FUSE_BACKING_FLAG_STRINGS \
 	{ FUSE_BACKING_TYPE_PASSTHROUGH,	"pass" }, \
-	{ FUSE_BACKING_TYPE_IOMAP,		"iomap" }
+	{ FUSE_BACKING_TYPE_IOMAP,		"iomap" }, \
+	{ FUSE_BACKING_TYPE_IOMAP_STRIPE,	"stripe" }
 
 DECLARE_EVENT_CLASS(fuse_backing_class,
 	TP_PROTO(const struct fuse_conn *fc, const struct fuse_backing *fb),
@@ -316,6 +317,47 @@ DEFINE_EVENT(fuse_backing_class, name,		\
 	TP_ARGS(fc, fb))
 DEFINE_FUSE_BACKING_EVENT(fuse_backing_open);
 DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
+DEFINE_FUSE_BACKING_EVENT(fuse_backing_create);
+
+DECLARE_EVENT_CLASS(fuse_backing_strip_class,
+	TP_PROTO(const struct fuse_conn *fc,
+		 const struct fuse_backing_stripe *bstripe,
+		 unsigned int strip_nr,
+		 const struct fuse_backing_strip *bstrip),
+
+	TP_ARGS(fc, bstripe, strip_nr, bstrip),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(unsigned int,		strip_nr)
+		__field(int,			strip_id)
+		__field(unsigned long long,	strip_width)
+		__field(unsigned long long,	strip_addr)
+	),
+
+	TP_fast_assign(
+		__entry->connection	=	fc->dev;
+		__entry->strip_nr	=	strip_nr;
+		__entry->strip_id	=	bstrip->dev;
+		__entry->strip_width	=	bstripe->strip_width;
+		__entry->strip_addr	=	bstrip->addr;
+	),
+
+	TP_printk("connection %u strip nr %u id %u width 0x%llx addr 0x%llx",
+		  __entry->connection,
+		  __entry->strip_nr,
+		  __entry->strip_id,
+		  __entry->strip_width,
+		  __entry->strip_addr)
+);
+#define DEFINE_FUSE_BACKING_STRIP_EVENT(name)			\
+DEFINE_EVENT(fuse_backing_strip_class, name, 			\
+	TP_PROTO(const struct fuse_conn *fc,	 		\
+		 const struct fuse_backing_stripe *bstripe,	\
+		 unsigned int strip_nr,				\
+		 const struct fuse_backing_strip *bstrip),	\
+	TP_ARGS(fc, bstripe, strip_nr, bstrip))
+DEFINE_FUSE_BACKING_STRIP_EVENT(fuse_backing_strip_config);
 #endif /* CONFIG_FUSE_BACKING */
 
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 815b797b8f52f5..4075db710db591 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -230,6 +230,7 @@ int fuse_backing_create(struct fuse_conn *fc,
 	fuse_backing_free(fb);
 	fb = NULL;
 
+	trace_fuse_backing_create(fc, fb);
 out:
 	pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
 	return res;
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 870822d24c0ca8..92fa9cd0d8044a 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -3309,6 +3309,8 @@ int fuse_iomap_backing_stripe_config(struct file *file,
 
 		bstrip->dev = strip.dev;
 		bstrip->addr = strip.addr;
+
+		trace_fuse_backing_strip_config(fud->fc, bstripe, i, bstrip);
 	}
 
 	ret = fuse_backing_create(fud->fc, &fuse_iomap_stripe_backing_ops,

