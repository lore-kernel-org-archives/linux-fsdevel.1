Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB8B3CB544
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152646; cv=none; b=ldFGgtOj1fr0fNkSwofpT1/BqO+V5q7kviYlvlrscc1msAdFPqOYIZeKUxe3j6B8ci3YwHvK9hptfHsXaczXPz9iqbSUiJ9ytFag7btaeAkVbQ8TBs9nfC49sTuYKm5qJ9AbNebOM05Ppicjvq5uSawlzTXxXQt7sdGLMpTdYn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152646; c=relaxed/simple;
	bh=uCsYVZ753xnVaLSMgrHyQzxwKaXZtDGn/0u7AvcO/pY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=K8yk/Hy+OUf7lCQRdB0XgC2k6s67D4fAVOfLI2sdf5X1MFlOvh80hgjuzyCbT/qBCnagakXCQ6wRKWqt60elFNEujq/gz3Fxg1JYgibymsZui24KjKiEQTPi98MAHIdJxKhHMpzOL18tdFb0MddnasuVcUU6jeGCriSsUOEMBjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzeVXFZY; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzeVXFZY"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-398b3d66515so1633511a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 11:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789152643; x=1789757443; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Vwui60iV1sbNyFImmoRi6Sq4sW+pHlWYoAVUwnnhsoc=;
        b=gzeVXFZYSd/mW5wCWIgHmVjTJQFjMn7a9ReaPJbRDUjMINBC9ksuHWApP1ZDujTKgm
         ejIkLnrc/3yQiyVL9F0iyYti60NBy+85nup2EfbnyxeCcvcbGG1ZkBG4TDC6UuP+HjvK
         hB3+wYGtKF4ipTiS/BMfFI7nBipeCcz4ED0yfseTxaKiqKbV99hqGm8NX6BZYAHDf0o1
         nRG8wbNNYop5e1vh9LabSwSp39AIQ6o4jQR0cNPd0jcC2EVivV/jZSiVTxrpqaQgGqqE
         nTXE3IYXaedTL2e35GF1gIvBaFQbdq4w2EtLUcqeRMQqOjThYH2AousgXJN3b00ZhPYS
         h66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789152643; x=1789757443;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Vwui60iV1sbNyFImmoRi6Sq4sW+pHlWYoAVUwnnhsoc=;
        b=JOdP/eo25Uo2aA5fcuNBNVqb0hmWBUMbdDrBYEpO2GzGOx0IR+ZACnn1uQG+BWqwRh
         vaUA006C952kiCjdobki81QYCcPTPck512A9WTyC+JZTJ/x34rEJR4+/VNwnqsp8WVKG
         yVIiKDV4V3Kz5YTudl4/dpYL8a3vERlQMv/QmM6qU2gnQQRTZvEdRmRjiGvmpUqmKYoc
         SzeKOnc83y5Vj5sBy+t+MMQRFWTdGnfm9ZHOAksX1joQMX3vTANdEeax1Mbyp/zleQfR
         bMmCs/mFO9lM+R9fye6pMowGB82G1WRbuYY5aTIUDLRkT9ObmvHVSsAPuDE+KPPXwsni
         ArzQ==
X-Gm-Message-State: AFuF++n14McrjBiJYmDLWRVsNfWtBvxv80Lki8N5dPj3TJgr+OzpRMgT
	x+Kle64TIuK0a00NggXhx2u8QFY4k+5igV+WJ509O2eNjDVxOQj6hjhZ
X-Gm-Gg: AYBFou0rH3PC/CIr23mUV1vA36kWhX4CJLkp3Y2kI73buG5fg/g/xReY7j7o9gss7Bd
	BB8JUueaopuDEx30VM/dGOlQUW4Lw4dfEXofY7g8t3OKBT1FhTQQmThNYnmap0OxscZICsioQhy
	6OPITLpa2rM9CEpFaytY1OI4E1XH97+deBUZcXfwsDIEzR45GSFXlHlSmjXm40ubnZWW6bZiKm3
	U8moKAbBiDYci236rEOmzdnKy162Nkxf6ao+CuxZ3p3G7N7qaYK4qD3hw89ucef0WMN+YyiiMJ0
	1bsR2xLYJkUXQJ06Ss1QHqMaY30UnX78zrtG7/9kTllSuorYADSGB18Xz+SMobiZ0NSK6xM+Rfh
	rOTvBDxLIW3RwpGWgN7jTdMb7cqiap/UiPDvmWHYjYIhw20OJoK/lN+JemZhFO37SZXh/KsUcJt
	TgxEj0AEjVCAr8AE8ZbTTdicBYRgakDJi6Jbescl4dpXHRFEtt+Z5hwhfbewkKjy+YWlpx9ajmG
	+EFGz4fSvQs06KlhVNNrfykhE3x6pfQzGbozuM4DYW8XoeUkl2iGdGQbbI6/deQSPA=
X-Received: by 2002:a17:90b:224d:b0:38e:659b:f366 with SMTP id 98e67ed59e1d1-39d9b984500mr8915050a91.0.1789152643128;
        Fri, 11 Sep 2026 11:50:43 -0700 (PDT)
