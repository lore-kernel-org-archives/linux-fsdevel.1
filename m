Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB3E8632B
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 01:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777081500; cv=none; b=j2mG5SVRwn2afjYLYXgP8vu7Jac3mfEuP73YGzaZZ2T9u2RGNqT5i5j7lPA7Y1ZljaVVpjLkXkI7x4NHutnFIAV3LvPRYbsN1Dlhx0GrXbS4qWTInrMDdGKbtg0MagWiDk4tzykREy2vH7ebAT1oJlVIoaCoMkH2efopnmmIWyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777081500; c=relaxed/simple;
	bh=qZue7senG6b4XUkFKuZtdgmK9m9UKeK6LxiMzBxt5YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+AkwW5yqFgvljS79j4B3HmkLxgkmo8nyIKvSB5kot5tzVt8FMz1mGl4gwXe3xLdHTG1J75yYGp1gdRgCXPQpRAThkAbUT/RITjMkDs4aRxKY9WSQxWyUnsFEoGFzYEx4byqslfkjVh/zrTrH6wmIf5Jh/NNhXIL0ZJUZmgPv/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQtUbnBV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQtUbnBV"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b2429f98d0so50009005ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 18:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777081498; x=1777686298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=znLTJ17e6o/9Uqg/bPhe5m+mdqnwh4CGLhNQYDWa13A=;
        b=cQtUbnBV4eoNf9ulQ89xER0c5pV+Ik+wLoVt86B9lQRL4ODJGcV9u15jDGBd153Ilc
         a7f3hejNRdVz9fGAdlE7pUOnlrD0PvBEuoMthl9PsocRo9QX9y5HzMkoqOopGK1crBeV
         qfkZUjLXesy2ORsE89wMAWCv5xFde1spNEajbDkhCoyCi+bun3fJTm2qaevN9dBFx9fm
         a4ITBzfhH3yf6kHHL+kaTBDcteQy/CvR/eML4jc15R+gxynWej2acRvYGsFiEWfY2MUm
         mw+f721qeP8hwJpAkvqSRrKDeAqhXhZ7sbL0yqPJiPgLN6xg7jvOTz/wUQbiIBqufGUf
         hQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777081498; x=1777686298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znLTJ17e6o/9Uqg/bPhe5m+mdqnwh4CGLhNQYDWa13A=;
        b=hGWHlvoQNCdzsKYZVQ/0gFpusXisYBc9S+JXVuDZA6Z8eA5Ct5xWy/08P0+grASA7D
         zmW7d+x9omRQi+jJtImIGmFUqd9EHho2EMTW6xJFaBH1XOJFDgUR6NejdvmYZbCkv/Ab
         jmCdcbrqpI0GBE1dWvyZKMelVE1P6dpCFCD6l27IYH+mEKqC3CAPuRcTARs5sx2QyZ1A
         ae3Nt3athvHiseCANiIvjQm2Kp5YXughlyoIFkTWfuVoi5ALpdKErPbRb0vjns63WiA5
         cdvJ8ns2GSFe0B++kHIj+I+oo1duQzV1ndMfrk265AYS0mox8bymYYkc6JXQme0ggqSu
         lOXg==
X-Gm-Message-State: AOJu0YygtBJfkOBsZtD3LaXyS+exaaz1KUUnEskCmF998hhEBi7NJY27
	oXH7sN9kjOYhH+QFPOeoM6dC6eJ4+Ud6IOmR0weA3FsehZsaocZupq7IaMKhP176
X-Gm-Gg: AeBDievDt/3B1wy3UwWjeCcPBU/3grsepYVEFMb2wiqgK/imZNAqZ2sLX9EbQHDkpAm
	0M20zhVWWNUCnO4rZOh/BZTAPaz3Bo/x/BoQN3TzptvLKSIKz5Ng5V7PNZ2dyCgXhI+1WxZs3Eb
	z+8e4gIa9AgBwx+RjWsz6Wkenw7ISaYnMpYDHD1pOyVK+Evculy6tNeXN1lTPr+ryYIkh08iZPC
	/NAwsdJgEHbYNYn1QhjY5fT0dQZTMI6VwFhL+akC9D76zj/GqovIsiuQqrr3OZ1s7mgOBvcF8v2
	u/9KZto+GTClnpXx1wSe6GO961iudf7zZi9VdkcQFXVHl4ZGtO14yM1UHp7JRdRRGy+LlKES9ee
	1hNaHdU+3aUP/OkPfV5wq4JZLcGLmD0uDTUqDI9P/uIQPKYsXR3eO/IoCnlensg/3X1K1Cbr4fr
	0YmxV160Kg4KBibbOAUHN/J4EZJvzgvXwhYUGoiahn+z3DD52jnfBWULAV+j1HounIHyWFQH3IT
	o7nyQTA4aUXx7SYE1hGVyYW/g==
X-Received: by 2002:a17:902:7585:b0:2b2:5704:5715 with SMTP id d9443c01a7336-2b5f9eaea6bmr225039135ad.15.1777081498255;
        Fri, 24 Apr 2026 18:44:58 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff729sm295697015ad.15.2026.04.24.18.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 18:44:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] hfs/hfxplus: use kzalloc_flex()
Date: Fri, 24 Apr 2026 18:44:41 -0700
Message-ID: <20260425014441.441252-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of doing the math manually, use kzalloc_flex() which does it in
a cleaner way.

Also clarifies which is the flexible array member.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 fs/hfs/bnode.c     | 6 ++----
 fs/hfsplus/bnode.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 13d58c51fc46..b0165de7640d 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -344,7 +344,7 @@ static struct hfs_bnode *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
 	struct hfs_bnode *node, *node2;
 	struct address_space *mapping;
 	struct page *page;
-	int size, block, i, hash;
+	int block, i, hash;
 	loff_t off;
 
 	if (cnid >= tree->node_count) {
@@ -352,9 +352,7 @@ static struct hfs_bnode *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
 		return NULL;
 	}
 
-	size = sizeof(struct hfs_bnode) + tree->pages_per_bnode *
-		sizeof(struct page *);
-	node = kzalloc(size, GFP_KERNEL);
+	node = kzalloc_flex(*node, page, tree->pages_per_bnode, GFP_KERNEL);
 	if (!node)
 		return NULL;
 	node->tree = tree;
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index f8b5a8ae58ff..a717fa008ddd 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -455,7 +455,7 @@ static struct hfs_bnode *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
 	struct hfs_bnode *node, *node2;
 	struct address_space *mapping;
 	struct page *page;
-	int size, block, i, hash;
+	int block, i, hash;
 	loff_t off;
 
 	if (cnid >= tree->node_count) {
@@ -464,9 +464,7 @@ static struct hfs_bnode *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
 		return NULL;
 	}
 
-	size = sizeof(struct hfs_bnode) + tree->pages_per_bnode *
-		sizeof(struct page *);
-	node = kzalloc(size, GFP_KERNEL);
+	node = kzalloc_flex(*node, page, tree->pages_per_bnode);
 	if (!node)
 		return NULL;
 	node->tree = tree;
-- 
2.54.0

