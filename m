Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C810A42AF9D
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489607; cv=none; b=O4089LxXFMCk48xW/cobTzymWg/irZ4Owh5+BS5pngCjI2FiOGxoaHOTB+H1+BKTS/F60BfZxIfYfW3yFVFiqQ/wYVOsu7yVRkw2OeqE8GEmSIRDf/gwbLjLRLaa4OIegh2O/oJ8gh35vpnjWZ7+wX8jcCGvtz7grXLDazozxjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489607; c=relaxed/simple;
	bh=kqx4XSzosXM/FuHozyi3YkQxepdc8QGC58mjew05E5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QTsQ+i3+QZkho4xYNG6Q4O4oOrnk/sCw1hwRBEmQxqTnR7ZDySh7AUHIRO2yUc2oV0QJV3GuoGAWB5xckdAcNtXEhMMTKxEcInCOWIzqKXACbYrSMluQTPQ09GQgmlsyRzH8trttPN4gugHznqac0Ec1e7fV3KGDOLFvdtk6408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+J0anu9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+J0anu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B581A1F000FF;
	Tue, 15 Sep 2026 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789489605;
	bh=O1/T+YthcYQiQcvgOlcg2zbQ/FH+7l6CzfyhXlvMrGk=;
	h=From:To:Cc:Subject:Date;
	b=n+J0anu9jfmEi/EUH2N2Gu0+ltsbzQJe4Krwfaxgk84Q67X19N9nIuWGsQgeI6oB5
	 QjiYVvgNtbM6rRb+RmSWmMi9+3gHk+yag6A8eQ4gPKO9kTZk8AsWjP/VbjB7vmXf/Y
	 hWkbzi6fl5245TTKyKgNTvsWDHIgTl0trkScdxaWL7QOkaYfMl6eh16ne7hWKjnxm6
	 3f6HGgnB5B5XGpvbSZGIf2RHLOa+GvH1cqMgTXG+lVWtRL99TCqtFqSqPBBVahPpFv
	 1Am5MjvXR9KLVsr8iK/p6yvnO4a5UyvB5UJTSTLEv+i7Yz69gIMtAoAJk0TJOBwbtS
	 sH3I2mWXkoU4A==
From: hubcap@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH] orangefs_super: don't wait on service operation on system shutdown.
Date: Tue, 15 Sep 2026 12:26:33 -0400
Message-ID: <20260915162637.499735-1-hubcap@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Marshall <hubcap@omnibond.com>

If someone reboots the system while an orangefs filesystem is still
mounted, don't wait for the completion of an unmount service operation
that's never going to return.

Signed-off-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/super.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 4ec7329b41f6..e6eedb2faef7 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -383,6 +383,24 @@ static int orangefs_unmount(int id, __s32 fs_id, const char *devname)
 {
 	struct orangefs_kernel_op_s *op;
 	int r;
+
+	/*
+	 * If someone reboots linux without unmounting orangefs first,
+	 * don't bother firing off an unmount service operation that
+	 * will never complete, or the whole system shutdown
+	 * stalls for ORANGEFS_DEFAULT_OP_TIMEOUT_SECS.
+	 */
+
+	if (!__is_daemon_in_service() ||
+		system_state == SYSTEM_HALT ||
+		system_state == SYSTEM_POWER_OFF ||
+		system_state == SYSTEM_RESTART) {
+			gossip_debug(GOSSIP_SUPER_DEBUG,
+				"%s: dirty unmount.\n",
+				__func__);
+			return 0;
+	}
+
 	op = op_alloc(ORANGEFS_VFS_OP_FS_UMOUNT);
 	if (!op)
 		return -ENOMEM;
-- 
2.55.0

