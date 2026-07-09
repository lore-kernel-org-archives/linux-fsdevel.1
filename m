Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402383612FE
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 01:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783558931; cv=none; b=ks1EwLQiz50s/5sFC6jdUHgqtzPCnCvz2xl0Y2CSLo37i/m9hZdDGlISmAT24nSMzQe3nh2t/Y95KsvnIi3WWyZ7HAdL0bKVJWN5PndUEp0k36xBYDHTv613ia4B/MJdq3BOUf8EyRIBPFV/RCQQeQU1FiF+IcaCwju5Kf2yxwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783558931; c=relaxed/simple;
	bh=we+2Ze6y2sAZAO6noChUcqJBrSnTxOQBehqDswGk2F0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tu+zUgxaxBPEG4isZTGCzE7cAr4LxpBUjLIuZo1rctymq9SeQAZ03oULFvS57ofen5cuRekHEOAYTMjomJ1NbffIU1OSXWQDYwZpvveO+Uh5Cdr0mBS5Dk8xwMn5WMkLOK86lOjQSALZPGxj2JUHzZJQ9hMswUpQNqaj2gIHWVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=EPMXm0dP; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="EPMXm0dP"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c0c45c580so9786471cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 18:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783558929; x=1784163729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=++EZx/mU5rVfumu/m5k5QOM5nQzKkY0hA+Savy1vrXo=;
        b=EPMXm0dPO0KZmEm617rZlXGItEGkh+3Ne07DSapQaiuTw94rpKjFkTDhOjg8gHmJ0A
         fJ7W8xXLvOwRfyNuTOqCV51xOCBIuz64GfGgK1rXA3HbctRVEvV6oXldHadSD+xXg6a7
         ygyKwTFXYuZ3gWVi306K0mr9UEqUqI7BajpQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783558929; x=1784163729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=++EZx/mU5rVfumu/m5k5QOM5nQzKkY0hA+Savy1vrXo=;
        b=GQhsWkqDTNIFiqztGd1ZE9DmV3wZkBrBBT9HKSSuSuWephjHhqDCQ9TL+kLnzc3gIi
         AydeAjovy3pGuCNco4VajpXZYBlsrWZKn4ujJMF1K6LTtt+tgEsxxyn4orljqmJ5DpXi
         xXeljMfejjL3ZHUnkPRJwO+a3N6ocdAauVs/I+hIi4Mf91JpdFxyVVshr2ceLpbdU3YJ
         zlXvJ9yGaaZHFUtx4ZD9t+FTRnPVqegsbw3dUSja/KwsexEzBu7/0Zt2Rgh9rYObYw5P
         schMkXFL6VZy4spOBJe6xOqWS79TTNYYXJl4vYIVGWmgiMRokx+8t9iqZpBVabiFiTXt
         veKg==
X-Gm-Message-State: AOJu0YxJB/Ps1O8K1nDGA3H/uXpdK2ziB1oCqq/RY34zJRkeEQgVJMjy
	oTbNOW0/9D3vxR3q7pmobQ9DTtSHOJKTvlpGtUsQ8raAbQu80qV8mo0DNq397i1x6gOyAfRcYjH
	n6qv5iUA=
X-Gm-Gg: AfdE7cl1vCM+uJxNxzo0nRW0nLnxo1Ga28pEANqgHqvlkFLzk76PzMnS8Q0E0HwU1kh
	MV0vEDbBqvvTOvEzxzPaBJojWEoVWfXCb28scpmCdYmKgTp7U0v9rakRmDFz/ccsjT+tqxd4jfD
	6Jxl2+Z5ZYk56uGfpzdRHnwjK+Dtr6jc4iQYnjHQmzl4+vwnMh35crZXQ9ipf//aLknFGhU+aGl
	xy9VHu+9RLfneKXqN+3GjybIYsiiIH6FjyfHhmv0Lk8KykCRVSsE+mBpnHXRLMTZH+UqTvEurva
	Uequ86wSOSVadx6wyhiXtZent7OeD+StYN4sOs+aMFyuxqrQcqGSFHBGnVyr2ycL1s2cdwDpDbq
	5FkrxcrkYlcgVxOJxgwGDr9EgC0uR/IoVT+n2puLeoQlHrkBgmYepFUlKFZz9/9etzpZ73YrxMJ
	rlGEq9Rb7KPpEzTUo5SjOBhVBVzaw5koPp44I9n1QMUdxCggagzmk7HhEFTCXQqabw8Y172jDfN
	K2CMyJu8nllR/iibsU=
X-Received: by 2002:a05:622a:311:b0:51c:18ef:6974 with SMTP id d75a77b69052e-51c8b2adf81mr55580021cf.2.1783558929008;
        Wed, 08 Jul 2026 18:02:09 -0700 (PDT)
Received: from com-75606.corp.openai.org ([209.249.37.147])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41b55495sm157387181cf.11.2026.07.08.18.02.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 18:02:08 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-fsdevel@vger.kernel.org
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH v5] hfsplus: validate thread record before delete key rebuild
Date: Wed,  8 Jul 2026 18:02:03 -0700
Message-ID: <20260709010203.49664-1-kylebot@openai.com>
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
record is a thread record or that its size matches the thread name.

A corrupted image can therefore provide an oversized thread name length
and make hfs_bnode_read() write past the catalog search-key allocation.

Read the CNID record through hfsplus_brec_read_cat(), which bounds the
record read to sizeof(hfsplus_cat_entry) and verifies that a thread
record's size exactly matches nodeName.length. Together, these checks
ensure an accepted thread name fits HFSPLUS_MAX_STRLEN. Reject non-thread
records before building the delete key from the validated thread name.

Share the thread-record-type helper between hfsplus_find_cat() and
hfsplus_delete_cat().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: Codex:gpt-5.6
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/hfsplus/catalog.c    | 25 ++++++++++++-------------
 fs/hfsplus/hfsplus_fs.h |  6 ++++++
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 776ce36cf076..fe11c4b6dd99 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -204,7 +204,7 @@ int hfsplus_find_cat(struct super_block *sb, u32 cnid,
 		return err;
 
 	type = be16_to_cpu(tmp.type);
-	if (type != HFSPLUS_FOLDER_THREAD && type != HFSPLUS_FILE_THREAD) {
+	if (!is_hfs_thread_record_type(type)) {
 		pr_err("found bad thread record in catalog\n");
 		return -EIO;
 	}
@@ -350,23 +350,22 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 		goto out;
 
 	if (!str) {
-		int len;
+		hfsplus_cat_entry entry = {0};
 
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
+		type = be16_to_cpu(entry.type);
+		if (!is_hfs_thread_record_type(type)) {
+			pr_err("found bad thread record in catalog\n");
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
index ec04b82ad927..7c8667d5a49c 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -521,6 +521,12 @@ static inline u32 hfsplus_cat_thread_size(const struct hfsplus_cat_thread *threa
 	       be16_to_cpu(thread->nodeName.length) * sizeof(hfsplus_unichr);
 }
 
+static inline
+bool is_hfs_thread_record_type(u16 type)
+{
+	return type == HFSPLUS_FOLDER_THREAD || type == HFSPLUS_FILE_THREAD;
+}
+
 int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry);
 
 /*
-- 
2.54.0

