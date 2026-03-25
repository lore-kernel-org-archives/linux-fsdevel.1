Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E296534C9A6
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 19:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467658; cv=none; b=IJ/J5XLb8FVgAZdit5Ney7yieGiNjuqswK5PgC96NjlFOc/NwXRIdaDfXDYz8lGfYfXxOv6LtkYgqQL4eXNgnyVszgkoxA95J+Q//DsPdsf3fWNXxXlP+YtXZ1lRnbBGVrnUiVvL3RMUG1VzM+v9tN3geZYJbjDr3E/ckJF+npY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467658; c=relaxed/simple;
	bh=7zwsmyUip3CAkS6JVcgPiuvcXkqOuFIklXcl4CKLS7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JaJpMVnFSSSk3cNj/tzhpZOEMhheIc9ClUBA+FYchgPldsGkljvLIRj9hi42V+F+8RJ6N8QM4iyIrZ6pHKY0uXzc/diOWmfAnsJNh4GCZEz9x082q8m0tVRq51Unti+35MhzS6phDHuj4D1PfBlhpMJUxVZ/xvokZsUXleVPRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Au7sydVY; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Au7sydVY"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PDhSHl1628193
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 15:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=7qfY
	4Yey2B/8xRD7jk2HVXbmFsGdrb8gwFavo/knRp8=; b=Au7sydVYHJxfvhcGusjW
	FEbpn9GGkRrzgLrTHhOCMbptHSX/ALA6C88pzf3RJSXe3GRiSgydzJVOXWnM9VaY
	BNdVPii2y6i0oYq7y+9TO5mMxTct2pKIusyD79XPROlhYQeMKRNs87jKHrvyI0uw
	Wn8noKHIq4KB814b8F0P5FciGNk7ALGmCIX5JsU1y5+3ZOptL+6ahq1z3ywm2k1x
	MeMBSMQF62gu6jXDiXJrd/WT/tL/m6ciFKIBfAIwvo+/WigpyDrml510h3ho9m//
	h3PTLxppFUGY/IZ/ripHeVxqmM3JNsTeqGDbAUh4GSukZ/h2dod+qzk1+uc+2Tnd
	Ag==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4d3wxhswsw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 15:30:42 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5093a985e21so13620761cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 12:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774467042; x=1775071842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7qfY4Yey2B/8xRD7jk2HVXbmFsGdrb8gwFavo/knRp8=;
        b=QA7cdp9Pof6wSw2LF2ZZXQRrjhjqajI8Du7+0ZZIIzBpNGmwtPqw9n56867qAucAQ6
         i2dZhA+5P7t+GjwbgWnblESc7Hxh40i5qFTn0sp/l9auIOCZSARnFzpENTg+5k8zjFFx
         +5nPWC6wgGHETx8FEFPRnMzdwNpKAWaDMpLEuLWM/mnk6mlxTvBxnpRar4XsqdxxeHCo
         FbHEflNqRkAsqnzptYzct0j5BNSSrZ/bkO2e/FTEnHyx/dZ0w11zsOScOHODmhXxofeQ
         aHweS0ucuZ5JOyB4xp8fNGROY7+/c1ylZowqj4j8t2lj0HYfTPrB3XOGC+uSIAhfohZg
         F0HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFafwYboSCqfnXnlmu9TixaZHQI43RptaRMM4CYXsAuTEWGuNO/e2vZm+dZuYPOaI+ME7xpeQuOLM8Tqac@vger.kernel.org
X-Gm-Message-State: AOJu0YymY5ZnS7wBT5LL2rDLZYWWv6AuImhqSaO7Jyicp5d+SxjnFZw9
	3nA4o7OpYlYaj4xnOsa6B0M6JAop0b65Oko52tJYIgQCLdp7FeIklQKNDFNbFYiBzDwLZ7wYNn7
	PKjRYWr/YRCs5XjjpbMXZQTn4TYUs/pCYIsqsQRufYIYJSjrCrl+IVmk7JdwO6rI=
X-Gm-Gg: ATEYQzy0eOcaAcBl4GtS5Vqo5s6I4+xlrzwCmsZDAibt1DgWj1kcQZtMt95Jq6+ccLa
	tJ+h+51rNl+FEDfjTISkPdZIF1qf/6uCCgtZBzgv/mVdVaTlVrxcLv55QkGbVSo6xdUE0TeS2UX
	70t8Lec1fG55VZiVPht+NDYlOXiGaD4dZEAGNC0/jU3N757HxhqtCZf5SllxEOxJ7F0nMBbPDGn
	vpMgFO7eNfnOMt/bQ6zjLck7ryqgDDFrmQ6A+NtZXpfBICLl8PYr6xaXGktNejoNLvlgfQLkRXu
	GKV75lsIIItkC/1tkLdfaeOid9FlVboGOxtQ7h2X8kzpJ65CNU/cZapkUOgm2QrQvyw/8CQYRhT
	lVmGR87rQ3GJjZ8flC2btHOEoL0h1XlRS+BGm4A==
