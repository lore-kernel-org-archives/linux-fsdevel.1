Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB738424C
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856767; cv=none; b=sMOyxfP2H8NmlJiCc8tTLqLCXwPMdpx/tyFc9Kj2bHIm+5g2UzrcaLDf8NuIRhxwdLFafdL3EojoGHYeLDZ4Iu2z0n3N8TLaSYrit/BAHpmC7Uk71ofam2ambRfKQnP/ejABdL/QYAqxWgEafSoVbAsvrKNfFwKgkF3rjfQ47b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856767; c=relaxed/simple;
	bh=cNWi1UGDMqPAMRURqi9VV4kv7Ya0+OolMMjPRtbcc+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7kfAkuLL/Zo7NGpX4K2GvAi6/4WJWENMgqdSAfZwIlSc7QN2DfeUaTmLkTK+euTOhyncCkAiFvoBIDhB7EzoiFJJCezhTnholiSBrZrT1uF8Tv14JtJxqSDVnpeSpN95jrSiOI0JAM/qyWTu3Lfznv+C9zp18Sisgpywk9IlHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LL7iwu5B; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LL7iwu5B"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398a1676000so1565246a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 15:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856764; x=1790461564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ohwZyrLifCQ5xETf8llfhYAktD3IRGB/Lnr7Rd8UdU4=;
        b=LL7iwu5BVCJKm13ZkaB1HzmrpKhrg0mnAl6zyRaFgr8DU+Bx8v/NnBrO7U+dWSRebZ
         W45YtNZBJaoUqyHO2zjoh7UovJ8ERcihJx1p21cCblmVZuV62KCokU2Dw4EDnghkRy0b
         gkJatd2XONYTwji5HjZ8v5owzKO0vDVxn8dGLbEh0ncncKdRf8ay6xqg8rA7DyS0V2T6
         eYCoz0SV3q5GABt6wfOtz36QV4uwRgBzbtBw+cLAg0Ycrb4bbpecvGfj3GuQsOhRvTEb
         SbTBAOHDK+qKMKE67IJbTccGGol3I/qJKCAIXP9f5CZavGq3WzrR3WQ0JZOmkFXobfOQ
         180g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856764; x=1790461564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ohwZyrLifCQ5xETf8llfhYAktD3IRGB/Lnr7Rd8UdU4=;
        b=wPTbUdTt5F8SRWuZkli2a5kLsR3a7RzZM3dQcRXRGFLDkl+NG8jYSNOPRSJQklDWAe
         vql0FSFVbRYhKFNdopCJE5XTVlWwpUIFbTnftWhc2iYdEfpbCgrat0bYutOqRCO53/hd
         3lU+JovRu4EUr5JSjkgpmiZvf526frOU/BHmofl3FdObCZHjybftO6SbMJ6kKCQKEia/
         jo2fV92xqbZq2AXWxYYzW7fMcxM2YYGnNghr64OodJUDCtrRW3Cdzi/YnzhWsYHfX9kA
         IC7v2XNJfjwn9ZnUZ57xcmte+O5KfGbqWgWzdVv5/8jMXMeGVFbf97RL1ALGBS0FQi8d
         OBrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzx/uljaIDe0gSasLPIYNUaVOW8+Kgg0ZCFEQLlJZEP88oZV/nRzO12IOAe2vjpj54pi0bzjPW/J7rmFAcj@vger.kernel.org
X-Gm-Message-State: AFuF++l3HJs96hGsNiTg64Xqnzoov1ok3UkS6F3s6IUodXDSnhlOY2bU
	hhzkAXTQKjhbgwAZZbHRhmWC7PTOpqOeVD30Bc458cj4RFysYk+czqyq
X-Gm-Gg: AYBFou1ahQIRzNOnk6EaINmK5MsRq56GlvQ6ZZgBhBzYnQJejdo3unxyvWkk7uQexL4
	1tbvzyON3mRn4Rw3ybJDdunCSFu7z8/Q23j091jBX4ZOyBScVZNoyT998XtJKQ6kbRAd227XiW3
	91zAwoOGk90h8mevOH2sGgHLRNPslLa1oeNvJyTxjNW6UFtIMGUD4j60SPZ9J/3EUFvwRCAfosg
	VfP2p0L/Pm7ghmzBsA2p3PnDGcw+ZUPES3l8AdmFpNpo1zeLeEnN/TYEoTkfxNdHemQGxUbxjB7
	4XtT8/EhiruX2j8WnavdWzNZTFMQMvGSojWkU+m8KCsyYGs/X/Z4GppAlilWoRc78M1NLC1oAv3
	OaMiCL8cZsaNQKbgprIDmR4rneMZlovHK5SO+X2IyEP/zy3mJDavZFfMG7k+u+Xv6WcHRfrxKqo
	NxFfm/HVgcwfchaQl6iRetaSLLZbwZ+3NYToXjjP92Hz30yAIPJhr+HeckYRXZ69LQGZxND7Kau
	fxf+ERskLbJmo5O6OzMyu2fFiziddHjW/5H/+DvQBnHeKf8sk8U/9Vo2SFVEo6H2uWdmAqbFQ7C
	7sH/pN0UkA==
