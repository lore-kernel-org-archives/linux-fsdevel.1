Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5999D265606
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 00:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410903; cv=none; b=Ar0tXS17W3EDLF9i+qIRXb6YEQkVzQFZ66W6U1FUQ4q/q6C02NQA8t9Z6mPOG1c1E59RMkyxezOuKbO0fcP0Kr0dfxTmOWvw2U16b+0i9SdcXLrW5NIpZGcmuGg8J9WP2knntWTWokBGUjN8NnBvG+UTOVVkahUohr75hyRqBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410903; c=relaxed/simple;
	bh=5Xs+CX5lLKoEHUMPSPmQPu5YJB7zvPSf/xuEQmphgTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQQtiNvzhGTFcr2UhkSbLkDqkPEuxuV5iyFKxOsrhf8riTKSzezUmNj0PCaLswgKf1tUNL9OsNjplwmtKRlB7+cc/5Yru/caO0wb7Ejo7fD9c4g3oCDlP06ifZleSdj8eYWUIOPk50O8/qwJdoKmk2yap09d3dv6pfuhH9RlvcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhzocWNY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhzocWNY"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-83ef1d17904so6813345b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 17:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779410901; x=1780015701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKq9lV/G7NzgSQyheH8/bgGyRcC1BkjmeWEjYZwko3I=;
        b=fhzocWNYiVszPs7CJqWw+4gHJnCopTtUSkyUq0P7v+96EWsDMCOS/abQyUWP7vDIBL
         VIGCkrUB5+imE5j0EekvIcd8Trbk3NwSrvBulq/NOZ/iM+zo1qam3kVAaFpjwfYSOi8K
         VVmJWkqjwxXSbucY+26CB/WX3Y+Nti4uGwnpNWZHERGmNN9SDVFEPUsZaED2/cKZ0T3z
         L3nDjXIDoyJkxgBsOMHHbYj7UadbDl064NCxnAbzcz7OU2QpWp35zKtYW2Xn2ihSI6xk
         bKhTfbIR/zRCA/RmpaCjFhp+vva7uDUsp4uMEhUwX4ZBge6ZJGI0CUNIoibK8U0WJHFN
         1doA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779410901; x=1780015701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hKq9lV/G7NzgSQyheH8/bgGyRcC1BkjmeWEjYZwko3I=;
        b=fS/Q7h6eC0pahEp1NjC7C3aN6nhHh/2f2yJf/6yH61vmcHw0iDv/JpbexR4554PLxd
         +qnycqF2ppP8KvcKlDPexBFseF++2utIAZOmGjA56rs22UzS5dvoAAQKafX5Edc6fEJ3
         o/G1LGLSXvtSoEE1ZpqAiXEp0vcdB/KcoSQK3AwFivE7T8iji84HrHDEDMl1kZ2nN9WN
         7Yi+k4oSIv8i8RRCFLNm/6wEyUFGaICZyAQis1FNtzVk1BZSpnZO29bXH9c7so43rFVd
         E2nV8+Kca3GF69lZ0Ir9+n+Bn45IjttTffiXhRJnDBuMT1X9MzYhKsG+JFNmtXebfMd5
         A1kg==
X-Forwarded-Encrypted: i=1; AFNElJ9xnlWAddKeWYOGGZpzDpxWAb1z5ELaIqKqa0D4w9vBsLneoOdxHBYb140nx+WGR7p8CVQEitsHZzX1SFQ6@vger.kernel.org
X-Gm-Message-State: AOJu0YzwTFD2nKY9p+WhOH0pvLjAwA7jRZhTpCmk2/TxOOTt/CmirJJO
	u74mvDP3zVK+R7S8GLczYC9kLwZXfg2PHsjNsc18mUwH1j+8MZew4eFT
X-Gm-Gg: Acq92OGOFUhAuVegiontiF7IkZTKJGprqZZrVAsqRZJO6n3AD1tCz2GcszDLaJsYePy
	2Uc4mP+6hI44mPzITWbggUHftBaIPe8OihJyTy0XaV8g3rJtCrDdm2afPx969glJ6vDGpa7JiCN
	vM0J3qg40IOrqwnAnR0BrzTam0S8gNEtO3EmSJmLu9AXZbMyTjZLPEl79wd7ApuONw4Ple+j5TM
	4QnaxU3xoLzHuyYkm9ErxZz1CfRn1pjgbMbdyPKrgtQPgZBc1DCGfLHcbmL/G3VXcI3KQXLmliP
	h6rtO0ujKbadPDTSDl/bHXQCFQOS17bAqPUQZfnn14TtuQvSh9ffnbuwvggvjOBtH865dbt8+2s
	aOCeLU+na8oI+4GEbBH91y1+PGFvOubotIOPEA/olpYRbaLfpTLODxpXQ8jmtvvALsOXF+Sgc/G
	TNc/T9JkQOIxx4qtzkhYJwstWUbZ5RzDKKc49SRPLK
X-Received: by 2002:a05:6a00:f95:b0:82c:dfea:9e2a with SMTP id d2e1a72fcca58-8415f0f02d6mr1538639b3a.2.1779410901547;
        Thu, 21 May 2026 17:48:21 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac99b0sm78484b3a.4.2026.05.21.17.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 17:48:20 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ntfs: centalize $INDEX_ROOT header validation
