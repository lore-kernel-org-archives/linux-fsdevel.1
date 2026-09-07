Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7143E2AD3
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747311; cv=none; b=mXbCup6mfA548+riKaqh/+nWkLeoEa88eRrTMVCutTmwrhxMJlCdAGLWXDflazxP5LafPubcE48pV60CxP38cdi9UTiybcMSNpbhUtibXkNzVjQ2YAEihOZfS2fcNZm8TIdDGLZPPzm8ULXCIrp/gZFQimpckq5kl4KWu/GQ0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747311; c=relaxed/simple;
	bh=Q+JkFVoD+9VtTQvusjBN/ZdydfYB8Qatpb8FUYnXtNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OBrui3zf2xUQBwdgyLDXWPrjhOweI9n5J+DntJAXOdqLfheq3+lbcd21c5wi5IsMM4Cjz2yjbvsGVi/RebNFks1A/TuYsYYtuo4RFwLsqVsWXdFWSj7bSSGakMQOdOsr15G635E/m39exdVMhX+Gp7zX41SJlV3zUDDbuMOXDyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=DybjH5Aa; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=VDWIg9r6; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="DybjH5Aa";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="VDWIg9r6"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6870bJmx851699
	for <linux-fsdevel@vger.kernel.org>; Sun, 6 Sep 2026 22:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=Vnc1SfQGmyn8O+fC4tqikkhh8x
	LBl/Vg6MkTrxsa1iM=; b=DybjH5AawY+7LHlYSgPdYG15v/PqxSp6jgrNsf1xK1
	KyXhC60ZyP0ozsISRQAOiu+LcRjSfKFrh/TN0+Q6aWLccc9umgJQB8EXwZasaGkP
	5HTO3P4dljdQbxqTZtaqGoo2FyQghk8LxB2d0neyZndXrYWw5EkWtSLs0LUtj7ky
	MfHDZa8l9BqNlVDD6I9hMfpMGBdgct8GpYyJKzKeN5W8qziGhC1OrH3NE3kco67g
	kvXIy42Ug8AtmDBuRCP42kqVvbX3evJpgcOcryFLt7U3ALyRS/JYmox9nulPcH8s
	7rbt5DAu94zqeK/1Umc+fY0FZDku7UsHSunMgk2KoBfQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ghf7qh0kd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sun, 06 Sep 2026 22:15:06 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90e98e74535so52089466d6.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Sep 2026 19:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788747306; x=1789352106; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Vnc1SfQGmyn8O+fC4tqikkhh8xLBl/Vg6MkTrxsa1iM=;
        b=VDWIg9r68tF+DqMgbh3UIRRjwuJxCHMEbXziNd8byqMWXyymh5VhIWae9NTUOYu4DJ
         vuut8zqnzCynLhwIr2daRcoU9GdiSmAJidaEyDyUmhO9/6pnEGmWAz66Vc5rikj50Av5
         +/Fqmmm0LSUJ/+wWQCCYAhbdEcRI1Zx+oXspMdi7eGlFnRf3bLEyFjmwx94MilbyA54T
         745Jeg2b4CjGNu0uuFShdNIwZ0qh3cipcO3m4TzOnMA2jD9nCt5XbXFWnZLL0xaQli0Y
         zUQgHwzGVFss6WheNhErYPLGX5hehCT/LOxJ8UXQ6yH2jMcbvGOTESdE9u8olBeECVhc
         ST5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788747306; x=1789352106;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Vnc1SfQGmyn8O+fC4tqikkhh8xLBl/Vg6MkTrxsa1iM=;
        b=KAaVheN6tBL3EbhMfCMpfQlg1j0JKZ3cOLxRgNxll2WhqIVgKODE4lgGZWrVY1DMpv
         ZLILFuJmtn2V0mQyB1O1g+2Ry+XUI40wmahYQELwCeEURail0TJ50L3huJaZp/Ys0Wam
         aLCcnpKkpBlzx2Wub5twe3GXq9fCpa5bQ7lbvyYtgLYKiDSL8OvjUe4Q4RhOzCNp+l3e
         TVNkrw04l4FHyC3YDiDu+1B+z7v080k5MoDv9ZdDR59PJFTQzOA3Rsh2cjheFZAWRJ1m
         g7My9Eb9BS19jIzSfEvboNd3dNsj0ogWByL9ZH6yP2S/W6XNPvRGymYFAMnxYPMe/X13
         xbHg==
