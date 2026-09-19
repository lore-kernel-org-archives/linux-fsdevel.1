Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5287357CF3;
	Sat, 19 Sep 2026 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789843885; cv=none; b=bvf/gWG/VEbzfr0tGC1lX3OUzxvQR6u75JlUswiEFuMsk/KzkvtSTl7JonTQz7bWnD6YR/8Ez+yBMl80ZDV/xJgAyKV3aIrk6GDbpnHzehxGdpXq0FS3J1Vp9gECV5a12S3FLFXEeYjFw4urrd2cbQgF+qbcuyMnUWRyw8e2sCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789843885; c=relaxed/simple;
	bh=X6Ow5jUfRQoDy6enKi1ug7ydikLkVQ+iKDSqLegmBxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pwQH8YwjAovaAwVlRyhcAonc9Io9mt3+4ZweMfKPoa/1L1fih7D4dMiafyvKLQwfVERtfUhMMHT+4tT9kZ0idgak3fZ38Qk9/rqYTd/UJTgJ7U/7ZPHFejRj5C6/3SxjJbZXNYq1zu/yKBbqANKNHXGzTe2YsT841zEU1UD3z20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn; spf=pass smtp.mailfrom=tju.edu.cn; dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b=E6tVxfhU; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b="E6tVxfhU"
Received: from tju.edu.cn (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [183.242.150.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e625c89d;
	Sun, 20 Sep 2026 02:51:13 +0800 (GMT+08:00)
From: Yibo Tan <lhfff@tju.edu.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Eric Sandeen <sandeen@sandeen.net>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1] test_sysctl: unregister tables before freeing bitmap
Date: Sun, 20 Sep 2026 02:51:10 +0800
Message-Id: <20260919185110.2243068-1-lhfff@tju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0bb021ce703a1kunm16bf57923f5855
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ0JJVkgeGkxIGBpMSB1DQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSU9JVUpOS1VCWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=E6tVxfhUWfa3JDNJDYIinNIedkDvQu4OBxRTpwMi7zHE+AV1syz6tbsQfpgqsFevuHGcPIqK3zzqXwOKRJ9OZVtMSyToyKlfDoliT9NxFAMaw1/R7xQchvQcFuLT3dAI12k0Z1YyYxQJzgngbwcHrJDEFIuUaFbGrh9R9HvOQeU=; c=relaxed/relaxed; s=default; d=tju.edu.cn; v=1;
	bh=FqotAjvbRM2/MPnyx+/q+j4a/Y1qEe/wYMcHqVht+p0=;
	h=date:mime-version:subject:message-id:from;

The table registered for bitmap_0001 retains a pointer to
test_data.bitmap_0001. unregister_sysctl_table() prevents new handlers
from starting and waits for active handlers to finish.

test_sysctl_exit() currently frees the bitmap before unregistering the
table. A concurrent read during module removal can therefore enter
proc_do_large_bitmap() while the bitmap is freed. KASAN reports a
slab-use-after-free in _find_next_bit().

Unregister all tables before freeing the bitmap so the unregister rundown
provides the required lifetime boundary.

The unmodified module reproduced the use-after-free in three KASAN runs.
With this change, three runs each completed 100 load, read and unload race
rounds without a kernel diagnostic.

Fixes: 2ea622b887e7 ("tools/testing/selftests/sysctl/sysctl.sh: add proc_do_large_bitmap() test case")
Assisted-by: Codex:GPT-5
Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
---
 lib/test_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 909cfcf76dbfc..dd795979558a2 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -321,11 +321,11 @@ module_init(test_sysctl_init);
 
 static void __exit test_sysctl_exit(void)
 {
-	kfree(test_data.bitmap_0001);
 	for (int i = 0; i < TEST_H_SIZE; i++) {
 		if (ctl_headers[i])
 			unregister_sysctl_table(ctl_headers[i]);
 	}
+	kfree(test_data.bitmap_0001);
 }
 
 module_exit(test_sysctl_exit);

base-commit: 40288c9206c17eb66a603262e06a58d300d0f279
-- 
2.39.5

