Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4954B366562
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079539; cv=none; b=P5A5zFF9lLJX4fibALJwEZGj8O02HPOgiSngnjz5fFQs8ne+w9mhK4dE4lopDlIugF7oQshReIHUbcOC+lyvsTCDhtyYOgpJuBcfpBX9GjemN8+8Xcpflm1nXqyZs8cMdRT5UmxIK2UHVZOUoDgcc/P4AoQS3uSMpyk6zv3EZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079539; c=relaxed/simple;
	bh=D4gkVYCuyVDuPE1Buvk1JCykg7DPhV5nQTFUmlWKvPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5cnzXKG42rt2s4UI1ZimQvr/xmhGHeRdGpgxUj2Voy61WARXqSmfmauBUycOWOv+AkqTl/ruLKHdTZ57i3462bC2SSrPLiLWHfg803BeQK2WoqyeMV5Mp9WK96vV/GpbgcSJtSHKHjo00OnimM/oKeOr2Zps2Y6d2h8/xN7F6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPqY59gJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPqY59gJ"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84a2dcec51cso3362386b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 18:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784079538; x=1784684338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CbeGLYld02CCONXLbMpcn1oEJP7Cj6rliwiy7C/rsVU=;
        b=FPqY59gJrGodh8O2Gd+gnF4Iw734rPB0p9mafshYopoOXBH3NoU5SZqWuVkdPjP4YX
         jof7ovO4NlXpnnLfCHS6cjKUu3siJ1c4nk2IyxSgMVeDsUJx7bcBO6juODPkRgSor59y
         lmrQI5S/PQhmudyVggN1Xgl4+sxIQDk7yJt/pi1AA4efMlBmO+JAYNrVVdV79NG/T/rS
         x1BOKxYDJtsbNy2ONagSj34M/xYQI3zqVyG/7hUaheUmub61Rqe4Yc66YFHbg/tqda2m
         lvpIulJ5eHnEJ+9VONrHaa2gIJs76ZaSoKPrZx/shzzYp4xLZ8+B++/Lv7fiMLoOKF1/
         vkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784079538; x=1784684338;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CbeGLYld02CCONXLbMpcn1oEJP7Cj6rliwiy7C/rsVU=;
        b=rjzAPGNFXwrPvYBZyP/pJeC/L//HmVVq0A2YqyB/wRo/rQiBJuoJmrecPFm1d1Hvcb
         ZDa40F72/TZ/Ux4bvbp01VA/1SE46TT7EGbTuYIFy3NzEd3ynzbkadjiMqK7kz+74aD/
         Q23PK9vEpIuDdFRPQYvC0IfJamCDHkfPnvbxA6CO5oJBs/5Du3ZIKyvSEhm1Nea+cktu
         lp3v0X/enxG2XImHgL0Rx69aNKJSVzLyHM6ycyWJAnt1B8W25gMXls+ZPivrmfTr/vi6
         vmHHc/Pw6+0wFvpuZW7khz/NeR6JuhNEYCn+II0TUtO6wHER4R5jeO969GIZN2Uoo0kc
         7EkA==
X-Forwarded-Encrypted: i=1; AHgh+Ro45HiVWMwu2B0pzi3WpEY08bG4MSM7s3WCbU40DlK+d+x/sCliDG5j3SQTga0Gl8S9uI+Rwahuz3H6FIyT@vger.kernel.org
X-Gm-Message-State: AOJu0YxfoUQxgCI6YerGW7AMau9Zq+rOnGc9SwABCl/b981Hdqb2d/sm
	yejnoNYQK0VDuo5Gq3wkjwURMS4+3Vs9vCzr+jfD7CIBkK594PgkUb31
X-Gm-Gg: AfdE7clyqS/4tpfh85rDtiaE6RAJrgRjea1GpZWx4bWBund9fxKhwNlFeW91C2SpsCF
	S/wW7g9aY58j+uz95GETviT8aitUglhBPy/an2HpV3DcPF0JK7Up6POo+iek6UpawlySm4FlH+0
	xwvzsjGe7qRYMVxZNHKUYd76QC8oSxddIkhdTgbgfgvx29Kgk6YeNixvzM9qGAsEPQJDl76Ir1W
	DgnjDHtA0QAuVzF4O5LWY3Uz/4tRl434InupZZD92QTkVj+jjDGbHQVPhc2wBdYkaLlUosEmjuE
	v/InwSs2gWi02BDEPg2vQQC7WNroI6xxyZPm563kBeoAwqVoK7i3C7aAQ+DdyVV472RNSF06Xyg
	upreSIQ6uzAruNMule3O1U6DAY6B7l6rhFcUnxsAtsRPyplce5MrT2f7x6ZdFhL1pZF05NMyULP
	k/ztJ4ecxKu/odeXtAJYM=
