Received: from mail-pj2-f21.google.com (mail-pj2-f21.google.com [74.125.227.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D782F3A545E
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856773; cv=none; b=KP+QnW0YkeYvy3h4f0UasqHmmDM9PXqJ3OAasSIhJ8RXjmaGxR1MZyLG7oTYKmUmJouXLyAGpzsuOdjJZ1sN0VkkP/XEByelijUxf+6wZMj3BR5iok+oDFK1PVDBS8Pf1G/PcHRR30nJVCVvsr+l2t3Vtms+Scq91Yh5KZ7c0RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856773; c=relaxed/simple;
	bh=PSDY18h/6p+CpldzH/+fu1Qf7z5F2c1RbgyeoKGE7hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FLKAjF9fkw9+cvPfNgAUIjTNf15slLfNjKtjNBkC9EFs60U/h95LLdyWvcxQZfd154yqD8V1CjR30LzIWYqlQYfMX/xI0JPZrhNdI+1zikagQxFsWXnSXEalb2wKYq5q4cqyN/f/XzNq87p8k6uLTWddAZLfP7m5bwtfLPRTNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUhW9R1w; arc=none smtp.client-ip=74.125.227.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUhW9R1w"
Received: by mail-pj2-f21.google.com with SMTP id d9443c01a7336-2d747f0b25dso20550835ad.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 15:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856770; x=1790461570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BOERddP/3wsRFSEkEbdiAeBbjAi0Tbkk2N3MtM1M3to=;
        b=jUhW9R1wMzkloWzLT6PALwxO57a9u3Sy8fmqyR/bnwxeAv/In0ig+tDlJ4EypnkkAQ
         ZHc4KofxuJBQWHunqjrn/DTeysh1cKzjPy8QQY0UKWbs5L0K0Ayv39rvSiilT4fBOUVg
         zj8oZzWpOaVjW5SiRaTax4i6imWJUwVu7W/wRidSteyH1xNLTkRSO1zcNjNyYkq2JnqP
         zstsGZhnea5zaELlrVH6+0gaQvddRWQBZNjwktlqT5SND3O91k3Tg9VGb1x8T+Ibfzwg
         Zo9BWdhI+N5ClJHcF79EYVZDTt5jXRkseqyPM+uE+XrRqfKmJZXFCZ91ZM1WKuFy79/o
         rqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856770; x=1790461570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BOERddP/3wsRFSEkEbdiAeBbjAi0Tbkk2N3MtM1M3to=;
        b=ohMTsGnldK48Dxf0mzTtqalV/FE7w+UyTsIpF6BCDmMFet1pw8DuQxTdkelFgko5C5
         clWwkJZRU323XtDdQzVomIeR3QugqVvQeWXO1CG5hWW7WHk+N90CV5gDFAhxn44P5kde
         ZQgzENpGX13Q8Y5hCE7XfX914sUPOF8cpK5KWJ5p2TrmlYj+AaFkhZS1HwqDkf5JSDnU
         rSr29S5pCFC1UYA60X+CYz09/bTaKOlBbORHwLNZ9/n8wfGqhrCGv/nz5q63/mare21U
         54Ex8E8sS2mXkJmfnBHgs1H0R5vyG2wiWsgWa4mt9ajgZtbjtKG+4CSCiD3+jbSplgF4
         07Jw==
X-Gm-Message-State: AFuF++mTnzm6aQXqrjTYGJeMpmu70F0mJot43OKddGcpR3XV8QQAvje0
	hPY/nxX8rOxFO07ISjg4xXee7qDvqMSR3/Em+072CMRaf0sc7n6H1xTi
X-Gm-Gg: AYBFou31RFkQUD7alGzpmZJqYJ2JdTBd3gbyBnenaTTxAtCWGNNfkudDKCq5sg6CVcw
	LM1EAN75VJzzkrDdY59kE9rRfGvMPvVGGPs4xR2yNNavyIqow8lCd/2H9ufml+gyv4F5L5k2N/n
	zErpf4O7lhBkr6WVCHlKu7WKv+xpUJDEjZpzb5uPwSRftmhlyCTTDNFQFlD7BlxEid7hVbK9+E8
	9iDcQY8GyDecK3ATi+UhRbfgllbCHjYIYmiKOK2o2YZOm0WlxbGLdy/x5H0M9Ji4niISLi0NFB2
	IioNWVW3C87w/IG0fq+jALusbq7VdujntTy+SleYdteeDAc9jmTGmFkct1L4jt8RFYloIWGar3h
	WMZZ7EJ6bso4NzMeOpBW/c4cpN3q6rNtLADnPdnmssonpOZxQNCEXKAEeTCoQ8w8CGtQl0xWQ1u
	cU4F9tJ+tD/u1CMjEAuCb8Khmj6ywe2rhVsFhnJt1fbZT/3zL9BuA48y8P7H9bLg2F75pn2oGMf
	9XehBHERtlgvVN9dlY9VJn7Vi7kVuUWa1KrYFDkhDyEF7Ge/IEQTctMC7fq5HZwSVTqb7NSTISU
	0/AGqOiRdg==
X-Received: by 2002:a17:902:eccf:b0:2db:210f:c111 with SMTP id d9443c01a7336-2ddb1ab4ef6mr116979405ad.2.1789856769848;
        Sat, 19 Sep 2026 15:26:09 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df3c43bed6sm2186635ad.1.2026.09.19.15.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:26:09 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: mikulas@artax.karlin.mff.cuni.cz,
	brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hpfs: fix extended attribute bounds checks and get_indirect_ea() overflow
Date: Sat, 19 Sep 2026 22:26:08 +0000
Message-ID: <20260919222608.3795070-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix extended attribute parsing bugs in fs/hpfs/ea.c and fs/hpfs/map.c:

1. In get_indirect_ea(), reject negative or wrapping size values (such
   as size == 0xffffffff where size + 1 wraps to 0 and kmalloc(0)
   returns ZERO_SIZE_PTR).
2. In hpfs_ea_ext_remove(), hpfs_get_ea(), and hpfs_map_fnode(),
   validate EA entry sizes (`ea->namelen` and `ea_size(ea)`) against the
   buffer end and ensure `ea_size(ea) > 0` so malformed extended
   attributes cannot cause out-of-bounds reads or infinite loops.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/fs/hpfs/ea.c b/fs/hpfs/ea.c
index 4664f9ab06ee..a3b3e6c7800e 100644
--- a/fs/hpfs/ea.c
+++ b/fs/hpfs/ea.c
@@ -51,6 +51,10 @@ void hpfs_ea_ext_remove(struct super_block *s, secno a, int ano, unsigned len)
 static char *get_indirect_ea(struct super_block *s, int ano, secno a, int size)
 {
 	char *ret;
+	if (size < 0 || size > 0xffff) {
+		hpfs_error(s, "bad indirect EA size %d", size);
+		return NULL;
+	}
 	if (!(ret = kmalloc(size + 1, GFP_NOFS))) {
 		pr_err("out of memory for EA\n");
 		return NULL;
@@ -135,10 +139,22 @@ char *hpfs_get_ea(struct super_block *s, struct fnode *fnode, char *key, int *si
 	secno a;
 	struct extended_attribute *ea;
 	struct extended_attribute *ea_end = fnode_end_ea(fnode);
-	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
+	if (le16_to_cpu(fnode->ea_size_s) &&
+	    (le16_to_cpu(fnode->ea_offs) < 0xc4 ||
+	     le16_to_cpu(fnode->ea_offs) + le16_to_cpu(fnode->acl_size_s) +
+	     le16_to_cpu(fnode->ea_size_s) > 0x200))
+		return NULL;
+	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea)) {
+		if ((char *)ea + 5 > (char *)ea_end ||
+		    next_ea(ea) > ea_end ||
+		    ea->name[ea->namelen] != 0)
+			return NULL;
 		if (!strcmp(ea->name, key)) {
-			if (ea_indirect(ea))
+			if (ea_indirect(ea)) {
+				if (ea_valuelen(ea) < 8)
+					return NULL;
 				return get_indirect_ea(s, ea_in_anode(ea), ea_sec(ea), *size = ea_len(ea));
+			}
 			if (!(ret = kmalloc((*size = ea_valuelen(ea)) + 1, GFP_NOFS))) {
 				pr_err("out of memory for EA\n");
 				return NULL;
@@ -147,6 +163,7 @@ char *hpfs_get_ea(struct super_block *s, struct fnode *fnode, char *key, int *si
 			ret[ea_valuelen(ea)] = 0;
 			return ret;
 		}
+	}
 	a = le32_to_cpu(fnode->ea_secno);
 	len = le32_to_cpu(fnode->ea_size_l);
 	ano = fnode_in_anode(fnode);
@@ -162,6 +179,7 @@ char *hpfs_get_ea(struct super_block *s, struct fnode *fnode, char *key, int *si
 		if (hpfs_ea_read(s, a, ano, pos, 4, ex)) return NULL;
 		if (hpfs_ea_read(s, a, ano, pos + 4, ea->namelen + 1 + (ea_indirect(ea) ? 8 : 0), ex + 4))
 			return NULL;
+		ea->name[ea->namelen] = 0;
 		if (!strcmp(ea->name, key)) {
 			if (ea_indirect(ea))
 				return get_indirect_ea(s, ea_in_anode(ea), ea_sec(ea), *size = ea_len(ea));
diff --git a/fs/hpfs/map.c b/fs/hpfs/map.c
index be73233502f8..b2c571e71a60 100644
--- a/fs/hpfs/map.c
+++ b/fs/hpfs/map.c
@@ -168,9 +168,9 @@ struct fnode *hpfs_map_fnode(struct super_block *s, ino_t ino, struct buffer_hea
 		return NULL;
 	}
 	if ((fnode = hpfs_map_sector(s, ino, bhp, FNODE_RD_AHEAD))) {
+		struct extended_attribute *ea;
+		struct extended_attribute *ea_end;
 		if (hpfs_sb(s)->sb_chk) {
-			struct extended_attribute *ea;
-			struct extended_attribute *ea_end;
 			if (le32_to_cpu(fnode->magic) != FNODE_MAGIC) {
 				hpfs_error(s, "bad magic on fnode %08lx",
 					(unsigned long)ino);
@@ -192,24 +192,31 @@ struct fnode *hpfs_map_fnode(struct super_block *s, ino_t ino, struct buffer_hea
 					goto bail;
 				}
 			}
-			if (le16_to_cpu(fnode->ea_size_s) && (le16_to_cpu(fnode->ea_offs) < 0xc4 ||
-			   le16_to_cpu(fnode->ea_offs) + le16_to_cpu(fnode->acl_size_s) + le16_to_cpu(fnode->ea_size_s) > 0x200)) {
-				hpfs_error(s,
-					"bad EA info in fnode %08lx: ea_offs == %04x ea_size_s == %04x",
-					(unsigned long)ino,
-					le16_to_cpu(fnode->ea_offs), le16_to_cpu(fnode->ea_size_s));
+		}
+		if (le16_to_cpu(fnode->ea_size_s) &&
+		    (le16_to_cpu(fnode->ea_offs) < 0xc4 ||
+		     le16_to_cpu(fnode->ea_offs) +
+		     le16_to_cpu(fnode->acl_size_s) +
+		     le16_to_cpu(fnode->ea_size_s) > 0x200)) {
+			hpfs_error(s,
+				"bad EA info in fnode %08lx: ea_offs == %04x ea_size_s == %04x",
+				(unsigned long)ino,
+				le16_to_cpu(fnode->ea_offs),
+				le16_to_cpu(fnode->ea_size_s));
+			goto bail;
+		}
+		ea = fnode_ea(fnode);
+		ea_end = fnode_end_ea(fnode);
+		while (ea != ea_end) {
+			if ((char *)ea + 5 > (char *)ea_end ||
+			    next_ea(ea) > ea_end ||
+			    ea->name[ea->namelen] != 0 ||
+			    (ea_indirect(ea) && ea_valuelen(ea) != 8)) {
+				hpfs_error(s, "bad EA in fnode %08lx",
+					(unsigned long)ino);
 				goto bail;
 			}
-			ea = fnode_ea(fnode);
-			ea_end = fnode_end_ea(fnode);
-			while (ea != ea_end) {
-				if (ea > ea_end) {
-					hpfs_error(s, "bad EA in fnode %08lx",
-						(unsigned long)ino);
-					goto bail;
-				}
-				ea = next_ea(ea);
-			}
+			ea = next_ea(ea);
 		}
 	}
 	return fnode;
