Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE961A6838;
	Wed, 11 Mar 2026 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773216683; cv=none; b=F5yR8e7C9tHxlPWYbZya3GaKahDLhK+OtM+B7zgCqU8V9fbWtaQY9wyADclpUGvsqSe53TQTSpPIU2pO58yBUxBO1EHUIjvOlP651ckGgjtWRyYCBl15iquTjUKiUkZL2fbvqjM7TbQvd7ViF8UCyQ6uIyq/FCVmFFg0xi7heKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773216683; c=relaxed/simple;
	bh=cw6tn8wxCm/8u7e7FCxBfpmxOiaI7cPaaWPioe1QVv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F5FBZt0Lbp6QepGW/HSwUFkp2Nqr/XUu5mVu7HsKqLRBt8132DV8U93crEeU3UhuO+qPfFqWnuiAqUa3GOjJIHK2okIn+29kYyJvBB7PuKISOnqSkK05HjVSYx/OQ4n1cQrdtx8dX1Wmx0a3FK6j2hjtE6vBl3tQuGy/CB/amvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gZtpidJb; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gZtpidJb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=11
	rxilNzodvuvzCLO3MeHRDznxrP0FHOC7bmEuqJ1b8=; b=gZtpidJbqu4n7DCX9M
	y1MOcYlubfMsNlT+LZFEqmgpl/36dSR0LIRlnMVAS5pys8b7t8827OwBL3kbkOmh
	LgCLRKq/dW6+gNLQOi2CRc3leEJgSY8iQdJLkirx4Dg8UxzRRkngM/3NMzydaufs
	gEaiGpgWYKDdgevh3mCNsVRRs=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3v8OGI7FpmUFfAQ--.47091S2;
	Wed, 11 Mar 2026 16:10:48 +0800 (CST)
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
Subject: [PATCH 5.15.y] binfmt_misc: restore write access before closing files opened by open_exec()
Date: Wed, 11 Mar 2026 16:10:46 +0800
Message-Id: <20260311081046.1668003-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v8OGI7FpmUFfAQ--.47091S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw4fGF48tw1UurW8AF1DWrg_yoW8WF4Dpr
	W5K34UtrZIqryj9ayvyas8XF15G3Z7Gr12vr4kWw1xXF1rXrs0gFZ2g3yj93W0y397A3yF
	qF4rC3sYyryUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxWrZUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbC5gmxHWmxI4mC7wAA3c

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
index 740dac1012ae..05c235309421 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -816,8 +816,10 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
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

