Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2042346A10
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Sep 2026 23:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788738358; cv=none; b=UPIxILjAWKXDqT7+Bs9rVXqudtQ0nIgvDadvnDBGTpRB52ALcozy83UbIfH31fsyBuANUxJ3GgSB4Q2JRh9MPaZXHpLw4LdcdpS3e33/UJdUDkeQAKVBS1TD8+y2VIftSwFNB0YLO/TVMWNs7fzWnwLiVsEvwZdyOVcFpAeswUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788738358; c=relaxed/simple;
	bh=YUiuq5HeQFR23XYm7BLXCGUfVjFSKte5pFD1VHdooz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a9Bv+w/xszf/HxAJ7U3mNgHUqkVjdRQPgYfRGs506GL65aQZXDBu80wZyC7Kq/No9GkkUGGioW041szODiaANPNiEZdaOhVUwEHCZNnrJVLR3dV0TgCPUTakG7VqCAKTWkFr3Y1V2WLiZT6nAHyvYJHrLQI+4+3B/0rfoRqpBKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=cBn30TGD; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=YePP35VO; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="cBn30TGD";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="YePP35VO"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 686MYZUC1114863
	for <linux-fsdevel@vger.kernel.org>; Sun, 6 Sep 2026 19:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=/yb4ZkUCpaFSOuZxeTi0yQTuX8
	MdzkWN0yCAF5xi2yw=; b=cBn30TGDABdCA6aqJdXTGmmni2RYUYCvuqY3haebvp
	8yW9p3sZwkhByVbuw4q4HEj7sW9iq6fNnAhFYnHzriKUZiB4kQYusDuPJgU8VPDn
	FG1B7SyiaiDmNmJgJhvT2WauCWZiFy68cCrAUXl0dcI88HAVtUC/saUcmiWhKCEt
	Ebf9NYI2v1UzpGcZ3GogitunKKiPJTk0Hf5GVam+1/VRWRjEJlHq4TDDUW0mof5c
	qER/49ZOvLXOU7n7Uh39/LCt+cmreJlcXZP1F5pfvMLSXDPfoU9Pd6JXO1Ai6taa
	a8x9fmr/JCiahaTeQ7MaNmKbiFBZDEzf6BMbxPMktWow==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gh42tu4aq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sun, 06 Sep 2026 19:45:48 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-53000c06184so76433291cf.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Sep 2026 16:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788738348; x=1789343148; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/yb4ZkUCpaFSOuZxeTi0yQTuX8MdzkWN0yCAF5xi2yw=;
        b=YePP35VOqsNCxKLYktI9XSPVuU57MVpWBU9rvJ28GH0fH8Pq8bBI/RGS5xvZJoCLq6
         ALi+G+5T+3NDAoBkRFMg7uqh8WkTNH+ipUlVZCZdNa9DXJ6h+VIAP7puH4QjWbnMhxKw
         fkv1roK9S2xiXIHfH7lDOdx7SOVCFBKczSvC2bYV4aAiY18HK3JRB1/q2NHecI+yGIVe
         nMxRqs19TZ16QcBcRZn/juVI5GzC/hpXIyNoGCu4eAUEt7cinvRLlJukcn1MlLdG40J6
         l/DjkXu3yPm3mnJ/LIPYUWb37sxk9G5cglyA43MgrN4+SCRSJpMmqUNipdmYW8k1KNzx
         Lr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788738348; x=1789343148;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/yb4ZkUCpaFSOuZxeTi0yQTuX8MdzkWN0yCAF5xi2yw=;
        b=UV4vDHymzknm91PbbnvylOBOxG+FbVarVtnORwFU7vW30k7ZuOIzVEOF7oPT/lzdnH
         GBm14utrGaKLZlfQU1JlXX+XNnmcyvzNoexb2P9L149YAZ2F9M1/5hkvp8ybpqAbFA/d
         rivoztsujN9CwjMJLGOabenBRnUG5OR+XsnZECPf54UGPo3Zg471JIsx1CVBAZSYldrL
         8FUfhPC1pzoAirfiKb6u5/+NTTV6pdrhdNaZmIDvMuftHIsaG2q+nDBk7kGbUcEFTMzZ
         +2LVzRDpOwa7CPFHq6+DtjhpaDssS2RQg1hJKsiO58Q/4HZL0mj39qLVwuCoG2xpy41R
         bk0w==
