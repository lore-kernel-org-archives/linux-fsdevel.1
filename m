Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D04643F8C0;
	Tue, 14 Jul 2026 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021291; cv=none; b=CFl3NQcczCky6xpCCGNu489Au4KCjhaNAMVv5ZVfFu/ax9CiQs/izcVCVQYERt5k6EvvHGmqu9reVDx/LVKSeKa5jkdDQfxX5wLZLE7rjFMLFb9cWeIt96pNLnGQd4JFE0YFgskiMUjAgyVKBQHUuyiyYtbwJYAIvGnQON/a8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021291; c=relaxed/simple;
	bh=NcalsM7VD/MSv6RK/0TuYEx3ifwFDTiAiM56DT//1zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSOzO46fLMlNDrqJ6Wxgj+NuOJsTk0go5Of6CJXuz4tZyvEeS9k7rLurn1MhTmqr4Q7c1b0oWzlAnnMLyBTtI06ZPS2GvleX0eUdI4DGBi2cjr/UdfdBVelv4C9zFH0EyW9HDmDp/IXO3nHGlPAxeNPyx89SdgnWid8xon8HxzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4dabde7c7f6611f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a572ca22-b5e4-4d27-8195-7502f03a9446,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:0aa5a7be02f0d9d6864f90a9eeb2d35c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4dabde7c7f6611f1aa26b74ffac11d73-20260714
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1375123903; Tue, 14 Jul 2026 17:27:59 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-fsdevel@vger.kernel.org
Cc: dsterba@suse.com, brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, chentaotao@didiglobal.com, chuck.lever@oracle.com, dlemoal@kernel.org, liuxixin@kylinos.cn, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] affs: check sb_getblk failure in getzeroblk/getemptyblk
Date: Tue, 14 Jul 2026 17:05:29 +0800
Message-ID: <cd800543f91dd914287e66c85aa50d3e43329ba1.1784019929.git.kylinos.cn>
In-Reply-To: <cover.affs-fixes-v1.1784019929.git.kylinos.cn>
References: <cover.affs-fixes-v1.1784019929.git.kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: affs/send-local.py

affs_getzeroblk() and affs_getemptyblk() pass sb_getblk() to
lock_buffer()/wait_on_buffer() without a NULL check, so allocation
failure crashes in the helpers before callers can handle it.

Return NULL when sb_getblk() fails.

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 fs/affs/affs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index 44a3f69d275f..651d61b3213a 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -250,6 +250,8 @@ affs_getzeroblk(struct super_block *sb, int block)
 	pr_debug("%s: %d\n", __func__, block);
 	if (affs_validblock(sb, block)) {
 		bh = sb_getblk(sb, block);
+		if (!bh)
+			return NULL;
 		lock_buffer(bh);
 		memset(bh->b_data, 0 , sb->s_blocksize);
 		set_buffer_uptodate(bh);
@@ -265,6 +267,8 @@ affs_getemptyblk(struct super_block *sb, int block)
 	pr_debug("%s: %d\n", __func__, block);
 	if (affs_validblock(sb, block)) {
 		bh = sb_getblk(sb, block);
+		if (!bh)
+			return NULL;
 		wait_on_buffer(bh);
 		set_buffer_uptodate(bh);
 		return bh;
-- 
2.43.0

