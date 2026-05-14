Received: from cvsmtppost104.wmail.worksmobile.com (cvsmtppost104.wmail.worksmobile.com [125.209.209.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C522083
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.209.209.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787181; cv=none; b=QBs8ThMyYDRvSH2iOOmfLzknJjW1uH0yCJBqc76nAXz6xsDtkkuP+JQ9HZOf3+5hhJvAD91S+zBHj1dMWT84mga21enkG6aLeKUFrIFxzn3s55XVHV5Jrm6770qe34o/rXS5RHQXfLulOWgHKukHss9cSxzaS3MFSPuAGSUuOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787181; c=relaxed/simple;
	bh=cGxWReALHu8JAhyDUsZHuquLUVgNUNj12JyXOoewDNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T7P2v2W7bNVHrApIPZ4eNdZF9G/REZmb6LcXscjqFpv1FfOtdyW9Gi6GgfftUUf09YhP/8/G6VMkpoqHNTmX42uy8VeBCN6pAKA3iNemGK+BWdLFOjpKhblpD8N4SZKy9HzeeD5i4m9IdKYjcLsXFronZpRBBlRURT5qUPLm/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr; spf=pass smtp.mailfrom=korea.ac.kr; dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b=Fe3DoZ1+; dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b=R9AaSaEn; arc=none smtp.client-ip=125.209.209.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b="Fe3DoZ1+";
	dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="R9AaSaEn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
	s=s20171120; t=1778787177;
	bh=cGxWReALHu8JAhyDUsZHuquLUVgNUNj12JyXOoewDNQ=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=Fe3DoZ1+Vog2Q+VqR1zqQpUu3TXhsrSb/QOCeeUx3bVrDPIhwlfp3anBgTznb+8Ur
	 r3mnJBsdxbw5pRP+uzhZepfZfuiMcyxHYAyI28Ta0vAVyRfRCD5XC6Z1anYOJX7aNq
	 HTuDHNpHiOOQBp/2+xgxe0yPDGiz9zvlKwO/8tgZ/dXUmxgmKJQpftOU1StT90KT9U
	 tir2O+GfyblKWeXb9LYQ+Ew0Z/JcPZp0XbAd2nU2B8aR4PxWs7bFgDT1I6k+sPEuW6
	 lzW5Kms+2wvV5V5rfsyYIiVNL2gspWPvw+gcH+Wcw0S+UgPOqGGbCEof2HO//dZPAL
	 oBqLd3beM0S+w==
Received: from cvsendbo004.wmail ([10.113.20.173])
  by cvsmtppost104.wmail.worksmobile.com with ESMTP id VaiWzy86Stq4LTAGJ8zSDQ
  for <linux-fsdevel@vger.kernel.org>;
  Thu, 14 May 2026 19:32:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
	s=naverworks; t=1778787177;
	bh=cGxWReALHu8JAhyDUsZHuquLUVgNUNj12JyXOoewDNQ=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=R9AaSaEnR4CbCO8T+bpXCyMbJZ1YzMYdQsy4ihNzLoLDwhU4iR0EqkjnovvE2Fuga
	 oakqetDhBO/RYkr+cCYsG1Vyb/IO65QiH8oKFvo331/7kNOWCm6WVKWI/rG7XW01fn
	 nioY55cuRbuVLRW+eq93IP5QAIbkU/9WEWsekAWI=
X-Session-ID: gt9NKnQJRQ+wa2C7TyESaA
X-Works-Send-Opt: EendjAIYjHm/FqM9FqJYFxMqFNwYjAg=
X-Works-Smtp-Source: A9b9Fq2XFqJZ+HmXFqbd+6E=
Received: from s2lab05.. ([163.152.163.130])
  by jvnsmtp401.gwmail.worksmobile.com with ESMTP id gt9NKnQJRQ+wa2C7TyESaA
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Thu, 14 May 2026 19:32:57 -0000
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ufs: Handle NULL return from ufs_get_locked_folio()
Date: Fri, 15 May 2026 04:32:56 +0900
Message-Id: <20260514193256.2556905-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ufs_get_locked_folio() may return either an error pointer (when
read_mapping_folio() fails) or NULL (when a concurrent truncate has
detached the folio from its mapping). The current IS_ERR() check in
ufs_alloc_lastblock() only handles the error-pointer case; a NULL
return falls through to folio_buffers(folio), causing a NULL pointer
dereference under the truncate race.

Use IS_ERR_OR_NULL() to cover both failure modes.

Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
---
 fs/ufs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 440d014cc5ed5..989ff3d3ad179 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -1051,7 +1051,7 @@ static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
 
 	folio = ufs_get_locked_folio(mapping, lastfrag >>
 				       (PAGE_SHIFT - inode->i_blkbits));
-	if (IS_ERR(folio)) {
+	if (IS_ERR_OR_NULL(folio)) {
 		err = -EIO;
 		goto out;
 	}
-- 
2.34.1

