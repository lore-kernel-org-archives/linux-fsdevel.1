Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AED331EC7
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783467698; cv=none; b=BR4a736/cCzoGWuVMIWyowN3p5CK0WGEopFQTL/qFDRNR9eCzGHCt+OtahunVPBIUzo6Yq62RG3px5OQsqTHR2igsBRZ/NUycg9qubgcDuv3/s4gZvcyllUflL/PoXBixTMMwWPhpISKwI9rCQnyeeJreUQ4sKxcqty9a/E+OoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783467698; c=relaxed/simple;
	bh=v89doh3Nde/7vGIf4lCw7H/GgLBxMIXwT61LxeFYvwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=esfwte1K9s6e5kSiTzc8z9cQVI/2CBw1N6TOodsedETdH36700uDwf1oJORWugC/l5gR55q2BE3z+NXMr/HSyKchPGE+T+gwcP0sTUwyoqG2CB038rQprmIavzk8gYa7a4vpO3s4z2e8C5y7r4cXd8eLnUC1R9+2PTvYJnYVdlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=NUpbilrU; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="NUpbilrU"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c1d487f2cso206301cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 16:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783467696; x=1784072496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OugduowrYxrDl/GZ+uKmR6/kIpiYKm0OZa5fo8adeo8=;
        b=NUpbilrU/+Zd5YRrNdAAYI2pSTvQyFubhrX87m4WxAl1MR1kojbKHgaUj41pdJxT0M
         RtqsA4tTnhVYlaePObCGibC4+Wsr0py4n5Z9mGPto8CqvLNZqh1VprztvtZ7Xmqqm4Cj
         hPv0/RQw3mi7qqDbVpAMz98YWgHCEUiP5gjCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783467696; x=1784072496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OugduowrYxrDl/GZ+uKmR6/kIpiYKm0OZa5fo8adeo8=;
        b=iz+LQuFdi2VMp16+yvqdyLnf1jcilvq9doHGqWolziIfXGNE+f+Q9vWX/lN8GDzbIE
         fTlCGga1fODRXRGIIXX9yrqdgONLF2kr1D0JjX6ItAYQn/9h5lAFhQL3r1EwZo7a3LNG
         ZDXN5mjjtZKJ04dbSJ4DTSsBgDpWyMycAqRljJWuVIslU28tXYCQ+A16JQ6wZuD0ncld
         8zmdYvKtZhLBE1YeOKvF8lWBqBf+8uZQ0ehmFff5ncIjjGdrJZFmCTm2c9kcInxI+2Bh
         J6H9g+AEMwKlNBruIKR9wzxSNBnZyRVPOdkS3rHQf6S9HPDXz7IRhcMCZHPNjZPsX82t
         R9fw==
X-Gm-Message-State: AOJu0YwvpOGSZLOEsBkCxXs/zpWjPrPJfwswQZad1Ag4CFFxO5c8hm44
	/CEzDddu5y/e8lL6Nfg8BGIH0lPWYuj5gJeKOlAtpZk8F8EuJlryTwS9Y07xXCZNARkHsyOjmfO
	Ka+BcClE=
X-Gm-Gg: AfdE7ck3Gqq7qJhX8T2GvZ4Tqm3C4wFcMzYfkvXosDLiN/Qkb+Eso0l3Q45y8c2jpzh
	c2mGQ/S8fo14FIXeyOORD/GgSUeSZZIaYCVDbiFTlkTfX0llvQPG+2fhaWTnPZHgIKuWuqlfg2G
	KtBq/u5gMDS+CWz9epAhcpx7qQlMdFKwQPU7UGdMuqerH7gIGLF84A2FremgThVxmuYWweLkCKV
	iMAa0+JNeRSzAWN4mNuCeOmq07sXdQVYvox3SpRQXsEjbf54A/mje+EJQa0Kc+FflCvtBL2i+iR
	zDPHrK8OUKyDarSYXwLtfXLugdFtVM3fELTEVRRLmabolZQ0Ur3WIJteuylUoBkJAE8Fm/l99wu
	aNQiQQsWwE/2mfyzSpaPFX9D5z1qUkcUmm76a7hHw9au7gr2EVi56X3/excOTRPcR2YoVb4RPNA
	XKC3J+2caNByNM/SXdFQMlX3nNduvqnHtZXcI79UXYMLXSqcWYc0ghdNr+pInKf3zje1wSrPSoh
	JivJ1yz625e8y+h13k=
X-Received: by 2002:a05:622a:4185:b0:51c:fc4:a144 with SMTP id d75a77b69052e-51c8b398ff7mr4032801cf.4.1783467695634;
        Tue, 07 Jul 2026 16:41:35 -0700 (PDT)
Received: from com-75606.corp.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41decc5csm123120651cf.26.2026.07.07.16.41.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 16:41:35 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-fsdevel@vger.kernel.org
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH v4] hfsplus: validate thread record before delete key rebuild
Date: Tue,  7 Jul 2026 16:41:30 -0700
Message-ID: <20260707234130.23524-1-kylebot@openai.com>
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

Make hfsplus_brec_read_cat() validate that a thread nodeName length both
fits HFSPLUS_MAX_STRLEN and exactly matches fd->entrylength, then share
the HFS+ thread-record-type helper between hfsplus_find_cat() and
hfsplus_delete_cat().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/hfsplus/bfind.c      |  8 ++++++--
 fs/hfsplus/catalog.c    | 30 ++++++++++++------------------
 fs/hfsplus/hfsplus_fs.h | 12 ++++++++++++
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 9a55fa6d5294..d5e41e1c70b3 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -322,8 +322,12 @@ int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry)
 			pr_err("thread record too short (got %u)\n", fd->entrylength);
 			return -EIO;
 		}
-		expected_size = hfsplus_cat_thread_size(&entry->thread);
-		break;
+		if (!is_hfsplus_cat_thread_name_length_valid(&entry->thread,
+							     fd->entrylength)) {
+			pr_err("catalog thread name length corrupted\n");
+			return -EIO;
+		}
+		return 0;
 	default:
 		pr_err("unknown catalog record type %d\n",
 		       be16_to_cpu(entry->type));
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
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index ec04b82ad927..01e5f1246ff6 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -521,6 +521,18 @@ static inline u32 hfsplus_cat_thread_size(const struct hfsplus_cat_thread *threa
 	       be16_to_cpu(thread->nodeName.length) * sizeof(hfsplus_unichr);
 }
 
+static inline bool is_hfs_thread_record_type(u16 type)
+{
+	return type == HFSPLUS_FOLDER_THREAD || type == HFSPLUS_FILE_THREAD;
+}
+
+static inline bool is_hfsplus_cat_thread_name_length_valid(
+		const struct hfsplus_cat_thread *thread, u32 entrylength)
+{
+	return be16_to_cpu(thread->nodeName.length) <= HFSPLUS_MAX_STRLEN &&
+	       entrylength == hfsplus_cat_thread_size(thread);
+}
+
 int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry);
 
 /*
-- 
2.54.0

