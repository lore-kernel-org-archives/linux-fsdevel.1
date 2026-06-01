Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A093644AF;
	Mon,  1 Jun 2026 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311896; cv=none; b=k7x7cUR5/eWZ9GfqVVY40tkyYlJDNDCg2ZgYa0ij2w2OsIPk6JuoZhHp+8QUBuQcuUpZN8Os/tID1CzFpkZ9Tm3CB2Goce/R+UeD7dzDmR5p7gw+0m36Ue5NwSfcG3/VZS3NFEIcjrAVtEwGMz9+tfaL7g8wPG8GJiGAeSk7mOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311896; c=relaxed/simple;
	bh=FV+q7XGqoCOQPOH7l1wr6dffuUDRkEb4pOCZI+9wwsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJ3Ir9EWyZsJFg0y8I07b4+XuwAmjiskO7ayUdlBM1YgPDK3ZduTBSmV08wYk0yHMPey+X9VPqu22W5aN7LNfO0j/vOrHV1DJOrZrfsOD9zhNFWZiT5kLqAbf3i3xGVDG56bpgvyEVufHsApxCTBL9tpirMrCDQ62piHeMoocTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b45cba625da911f1aa26b74ffac11d73-20260601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7a8b01ef-ce7f-4c3e-afdd-9491e2c62b7f,IP:10,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-10
X-CID-INFO: VERSION:1.3.12,REQID:7a8b01ef-ce7f-4c3e-afdd-9491e2c62b7f,IP:10,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:e7bac3a,CLOUDID:5f975c8c3e6bfe6541c7eecfa5b962dd,BulkI
	D:260601190449W6QGVN2M,BulkQuantity:0,Recheck:0,SF:10|38|66|78|101|102|127
	|865|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b45cba625da911f1aa26b74ffac11d73-20260601
X-User: tanze@kylinos.cn
Received: from desktop-od00ebi.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1277608410; Mon, 01 Jun 2026 19:04:48 +0800
From: tanze <tanze@kylinos.cn>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	akpm@linux-foundation.org,
	jack@suse.cz
Subject: [PATCH v1] mm/filemap: use folio_next_index() for start
Date: Mon,  1 Jun 2026 19:04:23 +0800
Message-ID: <20260601110425.44784-1-tanze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use folio_next_index() instead of open-coding
folio->index + folio_nr_pages(folio) when updating @start in
filemap_get_folios_contig(), filemap_get_folios_tag(), and
filemap_get_folios_dirty().

Signed-off-by: tanze <tanze@kylinos.cn>
---
 mm/filemap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 4e636647100c..e233d4a003ce 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2283,8 +2283,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 			goto put_folio;
 
 		if (!folio_batch_add(fbatch, folio)) {
-			nr = folio_nr_pages(folio);
-			*start = folio->index + nr;
+			*start = folio_next_index(folio);
 			goto out;
 		}
 		xas_advance(&xas, folio_next_index(folio) - 1);
@@ -2344,8 +2343,7 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 		if (xa_is_value(folio))
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
-			unsigned long nr = folio_nr_pages(folio);
-			*start = folio->index + nr;
+			*start = folio_next_index(folio);
 			goto out;
 		}
 	}
@@ -2403,8 +2401,7 @@ unsigned filemap_get_folios_dirty(struct address_space *mapping, pgoff_t *start,
 			}
 		}
 		if (!folio_batch_add(fbatch, folio)) {
-			unsigned long nr = folio_nr_pages(folio);
-			*start = folio->index + nr;
+			*start = folio_next_index(folio);
 			goto out;
 		}
 	}
-- 
2.43.0

