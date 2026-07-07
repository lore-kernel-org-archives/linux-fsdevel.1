Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9522C23909F
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450112; cv=none; b=Xa72VaasASQfbDLX5vW3NWej/5hsq329VKndawAnp/hvzzDjBJlpRyj9DGzNXidcA/wdsLcCxca1ik0xBAJqSuBglxZrySultVIB8GM72JPW1XOFw1OFc4xZUNmMZs8BfA46/qA2mbATZZr0xaF1V0o8Qs3DedavTrM4PwNEkt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450112; c=relaxed/simple;
	bh=YHnkhXt2qkybXHnCyw5g/L55yIql7gZUnPRQDMpOW0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nmu/fSIwt1khI+euDma7Y0IHtnAvHTpN320+Q3mQ00hEHPp6XgsY2z8WWR1a/fHJGMp7HO8gbkibwSjRLqtq72IgVJTLSUKuPk60qrXVRfvn3RYnVa6DRk8OPSdx4Ohiiz2Llkue9rpvzCbQKo5SRoyPLug8MVZAKS6hGvnDras=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Z9MPiHVG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Z9MPiHVG"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so37160225ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 11:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783450110; x=1784054910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eOl+/cGFsNBqiB9rxc6W6BcyV7OIyyCO+Aylp0NkyKE=;
        b=Z9MPiHVGoFXpue/+1hvBdu9qkTNr0MP5Qqvd9WLNXNVAhIOsMCtoLTseb21dVrzig0
         V7T/5AmIJVU92Ltir7nm6wWbu72QUJfbfAOXH7olN1zloaMX9zvmjBW5UA19f/n7Oq1V
         0gWglq8DNlMgq9qj3u5IDhWGhEAt603Vu9M7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783450110; x=1784054910;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eOl+/cGFsNBqiB9rxc6W6BcyV7OIyyCO+Aylp0NkyKE=;
        b=XLUdAMjuCUZ3WowK50ByYvEkF8IBETeq5bxcaw6dN45CZ6zNrRGtzJU7FQhI2uduCZ
         aSX7N4qNdxfkRYdWrpluXzn8hge9zyv5U0yCQLYN/4mmwtEMsms5Cd+Bj3y1yR/vbBEY
         LOXeicfwp3ZF/4OVd+T0tvTstZ1rpbFYApnbI/fheHwsfQINvIBytJbqOfo9J3EFaKaU
         /YDBvQ1Wibcqddo9rPNkxVMHI8LIFeZDcRT+kBDsNMCvpJ4nV6xY/FKN3Cp2FLcszQZy
         V4KZdIpMt95ObR93ka2M3nx+JT7bzjDURA7VC3kriDzPh0jozAd18WOtNn935YEb2dmn
         eiEA==
X-Gm-Message-State: AOJu0YzexmsrzCTMqjhTK39xxyxclVtJf9Q+TOPUpFBzV7HtXJ6th4sY
	3RiwuChVYjSd0LwrWRsMKm4A0rtUFLJN0LP4vT1XtR35EHnk+CSb10lhKKdaPYel7Fs=
X-Gm-Gg: AfdE7cncSkACCwiRY8i0klXCtL6bIINYhuQ+GJherhNTYDVKKiKsWMKtBD5pSPQzhVx
	AmyRfLhe31hzmScZ9/hMQcHnyXZG9gGAeQuagOJFXl86nvaSMmSHMZ7fJwHMQkNsFQYWGI2dvyr
	H7+kgMylE99f1wLA4jlNVELlrAeFUOa/+sV6mf2SHikfmw7pqGMsw+U/GetHOJniZxx8ZjHL+ht
	MB9pGBQDXIEQlHjEJKzAal42kzlOlL4fRftdD8aAHCXRR1mcx4qrQF81UihNbiPc22Xqp/1LSAC
	b2uIh/4GldgzbrHd2rW2RSzfTEKtK0Jlq0U7WD9K/r3+hadGY+81mZ4rr02UfnLuVuf1qRhB1bE
	4pRONifmrT2D8B+UmP6UUKbrngDp8p7ZDlEQqmYAC48TUhL6G8L3wYebp/iiDi0JRWQ8RkONMOo
	VNdg1X9hlNjS2eAy+yASMXVnNZ52/wXk6bYc4Zc4F4CtOrErrhqbVXI/KxJOavm7vEsxMnAw==
X-Received: by 2002:a05:6a21:398d:b0:3bf:6c08:fb97 with SMTP id adf61e73a8af0-3c08ef55aa1mr7658057637.57.1783450109822;
        Tue, 07 Jul 2026 11:48:29 -0700 (PDT)
Received: from com-75606 ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac178dsm11453031eec.28.2026.07.07.11.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 11:48:29 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:48:26 -0700
From: Kyle Zeng <kylebot@openai.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org, outbounddisclosures@openai.com
Subject: Re: [PATCH v2] hfsplus: validate thread record before delete key
 rebuild
Message-ID: <ak1J-ouL-DjO6pa3@com-75606>
References: <20260701063519.9447-1-kylebot@openai.com>
 <deaf9198e4e937310f92001628e48bb9d8b88844.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="T1dE2NJrD1N5iHMZ"
Content-Disposition: inline
In-Reply-To: <deaf9198e4e937310f92001628e48bb9d8b88844.camel@dubeyko.com>


--T1dE2NJrD1N5iHMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Slava,

A new patch following your suggestion is attached. Please let me know if
you prefer to receive the new patch in a separate thread.

Thanks,
Kyle

--T1dE2NJrD1N5iHMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-hfsplus-validate-thread-record-before-delete-key-rebuild.patch

From 25375348bf897058e2c47806bc9cf1d3dd6b2647 Mon Sep 17 00:00:00 2001
From: Kyle Zeng <kylebot@openai.com>
Date: Tue, 7 Jul 2026 18:37:32 +0000
Subject: [PATCH v3] hfsplus: validate thread record before delete key rebuild

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


--T1dE2NJrD1N5iHMZ--
