Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8650C27057D
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794684; cv=none; b=swVc1+wXZpTFmRP3YCWo/PPqhW/puFq95sJl6Xy3013qnk3uqcgghUuL2RpOMdrrj1e2oKTGo6bPf1dhWuwHePZgIn+j5BBef8AVtAprQfcIGubqHHKlWelRHpJRiXGvEtTiuVKPiQ7cXBzwwQluXIqYq8c5MBy/LN/UPaJVJGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794684; c=relaxed/simple;
	bh=M5J2lodRrUAmaH6dLAkP5KCyG2v+GNiSPgfQ3bSiU04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rmXDfDYkggdzNzk8bS9/eqGTN0MLPA0OjN/LK9Nha0llTauHVhrORMMXvk7Czyml8n7iRqvOyCBd7lNKnRPdSeNFqFDd5qWkqTzXASoDPYMqmT+eEQ0STqgeRwwOUs/qX51E/B6JnqwfJbSiLQTjVkxCoxdfTugzN/JP5HJMFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=uM/Pmvkq; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=SlGboqPs; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="uM/Pmvkq";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="SlGboqPs"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687EYvhQ2616575
	for <linux-fsdevel@vger.kernel.org>; Mon, 7 Sep 2026 11:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=fnG+7V+vVRFd32OZquqCYHb/ch
	8E17atJPROlBwFa5s=; b=uM/Pmvkq3KJujx1DdospGbKHf5XCeOuDi32kUYQgRw
	+/L1vlUl5eQvECuOWY5cmLd0V2RrQ49suDNr8Itj4G4/qwM4B0w+K2dufZEoDRPG
	efjqtKyoYydN5aT9fXhAPx1mybU64lM7LNJHdLfu6SBDnz+/zFBH37mY9wPI5YTu
	Ckl2ub5ZtGFAhkilTX5nEQUOdNJRl2J8FpQpRz4ExwAlofAppx8ows8EbhqRCP0u
	lafLjHAe7aHLXazXrAZhFORM+pooMTuDyuMhBHSh3GoDfirFbzCxZ+ktII58+381
	xPqjHMnwk2OUqyWCd20Hnaz5AneBcQr1QB9ROmmiGskg==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ghf7k3sx5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 11:24:41 -0400 (EDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6b85fefb1eeso1755840eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788794680; x=1789399480; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fnG+7V+vVRFd32OZquqCYHb/ch8E17atJPROlBwFa5s=;
        b=SlGboqPszrEMFRKGMc00jgLkHXm9aJla5RGQXW6o8yCqplQMUxyaB5xK+x/vyyXqmX
         HvlfgrONM1Qog/8gv0aIYBQMvNpyTIp6VkhabfRx3HI0gnI85qz/7hNSRg1XQ7p2dTol
         q0m2Tb/ete2XItDBB64jKT3zLf1jxHOEl3nWfLPt3s98a6soKaoTNF9AyGRdBufodLJ+
         qi2pwFSkMJlVR7Z9wPSKKVPGLw7G3jwGjWbg0bGXFWx30vIoHPEQRoqTtM18/QoXA/HC
         PQUCW9Bik5IHvhvqCkp5376U3prp2qDUV4s/xcg7EF9dvYBPTg9lQkmhc6euob8ZOHPC
         I8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788794680; x=1789399480;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fnG+7V+vVRFd32OZquqCYHb/ch8E17atJPROlBwFa5s=;
        b=prqiyngnxyw8TMDLXWN2DzpSxBsfZcZdL1IlMY7immIfMgh/om2NINplhyNGvNeAar
         bZ7es7jykicr4oP6Kx0DO1BhRIQh/HWhetrO6yYBUEbvkLs2NDYzMScIZlxWYCIgYEJd
         TIDSx23LEWfcnRThPi5EwkH/JdX2Ex/Y1HYKFkyOwiWTTExj03OEY8RKDUugfCCc10+m
         SWrJVRAisMNRPmU0c5NoItniDNq4rcTdrWEYzzG1+91ap9IEIgZk3tHX9cRmv9pH7NV4
         XK9GOXJ+aWavB63Ng1sk91kDUticeWQVZwH9fx9RKGGKm7O0WQIRQqVxxHtNX/Axw50u
         aq0g==
X-Forwarded-Encrypted: i=1; AKwUvBzZMcrF+uUWCjM+SLfGyxkOxXTZsG6ggDytySBjx2hI15OiRYy0l2UwQOTOvkLVYblq+WEcGzgc/2HtNJVk@vger.kernel.org
X-Gm-Message-State: AFuF++nuYCmpKWASxwzu165OZnxMIqxbEvA9GGHH3RCMVkMXUHdQKK3i
	tR8jmituFB3DjxYqaaI/I9ld/X1GdjZaOEncOKXUgsj1bdOkLieY3fsFjW60COnx3VrfMSATu0t
	pUfxR1KGDwTbxj2ICgaLE3iNI7bIJu71G0m6rF9wT71KMAnFOB0ICiVweXwpGPqVjUonbnn3r+w
	==
X-Gm-Gg: AYBFou2pql08YOYlejSmO8RS4VclQguywVDDtJ5/qSok66nf2Lveg+oJQJB1QzNclHh
	bhJGurjJQT5mwIkw8YdUcFRIBhv4XW8PrSUXttiDnRsEwWnpoB1vI2hhWavf2LOjeXXpsmMta/m
	yhKn7CTeJxg4Jigo07/AFlbWg194A7AXYtlsAcuqR/mYso9OrMZ6aNP0PEsof3ZVjKCdBdSVxQz
	r9uD8jkw2/LQOKVdb8LPbpXN8iYE+969WaVJo1dbTtyr5bSpWWqcot1fOm0atvu5+1u6qgF5ruE
	sAr6h7t+vg7BkGKxrNljjjTa2EftyJUPE+EyXgCoGDQjn47hlEsHKf+5p4Uvc0WRQpfvRcrQ62I
	LpbUdKZln9BThNAwE4rWC8ZOZOQJF+R4bPKqJA7cXHRAW/Q==
X-Received: by 2002:a05:6820:179b:b0:6b1:6136:956a with SMTP id 006d021491bc7-6b6fccdb1c9mr24227418eaf.15.1788794680452;
        Mon, 07 Sep 2026 08:24:40 -0700 (PDT)
X-Received: by 2002:a05:622a:352:b0:52f:b29d:1eef with SMTP id d75a77b69052e-530546be95amr271249281cf.7.1788794342484;
        Mon, 07 Sep 2026 08:19:02 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53093295584sm1566981cf.13.2026.09.07.08.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:19:01 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 07 Sep 2026 11:18:38 -0400
Subject: [PATCH v2] isofs: convert the zisofs read path to use folios
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-isofs-zisofs-folio-v2-1-c2e430abfcbc@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAM3VnmoC/32Nyw6CMBBFf4XM2hpasQRX/odh0cdUxiA1HSAq4
 d/lsXd1c5J775mAMREyXLIJEo7EFLsF1CED15jujoL8wqBypfMq14I4BhbfPUJsKYqzlVpJr6s
 CC1iGr4SB3tvprd6ZB/tA169Pa6Mh7mP6bNZRrr2/glEKKZxFo2VhyvIUri62w9OSOaIfoJ7n+
 QcdxUrMyQAAAA==
X-Change-ID: 20260906-isofs-zisofs-folio-5b1621d694e4
To: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788794341; l=7400;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=M5J2lodRrUAmaH6dLAkP5KCyG2v+GNiSPgfQ3bSiU04=;
 b=CMfJnquzMiO+SFW6SANUuHfybzXgj3GwpqGGYgI133mtaxcZwwHH/gu6mTxwOo8fnIcMWC0iB
 Piiw2S9GMRKBI6lXHBXB8YP7w7Zn0/qaIYPDPmZ3Ka3meqMti11ddgg
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: vJUfetddUfFkyHAZ3_OZnEwP9XwlEwlM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE3MCBTYWx0ZWRfXyTgpvEdXDAdK
 NolTCAkY+VK8zYDMlhLFob/qatoH44eMWOOBaPPyVfysH/qPVApo/Odo6fsBkfOfV2TBcfsaAjT
 mBmWhl7jui4JpInf9dT+o0bul+OK7rDWAd+VZbsa/ABi+R2wRZkC
X-Authority-Analysis: v=2.4 cv=QeBWeMbv c=1 sm=1 tr=0 ts=6a9ed739 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=bC-a23v3AAAA:8 a=PTHbhwen-nVrj_TBoDAA:9
 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE3MCBTYWx0ZWRfX1QftQZpmlpvS
 IXkBkTWEoW69cDoOuZNXFOkd1P44V+HXJbEkQou8v+2O21kbfBlbT9WfBtjnA5n2fw3kY+Bm6aO
 nk6fAN7DGXxON9t2rRjUNUlYkwYu8HPsftNpjTVdavPTWZkFwEVJBHdQzbOJlyzvMJumkYz8yRb
 Y4L+CyxGOc34865PJsrmdwbMMbHIfd+fg0M7JhJlGbecrebLESTCsBmj6yPMmz/d71J3x0i6hLK
 zAk9IWYKdFWs+z1JtLYLLr+cC+dA594W/9o2M2AR+JjxK03nd2CZz1I8DdAQA8rSQZ/47dfA0Z1
 3CHBToI0IRGp4a+0nonjYd7wEJ65jKrB/CFjgZv8biEcF29TKeMKfcg4E7TEzzeaDCVndgH2xIm
 it11gTr+xdIz8a0uYdUI3BtJugoWqUPk2qalFoLPtRjtt52Q63Rxgd7VQ7k946m0S27cmCgKTCX
 FfnjnWOf3tnGs06gWig==
X-Proofpoint-ORIG-GUID: vJUfetddUfFkyHAZ3_OZnEwP9XwlEwlM
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11899
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=10 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=10 clxscore=1015 impostorscore=10
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070170

Store folios in the array that zisofs_read_folio() passes to
zisofs_fill_pages() and zisofs_uncompress_block(), use the folio APIs on
them, and grab the folios with __filemap_get_folio() instead of
grab_cache_page_nowait(). This removes six compound_head() calls, from
page_offset(), the three SetPageUptodate() calls, unlock_page() and
put_page(), and the last struct page usage in isofs.

isofs only uses order-0 folios, so folio_size() is PAGE_SIZE and the
logic is unchanged.

grab_cache_page_nowait() passed FGP_NOFS as well, but FGP_NOWAIT already
prevents reclaim entirely, so leave it out, as FGP_NOFS is on its way
out [1].

Change poffset to be unsigned int rather than just unsigned while at
it.

[1] https://lore.kernel.org/linux-mm/20260830041901.2668-9-willy@infradead.org/

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
Changes in v2:
- Pass the offset to kmap_local_folio() and use folio_size(), per Jan
- Add a sentence in the commit message about how all folios here are
  order-0 for now
- Link to v1: https://patch.msgid.link/20260906-isofs-zisofs-folio-v1-1-cbea614a773f@columbia.edu
---
 fs/isofs/compress.c | 77 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index f9869d62b850..2d23abaeb874 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -39,7 +39,7 @@ static DEFINE_MUTEX(zisofs_zlib_lock);
  */
 static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 				      loff_t block_end, int pcount,
-				      struct page **pages, unsigned poffset,
+				      struct folio **folios, unsigned int poffset,
 				      int *errp)
 {
 	unsigned int zisofs_block_shift = ISOFS_I(inode)->i_format_parm[1];
@@ -66,11 +66,12 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 	if (block_size == 0) {
 		for ( i = 0 ; i < pcount ; i++ ) {
 			unsigned int off = i ? 0 : poffset;
+			struct folio *folio = folios[i];
 
-			if (!pages[i])
+			if (!folio)
 				continue;
-			memzero_page(pages[i], off, PAGE_SIZE - off);
-			SetPageUptodate(pages[i]);
+			folio_zero_range(folio, off, folio_size(folio) - off);
+			folio_mark_uptodate(folio);
 		}
 		return (((loff_t)pcount) << PAGE_SHIFT) - poffset;
 	}
@@ -119,11 +120,12 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 
 	while (curpage < pcount && curbh < haveblocks &&
 	       zerr != Z_STREAM_END) {
+		struct folio *folio = folios[curpage];
+
 		if (!stream.avail_out) {
-			if (pages[curpage]) {
-				stream.next_out = kmap_local_page(pages[curpage])
-						+ poffset;
-				stream.avail_out = PAGE_SIZE - poffset;
+			if (folio) {
+				stream.next_out = kmap_local_folio(folio, poffset);
+				stream.avail_out = folio_size(folio) - poffset;
 				poffset = 0;
 			} else {
 				stream.next_out = (void *)&zisofs_sink_page;
@@ -173,9 +175,9 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 
 		if (!stream.avail_out) {
 			/* This page completed */
-			if (pages[curpage]) {
-				flush_dcache_page(pages[curpage]);
-				SetPageUptodate(pages[curpage]);
+			if (folio) {
+				flush_dcache_folio(folio);
+				folio_mark_uptodate(folio);
 			}
 			if (stream.next_out != (unsigned char *)zisofs_sink_page) {
 				kunmap_local(stream.next_out);
@@ -206,7 +208,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
  * fills in other pages if we have data for them.
  */
 static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
-			     struct page **pages)
+			     struct folio **folios)
 {
 	loff_t start_off, end_off;
 	loff_t block_start, block_end;
@@ -221,14 +223,14 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
 	int err;
 	loff_t ret;
 
-	BUG_ON(!pages[full_page]);
+	BUG_ON(!folios[full_page]);
 
 	/*
 	 * We want to read at least 'full_page' page. Because we have to
 	 * uncompress the whole compression block anyway, fill the surrounding
 	 * pages with the data we have anyway...
 	 */
-	start_off = page_offset(pages[full_page]);
+	start_off = folio_pos(folios[full_page]);
 	end_off = min_t(loff_t, start_off + PAGE_SIZE, inode->i_size);
 
 	cstart_block = start_off >> zisofs_block_shift;
@@ -267,9 +269,9 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
 		}
 		err = 0;
 		ret = zisofs_uncompress_block(inode, block_start, block_end,
-					      pcount, pages, poffset, &err);
+					      pcount, folios, poffset, &err);
 		poffset += ret;
-		pages += poffset >> PAGE_SHIFT;
+		folios += poffset >> PAGE_SHIFT;
 		pcount -= poffset >> PAGE_SHIFT;
 		full_page -= poffset >> PAGE_SHIFT;
 		poffset &= ~PAGE_MASK;
@@ -289,9 +291,11 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
 		cstart_block++;
 	}
 
-	if (poffset && *pages) {
-		memzero_page(*pages, poffset, PAGE_SIZE - poffset);
-		SetPageUptodate(*pages);
+	if (poffset && *folios) {
+		struct folio *folio = *folios;
+
+		folio_zero_range(folio, poffset, folio_size(folio) - poffset);
+		folio_mark_uptodate(folio);
 	}
 	brelse(bh);
 	return 0;
@@ -312,7 +316,7 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
 	unsigned int zisofs_pages_per_cblock =
 		PAGE_SHIFT <= zisofs_block_shift ?
 		(1 << (zisofs_block_shift - PAGE_SHIFT)) : 0;
-	struct page **pages;
+	struct folio **folios;
 	pgoff_t index = folio->index, end_index;
 
 	end_index = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -336,33 +340,38 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
 		full_page = 0;
 		pcount = 1;
 	}
-	pages = kzalloc_objs(*pages,
-			     max_t(unsigned int, zisofs_pages_per_cblock, 1));
-	if (!pages) {
+	folios = kzalloc_objs(*folios,
+			      max_t(unsigned int, zisofs_pages_per_cblock, 1));
+	if (!folios) {
 		folio_unlock(folio);
 		return -ENOMEM;
 	}
-	pages[full_page] = &folio->page;
+	folios[full_page] = folio;
 
 	for (i = 0; i < pcount; i++, index++) {
-		if (i != full_page)
-			pages[i] = grab_cache_page_nowait(mapping, index);
+		if (i == full_page)
+			continue;
+		folios[i] = __filemap_get_folio(mapping, index,
+				FGP_LOCK | FGP_CREAT | FGP_NOWAIT,
+				mapping_gfp_mask(mapping));
+		if (IS_ERR(folios[i]))
+			folios[i] = NULL;
 	}
 
-	err = zisofs_fill_pages(inode, full_page, pcount, pages);
+	err = zisofs_fill_pages(inode, full_page, pcount, folios);
 
-	/* Release any residual pages, do not SetPageUptodate */
+	/* Release any residual folios, do not mark them uptodate */
 	for (i = 0; i < pcount; i++) {
-		if (pages[i]) {
-			flush_dcache_page(pages[i]);
-			unlock_page(pages[i]);
+		if (folios[i]) {
+			flush_dcache_folio(folios[i]);
+			folio_unlock(folios[i]);
 			if (i != full_page)
-				put_page(pages[i]);
+				folio_put(folios[i]);
 		}
-	}			
+	}
 
 	/* At this point, err contains 0 or -EIO depending on the "critical" page */
-	kfree(pages);
+	kfree(folios);
 	return err;
 }
 

---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260906-isofs-zisofs-folio-5b1621d694e4

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

