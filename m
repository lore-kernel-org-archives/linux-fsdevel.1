Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABD83E276D;
	Tue, 19 May 2026 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229640; cv=none; b=SoFdtghkMPEADGYJM2MakxHbSjCfOLmRwFCfU92FnuCBQAsJsyV0P+CoQmou/m7TbOue102J9ESsaDufNogA3zNuQP9CABVw80X9r4IxeIxKW51K9nk7H9MRs6Pm0OL3hhbPNdppEuNLZL3Jyb/GWHuqXzgPi8Wk2ntkZiTmkcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229640; c=relaxed/simple;
	bh=jX5Ce8lxOAHgZVOlJVIxZkCZ0Y9qgHkb2NyhabYKrYI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0lswyqzPNS/icsBqQDLG9VhlI76EuuMaSxG6wML00hc0/xQAHEuExLAcQJ7iW6Vs2nA9yzKuvxnzQNay1yS4IRnE7qDoQZQ9FgVCqEFyYnnPiqtjuxJpykt1iMN7lNwuZ//L3aEoPHXNQmUJAmmpyXKe/NMqHlB42m6pcQGtfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX4Fsz/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX4Fsz/2"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A27251F00893;
	Tue, 19 May 2026 22:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229638;
	bh=x1ov0KKMsvW8s24tJj/quLTA61D9oXYSep+Mi8iqago=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=MX4Fsz/2ZYbVbn4dwDBDYyHsA3TX/OQEkocezGvTP/FVxAXkkDmuL9aGKeFhwgMmJ
	 BkAOqHZ1ZZpozRdXobO2pCRptmFia2JOCVETkhcOOL2NDQK8GODG+YIgIWlM5362qP
	 FI7DbyJ/RHHSPWVrvtxZ5oLiCuEhg7/YX6x2nnWxCSEFMXxzeoplCFI5yy/iYtr1Fd
	 8Zudu5kdX6LpXTwQyv2U7nGeDi+xGX2pwgInUdNdfKZChPPu2L7QsTCz1CAn4jSyni
	 5TGFZkoIFKv+yWxZfL3D0VN1Lp5sQLs4MVIUY72K18OfZ2MBSOJDxJ82io01IHX/hB
	 cc3Ez3zU3GtWw==
Date: Tue, 19 May 2026 15:27:18 -0700
Subject: [PATCH 03/11] fuse: make iomap debugging configurable at runtime
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945306.2436837.12055031549333269076.stgit@frogsfrogsfrogs>
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

Use static keys so that we can configure debugging assertions and dmesg
warnings at runtime.  By default this is turned off so the cost is
merely scanning a nop sled.  However, fuse server developers can turn
it on for their debugging systems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap_i.h |   17 ++++++++++++++---
 fs/fuse/Kconfig        |   15 +++++++++++++++
 fs/fuse/fuse_iomap.c   |   42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 3 deletions(-)


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
index 201577812d007f..24a5a7bbf5ca24 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -18,6 +18,48 @@ static bool __read_mostly enable_iomap =
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
+	bool now = true;
+	int ret = 0;
+
+	if (val)
+		ret = kstrtobool(val, &now);
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
+	.flags = KERNEL_PARAM_OPS_FL_NOARG,
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