X-Received: by 2002:a05:622a:9d7:10b0:4ff:c08a:52c4 with SMTP id d75a77b69052e-50b80ce31d4mr55571901cf.18.1774467041726;
        Wed, 25 Mar 2026 12:30:41 -0700 (PDT)
X-Received: by 2002:a05:622a:9d7:10b0:4ff:c08a:52c4 with SMTP id d75a77b69052e-50b80ce31d4mr55571251cf.18.1774467041146;
        Wed, 25 Mar 2026 12:30:41 -0700 (PDT)
Received: from [127.0.1.1] ([129.236.226.199])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b9234e3a3sm5534221cf.19.2026.03.25.12.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:30:40 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 25 Mar 2026 14:43:01 -0400
Subject: [PATCH RFC v4 2/3] iomap: use BIO_COMPLETE_IN_TASK for dropbehind
 writeback
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-blk-dontcache-v4-2-c4b56db43f64@columbia.edu>
References: <20260325-blk-dontcache-v4-0-c4b56db43f64@columbia.edu>
In-Reply-To: <20260325-blk-dontcache-v4-0-c4b56db43f64@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774464193; l=1665;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=7zwsmyUip3CAkS6JVcgPiuvcXkqOuFIklXcl4CKLS7s=;
 b=L4CWzIK6kHXuFczj/fPjz2aWyUnS1OpJUL3M+esbeR43gMhMyjhAVsUMhpLPiY2zQSiPsjHza
 J5C73e08cUYBjjsRFhFa/ta9SjUn5dInI/J4XLjlsu/GNzv1JM0+xWE
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0MiBTYWx0ZWRfX6s6CsBJT3mrw
 vnIV2ZRCQKjvUzM5vqwOi4K3PYybhQcI4lmEBlafet1+v0c8o4JqK0yAJOe43Ml0o5pVQE7kU+R
 g7j3q5MSxrfHyM4cEVjaHY2X8vBc6CmHTfWk+QrTtkECIJO4PXdT6WGVwOIR28GOpF6Oni3EnxT
 hzPR30RXiEOKncwtTVCbcSspvKftc32raD/1ocGM+lrLJtV+G4+o6rXI7Wn+ZAAyAeMycPBddnN
 DM3e9ke7bgH+ViTer2g7WKYIsu1zmCGrUp6SGkwRkWVxvgKUFWg/Z3JB1kV1rD0DiYU6NhojFj2
 CXSxADfctvozdQx6/D5UACO32qyLlWI1irTcGY/Yqxt9bXwrvViFWosH3uyUF7PuMJvlzn6dIva
 +/kuhhEonqQ66ukobhH/sc0yz43eOqmHJRKaTKaghhqKHnRhwxqlv4CQRgEPzMUgJKjuZrIWd8I
 hXyxt1gg0hfUV8FB66w==
X-Proofpoint-GUID: fHulUO8QrKZSA-EQX9WdSTy21e99VMlR
X-Authority-Analysis: v=2.4 cv=V7NwEOni c=1 sm=1 tr=0 ts=69c437e2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=QOUmeeuX5y9IvSxXHa6D2A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=wJ0dTj9p17mGQU10CegA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: fHulUO8QrKZSA-EQX9WdSTy21e99VMlR
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11740
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=10 adultscore=0
 bulkscore=10 spamscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250142

Set BIO_COMPLETE_IN_TASK on iomap writeback bios when
IOMAP_IOEND_DONTCACHE is set. This ensures that bi_end_io runs in task
context, where folio_end_dropbehind() can safely invalidate folios.

With the bio layer now handling task-context deferral generically, XFS
no longer needs to route DONTCACHE ioends through its completion
workqueue for page cache invalidation. Remove the DONTCACHE check from
xfs_ioend_needs_wq_completion().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/iomap/ioend.c  | 2 ++
 fs/xfs/xfs_aops.c | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index e4d57cb969f1..6b8375d11cc0 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -113,6 +113,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
 	bio->bi_write_hint = wpc->inode->i_write_hint;
+	if (ioend_flags & IOMAP_IOEND_DONTCACHE)
+		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
 	wbc_init_bio(wpc->wbc, bio);
 	wpc->nr_folios = 0;
 	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 76678814f46f..0d469b91377d 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -510,10 +510,6 @@ xfs_ioend_needs_wq_completion(
 	if (ioend->io_flags & (IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED))
 		return true;
 
-	/* Page cache invalidation cannot be done in irq context. */
-	if (ioend->io_flags & IOMAP_IOEND_DONTCACHE)
-		return true;
-
 	return false;
 }
 

-- 
2.39.5

