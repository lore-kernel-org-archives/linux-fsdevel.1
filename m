Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032807;
	b=zjMHL5GpBVYdSy+QJy91AxRTUzIEOXVRfyv6kHFuuqZLhlm+3kSTsp2Om8iqSnLrsxP1
	 ujhvSmJQoLAYQGXaUQImfRXl93oE32gWJgINv7wf4VpOON3vboBTnZ/5w9SkxooKjEC9O
	 Nr89FEt90SXPyKkbWofNIqRbKWxKESzud+xafON8En7bY2BfOiVPmYfohRbVYJfMyFWE9
	 ouARWPw3XMxQq8kw9MiMGD+POFiMYAHViIOxWwYFSNeyWBeAslVorexq4R24/KZZBNosN
	 8CwMMenb4wq4jZpx17V96MeBeXR8bR8mhveYnI4Q3yA3e+9SCX/ZRFfZd6AxB5XWemA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032807;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cYVSo1i5WQlGWleE8v+Zhd8OtHW7bN9QAGNyKVwFr4Q=;
	b=UBI8EnT7Dt1Ve6WCHjVU9ueeYBLow9zmYPMd0+T8UIKDPhN5OKMZ88nAvgpXSaMUGYaD
	 m1XNfbLp+3LPaAa2M3HCIdbIb7dYzgoivvBEr1Gw/OElPwDlKEB4ROfxP0KnwvnsptgrU
	 rdZ4vaVT+x/Uww57UpL1ryQiFvr3ylGhX6TP7HolSVRSsb52fVMeW1E2mEb+ei1UO4TsS
	 BnKsm7HeEx8gSQOp0T7JuwdmoTahqQSLWQixIw71ZHQnNQHD49ie4ibkel8q4ceJbiLuG
	 J2SZ5A5O4nzYt3mMTDOKLpsn9V7i8Y473rI5kyGItI1uTGP7ZaX6CNYrZjbT5zMTlNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=pdWZAtnF;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47E606A31E;
	Mon, 26 Oct 2026 16:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A47E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=pdWZAtnF
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 707861210F3;
	Mon, 26 Oct 2026 13:39:45 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1793032785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYVSo1i5WQlGWleE8v+Zhd8OtHW7bN9QAGNyKVwFr4Q=;
	b=pdWZAtnFHWnBivFlQm/zpzEJNH26E4GPOKH8lL2P6riVYUi2QIjWqKa/vcZ7XOWcI9N8yf
	9cJA4gHNzU+Cx3QVJtNZYtMjrfQX6xhwM5NseokYNwxdOb0CU/H8NfB/jeq2c5OzlpjYgu
	QMmitioJ+PZiQIKmWkTMPv6pfhSJuQ4N/0GuW26Xa7FHmDk7eF6Q+FxjhCnJmRFKIv2SbP
	5uHUb6SebtaWMS6BA5Q2t0C7aX4BkpZG8fQdaOQ65w28yUojHWpCZENM/YiS0jsTNmTe5x
	dOWb3AuLH1BTzmj9R9SLdiLq8GlblQAKiSs53Ca0NGDrvig6dl32xMCBaoRnJg==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH v2 2/2] fat: improve fat_sync_bhs() write submission
Date: Mon, 26 Oct 2026 13:39:41 -0300
Message-ID: <20261026163941.495833-3-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026163941.495833-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261026163941.495833-1-matheus.aalmeida@inf.ufrgs.br>
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
index b6a9e2e122cd..e8e2f13254d5 100644
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

