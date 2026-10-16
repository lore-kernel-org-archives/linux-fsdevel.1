Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33647C0FB
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151565; cv=none; b=hxv5B6prttepz3RuQt5SNYUBAi44cOodFUVbDlk1K3E0n/da3tWb+gIbP1x3p7OBTBfgVDjPFt8w2iD+GPoY6YR3DZ/p4/wX7sqnEaghTjeKay4daegfOgQt6QjozVLxEQDOVDsSSru4mo1hvyJhQI26z5GbmGWE2JrljguDDpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151565; c=relaxed/simple;
	bh=x6SE8lgsHBQhuxqG5SxpxIZcbbdghSglSD4OM8h/oMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i9NEbelZQyqiFdqWKjGm5l7xOpXcy6fU0hgLw8oFxGGxnnLYUaWLBrVZ+en76jrG670tG2FEMtH0bbYpsnO6GCux8WlNsMTCWcRQZfl+tUAWE/9TIT5XdhxbdDPK8oMZzXy22P7RoQbqlWeu4v7OKYFLo4JK4ybWwYBXp1yqie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RBxHXOL8; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RBxHXOL8"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd633ef819bso1068348a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 04:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792151563; x=1792756363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P2cWXyzTqy4ATLwIvFgGwIz11Jn9SwiN4s9+0KODfO8=;
        b=RBxHXOL8pWYQ0inZcq4Y9UGmtXn59Z65Ff/4PYZzeSPeSRFxF14ppDwHS3abNhwgOC
         CDQOhehdYVkhIrzTLzpoEIo6jiXdK6E7vlEtHAYg0HfN9n6Eywhg6CJaw/sA3CfXzS+h
         PsbElGyPiN9l4AiVgovWg19DRw7K0OoULfSyroPMHrLD++gAVr+wx1jD4j9gnddjnDHS
         WH6hcXgGSlnkfQd2dtOkeVvz016m7lTVCAXM3DWlazD/2m2iRS32IjH+nMmmkEHbdLLD
         SX5RXbH4nRyn5GgiQ04bm9GFw/MJNF3JL9WlyuvB4e/Rlbjg44ZFlxqd/ZBLRmG3FLpQ
         wxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792151563; x=1792756363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P2cWXyzTqy4ATLwIvFgGwIz11Jn9SwiN4s9+0KODfO8=;
        b=e7EFFljtZjsA0fIJ6kEXJl1HQUW+WBgGbDSqbflASvpb7VCgHNVuEEjumJp2d40bbS
         /RCHHPdjKcEvsPtd2G+LFjz81GrvX+cGPgCAWqKpjNpYk3bx2CFoirZ0aJhvW3sv/gSP
         TQYL7xUYtdFTrtypCYKyXI7J7A+aLKiKuPT9vz5PxAbOgfu6yDLStpFhKFG/O5EjSH6D
         VbAP0TKcxbUrN4pcGEud/JWMtrTw3Z8kXNYo1tyTDMi9f5S+z59IvKN9pEBql/yjMcM7
         5Y/vaKGsPoLDDyyX0/ysQXK3yDHU6rS38yqU9TNXcFZ16f5O0S6G6HfycsWovJx8R6b3
         Puvw==
X-Gm-Message-State: AFq9FYK4JFe6fAxxWVDd7ZgWO0LzCul33OAsickwuUKHd3+xYI39rITo
	Isrpiet1LcZo07F1kQPTHpDPvTokO57KYhVMvB3ajR6E27YZ3Ms8kvbLdpY5bdHrc3jrCmlPRZb
	5RVLBFZ4=
X-Gm-Gg: AYBFou107AIwny3thAXjufcLUTChzTfIpdEgO3896J9RotPOjI41jT88jWLD96cHprD
	wp03WygoWeZzwYMp/hijMEcH44xQ5Xza9gZbP5fA6GPJACaAoAkiVLxiER33wDjDQ7LTEXGqUoU
	TtEkZUopsXaTqMrxVzUQklnImTXArbfwWxira+Eci4my/I+pj+6yHjzbDYGM4kB8eFwgVYCNfXA
	lrMpuMna8+0iqgJtFcpXxpZ9+397+rZOol9EXNK6RYZe4jivBbx92VB7WvLKyvfMMhpu0hUjCkv
	oTfipc/G9aSULADuSOFqI8Jwji5O9OVipJW+Ff7sFEPnwWlh8POHHn0ijGceOLiqXjx0uMGYZ1P
	ceQS2st8UhsyrqPB6lM8STSDC0x3x0DVuxvlTtfZnNaHXLRbikbpvI9NKWTkD8PxiM9sdIVPUR5
	Ql4zHHz9rr3ZKrEONqbJjnUBQBEm2o3NSEJCUB9p8CGvVe+G4f+aPp2PpOZQ5jx7VdWkWHiJ/Fo
	dQ=
X-Received: by 2002:a17:90b:5350:b0:3ac:9d83:8861 with SMTP id 98e67ed59e1d1-3ac9d838a70mr4890820a91.67.1792151563166;
        Fri, 16 Oct 2026 04:52:43 -0700 (PDT)
Received: from localhost ([106.38.226.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94792925sm8745182a91.13.2026.10.16.04.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 04:52:41 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	akpm@linux-foundation.org,
	roman.gushchin@linux.dev,
	dennis@kernel.org
Subject: [PATCH 2/2] writeback: clear old wb dirty state after inode switches
Date: Fri, 16 Oct 2026 19:52:30 +0800
Message-Id: <20261016115230.3640770-3-sunjunchao@bytedance.com>
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

Switching an inode to another wb updates the target wb's dirty-I/O state,
but no longer checks whether the source wb's dirty-I/O lists became empty.
The check was lost when inode_io_list_del_locked(inode, old_wb) was
removed to support tracking clean attached inodes.

If the last dirty inode is moved, WB_has_dirty_io remains set on the old
wb and its bandwidth contribution remains in bdi->tot_write_bandwidth.
This can keep an empty wb scheduled for periodic writeback and overstate
the total bandwidth used to distribute writeback work.

Call wb_io_lists_depopulated() on the old wb after the batch of inode
switches, while its list_lock is still held. This clears the flag and
removes the bandwidth contribution if its dirty-I/O lists are empty.

Fixes: f3b6a6df38aa ("writeback, cgroup: keep list of inodes attached to bdi_writeback")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/fs-writeback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 6984f6c10a86..04fca06bd520 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -566,6 +566,7 @@ static void process_inode_switch_wbs(struct bdi_writeback *new_wb,
 		}
 	}
 
+	wb_io_lists_depopulated(old_wb);
 	spin_unlock(&new_wb->list_lock);
 	spin_unlock(&old_wb->list_lock);
 
-- 
2.39.5

