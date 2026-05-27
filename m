Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D7E3E2ACA;
	Wed, 27 May 2026 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876070; cv=none; b=PQeNdWRVzJ7HLJdKdmA5MrQ3+CuKEFtsZji6I2hDsARaOrIXvHI16HEttGSJVyCi49+M8GWV4M6sX7VLCu2N4yt7yvHF+5zubAFknwaqTFmwPrcaTvcMiYfJcvXzfIU4Z861bREhAoFPj+pEZ8NPb0vIReGxaNdHG7abshJIy5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876070; c=relaxed/simple;
	bh=eVpAcihbKIpqg+q+HaAMVz39zT/2TpCrzAbJrr2cIm4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=h07ToY0a/270GiNosYCMiqiOAWYssRY3HCWasDJRoqDN5XrRXAg/Qlf6OTsq4FjsUt6U7yVm4T5kuf2e/khyFvRxhqTckmW+DgfzltFLBxF7j65DIPGJmEx/XJXkILf+t/kU+IN62nsj0SU6mz6Tvwwrss8sU2Rkz4EFbMuBR2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g5D1B3dX; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g5D1B3dX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=heEpIy0OArt07vnMB4QODmiQXeBWqauZRrXQz/C7YAA=;
	b=g5D1B3dXuiQ9Mbpj1X7sLpzbVho6MtRsIYqDDXsS9lgVX8gPgbnGKJMVjAfS2T
	Q++9RuWThFwE05KGpGJVTWNZP7rZWh86Q1lko8wVykrMhN33nwGASKZx+JP10/dG
	eiPMCJ0P6e+TNk3JVyZul41mSWdAxDxGes9cvrjUsjV8s=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCX0rfPwBZqxMp4FQ--.261S2;
	Wed, 27 May 2026 18:00:51 +0800 (CST)
From: fffsqian@163.com
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qingshuang Fu <fuqingshuang@kylinos.cn>
Subject: [PATCH v2] fs: fix spelling mistakes in comment
Date: Wed, 27 May 2026 18:00:24 +0800
Message-Id: <20260527100025.960339-1-fffsqian@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCX0rfPwBZqxMp4FQ--.261S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4xGryUZw47Cw4xJF43ZFb_yoW8GF1Dpa
	93K3s5trsYgr17C347CFW0v34Fg392yr4UWry5Zw1Yv34ktrnIgF4jv3WUu393C3y7Xw12
	ga1jgryYv34UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYoGQUUUUU=
X-CM-SenderInfo: 5iii21xldqqiywtou0bp/xtbC6hOET2oWwNM9-QAA3d

From: Qingshuang Fu <fuqingshuang@kylinos.cn>

Fix three spelling errors in the comment for an internal file structure
allocation function:
- happend  →  happened
- over     →  exceed (grammatical fix)
- int      →  in

Changes since v1:
- Fix comma after e.g.
- Fix incorrect use of "imbalance"

Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
---
 fs/file_table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 16e52e7fc2ac..3c08832aa387 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -231,13 +231,13 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 }
 
 /* Find an unused file structure and return a pointer to it.
- * Returns an error pointer if some error happend e.g. we over file
+ * Returns an error pointer if some error happened, e.g., we exceed the file
  * structures limit, run out of memory or operation is not permitted.
  *
  * Be very careful using this.  You are responsible for
  * getting write access to any mount that you might assign
  * to this filp, if it is opened for write.  If this is not
- * done, you will imbalance int the mount's writer count
+ * done, the mount's writer count will be wrong
  * and a warning at __fput() time.
  */
 struct file *alloc_empty_file(int flags, const struct cred *cred)

base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
-- 
2.25.1

