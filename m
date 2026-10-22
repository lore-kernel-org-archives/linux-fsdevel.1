Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792712178;
	b=zoOnB+zaxG9n+1LI/xutAGU+NbAwKV4/uZL+ux5cdW8kOL5Qi9HNkZZF5oREbn8muX+L
	 iFVp4Js0k8l91+7In3QtQKhipEXQfDCyj6xp+83f+OpYIrKQeePyrvxMwiwu4TIutYz6B
	 tF/lRWMuONDVM/zPWW4sAc+hHWvJUHYc9yIOeBR6QAdKMpQS4Lc5zZbqC2G71/xR3sEKQ
	 AMlXT7Wm4hc9aGu/lJyUj//Hp9LV0GoaluoD7N/7SNdniVe7nsJmhoxzbfvjDuJBzyb9o
	 5RHdBAxv4Ho4+4T81p1ZzeFRz9t/QgVV3OmhMxzUS/DocpGCi1DxDqhTRru0ivd7orA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=mKGa7EehFPI4Q1/tqBU4Iltp3oRRK/Y5Z/6eWwvfEFI=;
	b=1cafO3aNdyUcMssGJIyCEY0JIBI6YhWhgjuP0V3qdZ582BWl85uvrT7xs4LJoH/Bqp7V
	 ANKTnaj/IzP1gOkZEzd2cWrPMQugvwJJS2Yc8T0PM7hxEAOtnuLcw1nKTDFAFuePtsdD2
	 1xdvBvTlWx1e4tDX2pFuWTryasdl+sqjh027HCq3PEA7LRXI2d2R/X9Ga1nvicROdAXsS
	 NUjccooCvwabCksvfGu5jRGsmfYA3K/m8+2pQabQhw2SltxMsBubKuMDbFYNGey5na2hQ
	 CHlBjzVyR1MM1d6cXYOBj8Ha8QLy77yD5OzMd4Bk/JN9UV3I7liuLdfUnrtfFCrBvLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=qUVTWYcx;
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36663606A741
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 23:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36663606A741
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=qUVTWYcx
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-679334baa1fso410534d50.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 16:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792712176; x=1793316976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mKGa7EehFPI4Q1/tqBU4Iltp3oRRK/Y5Z/6eWwvfEFI=;
        b=qUVTWYcxvTzrDYcWGY2zqQZwec2KmCjicr9AISCQtrcbw2rmhthhyGlTplb6CpijjB
         TsH3Sy1EENLm/DCNHxw3egtVaOIZz+gltsWtutUp5yXJ+pjuMIMB8o2SuxOqbFpMoLDU
         e1eyi9sPujbV10zlmJHn32xltCkZJEGslZxfsQ3ceWKXOrhb6FMnX1ybAJIXeONKqDtn
         DZhphrzNUm+VRNAfGcTIMDSV/MLSP5zXcasDvf+9kqhJ1bJZVo+9OcXUyxh8CKjeM+mZ
         cBvpTgScq7MITEr+zKkmv0250Ik6SbKvvmlF27egVdWDPqXT+eErRo4VNMyDUstIt0kl
         WtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792712176; x=1793316976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mKGa7EehFPI4Q1/tqBU4Iltp3oRRK/Y5Z/6eWwvfEFI=;
        b=GXJUc9I3v9nOlUFHJffgG0XqIZoHY5LZI9T9fGLs7ewwLK+v9UuS5bH52XVkH6Hz99
         bMsuOWFodpWcwdLcqly+g3wUx1RVvG2vPpVarLnEE+LWtJ55pTgbf3AMI1H4pxakQNub
         FX4X/JEUw+18yqu9A2SMcynYlg3ZIEadDd5nrzj5js5yoK/QYnIAz0bP/8pvNsXdybPq
         MDqfjj1xWcoDKQ97iS0iH7oqd/M7bCz7gGqaiPEki5KSRgHZwbvnOnTYB5dAUuVbSZfV
         jFQkQcwjGcd7g/VtW0bbpNeWSQdCSBMLBTVk1HRrms+muJ9xDHR9QAw9joFEFfqXORIw
         NOOg==
