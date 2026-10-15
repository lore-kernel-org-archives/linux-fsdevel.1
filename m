Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173BB49C4A0;
	Thu, 15 Oct 2026 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054461; cv=none; b=akesR/xJWfKp9e29MjUOq6I0E0bEAS79lJ8RG3FCX7/hFr9BBSxh91wJBe+94c0mDHvXrexuRbv/H8sZfUcTKaSKAwR0JtteoP5H1p1/2t3W3GBjAhn1sVQ4sTSGXLEeu3tTTADpSZfMCGKZbzV5OqmFz2gpmt+SDGZ1KZR41W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054461; c=relaxed/simple;
	bh=GI/2hSbCG+oYyG9Rbh5FXd/YWUhLD2zFGN8tIQNLVqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dsOzq8x978jGvfZwwqgdVF/8a9SpZRMGPvdkSWGmv2AU5PKcs/QzRGaBNdDn2v94bVIETUUPH58jYN0xzb6+bW8tz8VkjTTLs6WXJIwAzprqu2+3A6XCvepv7Bki43SRd26/lhS8l+9r7GqK42npvzwfvIew2gX+uW2leNG4OYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f85b0fc0c87511f19a56ed5b684f684d-20261015
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:333b548b-af59-4bc6-8779-6cae5e04d7b0,IP:10,
	URL:0,TC:0,Content:49,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:59
X-CID-INFO: VERSION:1.3.19,REQID:333b548b-af59-4bc6-8779-6cae5e04d7b0,IP:10,UR
	L:0,TC:0,Content:49,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:59
X-CID-META: VersionHash:7db8b62,CLOUDID:5ef86a5da514a8a5324bd04138adc441,BulkI
	D:261015165405ZZRFU7UB,BulkQuantity:0,SF:10|38|66|78|102|127|865|898,TC:ni
	l,Content:4|15|50|99,EDM:-3,IP:-2|1,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_IBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f85b0fc0c87511f19a56ed5b684f684d-20261015
X-User: liqiang01@kylinos.cn
Received: from cvdaxia.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1766335554; Thu, 15 Oct 2026 16:54:02 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liqiang01@kylinos.cn
Subject: [PATCH] pipe: bound new-page copies by remaining iterator bytes
Date: Thu, 15 Oct 2026 16:53:26 +0800
Message-ID: <20261015085326.340074-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

anon_pipe_write() requests PAGE_SIZE bytes even when fewer bytes
remain in the source iterator. This causes copy_page_from_iter()
to perform an unnecessary extra iteration after copying all data.

Limit the copy size to the remaining iterator bytes to avoid
this overhead without changing copy semantics.

UnixBench pipe results on Hygon C86 7490 (Hygon 4):

| Threads | Before | After | Improvement |
|---------|--------|-------|-------------|
| 1       | 835    | 854   | +2.28%      |
| 256     | 179293 | 182895 | +2.01%     |

Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 fs/pipe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 292425a834dd..da5583f7f37d 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -595,7 +595,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				break;
 			}
 
-			copied = copy_page_from_iter(page, 0, PAGE_SIZE, from);
+			copied = copy_page_from_iter(page, 0,
+						     min_t(size_t, PAGE_SIZE,
+							   iov_iter_count(from)), from);
 			if (unlikely(copied < PAGE_SIZE && iov_iter_count(from))) {
 				anon_pipe_put_page(pipe, page);
 				if (!ret)

base-commit: 47324d3a5b3abd781295044d01d92d09f184e872
-- 
2.43.0