X-Forwarded-Encrypted: i=1; AKwUvBy9voyQbOSel9lEcIA0g2GIV6+rgQwGnrbJW0XSK4KDgO97P4Lhe4H0avJE7sDfesGeaRctuoZ+z7N/I+C0@vger.kernel.org
X-Gm-Message-State: AFuF++nB+f1145eTtNprfZC6vhoaNWH856SeRpSthei6yKJjPURGLrVO
	avrMSpk04DeAvJTZF+28CqTJhE1RU0SqLjvyfS15qAybzwek+PBYX57dFyIWNA1gVxCWHjtEENI
	F25nFHlosuCd55gDbbya9ITr3s8e3jTwxh6N2hh0KkQtOUInOd7bZuEwGowzXKhEm+29DQ8EHlQ
	==
X-Gm-Gg: AYBFou3FxICLnlJCH3KqvFD8Nl9kLSsmLoariPRa0GBo6CkhhuLa14GKVdj8bh9fqUi
	ttJKxthQSSueh0nlwgubLcX0UELZBvwEefRIZwxHXE3lXiM+581XTAqz5RCABhErbJY0YWTpcEw
	0IHr8zBp+1Y1YvmdNIjts3CSBAsZ6h4PlbcXD64VP4I5TGASUaH/QiCpAKb1ukUB9ujgfV4xwhA
	lzOqJ2GZ5UP/9zV3kC7V+ByOoJKlHBtCP6Rg+ZGWacZS0ONjvo6PlFT7ezHpEJgEMvn1DhnNWA1
	b7gwqrsvXmzmP3FSXtB+yFyXoUto7fn1hfFC4kH883Jburbk7vYKMoV0RFJ532NarytB6eZ+JPn
	q5Wb8YWqrqFmEDYEb9D1aVSC6pBTFLx6pPeROe3jUt0aZAXeJ
X-Received: by 2002:a05:622a:244d:b0:52f:ae28:6aef with SMTP id d75a77b69052e-530549ef56bmr206701841cf.36.1788738347738;
        Sun, 06 Sep 2026 16:45:47 -0700 (PDT)
X-Received: by 2002:a05:622a:244d:b0:52f:ae28:6aef with SMTP id d75a77b69052e-530549ef56bmr206701691cf.36.1788738347261;
        Sun, 06 Sep 2026 16:45:47 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-104.net.columbia.edu. [128.59.176.104])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530541ba2d2sm75705561cf.22.2026.09.06.16.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 16:45:46 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sun, 06 Sep 2026 19:45:33 -0400
Subject: [PATCH] cramfs: convert cramfs_blkdev_read() to use folios
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-cramfs-blkdev-read-folio-v1-1-1be99a82be55@columbia.edu>
X-B4-Tracking: v=1; b=H4sIABz7nWoC/yXMQQ6CQAxA0auQrm0ysJiAVzEuhk6LVWRMq8SEc
 HdHXb7F/xs4m7LDsdnAeFXXslS0hwbokpaJUXM1dKGLYQgRydJdHMf5lnlF45RRyqwF2yhMEof
 QJ4KaP4xF37/16fy3v8Yr0/P7g33/AN0bOq18AAAA
