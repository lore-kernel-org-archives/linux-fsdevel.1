Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792955457;
	b=IAR1pVtgm4CNNDoCKIlOCVILjpuV05o2p910L6Wpb9hhT7pASHqGIK8GdoptWnuKVJFb
	 wku0LVhckVGj6HPaoVqCpD8wWUVKkE/KnzpHB6MbZMchka3GkQSSb2B2Lg5K7z8pe77un
	 qLCLoSZfobUnRRqgJCxjVj/SwapzuCFf5cov8hcBWv6XbpocgV1QR45mzvgqjbT53262M
	 Y2G7fJHqUFRfNzkwz3+h73vXQMa2q197cnlY1B9f44GWOWzPG5J6etxSEWnOI0LUXpTXr
	 qXqgeX/aZkErVTukR3ZY+9r3xgDk4VRHGfY5O4ANZAsr+Bvkmm2iqwk7YxAKWKb2T4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792955457;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=InqFFuQ6wFnt/wZpSIQhYgtMjLwuMLny+bjXBvmNj9o=;
	b=BQprJRvtUzMP2UElWHutXWKAmXjL2sKb3iI5h60+dnhVeuWkVQiswTVaD+BCMaIpAma7
	 W/3VkcCkSenJ7wTG2x/KIwvDWc56F0Pn2g93dWf0+cMiqaDX5LWYXRC1v7plFoY59wNXk
	 BYojnKlhpNFSvhqCjH8MXQy32xqN9Wd3biFD6xYDZ+ij7sjoW91hvVMIEyE282EJzzNhV
	 MtxQX+qFIA3DAasgSpIonENNAaowE304Srz1tVAxblteVEwkerhScqIYCTBIk+TNHPGKe
	 cc2v0ajXRo8sACLuDgeDWeFILIdxhVbKP6/97HOBh4TKqIpV6Mk+I9+qIa3j8rtVu3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=3kw5IiUL;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F8606A325;
	Sun, 25 Oct 2026 19:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD8F8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=3kw5IiUL
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 4D1E11210B2;
	Sun, 25 Oct 2026 16:10:40 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1792955440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=InqFFuQ6wFnt/wZpSIQhYgtMjLwuMLny+bjXBvmNj9o=;
	b=3kw5IiULgaDH2pzljqj/fQNIGcBhk1zOAeBGnsdvrLxERczTwYtJy7kB1SzyXtOcPx+FSM
	nECSEaSnV6za4DQhAqcrHtcjNE1m5b4WfN5qsqTSaUkhhlHOQBefFS9gbISIGPCtXGaG0K
	tDSMWBnS9mNPTq4hIieuiNXQgcjr1amEDEvE+t7FwyHWKQZIuCtb0z/ya0cI+bd3UbBq3X
	a3ftK9H5tunFdR0wElGm7une46CRpuwATCW5DCoYlSqMJ4q9Y/KKuvZLn2+enFuLtwI3lK
	JYhgqRtMnwwdz9wBWrwA3SBsyVA2OPPA415Ru2xaNvPPkXpjoQFnejJX9MKalg==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH 2/2] fat: improve fat_sync_bhs() write submission
Date: Sun, 25 Oct 2026 16:10:06 -0300
Message-ID: <20261025191006.407209-3-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261025191006.407209-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261025191006.407209-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fat_sync_bhs() does many individual write_dirty_buffer() calls without
plugging, making batching in the block layer more difficult. It also
does not pass the REQ_SYNC hint for these synchronous writes.

Use a plug around the writes so the block layer can more easily batch
them. Pass the REQ_SYNC hint to write_dirty_buffer().

Benchmarking was done under QEMU/KVM with a virtio-blk device using
cache=directsync. Each result is the arithmetic mean of 10 samples.

start = now_ns();
for (unsigned i = 0; i < count; i++) {
    fallocate(fds[i], FALLOC_FL_KEEP_SIZE, 0, bytes);
}
elapsed = now_ns() - start;

Sync-mounted FAT32 using count=16 files:
File size    Cluster size    Before    After    Improvement
256MiB       512B            13.11s    11.87s   1.10x
256MiB       4096B           1.657s    1.469s   1.13x

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/misc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index f8f89b947baf..29ca983b917a 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -9,6 +9,7 @@
 
 #include "fat.h"
 #include <linux/iversion.h>
+#include <linux/blk_plug.h>
 
 /*
  * fat_fs_error reports a file system problem that might indicate fa data
@@ -354,9 +355,14 @@ EXPORT_SYMBOL_GPL(fat_update_time);
 int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
 {
 	int i, err = 0;
+	struct blk_plug plug;
+
+	blk_start_plug(&plug);
 
 	for (i = 0; i < nr_bhs; i++)
-		write_dirty_buffer(bhs[i], 0);
+		write_dirty_buffer(bhs[i], REQ_SYNC);
+
+	blk_finish_plug(&plug);
 
 	for (i = 0; i < nr_bhs; i++) {
 		wait_on_buffer(bhs[i]);
-- 
2.43.0

