Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920733D6D7;
	Wed, 29 Apr 2026 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473389; cv=none; b=K/wKNBOdMFb4EI70KCdZaTOtSnFkVYmnMAL4wxLWwBzg5D4CdISK5gPkuhOPC9FSJdsZ07poqaqvrHP2p7HZYFnPzBqB4ATWAbhMI+F3HVKOAB4s0FGpxCbiopOJYzfgIvyTwax+IaeCQ4i9NgJNrtu4/ZOeAGCX3jbhJ7hLP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473389; c=relaxed/simple;
	bh=Yar82Gg71In0Gp/DyTP77LpMp2X36menIJ2d1nGvj9k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tob47E8bYlgcIP6q5mERRWueiTse9fHHV67kcVfnYsqvQmYmm8DUUE0ifwUi0UatGPicldL1OnC/vDvFqVRqbKYKjXnlvlFn/C1WkV5Zh1Wn1lc/GLmmCB+d9eHzdhZw6ZFwhLcP2D7sFZdweH40rBRD5fBLdH3Jzdq+ih8b5rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCNR+ubS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCNR+ubS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EA3C2BCB8;
	Wed, 29 Apr 2026 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473388;
	bh=Yar82Gg71In0Gp/DyTP77LpMp2X36menIJ2d1nGvj9k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UCNR+ubSaHi+K6Xtu6nuwgCW4YYDyCbPsqJl2BjQ8WRZk8Z+h0Cm7m1UOWDeJqZPr
	 huIrNdJZF7TVCo5fbQ60ZnaUCbFKGYDVNvRkGoeqEC9GZfHGyS9v+hGMHQAXeZlVWV
	 JtVcqk8qHRZS99gaB4AKXjOrQGyB284i2pS18m/zVpjdd/LbCLq16x0saQ2LPdrd4q
	 MbEyxqsYILIYIh8AJfeW+bN5/aQY4WwiN1IrA7/CJghmWa27wHIFqaJs/v2tsUGB7p
	 x5h53Usi7RV6lGIm6txVTnX0jEtgEXEhG9GnSYNN54YH3fvFhQBY2cTMmmS8SjTP1z
	 L+ECzzNizkzkg==
Date: Wed, 29 Apr 2026 07:36:28 -0700
Subject: [PATCH 04/12] fuse_trace: use the iomap cache for iomap_begin
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747207086.4103699.1989377309123966430.stgit@frogsfrogsfrogs>
In-Reply-To: <177747206929.4103699.18256961856283014867.stgit@frogsfrogsfrogs>
References: <177747206929.4103699.18256961856283014867.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   34 ++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c |    7 ++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 697289c82d0dad..bf47008e50920a 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -404,6 +404,7 @@ struct fuse_iomap_lookup;
 
 #define FUSE_IOMAP_TYPE_STRINGS \
 	{ FUSE_IOMAP_TYPE_PURE_OVERWRITE,	"overwrite" }, \
+	{ FUSE_IOMAP_TYPE_RETRY_CACHE,		"retry" }, \
 	{ FUSE_IOMAP_TYPE_HOLE,			"hole" }, \
 	{ FUSE_IOMAP_TYPE_DELALLOC,		"delalloc" }, \
 	{ FUSE_IOMAP_TYPE_MAPPED,		"mapped" }, \
@@ -1509,6 +1510,39 @@ TRACE_EVENT(fuse_iomap_cache_lookup_result,
 		  FUSE_IOMAP_MAP_PRINTK_ARGS(got),
 		  __entry->validity_cookie)
 );
+
+TRACE_EVENT(fuse_iomap_invalid,
+	TP_PROTO(const struct inode *inode, const struct iomap *map,
+		 uint64_t validity_cookie),
+	TP_ARGS(inode, map, validity_cookie),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		FUSE_IOMAP_MAP_FIELDS(map)
+		__field(uint64_t,		old_validity_cookie)
+		__field(uint64_t,		validity_cookie)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+
+		__entry->mapoffset	=	map->offset;
+		__entry->maplength	=	map->length;
+		__entry->maptype	=	map->type;
+		__entry->mapflags	=	map->flags;
+		__entry->mapaddr	=	map->addr;
+		__entry->mapdev		=	FUSE_IOMAP_DEV_NULL;
+
+		__entry->old_validity_cookie=	map->validity_cookie;
+		__entry->validity_cookie=	validity_cookie;
+	),
+
+	TP_printk(FUSE_INODE_FMT FUSE_IOMAP_MAP_FMT() " old_cookie 0x%llx new_cookie 0x%llx",
+		  FUSE_INODE_PRINTK_ARGS,
+		  FUSE_IOMAP_MAP_PRINTK_ARGS(map),
+		  __entry->old_validity_cookie,
+		  __entry->validity_cookie)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 8b37c2f5cbdb2b..e1e7b98e591d16 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1581,7 +1581,12 @@ static bool fuse_iomap_revalidate(struct inode *inode,
 		return true;
 
 	validity_cookie = fuse_iext_read_seq(fi->cache);
-	return iomap->validity_cookie == validity_cookie;
+	if (unlikely(iomap->validity_cookie != validity_cookie)) {
+		trace_fuse_iomap_invalid(inode, iomap, validity_cookie);
+		return false;
+	}
+
+	return true;
 }
 
 static const struct iomap_write_ops fuse_iomap_write_ops = {

