Received: from cvsmtppost105.wmail.worksmobile.com (cvsmtppost105.wmail.worksmobile.com [125.209.209.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8333EE1E5
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.209.209.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180712; cv=none; b=IYUaKTqgqu0BvLa9wzIVZYnB4qO/k7o2KRF0OuVlJxoO5jqBagfQHB7PA8URah540rwpVdKvSXL7cwiLZ0xbCMzoBhy6MmlqEvRZsOjfebDyMs1IYoyYf5Etvgnms3NlneKHlInKElDocYLNn1T/g1fY22BxAe9Mzda850BBqsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180712; c=relaxed/simple;
	bh=m72EeEErYn8IjUAQQtRajGQn/TcdgEZ3GhbKW3Zvzms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oNC5MB8cDz9HMv9eo7qqf52U9UMXgs7HK6NbyxDk7YsiM17InoSi5YXgrOQAV+KMJObdXueK31YPNUIgvlSDa1lLzEPZfDHmQkRCZBfAGl/rNqieqJmD6pY0JkDweYUVZM94EM+EC/JlIC8LKnIOKoKGYtlaaZqP01Jy1v9BrPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr; spf=pass smtp.mailfrom=korea.ac.kr; dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b=ceD9mfUx; dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b=GKbZBzh9; arc=none smtp.client-ip=125.209.209.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b="ceD9mfUx";
	dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="GKbZBzh9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
	s=s20171120; t=1779180700;
	bh=m72EeEErYn8IjUAQQtRajGQn/TcdgEZ3GhbKW3Zvzms=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=ceD9mfUxw6mqEkNnclsSpQauMT/kZYjPfwXpUZjyMminexHKXKZeUylI8BHevrxA+
	 Tv+jrozh29pHVIUO9hd/vEn4CdrH9Qj3nPdjzbBNpHiDWNJKwlpCnhIDRG7OZRiQds
	 Y17wSHB+M1pj/ozjHlqAt5oqXul2XtB1ql9Vkqk8lnas8l+EWXE9CowpKCwhEgN7Ip
	 /aFxbnoAYDWefH6lMLqIkuWglvU+ShQlDSAZgHXZh02N5DVyoFYD4uWMA31ZZ0Stl9
	 dMymdjD04C4hZBRBn+kE3KadIo77KKpxcmRxT0KajGM/BdblbFQbdHty058t4E5aZc
	 hlN5oVJ2nz5iA==
Received: from cvsendbo005.wmail ([10.112.11.110])
  by cvsmtppost105.wmail.worksmobile.com with ESMTP id t5hwBxsmQgWTGrvUu028gQ
  for <linux-fsdevel@vger.kernel.org>;
  Tue, 19 May 2026 08:51:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
	s=naverworks; t=1779180700;
	bh=m72EeEErYn8IjUAQQtRajGQn/TcdgEZ3GhbKW3Zvzms=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=GKbZBzh9NO9+sKz9KGwIRACzPENgANC+FANI5M+mu1oqvZYTNXsHWj5pf1F4opnVU
	 i7cXPvmi89gkkUHB9CK8qQ5013wus66lc/D4y1sYvfLUZjxOURdB/aXILrrO9iNL0o
	 mwA14Yc+5SdZJUGPPqCuLokTnz/We9G+UNGsBHIY=
X-Session-ID: Yuaa0-W0Sj2Jsd4s6z3u9Q
X-Works-Send-Opt: EendjAIYjHm/FqM9FqJYFxMqFNwYjAg=
X-Works-Smtp-Source: ewYdKxvXFqJZ+HmmKAK/+6E=
Received: from s2lab05.. ([163.152.163.130])
  by jvnsmtp403.gwmail.worksmobile.com with ESMTP id Yuaa0-W0Sj2Jsd4s6z3u9Q
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Tue, 19 May 2026 08:51:40 -0000
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ufs: Defensively handle NULL return from ufs_get_locked_folio()
Date: Tue, 19 May 2026 17:51:38 +0900
Message-Id: <20260519085138.55591-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514193256.2556905-1-ingyujang25@korea.ac.kr>
References: <20260514193256.2556905-1-ingyujang25@korea.ac.kr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ufs_get_locked_folio() may return either an error pointer (when
read_mapping_folio() fails) or NULL (when a concurrent truncate has
detached the folio from its mapping). In ufs_alloc_lastblock() the
NULL path cannot be reached in practice because the only caller,
ufs_truncate(), holds i_rwsem and so serialises against other
truncates. Still, the current IS_ERR()-only check does not match the
documented contract of ufs_get_locked_folio() and is fragile against
future callers.

Use IS_ERR_OR_NULL() to match the helper's return contract.

Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
Reviewed-by: Jan Kara <jack@suse.cz>
---
Changes in v2:
- Rewrote changelog per Jan Kara's review feedback to clarify that the
  NULL path is unreachable in practice (i_rwsem in ufs_truncate()), and
  framed the change as matching the helper's return contract / future-
  proofing rather than fixing an active race.
- Diff unchanged.

Link to v1: https://lore.kernel.org/all/20260514193256.2556905-1-ingyujang25@korea.ac.kr/

 fs/ufs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 440d014cc5ed5..989ff3d3ad179 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -1051,7 +1051,7 @@ static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
 
 	folio = ufs_get_locked_folio(mapping, lastfrag >>
 				       (PAGE_SHIFT - inode->i_blkbits));
-	if (IS_ERR(folio)) {
+	if (IS_ERR_OR_NULL(folio)) {
 		err = -EIO;
 		goto out;
 	}
-- 
2.34.1

