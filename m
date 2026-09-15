Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1533DEF7
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489833; cv=none; b=NcFIAr4Ri4FBiaTA5LiYgaugQfsmbQ9Z4xlaK8iWV6GLkGLevA9UjA1tyR+MiCkWzYSuz2v1318PXZjrL7/3HnO8mBZEwHyOeRBzaISGHDTylZj8GGJk1yv9zRud+t1A9TlbigqpvaYHiZseIiXtVsGJ7TYcscrkIcsu1Md+IzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489833; c=relaxed/simple;
	bh=hFPtwixBRU5C73Mm8F5z6LrifwBlnSEGH5U3F3aaifw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZANcei+m8vx3YOZ/M9T4WkRLU9wi5cpfEBp9sxe0eCjAeCQ7ZvKO6luwvUrl/pTD2zmbpjmtVFqdjEHRtQOmEMO95kQK7xoQoe3hiAfIHA6HfuIM5NcFYOrhI/IBlT14VCysJME+5ITetoi8wrpVgYwGqhU5Aqs4KkGvVmgfNjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtVWeMz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtVWeMz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883A81F000FF;
	Tue, 15 Sep 2026 16:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789489832;
	bh=hArmy0s1DYARQYgiC6jKoJJZ2kFLjizxdMLebyW+LO4=;
	h=From:To:Cc:Subject:Date;
	b=mtVWeMz0sxhUaGG43AjQ9wTRQB0NzNUayja2MGgoObL9wJBXdJE7Hc8pGsPIc1nAs
	 O/lQfFdhUYFqUQLVc7PUyEbbRkgenU8dLBHH5jZ2FB4eEDajT3T1BYFC3LG+zHlXnQ
	 ZWkaOXrp6iinYAJuRlvC2GvBNRPioboIhmo+rTrxwPxHiNJ9ldOoXe/87L4QsOA+AI
	 zndyeo9+5Zx8qZqBSc/13+iQv4ouSLxeBtl38HqYEWqTjWG7+9LPMuXTMnFr73vHNh
	 MZ9sJ0UMVuuH8sXuCLc8tmRWnvEQ3A8ofAMHesWorGhGRo9e9+SgS8a97+UPPnwj81
	 UAi3CQTtkbi1A==
From: hubcap@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>,
	lkp@intel.com
Subject: [PATCH] orangefs: use ssize_t instead of size_t for error codes...
Date: Tue, 15 Sep 2026 12:30:25 -0400
Message-ID: <20260915163027.500798-1-hubcap@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Marshall <hubcap@omnibond.com>

strscpy can return size or errno.

Signed-off-by: Mike Marshall <hubcap@omnibond.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604071606.asPgJ8Fk-lkp@intel.com/
---
 fs/orangefs/orangefs-debugfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 9f94919a6bc6..fec7c1e864d2 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -238,7 +238,7 @@ void orangefs_debugfs_init(int debug_mask)
 static void orangefs_kernel_debug_init(void)
 {
 	static char k_buffer[ORANGEFS_MAX_DEBUG_STRING_LEN] = { };
-	size_t len =
+	ssize_t len =
 		strscpy(k_buffer, kernel_debug_string, sizeof(k_buffer) - 1);
 
 	if (len > 0) {
@@ -246,7 +246,8 @@ static void orangefs_kernel_debug_init(void)
 		k_buffer[len + 1] = '\0';
 	} else {
 		strscpy(k_buffer, "none\n");
-		pr_info("%s: overflow 1!\n", __func__);
+		if (len <0)
+			pr_info("%s: overflow 1!\n", __func__);
 	}
 
 	debugfs_create_file_aux_num(ORANGEFS_KMOD_DEBUG_FILE, 0444, debug_dir, k_buffer,
@@ -337,7 +338,7 @@ static int help_show(struct seq_file *m, void *v)
 static void orangefs_client_debug_init(void)
 {
 	static char c_buffer[ORANGEFS_MAX_DEBUG_STRING_LEN] = { };
-	size_t len =
+	ssize_t len =
 		strscpy(c_buffer, client_debug_string, sizeof(c_buffer) - 1);
 
 	if (len > 0) {
@@ -345,7 +346,8 @@ static void orangefs_client_debug_init(void)
 		c_buffer[len + 1] = '\0';
 	} else {
 		strscpy(c_buffer, "none\n");
-		pr_info("%s: overflow! 2\n", __func__);
+		if (len <0)
+			pr_info("%s: overflow! 2\n", __func__);
 	}
 
 	client_debug_dentry = debugfs_create_file_aux_num(
-- 
2.55.0

