Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE8E248F72;
	Wed, 15 Jul 2026 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784081326; cv=none; b=QLBZIBDC0lpIvP6xqYXUONcusJaANZ6k6KPWiF1p3ahsEBDRtGi4KlQ+O//W6YCD1WEG7L7yPTKQ+zmHWXCyNmZMARMTpfCMwhYHGhU4gojqfbdWwH+rnQk+3j/5vBOAjNscEdFJYpSROqsVKwv2cdyq5NlqxKT73B5L664cLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784081326; c=relaxed/simple;
	bh=NfIA0JqQKW9o1EsgLuE8Gl+PBHJurQSQJnsCxOYceSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i7Mu6Jpu1iRg2FTM9OJ8z7Y3wCfwARcHjO182VA+5OVoMVWKHcRI+toTzOu68JektfX4ZviKWRVK4rNtxs3va/JtF9GQi5rRYzhuT6qc6CtxMsxZ9JLrVWhA+PhQOUMY7NqjHkbHLdi7I7pikj8wk1zepDSRkMtCksywCReRhoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 191910767ff211f1aa26b74ffac11d73-20260715
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:147795fd-1c33-492e-aacb-384c4f5eb14b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:e7bac3a,CLOUDID:e2704ef0bbbf266c217f982913193de8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 191910767ff211f1aa26b74ffac11d73-20260715
X-User: yanlonglong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 457827744; Wed, 15 Jul 2026 10:08:40 +0800
From: longlong yan <yanlonglong@kylinos.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: longlong yan <yanlonglong@kylinos.cn>
Subject: [PATCH] initramfs_test: add NULL check for kmalloc in initramfs_test_fname_overrun
Date: Wed, 15 Jul 2026 10:08:19 +0800
Message-ID: <20260715020820.425-1-yanlonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1.windows.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing NULL check for kmalloc return value in
initramfs_test_fname_overrun(). Without this check, if kmalloc fails,
the subsequent memset() will dereference a NULL pointer, causing a
kernel crash.

Fixes: 83c0b27266ec ("initramfs_test: kunit tests for initramfs unpacking")
Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
---
 init/initramfs_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 1fc990a66563..c7aab7e5383e 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -189,6 +189,9 @@ static void __init initramfs_test_fname_overrun(struct kunit *test)
 	 * are already available (e.g. no compression).
 	 */
 	cpio_srcbuf = kmalloc(CPIO_HDRLEN + PATH_MAX + 3, GFP_KERNEL);
+	if (!cpio_srcbuf)
+		return;
+
 	memset(cpio_srcbuf, 'B', CPIO_HDRLEN + PATH_MAX + 3);
 	/* limit overrun to avoid crashes / filp_open() ENAMETOOLONG */
 	cpio_srcbuf[CPIO_HDRLEN + strlen(c[0].fname) + 20] = '\0';
-- 
2.43.0

