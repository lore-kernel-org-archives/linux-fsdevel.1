Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0EC37F746
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776680786; cv=none; b=foQC+XXbqnPgzPf0xekXC6qwiDoyeRKnNrZJ49VM03dVVvUwyF13lgGGJP6+dWP5HD/qZ3YZ7QtgSUfdo8s7w/igiA9FW9a2GTdsdxxgXCrHmSW9L95ZybYTjpfzRYMhwY56btUCr0vUiF/IlSN6yr1V2HJuvAhXj9y1O3yXZeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776680786; c=relaxed/simple;
	bh=LNwtkyQm8ws9gq+tN7DCrWXtxJsr7UMAUp6HhbEZyys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TU8uORurcCr5rANPaBf8Afs3lmo+tv2B68Lo6IkLGCPaiex9M9Req5pOyZTks/HwespbX/zE4jdv08JV8FAVyXmU/HolrSHdCwK2s0yPUfqWVCH2jQ36u1BVpJp4Y2Lu8ygC4qXZ2zhuP36Lgs1XyH+e91/zzrJ+mIkqCJwEQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CyibQGLN; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CyibQGLN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776680772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g0U1mDAbh5FMjsnXPHCnKYzI9MG3xW/VdlKBh0nFLkU=;
	b=CyibQGLNgQ+HeZk8ueQyUJ9ZQ4nNkAIn2WTaGRHFVbZgAvV4WLom3teCeCknytjtpAWKil
	AybFyltjrp55Zt+54h4lIEu3pJIelG4zh/sXXBYE0d3Luyz95f06KsMn2KBOdjPZkm2WLQ
	AmBBBKuG5eO/69C1/uqbAdODph/PJxY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] isofs: use QSTR_LEN() in isofs_cmp
Date: Mon, 20 Apr 2026 12:25:46 +0200
Message-ID: <20260420102544.8924-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124; i=thorsten.blum@linux.dev; h=from:subject; bh=LNwtkyQm8ws9gq+tN7DCrWXtxJsr7UMAUp6HhbEZyys=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJlP/2u84uTdu3miFVfIJ+dpQtrHGibGbXqq8rxPRnLy0 2n5+V+aOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAi74sZ/qm1a4Q8PnR77peL TBV6Kd+W+k/ftsGob774Z/FDDAHh0xcz/Pc3nTxx7ZLOV9pK72W+nDm/cWbPya/T9E70XF9vvCL 2bjIrAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use QSTR_LEN() and inline the code in isofs_cmp(). Remove the stale
function comment while at it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/isofs/namei.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index 8dd3911717e0..3ace3d6a55e7 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -10,20 +10,13 @@
 #include <linux/gfp.h>
 #include "isofs.h"
 
-/*
- * ok, we cannot use strncmp, as the name is not in our data space.
- * Thus we'll have to use isofs_match. No big problem. Match also makes
- * some sanity tests.
- */
 static int
 isofs_cmp(struct dentry *dentry, const char *compare, int dlen)
 {
-	struct qstr qstr;
-	qstr.name = compare;
-	qstr.len = dlen;
 	if (likely(!dentry->d_op))
 		return dentry->d_name.len != dlen || memcmp(dentry->d_name.name, compare, dlen);
-	return dentry->d_op->d_compare(NULL, dentry->d_name.len, dentry->d_name.name, &qstr);
+	return dentry->d_op->d_compare(NULL, dentry->d_name.len, dentry->d_name.name,
+				       &QSTR_LEN(compare, dlen));
 }
 
 /*
