Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F207C37CD45
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213201; cv=none; b=KMzgLyjbk+epw79BHs6EP+emK8BfeE8BKLQqNwxi3uwPfGrGT69lOeXvzV/io+u0F2OBPV75Sf3HDUs+lx/0T4CGaVOgJTtXMI/+4RBza65IkvNJaEmAo/NyTqxpfJsybvKDm4d60o9Y8PRJ5ZE+fetpwQCA7TBI471pmGZh/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213201; c=relaxed/simple;
	bh=QVK2lomjarxdqch8q+GSBavjR9vdvfKqSb0/h7sbjJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OLxfpKntxKBJ60bySW+IGUapr+JJ66pozQUrHty7IMX0Hhjr0Nu04yKpGlYsP2E7UhYTezavfRlSac0DZofFk2pBxGi5XzMJCvG0LF/fyLiK+oK/jOd0lO+RTzYBknyNqF+YLtDNY2XF/hwk+/yp/44ATRTHKA6h4vrAMy5g0Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Jjmgrg9m; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Jjmgrg9m"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51764768c36so2973941cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 14:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781213199; x=1781817999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7Q/1mp0xAAOLVTEgA4L3BLOHmcED6uIGoUmCZ9Wsh4=;
        b=Jjmgrg9m05Ht8/R6tOs84ZTTJCH0mMlR+FRxGhh2N4Or9vE2zdjTNIsUwis15f1YvM
         oTEXiAqRaHXMPlUvw2bimUmT+QBvYqE28e6EkETgcTHmrKPF+nB44OUjJPsj5PYhg/xS
         tbaZ7eAFJD+LRV9QTKMKTmbROYVxo4rIfxlYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781213199; x=1781817999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7Q/1mp0xAAOLVTEgA4L3BLOHmcED6uIGoUmCZ9Wsh4=;
        b=S6tVIqR4/U3H7Sp7UukSmwbckUteF64nojmtBLJxbwCQ5k56r927PP+xXV4QhW/Tmc
         1pWj3YnVhUgjT8SxwRJRhAVgvPDMIJb12DHtbYn5uutcCgpswJ7UPLw9gIvT8d+P/MPS
         eHGJ+p+0JzipC2uv4jMwEg5VfTqAtsvNIOCaB9VBWR0PQHQRz62WY293Q7rz2iDK2pZR
         Xw1QNxBrIq7vosBl+IVUGGw8gi0tEIG4sYOuDwlIVlwALmUvHYodo2i9YX2PfyKgjrwS
         QMpJ/+NaJs2VlUuYfjI3hnWQkWPfiq1uaCvHL6v9VH3pznym718eIuIojB19Cr4tjVhR
         cTpQ==
X-Gm-Message-State: AOJu0Yz7DVmAIKEOur4rpB+EPkCu1uAqlHNef5udJpvDc+opL3JmD31B
	z1xiEjfOIhP7PPQ/8mLf1l4SA+JW/YhlxKBHSXPyxW83+Vcbx1TYobkCUMgc8yVdew1Mvo3vKI5
	0fvwhWUI=
X-Gm-Gg: Acq92OE0+YHESzDFviY2gxUkmC1PYLT+mMCqOj8mbZNp2dzoPiHrTE5Lt+P3f+0pSef
	+CpXvTL847X9ESRqOZ70xS23t3SqccbD/Q1kKlejQSiP1g6HAPfEptrhOOms2aP6B/TjmV6tn+4
	8tt8DGjDmWbJTuZUccRz/syiXdhAc3iMbDYnoUe3vLURglb6HGG3AAgbbIIDJVJZkzFq3JTcB0G
	gWTNm3iuqjFhDWC8E09CkrpVEtyXY21MdOm87GwGPuMiqkKdKTShqhRPjVwJH0BLpIO2BrBK1s0
	nx3pcbT8drYlZu2LqommEAp3YBGXR4v3htTdG6QwlmAii8vdTwGfmYZQiBLOmtdj+f+vsNLRM7l
	81ez7wGeGH12vMr8a1EgkW7YoCEBVgFYKS0v36PygUm7jh0JmwFtiHQ0ydrPZ+dgRZ+fw70zlPm
	/L+dvlH26lMADfsqESFCATu3OAQ9rBgZRw/8pOmSBaHCqceKt6e5N76Mtxbn27OOmSK445S/PcK
	tXtlfAXqYNp+i8ElmVgRCCrRHlcyfMRaaWqAIR5rzfwFA==
X-Received: by 2002:a05:622a:96:b0:517:7082:da09 with SMTP id d75a77b69052e-517ee1a6e66mr66458071cf.23.1781213198715;
        Thu, 11 Jun 2026 14:26:38 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d30580269bsm4401096d6.49.2026.06.11.14.26.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 14:26:38 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-fsdevel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH] hfsplus: validate thread record before delete key rebuild
Date: Thu, 11 Jun 2026 14:26:33 -0700
Message-ID: <20260611212633.5058-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfsplus_delete_cat() is called with str == NULL when the last open
reference to an unlinked HFS+ hardlink backing inode is closed. In that
case, the function finds the catalog thread by CNID and rebuilds the
catalog key from thread.nodeName.

That reconstruction path reads thread.nodeName.length directly from the
catalog B-tree into fd.search_key and then copies length * 2 bytes into
fd.search_key->cat.name.unicode. It does not first check that the found
record is a thread record, that the record size matches the thread name
length, or that the name length fits in the fixed HFS+ catalog key
buffer.

A corrupted image can therefore provide an oversized thread name length
and make hfs_bnode_read() write past the catalog search-key allocation.

Read the CNID record through hfsplus_brec_read_cat(), reject non-thread
records, and explicitly bound nodeName.length before building the delete
key from the validated thread name.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/hfsplus/catalog.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 3f0cc1b1bb58..000000000000 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -351,23 +351,31 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 		goto out;
 
 	if (!str) {
-		int len;
+		hfsplus_cat_entry entry = {0};
+		u16 thread_type;
 
 		hfsplus_cat_build_key_with_cnid(sb, fd.search_key, cnid);
-		err = hfs_brec_find(&fd, hfs_find_rec_by_key);
+		err = hfsplus_brec_read_cat(&fd, &entry);
 		if (err)
 			goto out;
 
-		off = fd.entryoffset +
-			offsetof(struct hfsplus_cat_thread, nodeName);
-		fd.search_key->cat.parent = cpu_to_be32(dir->i_ino);
-		hfs_bnode_read(fd.bnode,
-			&fd.search_key->cat.name.length, off, 2);
-		len = be16_to_cpu(fd.search_key->cat.name.length) * 2;
-		hfs_bnode_read(fd.bnode,
-			&fd.search_key->cat.name.unicode,
-			off + 2, len);
-		fd.search_key->key_len = cpu_to_be16(6 + len);
+		thread_type = be16_to_cpu(entry.type);
+		if (thread_type != HFSPLUS_FOLDER_THREAD &&
+		    thread_type != HFSPLUS_FILE_THREAD) {
+			pr_err("found bad thread record in catalog\n");
+			err = -EIO;
+			goto out;
+		}
+
+		if (be16_to_cpu(entry.thread.nodeName.length) >
+		    HFSPLUS_MAX_STRLEN) {
+			pr_err("catalog name length corrupted\n");
+			err = -EIO;
+			goto out;
+		}
+
+		hfsplus_cat_build_key_uni(fd.search_key, dir->i_ino,
+					  &entry.thread.nodeName);
 	} else {
 		err = hfsplus_cat_build_key(sb, fd.search_key, dir->i_ino, str);
 		if (unlikely(err))
-- 
2.43.0