X-Forwarded-Encrypted: i=1; AKwUvBy8cdREMZOQF+n0y6ML+hKANshfpvwDASrDZZd0lwbPSRpErCsxClZ6NkZRHDutz3b4w6Q9ScTUafJquyBk@vger.kernel.org
X-Gm-Message-State: AFuF++lkSKjl+Hc/fW+QL/+4yZkUhnXc8fWagiGl4gJ0twflk7Z9JerD
	LktGgEQ+tatuIPG6IM0P9c9DqWNSgnDj3ox9Rf4v/DnLOa3BklA3CB6h4F+Vd3ws3/vsTh0ytPD
	8Kmzf7X5eZLpaiNn1TTR1MM2PHnTTKc8RiXXIHKagO//LUCJevlB1A0mZfkHvvPk=
X-Gm-Gg: AYBFou3W3duYTBmgPp9iP8cR9XvSkWWsfnsL8+m8DShfkPNzWKr6Pmlg/+Xi6QTW7W2
	1rjfZSjZBdkhIzMmlm+LpIGdhERWS+9kKE3ye6CR+jsfhDfDtZhkD4pKKeTy8S2U+Qmw8U2k3O/
	30xPA2x4y5lzWRTtaAGkBldp2vGeNbbF2Bd7pNBuxn/Nz0UDnsPIX0biGF/MNYU7AzupZhf7BTr
	pMsZWCaOWGJPpEuP6OZ/WSiQ1LlOGIXQqkOmLBQnd9038snf4w1qKD2UET9EtPBW5PWsgIyTYlg
	9sGM5r3zYLatRyNvzrc5i58OsBgpvQHP767sNaNmqbWjHmUyGiMUR1ojo95m7Z/6kpI0rVjrbeZ
	4hADBtSqwtwK/7vgZxhdqRj1s+qkHS5oMScgB3pmCjO923g==
X-Received: by 2002:ad4:5dcd:0:b0:910:4080:dc4f with SMTP id 6a1803df08f44-9104080f964mr236600536d6.4.1788747306256;
        Sun, 06 Sep 2026 19:15:06 -0700 (PDT)
X-Received: by 2002:ad4:5dcd:0:b0:910:4080:dc4f with SMTP id 6a1803df08f44-9104080f964mr236599986d6.4.1788747305781;
        Sun, 06 Sep 2026 19:15:05 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91043b54cd6sm69433866d6.34.2026.09.06.19.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 19:15:05 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sun, 06 Sep 2026 22:14:59 -0400
Subject: [PATCH] isofs: convert the zisofs read path to use folios
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-isofs-zisofs-folio-v1-1-cbea614a773f@columbia.edu>
X-B4-Tracking: v=1; b=H4sIACIenmoC/yXMQQ5AMBCF4avIrDVpG5pwFbFQpoyISgcR4u6K1
 cu3eP8FjIGQoUwuCLgTk58jVJpAOzRzj4K6aNBSG1lII4i9Y3H+4/xEXuRWGa06U2SYQTwuAR0
 dX7Sqf/NmR2zXtwT3/QBoewyPdgAAAA==
X-Change-ID: 20260906-isofs-zisofs-folio-5b1621d694e4
To: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788747304; l=7178;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Q+JkFVoD+9VtTQvusjBN/ZdydfYB8Qatpb8FUYnXtNM=;
 b=SmBVkIMX8+tMf4huypfY/mKrJ5HcyZoxYz+qR13DmhhnW44Ezp+PKtGrxjPpWxBa0r8Pl9w0W
 KqnfinDMXDWBoafAchyIvxJIupfqwni0TlBLnNcLkNdrRbQZdrs4IIR
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: CbHZwNrzG0tDzNxBfVMd6VFNn1NH_sh7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDAyMCBTYWx0ZWRfX60YGr8SW4OGt
 JG4fRQ6102hCQOKWoDrl2F+si14ZFQOD8Gwd8aSPSYRcBfAsRlIuS9P73Q3UOAdq8di3WFjVZHY
 1Xl6bsQxQGX0YbE435bxxxEqUKfgBMf+ti7Zs6oQJwgYxN8xgstX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDAyMCBTYWx0ZWRfX0n35v6jDoH0H
 BqTqA/PtdUzt1aQ1ctJxuiVL6ct+l4TyatUKlTefYTbvkE7IL2j5UwQNz2BuBrJyhKpDfPz7jBb
 7Ef8YnpAGyrWx7kgPPZwwUPRYaQ01IXWpcmGba0rwnJNmYoSGpgcA4R1e6gAAueJW7Pd7fTe7gs
 NtE2Z/jc1pwF2iPu4dvDcCQ7cQi2uHY8vuGPT37C1W9AhhFQ66Saw+cDE2QHUb/Pn1yQoYyAl3R
 lXnO3vB/R6MmgiD0187O6aemhrIMCM5OrOD/IcVKUIVAFmr6L77hJLgoclXw1srR6lBO10ThzHT
 UzFwpTqUvT5Y0zo7yEg0AJ6dL34hSk32iOKVhyQJw8WKz7GZjt44mRt7C6FcaenzMLeqR8cJf8+
 iV4GAZEgyanCB84vnHkBMYXA/YZqMN67OUUGftfDq32ylEYlfGncilNtNVZmXCfgIY/L3KtrYr8
 CQ/WcLBtXU9emKF40WA==
