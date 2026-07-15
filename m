Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1857F4D8D92;
	Wed, 15 Jul 2026 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119901; cv=none; b=KRhj+0+3zfG3qHoTK0UWzAl9h5bLk0cnitpJiuje+6mP944zQz2o3IExlmohJijuXaGfRPyVKjA2HXXMRBWy2J0K2FnE/ZroSvIutZbW9U6FNE/ZOJanENtrbNaxiA9rbo8I07kW0vStncTgrzgQMm6WaJSjzvYvgEsubqgNfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119901; c=relaxed/simple;
	bh=lSmEwj+B1mat7SaTKFMjo4IwobaJTkWipTmC6BVoGLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nQhTi6/OrMA5wCg9upe9gQh5HnNm5n9mc6keayaH5rKDrfsmfxMY2KXEg4dqksLDmZyuzUmTlVVxadSbwWycHk01u0siGqHw007ViYYw5TN8H5OKVTqQYXMhGjXfLOyzS95fYvmYiPrdjDJCCYbGGuZpXdXPoWLJ/OZ8FoajttM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e13a4e68804b11f1aa26b74ffac11d73-20260715
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_UNTRUSTED, SN_UNFAMILIAR
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:21b7c6ed-de2d-499d-b287-b361bddd0884,IP:10,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-10
X-CID-INFO: VERSION:1.3.12,REQID:21b7c6ed-de2d-499d-b287-b361bddd0884,IP:10,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:e7bac3a,CLOUDID:cdfbf5dbabe8f371e4a5d65433e3fd0f,BulkI
	D:2607152051219CON4VNU,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:1|19,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e13a4e68804b11f1aa26b74ffac11d73-20260715
X-User: tanze@kylinos.cn
Received: from desktop-od00ebi.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 4032209; Wed, 15 Jul 2026 20:51:21 +0800
From: Ze Tan <tanze@kylinos.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	tanze@kylinos.cn
Subject: [PATCH] namei: Use READ_ONCE() for d_flags in __follow_mount_rcu()
Date: Wed, 15 Jul 2026 20:50:57 +0800
Message-ID: <20260715125102.1051791-1-tanze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__follow_mount_rcu() reads dentry->d_flags without holding d_lock.

Use READ_ONCE() for these reads to make the lockless access clear.

Signed-off-by: Ze Tan <tanze@kylinos.cn>
---
 fs/namei.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 19ce43c9a6e6..cc8e8d961d7e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1687,7 +1687,7 @@ EXPORT_SYMBOL(follow_down);
 static bool __follow_mount_rcu(struct nameidata *nd, struct path *path)
 {
 	struct dentry *dentry = path->dentry;
-	unsigned int flags = dentry->d_flags;
+	unsigned int flags = READ_ONCE(dentry->d_flags);
 
 	if (unlikely(nd->flags & LOOKUP_NO_XDEV))
 		return false;
@@ -1701,7 +1701,7 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path)
 			int res = dentry->d_op->d_manage(path, true);
 			if (res)
 				return res == -EISDIR;
-			flags = dentry->d_flags;
+			flags = READ_ONCE(dentry->d_flags);
 		}
 
 		if (flags & DCACHE_MOUNTED) {
@@ -1711,7 +1711,7 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path)
 				dentry = path->dentry = mounted->mnt.mnt_root;
 				nd->state |= ND_JUMPED;
 				nd->next_seq = read_seqcount_begin(&dentry->d_seq);
-				flags = dentry->d_flags;
+				flags = READ_ONCE(dentry->d_flags);
 				// makes sure that non-RCU pathwalk could reach
 				// this state.
 				if (read_seqretry(&mount_lock, nd->m_seq))
-- 
2.43.0