X-Gm-Message-State: AFq9FYJk6RkX1lJKpDgxg//7c+47wFjS2k1hlufrJrGeTfdtZXikyOOP
	QfJ9bD+eO1/R4aHvwXOZtve1x6H7ut92bwmJ2u0YU2uA05EvL3ofkY33VG9WNx3bmKY=
X-Gm-Gg: AYBFou1XbDuA7KT6JuyqBYbq9mbIxKICD5fiXEXtP7tOrWWKIvdFY/MSTdVgQ5LMOAz
	UPcp81ZpSH+0wnU1ctAJ7kZA8R6WWnElkmVYMeb1nG5Dy6Rj1iDuyn9Q4s4ABuNda8LeyLYEQyh
	0FOM0Xqb8YmUGb8ToSYVjIJJr4FslvbOXXcTrnSSyOr4KNnpmq8e8Ckn6DDhoTQTkcR+mHyQ9vs
	VCNsDLy6OnVwALhE1GQTyPMz73KVVxMnTxMdn8/Bmtsrpl30CP2/jlJoQdYaIEB30+Lepq+lPnH
	yXAAGqjPIuZmwa7MQ/BcbeCX6tzBlxeS5NLInpIMk1/1RmPK7o4JIZrhIwMOkiCfzTn/9yZHfxb
	pNDlQyykDqywBvdQF3KOf+bQO5j8QL7T4OKKKY4EtJu0lZdnlBDZ/KzyV/RUJERmZymx3PNkELo
	DD5j+h7vZfzOxFLM4wdMmhYPGsUAYSaIWqXCnW+AuWXkBejcVrnRayQqm+C+CbpjWx1dKUWeShs
	lCWbnCUcXqnc+L3tnhXMfC9JRHcDy+6Kq56My1z7V5IxNFeWZGsYB1LuE0B5l52UazgFW+wMrTq
	kE3nAjD0tlXdem/LmnvTWnVsxEWuTKfjnCT78/llV0BSpAV+BHOFzoOwWeg9gSn9nTBYStczSSp
	beMHDKr0grw==
X-Received: by 2002:a05:690e:12c3:b0:679:9a92:5d70 with SMTP id 956f58d0204a3-67a359e6e12mr301041d50.13.1792712176201;
        Thu, 22 Oct 2026 16:36:16 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:5551:17ca:f374:dc57])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a34009247sm487643d50.11.2026.10.22.16.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 16:36:15 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs: fix logic of alloc/free b-tree node
Date: Thu, 22 Oct 2026 16:35:46 -0700
Message-ID: <20261022233548.3481882-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hfs_bmap_alloc() and hfs_bmap_free() modify
the b-tree's counters and nodes' bitmap of b-tree.
However, hfs_btree_write() synchronizes the state of
in-core b-tree's counters and node's bitmap with
b-tree's descriptor in header node. Postponing this
synchronization could result in inconsistent state of
file system volume. Add calling of hfs_btree_write()
in hfs_bmap_alloc() and hfs_bmap_free() methods.

HFS port of the HFS+ commit:
commit 63584d76765b ("hfsplus: fix logic of alloc/free b-tree node").

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/btree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index b140d8597474..27a515a3dd0c 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -458,6 +458,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 						set_page_dirty(page);
 						kunmap_local(data);
 						tree->free_nodes--;
+						hfs_btree_write(tree);
 						mark_inode_dirty(tree->inode);
 						hfs_bnode_put(node);
 						return hfs_bnode_create(tree, idx);
@@ -478,6 +479,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 		if (!nidx) {
 			printk(KERN_DEBUG "create new bmap node...\n");
 			next_node = hfs_bmap_new_bmap(node, idx);
+			hfs_btree_write(tree);
 		} else
 			next_node = hfs_bnode_find(tree, nidx);
 		hfs_bnode_put(node);
@@ -545,6 +547,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
 			nidx, node->type);
 	} else {
 		tree->free_nodes++;
+		hfs_btree_write(tree);
 		mark_inode_dirty(tree->inode);
 	}
 
-- 
2.43.0