X-Received: by 2002:a05:6a00:b4f:b0:848:2c6c:dfe3 with SMTP id d2e1a72fcca58-84a557a72acmr4640925b3a.17.1784079537650;
        Tue, 14 Jul 2026 18:38:57 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3643399sm11080617a12.22.2026.07.14.18.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 18:38:57 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	ntfs@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	usama.arif@linux.dev,
	lance.yang@linux.dev,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 4/4] ntfs: Remove references to page->__folio_index
Date: Wed, 15 Jul 2026 10:38:03 +0900
Message-ID: <20260715-review-matthew-v2-v3-4-3c996b687a5e@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715-review-matthew-v2-v3-0-3c996b687a5e@gmail.com>
References: <20260715-review-matthew-v2-v3-0-3c996b687a5e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=TV938wPTTx1vq7N5CivmMeKJLnUw2a3r1F1VLwdVUKk=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqVuRvP9UTvRS5uVX1ah9v2gqNS2gsubF2PLPeR
 ORpW5CPeQGJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCalbkbwAKCRA08jD6945I
 0/D8D/wKAYg6NRCGVlCO3z2QWh2+wKwGfReZJgiY1sU2x48N70m3VykK9FF5PJpoQjKMWGmD84i
 0bbE3bQYLsJbMylEbyF3TLQTTVx5WnxojP2xw2kPZWBvLwPUzT26dd6lx8VpFwzmZ/T0LUmQ5r3
 nYmPL/PIXSWYfeVO5EyV4yrXhk6KaGCfXyG+GtrMjwWIe74uKbNOyYuwt9w4OQ8nShaeZG14ld/
 rpxs1ajxh3lGwCepZcfJjbnfB1loN45urxUIzG4WUiomQoGqxe56A4oBjbkKGy5wO81usSqpxwY
 9jZbSRMXB7jYD532TTQCaOpF4s1CswqXtyBSQv250fRv/vWF3VqaHFAJMBcv+K5dvViWW1V5stW
 EGTPtwWf3/Qapho1IpqP9tfbahkNulLDi1ue6SuOWAtLpg3AICzUxujvFIO1OR01oND95gWto3R
 3alXifAJNsegzSFf5jZO+H6pc/mqUKr/jlu4xU729Nm5bNUb2kKWDRYEeNZJl+1jdTug/HxWGuM
 foqLdacpaP7tqZVyqbDymA+clz9e9KOGz8d5gO0PI32mDurf1l5++W8OzB2rz8VQNsccXyIYxPw
 qVWYvKZfcKn7eVZ5s2smIZyy3xZjsZPJAt0Jiel8L1XiJgn42fB8RHXDjlYIW9lBZN1aZc00WLx 8bWJYqzbMOsxoUw==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Pages don't have indexes, folios have indexes.  Correct this in
ntfs_read_compressed_block() and also remove a use of page->mapping
while I'm in here.  Also convert the calls to unlock_page() and
flush_dcache_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/compress.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index f03fae63c199..d83d3e8e06ae 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -456,14 +456,14 @@ int ntfs_read_compressed_block(struct folio *folio)
 	struct page *page = &folio->page;
 	loff_t i_size;
 	s64 initialized_size;
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 	struct ntfs_inode *ni = NTFS_I(mapping->host);
 	struct ntfs_volume *vol = ni->vol;
 	struct super_block *sb = vol->sb;
 	struct runlist_element *rl;
 	unsigned long flags;
 	u8 *cb, *cb_pos, *cb_end;
-	unsigned long offset, index = page->__folio_index;
+	unsigned long offset, index = folio->index;
 	u32 cb_size = ni->itype.compressed.block_size;
 	u64 cb_size_mask = cb_size - 1UL;
 	s64 vcn;
@@ -812,14 +812,16 @@ int ntfs_read_compressed_block(struct folio *folio)
 	for (cur_page = 0; cur_page < max_page; cur_page++) {
 		page = pages[cur_page];
 		if (page) {
+			folio = page_folio(page);
+
 			ntfs_error(vol->sb,
 				"Still have pages left! Terminating them with extreme prejudice.  Inode 0x%llx, page index 0x%lx.",
-				ni->mft_no, page->__folio_index);
-			flush_dcache_page(page);
+				ni->mft_no, folio->index);
+			flush_dcache_folio(folio);
 			kunmap_local(page_address(page));
-			unlock_page(page);
+			folio_unlock(folio);
 			if (cur_page != xpage)
-				put_page(page);
+				folio_put(folio);
 			pages[cur_page] = NULL;
 		}
 	}

-- 
2.43.0

