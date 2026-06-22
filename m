Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B83502A5
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 04:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782102798; cv=none; b=UgpkxvCDCsC1v/hbXIlqs2kXW5oWtt1WaRzonQqHUu3ez3oE8taLWzS1dAS7bIGkr7DeNWRcQgFjE4DUSlb9H2/Z01yGYjvj8uu+NrY/dEyahdUtrVBMiQFHHg8HUpty/k5IhJIBSnlosaFZORTM+kXNwtI6NVsEEdW7Ze4sEcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782102798; c=relaxed/simple;
	bh=6DEtv6yb5D3pU4W3a42V7jIWtD557aOuwYlsmACNTn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dPprEpmG/JdDOlpNTwiR28gF5DQXuSnxP/RIMYXldLza5yNr6KT0dKwwzDG2xmQxMhrdO+uJYPJJcHxwNaMz6WuYd3x4z5J+bbtr7maFbaChmHJW7F9HicP0J2Witd5SVmOrLBIZRSSslXRjKbG7hTStIRn21DSxKloV3X3lvdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J73Tuhvo; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J73Tuhvo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782102785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LqeobtkxZIczjC3bBaAr9HImKF/rei2wNFng7Y5jhs0=;
	b=J73TuhvoABT/umMjUMDoOw/XnTyXYEE5/YjP1mgTcrUguIUwP17QV3gx3fICXFV9IPGuNB
	tZniVKISrXoWEXYV+KKrhC2+YlbDYPB0T6LWAbBlw2qU+LtOv0o88xSgFb/zG5YKx/xmhz
	q1Jlnb4JdnpR/gCl4Scnv2bdG58HPUU=
From: Kaitao Cheng <kaitao.cheng@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH v3 6/7] initramfs: Use mutable list iterator
Date: Mon, 22 Jun 2026 12:32:10 +0800
Message-ID: <20260622043210.32069-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kaitao Cheng <chengkaitao@kylinos.cn>

The safe list iterator in dir_utime() requires a temporary cursor even
though the loop body only deletes and frees the current entry.  The
mutable iterator keeps the same removal-safe traversal semantics while
hiding the internal cursor from the call site.

Switch dir_utime() to list_for_each_entry_mutable() and drop the unused
temporary cursor variable.  No functional change is intended.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 init/initramfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 20a18fcda48e..e226d7eb1257 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -167,8 +167,9 @@ static void __init dir_add(const char *name, size_t nlen, time64_t mtime)
 
 static void __init dir_utime(void)
 {
-	struct dir_entry *de, *tmp;
-	list_for_each_entry_safe(de, tmp, &dir_list, list) {
+	struct dir_entry *de;
+
+	list_for_each_entry_mutable(de, &dir_list, list) {
 		list_del(&de->list);
 		do_utime(de->name, de->mtime);
 		kfree(de);
-- 
2.43.0