Date: Fri, 22 May 2026 09:47:45 +0900
Message-ID: <20260522-t-fix-oob-v2-v1-2-0bea6582a361@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522-t-fix-oob-v2-v1-0-0bea6582a361@gmail.com>
References: <20260522-t-fix-oob-v2-v1-0-0bea6582a361@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3560; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=5Xs+CX5lLKoEHUMPSPmQPu5YJB7zvPSf/xuEQmphgTo=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqD6Z9O4ltOV9eAaDf2wkRmLfLYyTGxMD0/dERE
 bp2COK1gBOJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCag+mfQAKCRA08jD6945I
 03soEADEufoIfYsv9rPrXePjHYzfQOMkdxD6CvOd+d2rPoKOe3BDgYiXpHFKoUiFFM8SyyJ7u8S
 JFIrJ974ULrCdOODLr9zHPZsv/bQOFXcGomwbt21TMs2o9ajzoij0SXWLL3MzwcQ2FZcbsn0dwZ
 7fPcp6pEpMFFKOOHNnaM7t1HWocRhb7cMdav9JsXEgRKF5+e7TX75JBSxaek1BcMHs3FyGUfpRY
 ps0wBDF+N5nX972KRePa9+naoAD1neLDfEOmrvw21cnmhORwTWAMfolXhWGaMxMMABuW/CMELX2
 zrRdyQ1wE9U/DGHnZGr0HPXRb1aDI3qH6bY+3G+5Ojt8OpYimH2jiTHu7DR/ljh02P76nl/WPFr
 XmVFDLo68eHEjidnvYmE+dFNfn1ESrtfMFgFVkh5Yc7LA616UZD9QS+om4+8uUaVr4tBR6a6QWp
 2iOzcN82qNEwyRNDWBPM0xoE/bc5z9Ny7X+zme4A281sBOPBGOl3GcjD0oX3S25C7PSEWYa0VcS
 JiGHvejecHKXgXiMtPnxJ+UZrTkODey+ZpfNmVS9/lOv+q0nyTc0zkGWsW7/6MhNMkJlVWrrL3Y
 7K/hIuQYcFsBOnXo7XMSfXmoYxvh4C953KRXujSuOgq2gNPAbp7hw3nNx0/13ng7jalhwvlZGS4 vYPnvrHChX7sf+A==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

Add a dedicated helper to perform stricter validation of $INDEX_ROOT and
use it for both directory inodes and named index inodes. This keeps the
root size and header geometry checks consistent across both read paths.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/index.c | 18 ++++++++++++++++++
 fs/ntfs/index.h |  3 +++
 fs/ntfs/inode.c | 11 ++---------
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index c203a5ad47b6..91fcaa79f8ac 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -539,6 +539,24 @@ int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
 	return 0;
 }
 
+int ntfs_index_root_inconsistent(struct ntfs_volume *vol,
+				 const struct attr_record *a,
+				 const struct index_root *ir, u64 inum)
+{
+	u32 value_length = le32_to_cpu(a->data.resident.value_length);
+
+	if (value_length < offsetof(struct index_root, index)) {
+		ntfs_error(vol->sb, "$INDEX_ROOT in inode %llu is too small.",
+			   (unsigned long long)inum);
+		return -EIO;
+	}
+
+	return ntfs_index_header_inconsistent(vol, &ir->index,
+					      value_length -
+					      offsetof(struct index_root, index),
+					      inum);
+}
+
 static struct index_root *ntfs_ir_lookup(struct ntfs_inode *ni, __le16 *name,
 		u32 name_len, struct ntfs_attr_search_ctx **ctx)
 {
diff --git a/fs/ntfs/index.h b/fs/ntfs/index.h
index 3451ec8a1c4e..cad78568d8b3 100644
--- a/fs/ntfs/index.h
+++ b/fs/ntfs/index.h
@@ -89,6 +89,9 @@ struct ntfs_index_context {
 	bool sync_write;
 };
 
+int ntfs_index_root_inconsistent(struct ntfs_volume *vol,
+				 const struct attr_record *a,
+				 const struct index_root *ir, u64 inum);
 int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
 				  const struct index_block *ib,
 				  u32 block_size, s64 vcn, u64 inum);
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 360bebd1ee3f..63ee7acff4fc 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -890,7 +890,6 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	 */
 	if (S_ISDIR(vi->i_mode)) {
 		struct index_root *ir;
-		u8 *ir_end, *index_end;
 
 view_index_meta:
 		/* It is a directory, find index root attribute. */
@@ -940,10 +939,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		}
 		ir = (struct index_root *)((u8 *)a +
 				le16_to_cpu(a->data.resident.value_offset));
-		ir_end = (u8 *)ir + le32_to_cpu(a->data.resident.value_length);
-		index_end = (u8 *)&ir->index +
-				le32_to_cpu(ir->index.index_length);
-		if (index_end > ir_end) {
+		if (ntfs_index_root_inconsistent(ni->vol, a, ir, ni->mft_no)) {
 			ntfs_error(vi->i_sb, "Directory index is corrupt.");
 			goto unm_err_out;
 		}
@@ -1483,7 +1479,6 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 	struct attr_record *a;
 	struct ntfs_attr_search_ctx *ctx;
 	struct index_root *ir;
-	u8 *ir_end, *index_end;
 	int err = 0;
 
 	ntfs_debug("Entering for i_ino 0x%llx.", ni->mft_no);
@@ -1534,9 +1529,7 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 	}
 
 	ir = (struct index_root *)((u8 *)a + le16_to_cpu(a->data.resident.value_offset));
-	ir_end = (u8 *)ir + le32_to_cpu(a->data.resident.value_length);
-	index_end = (u8 *)&ir->index + le32_to_cpu(ir->index.index_length);
-	if (index_end > ir_end) {
+	if (ntfs_index_root_inconsistent(vol, a, ir, ni->mft_no)) {
 		ntfs_error(vi->i_sb, "Index is corrupt.");
 		goto unm_err_out;
 	}

-- 
2.43.0