X-Authority-Analysis: v=2.4 cv=N94Z0W9B c=1 sm=1 tr=0 ts=6a9e1e2a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=G7T0RNa-ZGpa6v3PHtgA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: CbHZwNrzG0tDzNxBfVMd6VFNn1NH_sh7
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11898
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=10 suspectscore=0 clxscore=1015 impostorscore=10
 malwarescore=0 lowpriorityscore=10 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070020

Store folios in the array that zisofs_read_folio() passes to
zisofs_fill_pages() and zisofs_uncompress_block(), use the folio APIs on
them, and grab the folios with __filemap_get_folio() instead of
grab_cache_page_nowait(). This removes six compound_head() calls, from
page_offset(), the three SetPageUptodate() calls, unlock_page() and
put_page(), and the last struct page usage in isofs.

grab_cache_page_nowait() passed FGP_NOFS as well, but FGP_NOWAIT already
prevents reclaim entirely, so leave it out, as FGP_NOFS is on its way
out [1].

Change poffset to be unsigned int rather than just unsigned while at
it.

[1] https://lore.kernel.org/linux-mm/20260830041901.2668-9-willy@infradead.org/

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
Convert the zisofs decompression path to folios. This removes the last
struct page usage in isofs and one of the three remaining callers of
grab_cache_page_nowait().

isofs never enables large folios, so the one page of zlib output per
array slot is unchanged.

Based on v7.3-rc2.
---
 fs/isofs/compress.c | 74 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index f9869d62b850..d7fdebf4b787 100644
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
+			folio_zero_range(folio, off, PAGE_SIZE - off);
+			folio_mark_uptodate(folio);
 		}
 		return (((loff_t)pcount) << PAGE_SHIFT) - poffset;
 	}
@@ -119,9 +120,11 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 
 	while (curpage < pcount && curbh < haveblocks &&
 	       zerr != Z_STREAM_END) {
+		struct folio *folio = folios[curpage];
+
 		if (!stream.avail_out) {
-			if (pages[curpage]) {
-				stream.next_out = kmap_local_page(pages[curpage])
+			if (folio) {
+				stream.next_out = kmap_local_folio(folio, 0)
 						+ poffset;
 				stream.avail_out = PAGE_SIZE - poffset;
 				poffset = 0;
@@ -173,9 +176,9 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
 
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
@@ -206,7 +209,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
  * fills in other pages if we have data for them.
  */
 static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
-			     struct page **pages)
+			     struct folio **folios)
 {
 	loff_t start_off, end_off;
 	loff_t block_start, block_end;
@@ -221,14 +224,14 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
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
@@ -267,9 +270,9 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
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
@@ -289,9 +292,11 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
 		cstart_block++;
 	}
 
-	if (poffset && *pages) {
-		memzero_page(*pages, poffset, PAGE_SIZE - poffset);
-		SetPageUptodate(*pages);
+	if (poffset && *folios) {
+		struct folio *folio = *folios;
+
+		folio_zero_range(folio, poffset, PAGE_SIZE - poffset);
+		folio_mark_uptodate(folio);
 	}
 	brelse(bh);
 	return 0;
@@ -312,7 +317,7 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
 	unsigned int zisofs_pages_per_cblock =
 		PAGE_SHIFT <= zisofs_block_shift ?
 		(1 << (zisofs_block_shift - PAGE_SHIFT)) : 0;
-	struct page **pages;
+	struct folio **folios;
 	pgoff_t index = folio->index, end_index;
 
 	end_index = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -336,33 +341,38 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
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

