Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91164233956;
	Wed, 20 May 2026 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275768; cv=none; b=CR2PcVYx7l+qa2QC5L/eWYeGB82/qMdhntZYOR3fzbano28PyAiQFGhSwv85gNicjuAm/1l3u4PvKieXXF7Nt6boG0Cq8Qekw4cY53n1rsoSRUPOVOcZuvZSoFbHrdLM/7nygGff+Cj4Zvvo7O0Q9opyjZYJmLzqN7QESjf1re0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275768; c=relaxed/simple;
	bh=ygRKUzMFFdaUTtFrd7BH0mJ/NRC1N9qgpGkimW8xWHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XURbGab+ua+EDpfYCsxFI/IrWC29qX8cY2aNFMIVE6azprRxa9DPTpslWai5ZJidoPzJ7k4zVq7mKTF8uRFeDDzmBkWyEK2LzyjOMkW5Vsgf1KV1KOq47iLluhs+ISGlmGy7mUtNoDvXXsnQ6RUJnJw85OwvbLYiTtK1rFyqldU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4822ae44543d11f1aa26b74ffac11d73-20260520
X-CID-CACHE: Type:Local,Time:202605201903+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6e4838ed-7681-4f6f-8d8d-7dd441de34cd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:25e3d51ed72abeb9510d89e4e54cf502,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4822ae44543d11f1aa26b74ffac11d73-20260520
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1509734321; Wed, 20 May 2026 19:16:00 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH] ntfs: Validate error in ntfs_lookup()
Date: Wed, 20 May 2026 19:15:55 +0800
Message-Id: <20260520111555.79902-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that MREF_ERR returns non-zero before using as error pointer.
This prevents potential ERR_PTR(0) when error code is zero

Fixes: af0db57d4293 ("ntfs: update inode operations")
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 10894de519c3..bb075aa97b53 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -236,7 +236,7 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
 	}
 	ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %i.",
 			-MREF_ERR(mref));
-	return ERR_PTR(MREF_ERR(mref));
+	return MREF_ERR(mref) ? ERR_PTR(MREF_ERR(mref)) : NULL;
 handle_name:
 	{
 		struct mft_record *m;
-- 
2.25.1

