Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED9A1922F5;
	Wed, 29 Apr 2026 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472669; cv=none; b=eWXvWX5VF5p2VXZeTePs79aCOaz/VqDY74datOKdlrS3rJwWog1vaS4TGbuztNJP4G4Dku37xCe/1zKnj2s5UnimyR+br8L1SJ95CrFHETdXPMEXpRARuCCKk9BEuGEWc3T66vwRDYCdeaFHCW8R8RDoidQQGfLyUJ+iwS2pvEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472669; c=relaxed/simple;
	bh=/w/xgCdATbtP5PCQ004Ce6uIg19AwIwxTReKdOiZs6s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tiEPEa84yD7Ce7X/zTsrUniJE3JF0j+gi7yvl3Sare0YK/lA3jKpKLwvfpzteNmMyPYFKlsDwPhAIHqBe3mqvexp+Bpv8q0E2Kw3jU08SMCdPPh/n/2QQWhqBIus18jB6AkhTNMnxUv9c2u5qOT+b3fI0BEGkvB4/deb5rPsohQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhoEri6z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhoEri6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2052C19425;
	Wed, 29 Apr 2026 14:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472668;
	bh=/w/xgCdATbtP5PCQ004Ce6uIg19AwIwxTReKdOiZs6s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OhoEri6z88+08+GcQu7S1evrTiEWV2fun4wnSu7LlEZb4I/5cgINJV/5336EJ1Q9x
	 SINPVbfyyMvr6YXZfNwJuTOEgruG//N6cKrB03m5yZewMeiEiQpEsFymGKJx9s4PsH
	 lsPh9heweMWCe+QeRldWLT7Pemb6kYojyYuNxr/0W3TTORqbXif6lkJdVxmne2kdSq
	 EltdSPtpyNP2DjpUkQ4tPD8WjkQ4Ekzf1KRzywMS6G8RnGZnS6rPBf0j9yQLm8w4JO
	 cynFbpduVKTgPg/9nigQP+KBigSL2kCXmgDTxbeSTSqf1q58l/92QHGR8Cv8uDkupY
	 DGC7/YgPTNkHw==
Date: Wed, 29 Apr 2026 07:24:28 -0700
Subject: [PATCH 03/33] fuse: make debugging configurable at runtime
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205214.4101881.6181001367021214200.stgit@frogsfrogsfrogs>
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

Use static keys so that we can configure debugging assertions and dmesg
warnings at runtime.  By default this is turned off so the cost is
merely scanning a nop sled.  However, fuse server developers can turn
it on for their debugging systems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap_i.h |   17 ++++++++++++++---
 fs/fuse/Kconfig        |   15 +++++++++++++++
 fs/fuse/fuse_iomap.c   |   43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/fuse_iomap_i.h b/fs/fuse/fuse_iomap_i.h
index b9ab8ce140e8e1..c37a7c5cfc862f 100644
--- a/fs/fuse/fuse_iomap_i.h
+++ b/fs/fuse/fuse_iomap_i.h
@@ -8,17 +8,28 @@
 
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
 #if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
-# define ASSERT(condition) do {						\
+
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_BY_DEFAULT)
+DECLARE_STATIC_KEY_TRUE(fuse_iomap_debug);
+#else
+DECLARE_STATIC_KEY_FALSE(fuse_iomap_debug);
+#endif /* FUSE_IOMAP_DEBUG_BY_DEFAULT */
+
+# define ASSERT(condition) \
+while (static_branch_unlikely(&fuse_iomap_debug)) {			\
 	int __cond = !!(condition);					\
 	if (unlikely(!__cond))						\
 		trace_fuse_iomap_assert(__func__, __LINE__, #condition); \
 	WARN(!__cond, "Assertion failed: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
-} while (0)
+	break;								\
+}
 # define BAD_DATA(condition) ({						\
 	int __cond = !!(condition);					\
 	if (unlikely(__cond))						\
 		trace_fuse_iomap_bad_data(__func__, __LINE__, #condition); \
-	WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
+	if (static_branch_unlikely(&fuse_iomap_debug))			\
+		WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
+	unlikely(__cond);								\
 })
 #else
 # define ASSERT(condition)
diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 934d48076a010c..1b8990f1c2a8f9 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -101,6 +101,21 @@ config FUSE_IOMAP_DEBUG
 	  Enable debugging assertions for the fuse iomap code paths and logging
 	  of bad iomap file mapping data being sent to the kernel.
 
+	  Say N here if you don't want any debugging code code compiled in at
+	  all.
+
+config FUSE_IOMAP_DEBUG_BY_DEFAULT
+	bool "Debug FUSE file IO over iomap at boot time"
+	default n
+	depends on FUSE_IOMAP_DEBUG
+	help
+	  At boot time, enable debugging assertions for the fuse iomap code
+	  paths and warnings about bad iomap file mapping data.  This enables
+	  fuse server authors to control debugging at runtime even on a
+	  distribution kernel while avoiding most of the overhead on production
+	  systems.  The setting can be changed at runtime via the debug_iomap
+	  module parameter.
+
 config FUSE_IO_URING
 	bool "FUSE communication over io-uring"
 	default y
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index c22c7961cc0bdc..f7a7eba8317c18 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -18,6 +18,49 @@ static bool __read_mostly enable_iomap =
 module_param(enable_iomap, bool, 0644);
 MODULE_PARM_DESC(enable_iomap, "Enable file I/O through iomap");
 
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_BY_DEFAULT)
+DEFINE_STATIC_KEY_TRUE(fuse_iomap_debug);
+#else
+DEFINE_STATIC_KEY_FALSE(fuse_iomap_debug);
+#endif /* FUSE_IOMAP_DEBUG_BY_DEFAULT */
+
+static int iomap_debug_set(const char *val, const struct kernel_param *kp)
+{
+	bool now;
+	int ret;
+
+	if (!val)
+		return -EINVAL;
+
+	ret = kstrtobool(val, &now);
+	if (ret)
+		return ret;
+
+	if (now)
+		static_branch_enable(&fuse_iomap_debug);
+	else
+		static_branch_disable(&fuse_iomap_debug);
+
+	return 0;
+}
+
+static int iomap_debug_get(char *buffer, const struct kernel_param *kp)
+{
+	return sprintf(buffer, "%c\n",
+		       static_branch_unlikely(&fuse_iomap_debug) ? 'Y' : 'N');
+}
+
+static const struct kernel_param_ops iomap_debug_ops = {
+	.set = iomap_debug_set,
+	.get = iomap_debug_get,
+};
+
+module_param_cb(debug_iomap, &iomap_debug_ops, NULL, 0644);
+__MODULE_PARM_TYPE(debug_iomap, "bool");
+MODULE_PARM_DESC(debug_iomap, "Enable debugging of fuse iomap");
+#endif /* IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG) */
+
 bool fuse_iomap_enabled(void)
 {
 	/* Don't let anyone touch iomap until the end of the patchset. */

