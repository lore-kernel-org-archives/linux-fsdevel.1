Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71693ACEE2;
	Tue, 19 May 2026 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229670; cv=none; b=cEH25h2Xm//nObxvJa7S447V7z6X2ckc6UIgXBt1WCaRWXaKrcuLioZzXjzlgQ9/EQLQrJ2ZQi7ZEKFCakikB0pcSvuzRUldJzr4PyvV3zcd5cirPmP5fecrQyplqrG+3PXce9wP2T6wQkmAnVsoaJNjjCRO9DyhbbLzNod2x3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229670; c=relaxed/simple;
	bh=Ga+C4GL/eC1BI/4brZg5Sg0mbDlxESOW2W2VVa8FKaY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJ9my+UT1/aO2WrCFn+e6u3EvDJQxjwMmOVkrB600Or+OBa8cX6iJ87aeyGz75Ud4j60/CLuKE2x2M1LUOA9RAcmrc5eFe9trqABKQgpBpnFrspLywZNv/5q+nFVaYTBuZrbKUck1LnZfoCo5ntrkLhcD4FeWjK59jHVNxUtBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejXidmsh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejXidmsh"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id AEEF01F00893;
	Tue, 19 May 2026 22:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229669;
	bh=OzEXJUiYKCyu+cHC28fYbpim+/SGSYLEzImqlw5bGe0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=ejXidmsh8H3Z7QnY8GRqIvCmguAGJTrN+AT1GjoKiLs79Vnzm1Ms6IRf+EZajx3dd
	 gwM8HsZ59tOHiMTHLM781vxn2JSzor8eHFDmzuUfJAUF2SmFqxrTrQ4TDM3IuNx+ON
	 p+zNwkuQ+wW1vmMXbZk5PnaQ4ReTMRlsRVQBiiCGCkq874YdvH6QRBhLXgg2Hpop42
	 ND+9Xynvj8uZRtRM9qQz32cOljsLyOYDcwXCSGWi6Rbak4Lrh8ZZdDu2vJ5GN7+Axd
	 0dabPpAYJvRt6F5EYujxpT8Rzq2aPbzJCgkFYWQhoUZLLq5IDtxZps3QJ407lCIt0M
	 cAT2+djQOkgLg==
Date: Tue, 19 May 2026 15:27:49 -0700
Subject: [PATCH 05/11] fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to
 add new iomap devices
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945349.2436837.1059278288818196019.stgit@frogsfrogsfrogs>
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

Enhance the existing backing file tracepoints to report the subsystem
that's actually using the backing file.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 2fcff2c46a9733..e942480b9d5841 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -175,6 +175,10 @@ TRACE_EVENT(fuse_request_end,
 );
 
 #ifdef CONFIG_FUSE_BACKING
+#define FUSE_BACKING_FLAG_STRINGS \
+	{ FUSE_BACKING_TYPE_PASSTHROUGH,	"pass" }, \
+	{ FUSE_BACKING_TYPE_IOMAP,		"iomap" }
+
 DECLARE_EVENT_CLASS(fuse_backing_class,
 	TP_PROTO(const struct fuse_conn *fc, const struct fuse_backing *fb),
 
@@ -183,7 +187,9 @@ DECLARE_EVENT_CLASS(fuse_backing_class,
 	TP_STRUCT__entry(
 		__field(dev_t,			connection)
 		__field(int,			id)
+		__field(unsigned int,		type)
 		__field(unsigned long,		ino)
+		__field(dev_t,			rdev)
 	),
 
 	TP_fast_assign(
@@ -192,12 +198,19 @@ DECLARE_EVENT_CLASS(fuse_backing_class,
 		__entry->connection	=	fc->dev;
 		__entry->id		=	fb->id;
 		__entry->ino		=	inode->i_ino;
+		__entry->type		=	fb->ops->type;
+		if (fb->ops->type == FUSE_BACKING_TYPE_IOMAP)
+			__entry->rdev	=	inode->i_rdev;
+		else
+			__entry->rdev	=	0;
 	),
 
-	TP_printk("connection %u id %d ino 0x%lx",
+	TP_printk("connection %u id %d type %s ino 0x%lx rdev %u:%u",
 		  __entry->connection,
 		  __entry->id,
-		  __entry->ino)
+		  __print_symbolic(__entry->type, FUSE_BACKING_FLAG_STRINGS),
+		  __entry->ino,
+		  MAJOR(__entry->rdev), MINOR(__entry->rdev))
 );
 #define DEFINE_FUSE_BACKING_EVENT(name)		\
 DEFINE_EVENT(fuse_backing_class, name,		\