Received: from localhost (ec2-35-80-130-216.us-west-2.compute.amazonaws.com. [35.80.130.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d98e602e7sm6767203a91.5.2026.09.11.11.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:50:42 -0700 (PDT)
From: "Patrick Lu (Anthropic)" <perf.patrick.lu@gmail.com>
Date: Fri, 11 Sep 2026 18:49:49 +0000
Subject: [PATCH v2] writeback: bound cleanup_offline_cgwb() rescans by
 rotating scanned inodes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-wb-cgwb-rotate-v2-1-a9ab253a1295@gmail.com>
X-B4-Tracking: v=1; b=H4sIAExNpGoC/3WOSw6CMBCGr0K6tkIbhNSV9zAs2jKFKlIyraAh3
 N0WVy7cTPLNzP9YiQe04Mk5WwnCbL11YwR+yIju5dgBtW1kwgteFaIQdFFUd3GgCzIANayW9cl
 IbVpNomhCMPa1G16bL/unuoEOySV9KOmBKpSj7tNqmHLtFod3wHw//QYkRW99cPjeO84sOf+tM
 zPKqOGghChbLsvq0j2kHY7aPUizbdsHOddOJfAAAAA=
X-Change-ID: 20260909-wb-cgwb-rotate-f17a75facfdc
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Tejun Heo <tj@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 "Patrick Lu (Anthropic)" <perf.patrick.lu@gmail.com>
X-Mailer: b4 0.15.2

cleanup_offline_cgwb() prepares at most WB_MAX_INODES_PER_ISW inodes
per call and is called again until the dying wb is drained, but every
call walks wb->b_attached and then wb->b_dirty_time from the same end.
Inodes already prepared (they stay on the list with I_WB_SWITCH set
until the switch worker runs) and inodes that cannot be switched
(I_FREEING, I_WILL_FREE, !SB_ACTIVE, DAX, already on the target wb)
stay where they are, so each pass rescans a growing run of them under
wb->list_lock and a full drain is quadratic in the number of inodes on
the list. With ~17M inodes attached to one dying cgwb we saw this end
in soft lockups, with CPUs reported stuck for 21-48s.

Walk both lists from the oldest end and move every scanned inode to
the newest end, so the next pass starts where the previous one stopped
and the drain becomes linear. b_attached is unordered, so nobody sees
the reorder there. b_dirty_time is ordered by dirtied_when, but the
oldest unscanned inode stays at the end move_expired_inodes() picks
from, sync takes the whole list regardless of order, and prepared
inodes leave the list as soon as the switch work runs and get a new
dirtied_time_when on the new wb anyway, so the only inodes left out of
order are the ones that can never switch (DAX), and only on the dying
wb.

Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
Cc: stable@vger.kernel.org
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Assisted-by: LLM
Signed-off-by: Patrick Lu (Anthropic) <perf.patrick.lu@gmail.com>
---
Seen in production on a 6.18-based kernel: with ~17M inodes attached
to one dying cgwb, a node spent 36 minutes in back-to-back
wb->list_lock holds by the cleanup scanner (~6ms each, ~46% of wall
time, starving writeback on that wb); with v1 of this patch the same
workload drains in ~30 seconds. Also seen on stock Amazon Linux 2023
6.12.68 as isw workers spinning on the list_lock in
inode_switch_wbs_work_fn() while cleanup_offline_cgwbs_workfn() runs.

Tested v2 with a QEMU A/B at 100k inodes on b_attached and 100k
lazytime inodes on b_dirty_time: the per-pass scan under list_lock is
flat on both lists where unpatched (and v1 on b_dirty_time) grows
across the drain, all inodes switch, and on-disk timestamps match after
sync. v1 was also run patched vs unpatched on production-class hardware
at ~17M attached inodes.

Josef Bacik's patch making the drain loop report a Tasks-RCU quiescent
state [1] fixes BPF/ftrace detach stalls behind the same drain; this
patch bounds the walk itself. The two are independent.

[1] https://lore.kernel.org/linux-mm/20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com/
---
Changes in v2:
- Rotate b_dirty_time as well, walking both lists from the oldest end
  so the expiry still sees the oldest unscanned inode first (Jan)
- Drop the unrelated comment updates
- Kept acks from Tejun and Roman since the b_attached side did not
  change
- Link to v1: https://patch.msgid.link/20260909-wb-cgwb-rotate-v1-1-f2eb994d2a46@gmail.com
---
 fs/fs-writeback.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e744f9f9d43f..ea3eb40bf828 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -727,19 +727,34 @@ static bool isw_prepare_wbs_switch(struct bdi_writeback *new_wb,
 				   struct inode_switch_wbs_context *isw,
 				   struct list_head *list, int *nr)
 {
-	struct inode *inode;
+	struct inode *inode, *tmp;
+	LIST_HEAD(scanned);
+	bool full = false;
+
+	/*
+	 * Walk from the oldest end and move scanned inodes to the newest
+	 * end, so the next scan resumes at unscanned inodes instead of
+	 * re-walking an ever-growing run of prepared and skipped ones.
+	 * For b_dirty_time this keeps the oldest unscanned inode at the
+	 * end move_expired_inodes() picks from; b_attached is unordered.
+	 */
+	list_for_each_entry_safe_reverse(inode, tmp, list, i_io_list) {
+		list_move(&inode->i_io_list, &scanned);
 
-	list_for_each_entry(inode, list, i_io_list) {
 		if (!inode_prepare_wbs_switch(inode, new_wb))
 			continue;
 
 		isw->inodes[*nr] = inode;
 		(*nr)++;
 
-		if (*nr >= WB_MAX_INODES_PER_ISW - 1)
-			return true;
+		if (*nr >= WB_MAX_INODES_PER_ISW - 1) {
+			full = true;
+			break;
+		}
 	}
-	return false;
+	list_splice(&scanned, list);
+
+	return full;
 }
 
 /**

---
base-commit: e14d4302cbd0de773960bec33c2281508c8d8855
change-id: 20260909-wb-cgwb-rotate-f17a75facfdc

Best regards,
--  
Patrick Lu (Anthropic) <perf.patrick.lu@gmail.com>