X-Received: by 2002:a17:90b:4f91:b0:39e:14db:4371 with SMTP id 98e67ed59e1d1-39e54c8895amr10821792a91.1.1789856763667;
        Sat, 19 Sep 2026 15:26:03 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a02526e27dsm1930910a91.0.2026.09.19.15.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:26:03 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: shaggy@kernel.org,
	brauner@kernel.org
Cc: jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] jfs: validate dmap parameters in dbMount() and slot chains in jfs_dtree.c
Date: Sat, 19 Sep 2026 22:26:02 +0000
Message-ID: <20260919222602.3794171-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two filesystem corruption crashes in fs/jfs/:

1. In dbMount() (fs/jfs/jfs_dmap.c), validate db_mapsize > 0, db_numag
   <= MAXAG, db_agheight <= MAX_AGHEIGHT, and db_agwidth > 0 to prevent
   out-of-bounds array indexing on bmp->db_agfree[] and shift UB.
2. In check_dtroot(), check_dtpage(), and jfs_readdir()
   (fs/jfs/jfs_dtree.c), validate directory slot continuation indices to
   prevent cyclic or out-of-bounds slot walks.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a841cf21da7d..f7d6efe8cec8 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -288,7 +288,8 @@ int dbMount(struct inode *ipbmap)
 	    (bmp->db_agstart > (CTLTREESIZE - 1 - bmp->db_agwidth * (MAXAG - 1))) ||
 	    (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG) ||
 	    (bmp->db_agl2size < 0) ||
-	    ((bmp->db_mapsize - 1) >> bmp->db_agl2size) > MAXAG) {
+	    (bmp->db_mapsize <= 0) ||
+	    (((bmp->db_mapsize - 1) >> bmp->db_agl2size) >= MAXAG)) {
 		err = -EINVAL;
 		goto err_release_metapage;
 	}
diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 8ce6e4458cc2..0a5361804155 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -2968,6 +2968,17 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 			/* copy name in the additional segment(s) */
 			next = d->next;
 			while (next >= 0) {
+				int max_slot = (p->header.flag & BT_ROOT) ?
+					DTROOTMAXSLOT : p->header.maxslot;
+
+				if (unlikely(next < 1 || next >= max_slot)) {
+					jfs_error(ip->i_sb,
+						  "JFS:Dtree error: ino = %ld, bn=%lld, index = %d\n",
+						  (long)ip->i_ino,
+						  (long long)bn,
+						  i);
+					goto skip_one;
+				}
 				t = (struct dtslot *) & p->slot[next];
 				name_ptr += outlen;
 				d_namleft -= len;
@@ -4343,6 +4354,10 @@ bool check_dtroot(dtroot_t *p)
 		}
 
 		/* The last node in the free list must terminate with next = -1 */
+		if (unlikely(__test_and_set_bit(fsi, bitmap))) {
+			jfs_err("duplicate index%d in slot in dtroot\n", fsi);
+			return false;
+		}
 		if (unlikely(p->slot[fsi].next != -1)) {
 			jfs_err("Bad next:%d of the last slot in dtroot\n",
 					p->slot[fsi].next);
@@ -4376,6 +4391,21 @@ bool check_dtroot(dtroot_t *p)
 			jfs_err("Duplicate index:%d in stbl in dtroot\n", idx);
 			return false;
 		}
+
+		if (idx > 0) {
+			int next = (p->header.flag & BT_LEAF) ?
+				((struct ldtentry *)&p->slot[idx])->next :
+				((struct idtentry *)&p->slot[idx])->next;
+
+			while (next >= 0) {
+				if (unlikely(next < 1 || next >= DTROOTMAXSLOT ||
+					     __test_and_set_bit(next, bitmap))) {
+					jfs_err("Bad continuation slot:%d in dtroot\n", next);
+					return false;
+				}
+				next = p->slot[next].next;
+			}
+		}
 	}
 
 	return true;
@@ -4436,6 +4466,10 @@ bool check_dtpage(dtpage_t *p)
 		}
 
 		/* The last node in the free list must terminate with next = -1 */
+		if (unlikely(__test_and_set_bit(fsi, bitmap))) {
+			jfs_err("duplicate index%d in slot in dtpage\n", fsi);
+			return false;
+		}
 		if (unlikely(p->slot[fsi].next != -1)) {
 			jfs_err("Bad next:%d of the last slot in dtpage\n",
 					p->slot[fsi].next);
@@ -4464,6 +4498,7 @@ bool check_dtpage(dtpage_t *p)
 	 */
 	for (i = 0; i < p->header.nextindex; i++) {
 		int idx = DT_GETSTBL(p)[i];
+		int next;
 
 		/* Check if index is out of valid data slot range */
 		if (unlikely(idx < 1 || idx >= DTPAGEMAXSLOT)) {
@@ -4477,6 +4512,18 @@ bool check_dtpage(dtpage_t *p)
 			jfs_err("Duplicate index:%d in stbl of dtpage\n", idx);
 			return false;
 		}
+
+		next = (p->header.flag & BT_LEAF) ?
+			((struct ldtentry *)&p->slot[idx])->next :
+			((struct idtentry *)&p->slot[idx])->next;
+		while (next >= 0) {
+			if (unlikely(next < 1 || next >= DTPAGEMAXSLOT ||
+				     __test_and_set_bit(next, bitmap))) {
+				jfs_err("Bad continuation slot:%d in dtpage\n", next);
+				return false;
+			}
+			next = p->slot[next].next;
+		}
 	}
 
 	return true;
