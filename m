Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D439B94A
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633344; cv=none; b=CLoehhdtJ4qF8f4tEuCewddYlq3vN0tWHts7ER+DgwY1UrIugWt0L649EI0ZxgCIQuT74bw/KM6TYOQ3p/7rqQZoPdsetSBHtPpgTOY5IkBXQgb8sPewjZ8WNY5aGM0RBZSzXcgEii3iJiAne+Y4ixUrvI55bhbpp7ffQGGzsEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633344; c=relaxed/simple;
	bh=Fv/OiQ1bnW0J2vPNKf91L9Akl/sJBzQMgAnEhO7UEdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8VkQaLLZO1sQRAdRN3TDXWlaz4qfIBdqiCK5to5chkZnq+Sxic/KUwbFu6H5L65nq1uOzvSCmIGNOp+HEhr6JBYuiSnupdEOjxhkzJ4tddECnwN99mw38nP75kQTlgi0+2XpT8QhmLif9aV4vUgCMqOhs5iAPjHiRUrlDCkjkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brCv+gyu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brCv+gyu"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso10592185e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2026 04:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777633341; x=1778238141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkx0SbVcB+vrfiwO5OKv0Vwto/EW891UcGdT1uFJmtM=;
        b=brCv+gyu/kz7RnEGt9CPjcygTi8NWhRI7vx0LiI1NV2yJNCK5bVpJ4w9ETQOsqx9d6
         NRJyqTleU2KAaZYA9ADkdVeluRo+xPeOdq542fsGfEGjgv66KVP7bbyMDPGOg68Rq9uH
         0oklUMCIB92qPGnNQfSZzqsHCFlu9nAF9XI85IkUN0IVRY7945dpa6nwdBIglOFLTy5V
         eHkZfOS9uLIPg9ePQ7veChjPoZc0F7XknhKJj5BNxABcX3kPiGcoRYfgRqxE9seiy10r
         R08yudyw0uDeYN9kopOoV+j/8McPjUKhC+Q8D0goAqzDqWlecGSfSD2ACpQGfhoj39Op
         tO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633341; x=1778238141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xkx0SbVcB+vrfiwO5OKv0Vwto/EW891UcGdT1uFJmtM=;
        b=ScN+zcD5redw2S+l7lEr1urNuiUjiPo/JfaHirXH8T9IlM759mlbMhVJKRQ//7/v25
         f35lDeN4P+UzJnLbID3V/nUp4e4yI+GIfrHD3MZiPgjMiM6VEz/v+obogxFRnSKLucGn
         qxIiSCfXFKJerJFT8qvKBh6bUntO7w8/aB8aMjILGDb1WnagkIPJhIHzH6xMtxAtHmat
         kq+3X8ODH3ROyYgpbb/QuuS336x3oFMqGUhw0rzbF7IEs9OxYC0Df9ghNKnfMWDr5pGF
         zXfBi7BWixzRQuY0JTIfepMs3RFlktANaoUqaX+/gnOTDbhDcg2qh68+MT99EI7wPq4E
         KLFg==
X-Gm-Message-State: AOJu0Yz7UkizKEAWf9vU8qzMSKgOQxyIMdUTmzquC6Jk1wL+buUW8tgL
	6Cfd4it5aMTq/14Q5ZoEUCX1zWOHju/vkZWkDJDg0bDD3RrlGN23c8A=
X-Gm-Gg: AeBDietn9tHQ3jisg10bRWiCPKehGUMqTn6IGzRCWRbV4GbCQOqg8CAQmla5ce3jBpi
	zoxYJ7l390ZoJMBcBlwckm6irFya2uui+KvuyZok7MQCnMGTrWdFnkOI25B26ZvEQ40L5xK0Nib
	hiOGNEjtPRVHmFz/xwI6xHoJKh16JXq6mFCczhL9ICMrFDnB5iOqxLC+tnAl6ILtNPFPfHmaYKp
	BwoDmiQ0NCL25O2w/Pbin0ZghvLM2+n+IMDB2cfgqpNp+DXonetyrKkNQrFH9j3D+4JbHeX/B2f
	SfasqrI6SAkm4x86zd15yQTD3t9reMb3Uw5zwCZveXZkEwhUf9oa/VYnaeUoxTPCLKIhTg2Vvfe
	dO1wmjww/cEhEFM1yzdWnVPoWkDa38kGWBxCKLxsm6lnn3NT3lBZe0xVoBh7Kjcyxnwso7dokuC
	pAnWA=
X-Received: by 2002:a05:600c:c10b:b0:48a:5821:5ff2 with SMTP id 5b1f17b1804b1-48a844eba7fmr87053555e9.8.1777633340787;
        Fri, 01 May 2026 04:02:20 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c8556sm121627405e9.4.2026.05.01.04.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:02:20 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com
Subject: [PATCH 3/3] hfsplus: fix null pointer dereference in hfsplus_create_attributes_file
Date: Fri,  1 May 2026 11:02:17 +0000
Message-ID: <20260501110218.29906-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501110218.29906-1-tristmd@gmail.com>
References: <20260501110218.29906-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

hfsplus_create_attributes_file() calls hfsplus_mark_inode_dirty() with
HFSPLUS_ATTR_TREE_I(sb) before sbi->attr_tree has been set by
hfs_btree_open().  HFSPLUS_ATTR_TREE_I dereferences sbi->attr_tree to
reach ->inode, causing a null pointer dereference when attr_tree is
still NULL.

Move the mark_dirty call to after hfs_btree_open() and guard it with a
NULL check on sbi->attr_tree.

Reported-by: syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bc70a12e438dadba4fb4
Tested-by: syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com
Fixes: ee8422d00b7c ("hfsplus: fix potential Allocation File corruption after fsync")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/hfsplus/xattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 452a1f9becb2d..1ea9f313368c5 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -317,12 +317,13 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 		next_node++;
 	}
 
-	hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb), HFSPLUS_I_ATTR_DIRTY);
 	hfsplus_mark_inode_dirty(attr_file, HFSPLUS_I_ATTR_DIRTY);
 
 	sbi->attr_tree = hfs_btree_open(sb, HFSPLUS_ATTR_CNID);
 	if (!sbi->attr_tree)
 		pr_err("failed to load attributes file\n");
+	else
+		hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb), HFSPLUS_I_ATTR_DIRTY);
 
 failed_header_node_init:
 	kfree(buf);
-- 
2.47.3

