Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E03AE718
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 06:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887729; cv=none; b=fdCoTll9KCWsIoHXWywfT2Qkp7+GKn4QvZdPEncDomT5Qi57rJlJZ/fgS91yDC4zr1NITRVQRq/71N7DejJwIvueAG9d5mmVQQ0xAh0q+q13cW3i/TSJbmHIGFxJmeGA5nR7vFTIMjBjVA1FsndZ/UJtwvdNgtwKuzat2M4JRcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887729; c=relaxed/simple;
	bh=I1xNCth7tHHNgSKMfMkcx8CyTf5cLtcUESi0IbW8W4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gH7fZodqLAi1aV8riEdrfC56Mf1FLvZSNHcVGr5b5qKjvFZ+ck5fJP1xZNs7ETqx5N0d3QxXqB9q1gVb2PvGw64yaHeRuTNnarNCg/nR5XN+P6zNU1Hb1JLd00rTQYwyrynwtQQQnOpCw1IgkLLgh+LDixniXgDYAGMwBO1EGIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=GLQf1Kgo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="GLQf1Kgo"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so2093495e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 23:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1782887726; x=1783492526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NajUa4MXgDP83skbWtpZ9UueedSuuATXIjKv0y8IwjY=;
        b=GLQf1KgoTOvIG9ge5lzI4qtzIj7TGoywKz+Vbv/ygppPcP3ds9rJfxgMjteHp3ptqS
         UFB90bAGFEkZFdYK5AS1sDgmKzkyQbEzIU4HG3nZWThmpzlOv/BObet5KMdswYZBJa4g
         UBcSfpyrmqLdv2SDGkHv//nUBne+8zVnIk5t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782887726; x=1783492526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NajUa4MXgDP83skbWtpZ9UueedSuuATXIjKv0y8IwjY=;
        b=qAFfCdzM6iEBniWbJNTnCgaUcrr6KiZB/Bc/6jYqPPtx0PNVXmafbjcdTF1I4bnYtv
         Q17rPLOGwfT3IBmIvSw8KESf4v+ljdWbqhCV3Tt0wxqHe0XjIVii71UuV/6BWqprtAm7
         ZoM5ZcX+EPrMQf0cxV9e5sGR6tKBztC5sKOrWsKw6qqilIHph1DQWETmlbj+mafPAmn1
         fFK6e9x0xYfJIMYlq2hWAfUggUJ9iFrmCGkvvpjotLkxUUQ2xGTVzG8tf3iuRgSsrJFL
         SAeA1aW1zyXsjGU79uLYgeu4G56xhhe30t2lqWgzyO4cj25cZ0Gj/oBe5SL8EKmS+aE/
         9jTQ==
X-Gm-Message-State: AOJu0Yy3MC5wSTiAXq8C8zZ7HX08hLcltPomX1UW4wrA0MDHQPhozjE1
	LQjs1W9u7CQ90P397FuooIwk3fgOnKKjl6ObCgE7dLzZevqIVOStUv9f5X73yoroLYLzVhKWm2u
	wxnu5mc8=
X-Gm-Gg: AfdE7cmokE+i5tlSQZC43HhTtmTwhnCCXNggrPLglX//aSZSwSY0bREDXNxbervtZwX
	DJ5Tipg5NLiMWQZfgy1IfNtVp956L1GeYSfnPHhgZksVGiFFR3m6SaqrCarela7k52TMkL2zO5o
	voqRL6wLmbZitXSLcOUy9WJOl0Y7en0EClbZKmN8Rxd/mtVBcmKh8aC4kr+MsqhZnXHJWIB6L0A
	ny3n44ubzuD51eujzlOj3qkpIkSRzKf5m95xOHPA9QFLcJbaor1EuYGAg/iIPjIP8p33mcEYEaP
	FTCvB7xdK3fS0J7Oj4DmeaOOmVhspLKHaw40Dk0Ey6QcU9xajGTa7nuF8+UwFnicHMoNOubnjb1
	/esPXQO64TE0Ok3cjAYiI8kdedbjxtgiacyBxxbxCJPe0W5IQ7926wOrSpeXN3v74Z8VCHqsxbO
	h4xkOzn5Z/0iPU8EmENLjTNq5faYVebTPP+0ha/dMhgs7bJ7EOHp8tyBxvzZ7Mqj1oh9hP7hKmF
	7CNO+LLioTolQJ2LsU/NihrFry4