X-Change-ID: 20260906-cramfs-blkdev-read-folio-16fecf6908ac
To: Nicolas Pitre <nico@fluxnic.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788738346; l=2174;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=YUiuq5HeQFR23XYm7BLXCGUfVjFSKte5pFD1VHdooz0=;
 b=7RQVLj+g4dR1Ms5MKg10azl/ZEQxqrZ+FrRbgv+OZXEbwjS/gh1ZsOCHA04qZAWcLuFRYMf2v
 uWXO2T/4bvGC0UrS30MOFyxP1o2OhYjSXUPIpZ41FdgLl8ue/IRIhgr
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDI2NyBTYWx0ZWRfX+OF3g2KZZ0nv
 zqVN0sNcoMjmdzTsQPtDCmvVUWz1SvAoTVZ+i8hY1Tv2f9hPuMsv5tj5Q+vsu5dmxkgkFB+O4u1
 9ErdmUolEUGplkUtWeZYy1Y+fuTbU31tkXF4vcfyjOCvYAK2aEQ/lt9pfykQq2MLntuv/laboYk
 HK3CNsbLlgfocxqCDaoy17RONJ1+tFgc6g75UFE5VDz/xilxGcZMi+gd8LhdYF5GOo+fvvoiNme
 PU2+1SJZafVvr06EHQSv6ciB06/b2j8asDaG+t650KO3/anmN+gVrrXWwRYZh/B5TR9LjrsfFGu
 2nhaAbtmi8UAS+29CU0OL154y3UA1NE05P/veD2aDPBa0dsSIMVO6sqCpi93Ys362cv4EeDqILB
 l9va4nMgv0LQJC+r1qA7dKDudaRWVnH89W3XxpgBKHgT8GomnBxOmAwBN0k1qw+YUQ+PHprU9Tk
 j2uOlBr2sZMdzJP40Vg==
X-Proofpoint-GUID: kC0y5-FuWVYejMHt6mEB9U7oB8yLQDdt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDI2NyBTYWx0ZWRfXyDeSqnAM1Pw/
 O59UrFgCzwF+9j6THLX5NZHmj7f8XTSTtQrVQMwlMUUDWPTBc9OC1H6SDVbbq7OZN+KbEEN86yH
 QWQJjiuhEH21H+qOQXkR7ed8Iol4TM7rm8GEEMZRE32ZQN4dlOov
X-Authority-Analysis: v=2.4 cv=DrhmPm/+ c=1 sm=1 tr=0 ts=6a9dfb2c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=aNLBvxxoObQFLnBXsbaGlA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=QBf-Z-tBp1IkNLPPPQEA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: kC0y5-FuWVYejMHt6mEB9U7oB8yLQDdt
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11898
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=10 impostorscore=10
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=10 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609060267

Read the block device pages through read_mapping_folio() and copy with
memcpy_from_folio() instead of going through a page.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/cramfs/inode.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index d4cd03f4f60d..b55eb3bd29c1 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -194,7 +194,7 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
 {
 	struct address_space *mapping = sb->s_bdev->bd_mapping;
 	struct file_ra_state ra = {};
-	struct page *pages[BLKS_PER_BUF];
+	struct folio *folios[BLKS_PER_BUF];
 	unsigned i, blocknr, buffer;
 	unsigned long devsize;
 	char *data;
@@ -227,15 +227,15 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
 	page_cache_sync_readahead(mapping, &ra, NULL, blocknr, BLKS_PER_BUF);
 
 	for (i = 0; i < BLKS_PER_BUF; i++) {
-		struct page *page = NULL;
+		struct folio *folio = NULL;
 
 		if (blocknr + i < devsize) {
-			page = read_mapping_page(mapping, blocknr + i, NULL);
+			folio = read_mapping_folio(mapping, blocknr + i, NULL);
 			/* synchronous error? */
-			if (IS_ERR(page))
-				page = NULL;
+			if (IS_ERR(folio))
+				folio = NULL;
 		}
-		pages[i] = page;
+		folios[i] = folio;
 	}
 
 	buffer = next_buffer;
@@ -245,11 +245,14 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
 
 	data = read_buffers[buffer];
 	for (i = 0; i < BLKS_PER_BUF; i++) {
-		struct page *page = pages[i];
+		struct folio *folio = folios[i];
 
-		if (page) {
-			memcpy_from_page(data, page, 0, PAGE_SIZE);
-			put_page(page);
+		if (folio) {
+			size_t offset = offset_in_folio(folio,
+					(loff_t)(blocknr + i) << PAGE_SHIFT);
+
+			memcpy_from_folio(data, folio, offset, PAGE_SIZE);
+			folio_put(folio);
 		} else
 			memset(data, 0, PAGE_SIZE);
 		data += PAGE_SIZE;

---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260906-cramfs-blkdev-read-folio-16fecf6908ac

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

