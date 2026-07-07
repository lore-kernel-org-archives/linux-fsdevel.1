Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D970F360ED0
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450970; cv=none; b=T7mj2MLyEsdrMGDA+g5VvRHA46DH8kqoamAzE7tDXyTsXHUMhT8Uwubz8ZKEOLFbnyFwJstQfMJRstdaxz5cRe+rr78fTPVsVym0iCENOUkS4NK5WGKlU+LGJ1u1vWqGvZFIEO29j21O0GdOKwjxyyfK7EROG/lvlYpBG6dg8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450970; c=relaxed/simple;
	bh=fYi7LXGzRQdmT1O7PHY4TblYUZEs1AiWfUc3F6mJ7c8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r5QUOLFeHdiKGJB+lDZpbN0WsE3lWW8qmf9Fw3hNFvEYtQaUShmglLPoFYeNkGnz+e/Zt2ZyXv2o9xhg7JmHuM8N4v/0Bd8U/4aP5nlaPX4If3UGFpsKkjpCMVrZziTa98P0oOyoS/JGefxX6uDLhqu83RPLfiqIDvGRfJK5yyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=PbBzJZI2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="PbBzJZI2"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381b831d535so5225926a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 12:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783450968; x=1784055768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v6CnhBIjoJ5BTuoT0ljXiDP46aBEP5GKBx4JLBByTGs=;
        b=PbBzJZI2yLSdfv9p3xzkZkCmtR1AS51XV89O5L7fKgz/CTaX9NNrza6gFvFi/s4jXE
         w30oN4avVLAYKk6s/ChbLXho2UYt2ROLBhK2/nlHYSzk9roq3z2KvC2ErPd5iTs5Oamo
         DvjenNrtNwXTMnHWUZ0ypwqOKo0MQL6xOK1WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783450968; x=1784055768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v6CnhBIjoJ5BTuoT0ljXiDP46aBEP5GKBx4JLBByTGs=;
        b=YM/pk3Qlkh1M/hqQXoB7UIHBq0d2dD8oWiOozZrtKKfLl4C1ZG1ChVTEsUvff2L0RS
         Fso5gbvcpR1kAGmcPLQvYZLGR9X1gm8KCH2pxVuDdGnTJh9xXm5HcikgBu8PJ4dvxdsw
         SLS7VIlIS/O7Ax/beIHdtvd+R1aPoMN/MHUNzbQM1aNpo5jRWNLADfgxAz9B+NGRcK5s
         aCVA0q0npnXlDfCCKDLRohQVPay64ZPeq5L1BFDYhR2KNrYaoHKlCa46PoXaJarZZtQC
         UxGUp/47j04Vhp9GhQ+c9WFI9R+inn89xiDcoLEQbPjWMoM3noFXSUCfAsV2huTpTtWj
         MdEA==
X-Gm-Message-State: AOJu0Yxe5XjVQew807JNAyIJyWB3cDi9Vf6O6YbZS1kr/lN/olvvgBg7
	Js8Bkm5ezCwvhPAiw/gvpH6wkCrk91DZO/1oXXwnnw5ADCfinSKWdA7vC89hbSWcGBoXkYGftaV
	L+8s0swQ=
X-Gm-Gg: AfdE7cnIc8GAhsLxNKO8OJhzTUvdZioHBLoLhuMuhifEF365lIiqG6qCqbgp1AK82sf
	fU5z09Ae+ES+ZRhPwDYhs/lRWytWp4rCyj8SfV+YSqNom6zY7y86Da8/mfEzE5QIgjBsBoYU5Rs
	KMcdjk1v9fZAWVfUEINlVRwRMSpDZF/b6u6ZEoVaNRMVDTDwl4LFqPvD9lqg4VXGOLuK4Lw0++m
	99E0LJLuVLeFxA5nb+0bJgnrV+w1VLfpkv8xgMEKVpfiHGND5WPPKG8buocv1zhHN0RTdkKVo1A
	OjhyvAIo07ZPAQHeapT1UUrIB+ubyrdREgdHuvKzDdiU9sMzjK29KgE0CyGJ18q3JX45wLsJPpq
	XfSe6KQSZoTiqPUm47si/IIME8aWUIaVMxzex+WifVDu/qrqqd1/1G7B4YKWoKeOMkB4IpqL19A
	7r7MwWfCHPXu97l51ck9L26H8e2h7J6SvRaXFFVhPnnFFvdr9xqV639j+y5SnggJrcAfkQXZbqH
	eLg5+RtXM635LgFsuE=
X-Received: by 2002:a17:90a:ec86:b0:37e:1bc4:b6ae with SMTP id 98e67ed59e1d1-387568fded7mr6900811a91.8.1783450968164;
        Tue, 07 Jul 2026 12:02:48 -0700 (PDT)
Received: from com-75606.corp.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm11717610eec.31.2026.07.07.12.02.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 12:02:47 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-fsdevel@vger.kernel.org
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH v3] hfsplus: validate thread record before delete key rebuild
Date: Tue,  7 Jul 2026 12:02:38 -0700
Message-ID: <20260707190238.44998-1-kylebot@openai.com>
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
record. Reject non-thread records before building the delete key from
the validated thread name.

Move the HFS+ catalog thread name bound into hfsplus_brec_read_cat() so
it is checked together with the record-size consistency validation, and
factor the thread-record-type check into a shared HFS/HFS+ helper.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/hfsplus/bfind.c         |  5 +++++
 fs/hfsplus/catalog.c       | 30 ++++++++++++------------------
 include/linux/hfs_common.h |  5 +++++
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 9a55fa6d5294..417c3014f4c7 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -322,6 +322,11 @@ int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry)
 			pr_err("thread record too short (got %u)\n", fd->entrylength);
 			return -EIO;
 		}
+		if (be16_to_cpu(entry->thread.nodeName.length) >
+		    HFSPLUS_MAX_STRLEN) {
+			pr_err("catalog name length corrupted\n");
+			return -EIO;
+		}
 		expected_size = hfsplus_cat_thread_size(&entry->thread);
 		break;
 	default:
diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 776ce36cf076..1a4b0beae135 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -204,16 +204,11 @@ int hfsplus_find_cat(struct super_block *sb, u32 cnid,
 		return err;
 
 	type = be16_to_cpu(tmp.type);
-	if (type != HFSPLUS_FOLDER_THREAD && type != HFSPLUS_FILE_THREAD) {
+	if (!is_hfs_thread_record_type(type)) {
 		pr_err("found bad thread record in catalog\n");
 		return -EIO;
 	}
 
-	if (be16_to_cpu(tmp.thread.nodeName.length) > 255) {
-		pr_err("catalog name length corrupted\n");
-		return -EIO;
-	}
-
 	hfsplus_cat_build_key_uni(fd->search_key,
 		be32_to_cpu(tmp.thread.parentID),
 		&tmp.thread.nodeName);
@@ -350,23 +345,22 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
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
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index 45fb4c9ff9f5..c4862166efc9 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -92,6 +92,11 @@
 #define HFS_CDR_THD		0x03	/* folder (directory) thread */
 #define HFS_CDR_FTH		0x04	/* file thread */
 
+static inline bool is_hfs_thread_record_type(u16 type)
+{
+	return type == HFS_CDR_THD || type == HFS_CDR_FTH;
+}
+
 /* legal values for hfs_ext_key.FkType and hfs_file.fork */
 #define HFS_FK_DATA		0x00
 #define HFS_FK_RSRC		0xFF
-- 
2.54.0

