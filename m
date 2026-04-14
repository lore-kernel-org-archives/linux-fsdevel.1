Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B8469D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 01:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776129192; cv=none; b=tHIgGsHvzhIUWMW/7ASq7D+f89r7YG/KfVVVk9fvKdFPYV1mJkH6yMwFowINxw0GfVBnOLz8gY5NzoExTWyLopAX3JcGLHyhcBuOB/X1LN/buyz8inxTdJVM09QnYbkXjLXHrMsFFYoQ33Rv0W9SfWG6m7IpGsbrfrlbU252VxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776129192; c=relaxed/simple;
	bh=/YNbRbuUn0se/eOxh9EWYDr7/E/hoK/hBbsC2Ksi4s0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OpsU/uH6Gw6f7/K71nCawHwCYfjGpbCSEpNMXZ8zNTZRU+0wasdL134/bNeUcgY6Yac3TJuakJHeIq3fVr4lnLbW/B+y8v4tNUO0Qe2blp3iM7jcPb467JM6gOVlzV0OfYPCeUC4qBNEDunr7pN+7p+IvX1/JCGEU8EefNj7BiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmAxUGF+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmAxUGF+"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35fb7c1a455so632768a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 18:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776129190; x=1776733990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K2UbA4pmTQcH00NyW6Az7G0FxPyEU3JCK2aV1c8PuUI=;
        b=pmAxUGF+SEFeXZlvIdYJ7WRv9ZpLK2BN0woJPBdKx/vXbhNyY60p5+HdjeiAyFb3Ta
         gignrqSy7lsQoMPBLiSPttWd+U31LNn9dDI4jRgybn8z+zTtyry9ZycgGa07DslYayWs
         UCiwqNQ4X+si8TYBdpYroM8vvav3rdpa340RrQo/V8XSJU52o5wuUydo625TpWq+6y5M
         rg33yjZpBgqcQyVAe4gRUI66YySyWMqbGdDlW58cQuTaQMlecO4EAIxoMQt0jYzqnyJj
         KJiPk068F55YU6ixuSi7hCRTUc45Egt0G4OVq2p/iIxy+TXnX2zu199fqlDw2Qs2R50H
         0jCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776129190; x=1776733990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2UbA4pmTQcH00NyW6Az7G0FxPyEU3JCK2aV1c8PuUI=;
        b=Ht1k4hcMZZGcW/9MEooUVfeV0IkAIHg6fRTnRoX5O+ZHCk9wTu9jnGx8AWwAxLNIBM
         zwiKLdm+gUcdOCyTf/5J38Rl5qlLHNv2TiqVoiGZBPSJarI6YNYw3/LO9RxeYf5g8Z+B
         UgXdjoBfRIlX2UhJorhjkGnMjhjZ1q/ZuafVSyvXk958N4nWMUOvYvuTSZ0G1LOeH0g9
         9ge4nPG9pLPYN2g0sWj0DPLxD6WGq5jQ6Tt8R6Jm1mlQkxePAf/TjnBHBwldWfO14JHS
         lviGzUdxfUKkFD0Z67Edi1TB5dtZiw1HZ1lnJReW6FnvaEP6siASz1pQjwvzbho4xk2/
         MizQ==
X-Forwarded-Encrypted: i=1; AFNElJ+TT96zj/tW2SVzKnpLQAyNa9TeZJNjqunwVkMkkl2mSSTLt1oup3Q+HUBj/d0fwQoyqqaJhdCmxxT9dRfs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+lVLl2S9Vvfpn7kqVC1M6ju1SJucNZISpnTHqBmqsY0qj2ksq
	CHu7TN5oC+FewJggcXKTHcBV8WELwKLYRWaBgtcn03M4whnh6Bsudqe5
X-Gm-Gg: AeBDiev6uwW/k8D2Yw70BatUXmjTpZDuwWviSlqreBfS9jsYV04yZJYaXhQgmUCCdlR
	iYQ0eYsirKkTf8454UrSPLDW9Wjx73M1F9fCyYSf4VgOSfg4AjlWF3OVwZ8lEtLIlUeZJbKllEa
	//szLVIX6wmixsb0vX5iVV+nwppyMfdq44ugVSLRXw9eQxFQL2nL/TpWXx+qzyh7BneUpFmbJcq
	jZKCAtqC8yHEogOzRwEPWPB1t7Py0tiUSeYmByr+pKXbG6qQsL3Mv5kgUvFZTXHkaZVjQwRvvOK
	vXYaWxBZUGACIjCOUdKKsd9Wi6L2NiFoaFFm0Puh0D5X6GdOqwbA3pKkiKZs5zcSkT0fRC7WigK
	N8TFz+ujIKG3ECy2uqda+gaZT5aoDDn3H9LYQ98x4sXI7KBnb1/PYYEQhAFWqt/DAkuF18Ai15I
	8QP4+WbctIjiTyCr+H0vltgXr1gEJsDAS6BAlxaZffCnSnLPl4OD/eTl06lf4BKi71ssBGun7Uu
	1MjvtLpYcFXCnqyfg==
X-Received: by 2002:a17:90b:1e08:b0:35f:bfdd:f5a1 with SMTP id 98e67ed59e1d1-35fbfddfb16mr3220626a91.13.1776129190256;
        Mon, 13 Apr 2026 18:13:10 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:445c:f4a3:a803:e3c6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc6e8ca0fsm251344a91.14.2026.04.13.18.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 18:13:09 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Subject: [PATCH] hfsplus: fix ignored error return in hfsplus_delete_cat
Date: Tue, 14 Apr 2026 06:43:03 +0530
Message-ID: <20260414011303.61374-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfsplus_delete_cat() calls hfsplus_delete_all_attrs() to remove all
extended attributes associated with a catalog entry, but silently
discards its return value. When the xattr deletion fails due to
filesystem corruption (as in a crafted image reported by syzbot),
hfsplus_delete_cat() returns 0 (success) to hfsplus_unlink().

hfsplus_unlink() then proceeds to call hfsplus_cat_write_inode() on
the inode in a corrupt, half-deleted state. Inside that function, if
HFSPLUS_IS_RSRC() is true but rsrc_inode was never properly set,
main_inode is assigned NULL. The subsequent dereference of
main_inode->i_nlink triggers a general protection fault, caught by
KASAN as a null-ptr-deref at offset 0x28.

Fix this by capturing the return value of hfsplus_delete_all_attrs()
and propagating genuine errors back to the caller. -ENOENT is
excluded since it signals normal loop termination (no more xattrs
left to delete) and is not an error condition.

Fixes: 324ef39a8a4f ("hfsplus: add support of manipulation by attributes file")
Reported-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c0ba772a362e70937dfb
Tested-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/hfsplus/catalog.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 02c1eee4a4b8..adbaeabc06ab 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -421,8 +421,15 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 	hfsplus_mark_inode_dirty(dir, HFSPLUS_I_CAT_DIRTY);
 
 	if (type == HFSPLUS_FILE || type == HFSPLUS_FOLDER) {
-		if (HFSPLUS_SB(sb)->attr_tree)
-			hfsplus_delete_all_attrs(dir, cnid);
+		if (HFSPLUS_SB(sb)->attr_tree) {
+			int attr_err = hfsplus_delete_all_attrs(dir, cnid);
+
+			if (attr_err && attr_err != -ENOENT) {
+				pr_err("hfsplus: failed to delete xattrs for cnid %u: %d\n",
+				       cnid, attr_err);
+				err = attr_err;
+			}
+		}
 	}
 
 out:
-- 
2.43.0

