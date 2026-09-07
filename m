Received: from mta0.migadu.com (out-215.mta0.migadu.com [91.218.175.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F96409635
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764256; cv=none; b=JAW6KKyEwWyv5R5F3Wz+SeVSYma9Wub4D2yAF+R/BsySlVwFBVHe7xWSf8FpULgKf6Ac6ZcCe7ssVX4ylxRN7UEbn43p1uqW6rhMcljZTCTwJgNN4MptK4InFRyOXP35asppzSpLV9OhQmeJniRVq9PLlCFdEJaGvLhKJflSVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764256; c=relaxed/simple;
	bh=gQBaUqklxjcC9STbz4BtdWOD0PZQAs6cEpCAdU2Ruuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OuTRISQ0n4OZmHW5+kahvxdNn2Kpf1LlhbYENzmdXSNezLevO3516raRTl30DCKaWTC8eVHCcHT9F3G48p0YcBUoZB7LMOs3p18J+8WMbpcvm0c3FGRQXr+pagM45QywyqkGCISb7k/7IeibrIjAoVzAyTvJcQM91+rjqRwdz4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J6Ba9/I7; arc=none smtp.client-ip=91.218.175.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J6Ba9/I7"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gQBaUqklxjcC9STbz4BtdWOD0PZQAs6cEpCAdU2Ruuc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788764253; v=1; x=1789369053;
 b=J6Ba9/I7whume/lZl+OWxhIBzts2c4J2lmF4QIvcQpTh0/GCbC1RPSY6R/T15GJkleQUUbPw
 3EkPGLRUX0gL+d7jNXJKApwNHu+ojBOrdo/mBZB5CHY7cvOxOZsNMiqfzNh5nwcicjPT+kaB8be
 1MU8lDvUiQ7DmlEJ2qJ/V+zA=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a422daf900bcebfb;
	Mon, 07 Sep 2026 06:57:33 +0000
X-Mizu-Trace-ID: a422daf900bcebfb
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	andrii.nakryiko@gmail.com,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fs: reject U64_MAX as last_mnt_id in listmount()
Date: Mon,  7 Sep 2026 14:57:23 +0800
Message-ID: <20260907065724.1355551-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

listmount() uses mnt_id_req::param as a pagination cursor: on forward
iteration do_listmount() starts from the first mount with an id strictly
greater than last_mnt_id.  The sanity check in prepare_klistmount() only
rejects ids in the range [1, MNT_UNIQUE_ID_OFFSET]; U64_MAX passes the
check, and incrementing it wraps back to 0, so mnt_find_id_at() restarts
from the leftmost mount in the namespace every time.

A caller paging with last_mnt_id set to U64_MAX therefore always gets
the same first batch of ids returned and can never advance to the end of
the list:

  # base: every call returns the same first batch
  listmount(param=U64_MAX) = 8 ids: 2147483886 2147483888 ...
  # patched:
  listmount(param=U64_MAX) = -1 EINVAL

Reject U64_MAX up front together with the other invalid ids.

Fixes: b4c2bea8ceaa ("add listmount(2) syscall")
Cc: stable@vger.kernel.org
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 fs/namespace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 8d4009cfbf5b..cb95b855f78b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6108,6 +6108,9 @@ static inline int prepare_klistmount(struct klistmount *kls, struct mnt_id_req *
 	/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
 	if (last_mnt_id != 0 && last_mnt_id <= MNT_UNIQUE_ID_OFFSET)
 		return -EINVAL;
+	/* U64_MAX would wrap to 0 and restart the iteration. */
+	if (last_mnt_id == U64_MAX)
+		return -EINVAL;
 
 	kls->last_mnt_id = last_mnt_id;
 
-- 
2.43.0