X-Received: by 2002:a05:600c:4e56:b0:493:a438:7f98 with SMTP id 5b1f17b1804b1-493c2b9099fmr3432095e9.18.1782887725760;
        Tue, 30 Jun 2026 23:35:25 -0700 (PDT)
Received: from com-75606.corp.openai.org ([38.18.220.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4d2bc5sm53592115e9.5.2026.06.30.23.35.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 23:35:25 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-fsdevel@vger.kernel.org
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH v2] hfsplus: validate thread record before delete key rebuild
Date: Wed,  1 Jul 2026 00:35:19 -0600
Message-ID: <20260701063519.9447-1-kylebot@openai.com>
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
length, or that nodeName.length fits in the fixed HFS+ catalog key
buffer.

A corrupted image can therefore provide an oversized thread name length
and make hfs_bnode_read() write past the catalog search-key allocation.

Read the CNID record through hfsplus_brec_read_cat(), which performs the
hfs_brec_find() lookup via hfs_brec_read() before validating the catalog
record. Reject non-thread records and explicitly bound nodeName.length
before building the delete key from the validated thread name.

Factor the existing thread-type and name-length checks into shared
helpers so hfsplus_find_cat() and hfsplus_delete_cat() use the same
validation.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/hfsplus/catalog.c    | 38 ++++++++++++++++++++++----------------
 fs/hfsplus/hfsplus_fs.h | 11 +++++++++++
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 776ce36cf076..c57c3bbb8143 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -196,20 +196,20 @@ int hfsplus_find_cat(struct super_block *sb, u32 cnid,
 {
 	hfsplus_cat_entry tmp = {0};
 	int err;
-	u16 type;
+	u16 entry_type;
 
 	hfsplus_cat_build_key_with_cnid(sb, fd->search_key, cnid);
 	err = hfsplus_brec_read_cat(fd, &tmp);
 	if (err)
 		return err;
 
-	type = be16_to_cpu(tmp.type);
-	if (type != HFSPLUS_FOLDER_THREAD && type != HFSPLUS_FILE_THREAD) {
+	entry_type = be16_to_cpu(tmp.type);
+	if (!is_hfsplus_thread_type(entry_type)) {
 		pr_err("found bad thread record in catalog\n");
 		return -EIO;
 	}
 
-	if (be16_to_cpu(tmp.thread.nodeName.length) > 255) {
+	if (!is_hfsplus_name_length_valid(tmp.thread.nodeName.length)) {
 		pr_err("catalog name length corrupted\n");
 		return -EIO;
 	}
@@ -350,23 +350,29 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 		goto out;
 
 	if (!str) {
-		int len;
+		hfsplus_cat_entry entry = {0};
+		u16 entry_type;
 
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
+		entry_type = be16_to_cpu(entry.type);
+		if (!is_hfsplus_thread_type(entry_type)) {
+			pr_err("found bad thread record in catalog\n");
+			err = -EIO;
+			goto out;
+		}
+
+		if (!is_hfsplus_name_length_valid(entry.thread.nodeName.length)) {
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
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index ec04b82ad927..b954b45a1003 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -521,6 +521,17 @@ static inline u32 hfsplus_cat_thread_size(const struct hfsplus_cat_thread *threa
 	       be16_to_cpu(thread->nodeName.length) * sizeof(hfsplus_unichr);
 }
 
+static inline bool is_hfsplus_thread_type(u16 entry_type)
+{
+	return entry_type == HFSPLUS_FOLDER_THREAD ||
+	       entry_type == HFSPLUS_FILE_THREAD;
+}
+
+static inline bool is_hfsplus_name_length_valid(__be16 name_length)
+{
+	return be16_to_cpu(name_length) <= HFSPLUS_MAX_STRLEN;
+}
+
 int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry);
 
 /*
-- 
2.54.0

