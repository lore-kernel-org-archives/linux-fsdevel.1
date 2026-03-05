Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B274258EF3;
	Thu,  5 Mar 2026 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772678142; cv=none; b=Nw9IGnVZoVXgJRwUHQvg1Qbb9Ua1I/v/dXdrT781ewMPotPW4+3Aq5oBtwpJ9ETzndXxRvvnWo3GkywRXvOHKKcwXggfbCocvzN6Klj/brJ9JePHvgnM+y/PnJmsgwQHtcedeCo4Vlj2zdbLzeQIRvM2eHegqi0FheX5QNEtvnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772678142; c=relaxed/simple;
	bh=Rn0gwkny07s0QHBZNhTS6KaPP6qFbOmRVtRtmMF48vY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=twYD73E4GBzxEmSKTeH5zKDkVisBtLydnmy0Jp2yJZEGQjFuqKnwT8QCZosCMo0QWMQTgpbe3W6QnaSmwOV5sY1ZJnyBxGtaSjDvnmBK367f+jPyOJJr5zgW0xoa65A+Fs9CD77aby6B/pF4BakcoFxRfgaWEXQCJndY4rpynDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gSmQ8gEQ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gSmQ8gEQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9R
	lnR5jm9PhBAUJXCN4QxuMr47fR0FrOXWZf5lEzkxk=; b=gSmQ8gEQ9WbdBwE8fA
	yTjww1L29EOpFp06fbZel4LBArgsy2LE2GP5xVtIIhG4o8Vms+0T8ELDE8oOGJ1G
	Wb7slHvsxDINA0KLN4R/KHgYutlR/8sjWyC6qifUXVtYYRFZVoQ81bG0LOdg7sjO
	5cgks1ZWtI1ET8h/jFN6DTxz8=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBn393V66hpNnfqUA--.606S2;
	Thu, 05 Mar 2026 10:35:02 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Robert Garcia <rob_garcia@163.com>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Helge Deller <deller@gmx.de>,
	Lior Ribak <liorribak@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y] binfmt_misc: restore write access before closing files opened by open_exec()
Date: Thu,  5 Mar 2026 10:35:01 +0800
Message-Id: <20260305023501.4003943-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBn393V66hpNnfqUA--.606S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw4fGF48tw1UurW8AF1DWrg_yoW8WF4Dpr
	W5K34UKFZIqryj9a1kCas8XF15G3Z7Gr12vr4DWw1fXrn5Xrs0gFZ2g3yj93W0y397ArWF
	vF4Fk3sYyryUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UoCJQUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbDARa0IGmo69acswAA3Q

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit 90f601b497d76f40fa66795c3ecf625b6aced9fd ]

bm_register_write() opens an executable file using open_exec(), which
internally calls do_open_execat() and denies write access on the file to
avoid modification while it is being executed.

However, when an error occurs, bm_register_write() closes the file using
filp_close() directly. This does not restore the write permission, which
may cause subsequent write operations on the same file to fail.

Fix this by calling exe_file_allow_write_access() before filp_close() to
restore the write permission properly.

Fixes: e7850f4d844e ("binfmt_misc: fix possible deadlock in bm_register_write")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Link: https://patch.msgid.link/20251105022923.1813587-1-zilin@seu.edu.cn
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ Use allow_write_access() instead of exe_file_allow_write_access()
according to commit 0357ef03c94ef
("fs: don't block write during exec on pre-content watched files"). ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 fs/binfmt_misc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index cf5ed5cd4102..a45b5ba12a9c 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -815,8 +815,10 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	inode_unlock(d_inode(root));
 
 	if (err) {
-		if (f)
+		if (f) {
+			allow_write_access(f);
 			filp_close(f, NULL);
+		}
 		kfree(e);
 		return err;
 	}
-- 
2.34.1

