Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B533254B8;
	Wed, 29 Apr 2026 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474187; cv=none; b=dLzb0KQVuMAhD6QskQM6IzNpGoNAPxfJ363uIEuIEYmMErvJXWD9GbW2mCUF0ZfFpf5K0iVRLtvAZNh+GbuNf/0sFvClTL/h2OI7n8iDZoYSdglc9OeZiIWMrVw8AcB0gV/eBuFUq7xk20elLPSdvhiKQmodO7PGdSn0a3AWxB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474187; c=relaxed/simple;
	bh=lRbf2/Scxk2lvkgZ2rhV9XSkmhoobFuJ/847hCJ9BJc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTwbfj/FalL3rqFLGPdLUpojgdkkmY5eMVfMnHB2UV8JlXqWhvjmeFTOmE8mkWfu1MyyyOTJouMxRFIF1KlcV/Y0SIKxPByeBsf0n7UU2MPB7tfLZekqjYn7IBpTya4Nd2J1kmS0DyDNond4aEzp4C65uqfjflcXZniPXphq9Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWi0rW1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWi0rW1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8CFC19425;
	Wed, 29 Apr 2026 14:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474186;
	bh=lRbf2/Scxk2lvkgZ2rhV9XSkmhoobFuJ/847hCJ9BJc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=pWi0rW1Qc1eksrgmzkg8cisDpbnbL0tAN/GXHc3XSBERqqE+RwhDJyS67xSMSo/h7
	 BO28eqnu8skuK1UQ9745SxYMDDzWlCG4MQnE8makHLhEBE2qm6WgBhNRElB04FVHok
	 P4LbqVUozWCuwid7kKHAeR2S5wN6G2rtpkVgDBMlbwIbIz5RVYNRyDtUWn9Hy6DA5F
	 j4nBWtrUiowfW95214jhxj4fufTQZkVsG/xKq9ijZdzIF0sNrNa7RODQDaGJUtQdk7
	 HYlEKuE0ojTPX0zzJj+v3MD6h4SXVdy5hkDgCA9mHL0DXV6xwSbcBoGiGigPoqOQpo
	 U4jOk5xBbVgqw==
Date: Wed, 29 Apr 2026 07:49:46 -0700
Subject: [PATCH 3/9] libfuse: allow constraining of iomap mapping cache size
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747213300.4106384.11857681307635538525.stgit@frogsfrogsfrogs>
In-Reply-To: <177747213211.4106384.5167047581302637277.stgit@frogsfrogsfrogs>
References: <177747213211.4106384.5167047581302637277.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Allow the fuse server to constrain the maximum size of each iomap
mapping cache.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    7 ++++++-
 include/fuse_kernel.h |    6 +++++-
 lib/fuse_lowlevel.c   |    9 +++++++--
 3 files changed, 18 insertions(+), 4 deletions(-)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 76c65f7e79179e..3a8fc7ea78bcc7 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1266,11 +1266,14 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 #define FUSE_IOMAP_CONFIG_MAX_LINKS	(1 << 3ULL)
 #define FUSE_IOMAP_CONFIG_TIME		(1 << 4ULL)
 #define FUSE_IOMAP_CONFIG_MAXBYTES	(1 << 5ULL)
+#define FUSE_IOMAP_CONFIG_CACHE_MAXBYTES (1 << 6ULL)
 
 struct fuse_iomap_config_params {
 	uint64_t flags;		/* supported FUSE_IOMAP_CONFIG_* flags */
 	int64_t maxbytes;	/* max supported file size */
-	uint64_t padding[6];	/* zero */
+	uint32_t cache_maxbytes; /* mapping cache maxbytes */
+	uint32_t zero;		/* zero */
+	uint64_t padding[5];	/* zero */
 };
 
 struct fuse_iomap_config {
@@ -1294,6 +1297,8 @@ struct fuse_iomap_config {
 	int64_t s_time_max;
 
 	int64_t s_maxbytes;	/* max file size */
+
+	uint32_t cache_maxbytes; /* mapping cache maximum size */
 };
 
 /* invalidate to end of file */
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 115c8a228e765a..d9b65fe2395bde 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1433,7 +1433,9 @@ struct fuse_iomap_ioend_out {
 struct fuse_iomap_config_in {
 	uint64_t flags;		/* supported FUSE_IOMAP_CONFIG_* flags */
 	int64_t maxbytes;	/* max supported file size */
-	uint64_t padding[6];	/* zero */
+	uint32_t cache_maxbytes; /* mapping cache maxbytes */
+	uint32_t zero;		/* zero */
+	uint64_t padding[5];	/* zero */
 };
 
 struct fuse_iomap_config_out {
@@ -1457,6 +1459,8 @@ struct fuse_iomap_config_out {
 	int64_t s_time_max;
 
 	int64_t s_maxbytes;	/* max file size */
+
+	uint32_t cache_maxbytes; /* mapping cache maximum size */
 };
 
 struct fuse_range {
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 6e8d2a7d74201b..4af2ed8380f5ac 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2851,7 +2851,8 @@ static void do_iomap_ioend(fuse_req_t req, const fuse_ino_t nodeid,
 			      FUSE_IOMAP_CONFIG_BLOCKSIZE | \
 			      FUSE_IOMAP_CONFIG_MAX_LINKS | \
 			      FUSE_IOMAP_CONFIG_TIME | \
-			      FUSE_IOMAP_CONFIG_MAXBYTES)
+			      FUSE_IOMAP_CONFIG_MAXBYTES | \
+			      FUSE_IOMAP_CONFIG_CACHE_MAXBYTES)
 
 #define FUSE_IOMAP_CONFIG_ALL (FUSE_IOMAP_CONFIG_V1)
 
@@ -2860,7 +2861,7 @@ static ssize_t iomap_config_reply_size(const struct fuse_iomap_config *cfg)
 	if (cfg->flags & ~FUSE_IOMAP_CONFIG_ALL)
 		return -EINVAL;
 
-	return offsetofend(struct fuse_iomap_config_out, s_maxbytes);
+	return offsetofend(struct fuse_iomap_config_out, cache_maxbytes);
 }
 
 int fuse_reply_iomap_config(fuse_req_t req, const struct fuse_iomap_config *cfg)
@@ -2898,6 +2899,9 @@ int fuse_reply_iomap_config(fuse_req_t req, const struct fuse_iomap_config *cfg)
 	if (cfg->flags & FUSE_IOMAP_CONFIG_MAXBYTES)
 		arg.s_maxbytes = cfg->s_maxbytes;
 
+	if (cfg->flags & FUSE_IOMAP_CONFIG_CACHE_MAXBYTES)
+		arg.cache_maxbytes = cfg->cache_maxbytes;
+
 	return send_reply_ok(req, &arg, reply_size);
 }
 
@@ -2908,6 +2912,7 @@ static void _do_iomap_config(fuse_req_t req, const fuse_ino_t nodeid,
 	struct fuse_iomap_config_params p = {
 		.flags = arg->flags & FUSE_IOMAP_CONFIG_ALL,
 		.maxbytes = arg->maxbytes,
+		.cache_maxbytes = arg->cache_maxbytes,
 	};
 
 	(void)nodeid;

