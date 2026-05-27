Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8FF33B6ED;
	Wed, 27 May 2026 03:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779851741; cv=none; b=EGRkoy19DhvV7Lo6GPyBqIni2Sv00VGZCrxxsPmnMiUelIOUXbxg+zBJKTkcM8/dmjG28aQs9ufoYnDiUk/l5dpvzjbjyogBsdIX5nmG9ObP70zt8j3t+Yo5I6AAIXEM0klu/JRphPUP2I72Vlf8WWtj9Nzj+TeVXxTIDaeLSKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779851741; c=relaxed/simple;
	bh=x90YdPh07u2vD1VUJH0xQ2onWclbg2UGF4pv81vNu4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jkpWZosD3eLH6XI1+wUFhjoZ3CojYdKhNxgd220VX1Nak0/oxqz7N+4vBR2hQzHdbdqRBTCk9dscwzJVUnXE22X84zS9UNCHWzyI982Gy/LH+EX5izM9V0AvVSxhr6jKL3+Tb0iYrgoS+1BTaSssT0g1h5n6hcB+KB3EqZHde38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UD8xJtlk; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UD8xJtlk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=fDPXYPrvtsxNVZLx14/RP0AMdVMjMF3pl+xDYAo5Jc0=;
	b=UD8xJtlkV/uoGvKENbjnHfnawakn0wpcQYD1tFbcVg6vvlYay/5SGOpL6g5EE/
	4bw0OhEZS5xpQcYIYFgDMMJ9WqQauf+fC/fKkCIOb+/Txsk1DZbqEcoeqPyx/QBs
	iLHyTNp2lON+mCr+qRz1uKeU73mIET5UU51e/SS5PAoNw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wC3Xaq_YRZqznkDEA--.33607S2;
	Wed, 27 May 2026 11:15:12 +0800 (CST)
From: fffsqian@163.com
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qingshuang Fu <fuqingshuang@kylinos.cn>
Subject: [PATCH v1] fs: fix spelling mistakes in comment
Date: Wed, 27 May 2026 11:15:08 +0800
Message-Id: <20260527031508.820423-1-fffsqian@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3Xaq_YRZqznkDEA--.33607S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4xGryUWF4rJr4DWryfJFb_yoW8Jw48p3
	93K3s5tFsagw17u347CF409a4Sg392yr47Wr98Zw1Yvr1kGrnIgF40vF1UuayfC3yxXw12
	gw4jgryYv34UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ptQ6PUUUUUU=
X-CM-SenderInfo: 5iii21xldqqiywtou0bp/xtbC6gCoc2oWYcDjAAAA3P

From: Qingshuang Fu <fuqingshuang@kylinos.cn>

Fix three spelling errors in the comment for an internal file structure
allocation function:
- happend  →  happened
- over     →  exceed (grammatical fix)
- int      →  in

Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
---
 fs/file_table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 16e52e7fc2ac..fa06b660f116 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -231,13 +231,13 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 }
 
 /* Find an unused file structure and return a pointer to it.
- * Returns an error pointer if some error happend e.g. we over file
+ * Returns an error pointer if some error happened e.g. we exceed the file
  * structures limit, run out of memory or operation is not permitted.
  *
  * Be very careful using this.  You are responsible for
  * getting write access to any mount that you might assign
  * to this filp, if it is opened for write.  If this is not
- * done, you will imbalance int the mount's writer count
+ * done, you will imbalance in the mount's writer count
  * and a warning at __fput() time.
  */
 struct file *alloc_empty_file(int flags, const struct cred *cred)

base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
-- 
2.25.1

