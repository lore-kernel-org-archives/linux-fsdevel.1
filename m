Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D2647F2C3
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151560; cv=none; b=X5S6URkLK4XtvELtiULwWbdGmfzizEavM07OZgDnRgSwzYOEpQARtxZjQSH3Fea7wGxvjLaz6gQXPp8BimZfz1CVZPaQzlwAymr8GUiNWnykqWq4bT1U7t5RExxPr5moriRjNYSIe9LtQ9hi8YJ0owOwdP4Eawba+yq3ocpywKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151560; c=relaxed/simple;
	bh=dX6udeTBqDwq/nz6u9DJdafKIxXQMQJvrwQywiuiIj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rwIhVvHEBHfrOwatVrfN9HnHF5v+RYpMerIbofoAYU0Iuik/HmnD05FEOA37B1wT786gRE/fbe5LKJUj+ZlWiKDTyxQQpvTECQEs5J9KzuGg/GCB82vRZZJ3DP1/VNjlYejBAiY/dde7Iy6MQ/J/pqblMtjz4tV5nqpHV+cUGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N6Da0B67; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N6Da0B67"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e5378b281aso36362365ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 04:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792151558; x=1792756358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+5ntDWW7lL83gJluFN9/WXw9lVajZqu4nwy3QpGcvj8=;
        b=N6Da0B67v9uWwdGtou+ql0yFCvq8KSApEN5siUCu2E3jecbMbBsr890vZuAqK+yu+k
         m2ZGcckWLUhrCgamkmpM2uc9SkbiZAqL3B6Op8BoGGHWj/ZQeMDmfnK8LzkxR7lSgM4h
         tfNVvt8bZtqRXzx9wv0tYz2hj2srIO475NgPP4586Zn2pZ7ZmcxAcj8wXQAxjB6zIyD4
         rcUOotfn597rjTpfWfhvF/7wqIPWfiTbxSrkUt8GNYQ3stDHWxY5eePQ04iz1SfFlkaO
         T95DBQeG2VAFTHeixOxMr/FyLq4llrMmHsme+0ti5FUxjxE6gyu2tmYqsql2eaOQTnEB
         R31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792151558; x=1792756358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+5ntDWW7lL83gJluFN9/WXw9lVajZqu4nwy3QpGcvj8=;
        b=mRggrj1yNKLw+FeKVcoNrGoRkqQ+gbB3yU1LNwJRxUnRCEHZJMDj45+Cw4g9jWoR+l
         j5/Cqij0r1EciI//J1PlQHDg1MCWvF44gFPXh7GNvpgeYpHQi+RZQ3B+09db424LTS51
         LxZqMwSG77Ta/KDRNy1B8OMjzu3Iopd501XrjVE9FEL5gD19xeow3MuAbzL94lsJqRx5
         X7EO/AHOxkVaySVNlW91TF1bbS3429GgtdSGew7Cnq0PYpIG2Gc3AKp8DKIjjZdi+BdR
         +jyuE4drhdE5OllrZ4pziQrMFAsJW/pZmDPt7sQtr4YPosEEOIonVa8VO+3cfVB87BIy
         eIkQ==
X-Gm-Message-State: AFq9FYKf18D8h+4hAidVyOGHP5UC+YfBHY7dI6hbUx+fHismmSdobd7A
	Bdd/pYz7C+jDahOQeoLxu2atz1+UUkKezB91Zkx3W0irxqq1BlKPVusptYFgohUE52xOzx4mvpC
	LypFbvCU=
X-Gm-Gg: AYBFou3v1It3uoyP6G8FTRDkE0SF/sYZOiyavcUZlgt7NT4OoXN1+uDWK9dp/kkfTtv
	XK8XetyRyejeyTYgCgFdOEvrcy2Fq8TFSP6c5UDLG066hpqhRgpLKJB+SDnM0tS7X7LL/eAKpi6
	pdegVXJlyBeer5GO5+iS26XHKxgjYodcn+3X9eQFhJ7L+4cs2qS05nAdhFJVpYEH7XYOUyzcPt4
	2YlwM8fc+ECDtp2wTvG2r1Biz7nFoat06JIZ92U4sPCA8BVrOMPRBeY1HhdkaWRNJues+k083TR
	Rtv+rJgp7QY/srOW53Ai+GoH+/L2wOnLLxAyml7VMxSSynQzj27VK7tU6cMSAtykM9i4rQ/odyF
	iHGsaLt333Ppuhu5wED0PDQfuZ5iO1hqGSmRUv1EPxfQ/x/x6Hfx/HMpFEEesAB9Umv6LGkua/7
	uGmtA5Pr3BXxjMY3+GFvrdCnD13Elehe6L14aVpCCtho4rgN5uDIb8yxYLAUFd28XXbXETUvcdc
	to+
X-Received: by 2002:a17:903:22c6:b0:2e9:9b5b:e179 with SMTP id d9443c01a7336-2e99b5beef2mr6674105ad.50.1792151557694;
        Fri, 16 Oct 2026 04:52:37 -0700 (PDT)
Received: from localhost ([106.38.226.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804eb4sm8793055ad.20.2026.10.16.04.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 04:52:37 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	akpm@linux-foundation.org,
	roman.gushchin@linux.dev,
	dennis@kernel.org
Subject: [PATCH 1/2] writeback: reset dirtied_when when switching wbs
Date: Fri, 16 Oct 2026 19:52:29 +0800
Message-Id: <20261016115230.3640770-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261016115230.3640770-1-sunjunchao@bytedance.com>
References: <20261016115230.3640770-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When switching a dirty inode to another wb, inode_do_switch_wbs() puts
it at the newest end of the target b_dirty list instead of searching
for its sorted position. This requires updating dirtied_when, which
move_expired_inodes() uses to decide where to stop scanning.

However, the switch updates dirtied_time_when instead. This leaves
b_dirty out of order and can make the scan stop before reaching older
inodes. It also resets the lazytime expiration timestamp, potentially
delaying timestamp writeback.

Update dirtied_when instead, preserving both the constant-time insertion
and the lazytime expiration timestamp. Correct the field name in the
comment and document the distinction between the two inode timestamps.

Fixes: 9a6ebbdbd412 ("writeback: Avoid excessively long inode switching times")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/fs-writeback.c  | 6 +++---
 include/linux/fs.h | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e744f9f9d43f..6984f6c10a86 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -468,12 +468,12 @@ static bool inode_do_switch_wbs(struct inode *inode,
 		if (inode_state_read(inode) & I_DIRTY_ALL) {
 			/*
 			 * We need to keep b_dirty list sorted by
-			 * dirtied_time_when. However properly sorting the
+			 * dirtied_when. However properly sorting the
 			 * inode in the list gets too expensive when switching
 			 * many inodes. So just attach inode at the end of the
-			 * dirty list and clobber the dirtied_time_when.
+			 * dirty list and clobber the dirtied_when.
 			 */
-			inode->dirtied_time_when = jiffies;
+			inode->dirtied_when = jiffies;
 			inode_io_list_move_locked(inode, new_wb,
 						  &new_wb->b_dirty);
 		} else {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f9d1e05e8ae6..c5dd44314170 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -815,7 +815,9 @@ struct inode {
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
-	unsigned long		dirtied_when;	/* jiffies of first dirtying */
+	/* Timestamp for writeback list ordering and age checks (jiffies). */
+	unsigned long		dirtied_when;
+	/* Start time for deciding when lazytime updates need writeback (jiffies). */
 	unsigned long		dirtied_time_when;
 
 	struct hlist_node	i_hash;
-- 
2.39.5

