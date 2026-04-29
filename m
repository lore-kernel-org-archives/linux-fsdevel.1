Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0732ED34;
	Wed, 29 Apr 2026 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472778; cv=none; b=MAmKqYqv5pDm047x8gA1GuvC1EoCpNntaxoeMmAeHTxDIohXeyU9IGuBvwWnc2a86iV43AL0TbeQCvhkLjIp5fEETZNlBfBqWnRL8OPsWeAroP8pudCTWyanQT0P19uIPDM01s8MnZfBw12CP83BKmPzMAn8naQ+6eTAdlpLjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472778; c=relaxed/simple;
	bh=u6SUf/MaHXwnw0CUQYL+TZ39+29DAH/03QugexVKhH8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSpqwRptgSLCtQmlOg3GYlIhjruzrZfk5WYaRrJDQjPDfncvloejt0AAhnHbt4d9DKgBXB6oux/tO2tXrRs3+ym1Ne7+yak/fWlzWe6/8jwxfaJY2E5ItrkfZaeS8NAxaHSZnRh8JWrtklhQRhy5vlDyI8j6jeY2oNNTsHj9eH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4yQRWI7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4yQRWI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ABCC19425;
	Wed, 29 Apr 2026 14:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472778;
	bh=u6SUf/MaHXwnw0CUQYL+TZ39+29DAH/03QugexVKhH8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=E4yQRWI79lQNwto/9f7NU8lw/He6GpdXsd4owUV2IeDCLA/PVy7HByWAv5/uFv+ka
	 wq++It1G8rpyglK/9NEy1cZRY/GUK7xryUVpyBSKkAaUyx2mYo45NbeLO5k6hVaaSA
	 KSY283QH9Ep1+t7NDP+WA4Icxc5CE6I+OLr+4BHLwd6/Jjnu/Yv+A/xMTH4M8EsoOD
	 wnz29PB6RxW+9mrMf0cYP8YJWnoyAgfqqIOwDdY+NIeTKGjTr/pGit4GLGiFTGeRJs
	 AybLEaKFJvz209P1nH0Fk7InvySiyYXgeJ/b1+lxSJ8qh/mpKZRmrnQB4fpcI8C6Rx
	 6MC3+AI23HXIg==
Date: Wed, 29 Apr 2026 07:26:18 -0700
Subject: [PATCH 10/33] fuse_trace: create a per-inode flag for toggling iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205365.4101881.13745355926650124202.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c |    8 +++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index af21654d797f45..fac981e2a30df0 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -300,6 +300,25 @@ DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
 	{ FUSE_IOMAP_TYPE_UNWRITTEN,		"unwritten" }, \
 	{ FUSE_IOMAP_TYPE_INLINE,		"inline" }
 
+TRACE_DEFINE_ENUM(FUSE_I_ADVISE_RDPLUS);
+TRACE_DEFINE_ENUM(FUSE_I_INIT_RDPLUS);
+TRACE_DEFINE_ENUM(FUSE_I_SIZE_UNSTABLE);
+TRACE_DEFINE_ENUM(FUSE_I_BAD);
+TRACE_DEFINE_ENUM(FUSE_I_BTIME);
+TRACE_DEFINE_ENUM(FUSE_I_CACHE_IO_MODE);
+TRACE_DEFINE_ENUM(FUSE_I_EXCLUSIVE);
+TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
+
+#define FUSE_IFLAG_STRINGS \
+	{ 1 << FUSE_I_ADVISE_RDPLUS,		"advise_rdplus" }, \
+	{ 1 << FUSE_I_INIT_RDPLUS,		"init_rdplus" }, \
+	{ 1 << FUSE_I_SIZE_UNSTABLE,		"size_unstable" }, \
+	{ 1 << FUSE_I_BAD,			"bad" }, \
+	{ 1 << FUSE_I_BTIME,			"btime" }, \
+	{ 1 << FUSE_I_CACHE_IO_MODE,		"cacheio" }, \
+	{ 1 << FUSE_I_EXCLUSIVE,		"excl" }, \
+	{ 1 << FUSE_I_IOMAP,			"iomap" }
+
 DECLARE_EVENT_CLASS(fuse_iomap_check_class,
 	TP_PROTO(const char *func, int line, const char *condition),
 
@@ -488,6 +507,31 @@ TRACE_EVENT(fuse_iomap_dev_add,
 		  __entry->fd,
 		  __entry->flags)
 );
+
+DECLARE_EVENT_CLASS(fuse_inode_state_class,
+	TP_PROTO(const struct inode *inode),
+	TP_ARGS(inode),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(unsigned long,		state)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->state		=	fi->state;
+	),
+
+	TP_printk(FUSE_INODE_FMT " state (%s)",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __print_flags(__entry->state, "|", FUSE_IFLAG_STRINGS))
+);
+#define DEFINE_FUSE_INODE_STATE_EVENT(name)	\
+DEFINE_EVENT(fuse_inode_state_class, name,	\
+	TP_PROTO(const struct inode *inode),	\
+	TP_ARGS(inode))
+DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_init_inode);
+DEFINE_FUSE_INODE_STATE_EVENT(fuse_iomap_evict_inode);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 39c9239c64435a..dccfc9a2c9847c 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -651,15 +651,21 @@ void fuse_iomap_init_inode(struct inode *inode, struct fuse_attr *attr)
 		return;
 	}
 
-	if (!S_ISREG(inode->i_mode))
+	if (!S_ISREG(inode->i_mode)) {
+		trace_fuse_iomap_init_inode(inode);
 		return;
+	}
 
 	fuse_inode_set_iomap(inode);
+
+	trace_fuse_iomap_init_inode(inode);
 }
 
 void fuse_iomap_evict_inode(struct inode *inode)
 {
 	ASSERT(fuse_inode_has_iomap(inode));
 
+	trace_fuse_iomap_evict_inode(inode);
+
 	fuse_inode_clear_iomap(inode);
 }

