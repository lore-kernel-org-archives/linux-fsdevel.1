Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD4C397688
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979843; cv=none; b=j4LVRHmsOL9YbkoqvZeXPq5iai/Zt5HJorJ6CotGwR8fqP0811pNz+HBFTrePwcyKexhu8u9QBvf7KSXU/9dtoclub5KPA8djscUIModPb2A4ndnd9CPYGtomegKp/Y9mL3Av7bemJs30Lgd2OyoM4sDj5JxE+wOZVR8T2ysf8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979843; c=relaxed/simple;
	bh=ecvfBjhm+yhR7rXfHdAcTwexxJvDEv79hZIRw3H8yXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aiYwmjeYEIZfHeXSqdRtGrN8nIXyEBt1a9aT1oymCiDUzJ7lFfu0LkFHl0D6hPG/8NBMDV7swVoImjKt5tbfn1h01FpMr8xDF7WsBbwF1QjS/Wbvd5eVMIHRfkYABJMqflK23T4FYmvVhxEeBjlLxdcbpxHtoW7Hpt7sNK/FqXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lizAZQsd; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lizAZQsd"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4ae61629fso165061a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 11:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788979839; x=1789584639; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p0BwiWfcrxJYj2VLhIlkUjpi9RdntgrmlPrUUWjihQY=;
        b=lizAZQsdpnGK6bcKYL/tv3LgerrwRXQVS+G0vQKrHbf64NFJqsNtbNx7ygwcJMaw13
         fWlN12Gh4vxw5zni6jacxTOrhne29UlpTwGn70CSL5bG+Jnbw2XB6dfAm9ON3YnEXoQ2
         nRT77B+uZTlzQGtkQOSh86Lotk5tsFjnOP+4RdX1SO7hG7/+L2ny5/51fQYB8r2zaUzo
         Ak6xNNu3N1fWKkTaShWXqfcwYBfZLlgANuvHEG8ppbboQHecDy7Le23c6HO4MiBMPDT7
         kDOgdacljsxVUJIWH5cFbdb9HBmjdd2woMl+dAcLqoD9q9MVtk1QXKhSFD2njBPh1QbN
         Llfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788979839; x=1789584639;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=p0BwiWfcrxJYj2VLhIlkUjpi9RdntgrmlPrUUWjihQY=;
        b=Tv/LCcxEllr2oitor/gyUnlVgsr8LJieXfSP09FDkoQqxFUMkwfifBFlgrdA0Jh2nR
         SyNG59h/5aJGpuALshFo3IZh42T9xzVkhrEUsFTw9djiwBT5RMge2g+1tNx40yln0lzJ
         gZQQieu0EDVm4tHI3f/fpiZP554h29lDS4+wG9VnDkfs25gShZgm6O+eIHShR0sDYsLd
         zECOcuFaZC1y40wxDpKYi+Fyo9wNdJMio1Nzlstv7+KtgDW3mYZCd83QnVQ10jQTjHfC
         11cuKlfW94U86sjBxS5eAxuFMfzSCv/65erm6oDir0Fggmfdy4ZQUNVk4nW5wY/Yj+kV
         iv1Q==
X-Forwarded-Encrypted: i=1; AKwUvByEWH109JeMCL8CTGz30sDSFVszPgQuLEEyc8FHptZzjJFXrdou2cn4+YjNwMvsx6wyxD6ry7J4BjFszjva@vger.kernel.org
X-Gm-Message-State: AFuF++koFriQqmm0x0vHiZFgWoe9g6lum2SiW2b5r3vvsXq1PMiw96HH
	PQs0r+hbQqsV1mp3vlxlY/Upq508mwH8Ezsu4gqS1Drc/0WG48n26700
X-Gm-Gg: AYBFou2n1VzzwaP6NImgHPTuiBpYNJcll+gfdC38pw0XQwS8d55jgJyd0InH2RXE1TP
	TfQ1f7GZBK/u64uRzGmcmpaszBg+9A6ftOPK75uMxhSj+ET6IYSOgxXM8IUh+I0ZZNZB2zQ7u7l
	N1UsnS7WnQQvvhrdEP4mmfFLyXfG16/lRjCn90uYd6onBf2TaEbe6NtP2JP2C4b/YldQgM3sNmT
	6oBfXIDeX3MCo+bzuyWCgz8enPwrYviDQdXEuKu21Ygdf4L+TzSsR/tQ8h5G3X0UtsOde7RBP4C
	n3osY4ngC5n9tkRK8SFyxjwPm7VEFKDQI27qpRtnsRQekbZcilbKMVpbQvxIHRSqgEdcrvrrQCh
	WNPEbVGp0w6RV2pkHACtJ8jM+l3EwaGZ+lWlCmkykMcEaXyDez3CaycWhtE5jyx86CBz5rfZwvw
	qMC/0yY6mQtZKXGKpUYXK7rs+fIg9qub6ry7A4iJkqcJd7R1tixDBWzpXeuDBZPqkN64jcZTWzW
	RYm3a/BStXIJqQUqoIFW31S42WRt4sLeX+CfDoVon301J6kCa+ZKFwkbIuk+iFl
X-Received: by 2002:a05:6a20:a10d:b0:3d3:adbf:7782 with SMTP id adf61e73a8af0-3dacbf15104mr3902682637.23.1788979839150;
        Wed, 09 Sep 2026 11:50:39 -0700 (PDT)
Received: from localhost (ec2-52-89-207-25.us-west-2.compute.amazonaws.com. [52.89.207.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc464393760sm6282776a12.3.2026.09.09.11.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:50:36 -0700 (PDT)
From: "Patrick Lu (Anthropic)" <perf.patrick.lu@gmail.com>
Date: Wed, 09 Sep 2026 18:50:27 +0000
Subject: [PATCH] writeback: bound cleanup_offline_cgwb() rescans by
 rotating b_attached
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-wb-cgwb-rotate-v1-1-f2eb994d2a46@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHKqoWoC/1WN0Q6CMAxFf4X02YVBogR/xfjQlQ6mZiPdEBPCv
 7vhky9NTu/t6QaRxXGEa7WB8NtFF3yG5lQBTehHVm7IDK1uL7rXvVqNojEPCQkTK9t02J0tkh0
 I8tEsbN3nEN7uP46LeTClYikNg5GVEfQ0ldVrrimsQZ4s9RH9P4B9/wKtjudGpAAAAA==
X-Change-ID: 20260909-wb-cgwb-rotate-f17a75facfdc
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Tejun Heo <tj@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dennis Zhou <dennis@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 "Patrick Lu (Anthropic)" <perf.patrick.lu@gmail.com>
X-Mailer: b4 0.15.2

cleanup_offline_cgwb() prepares at most WB_MAX_INODES_PER_ISW inodes
per call and is called again until the dying wb is drained, but every
call walks wb->b_attached from the head. Inodes already prepared (they
stay on the list with I_WB_SWITCH set until the switch worker runs) and
inodes that cannot be switched (I_FREEING, I_WILL_FREE, !SB_ACTIVE,
DAX, already on the target wb) stay at the head, so each pass rescans a
growing prefix under wb->list_lock and a full drain is quadratic in the
number of attached inodes. With ~17M inodes attached to one dying cgwb
we have seen this end in soft lockups, with CPUs reported stuck for
21-48s.

Move every scanned inode to the tail of b_attached, so the next pass
starts where the previous one stopped and the drain becomes linear.
b_attached is unordered and isw_prepare_wbs_switch() is its only
walker, so nobody else sees the reorder. b_dirty_time is ordered by
expiry for move_expired_inodes() and keeps its current scan.

Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Patrick Lu (Anthropic) <perf.patrick.lu@gmail.com>
---
Seen in production on a 6.18-based kernel: with ~17M inodes attached
to one dying cgwb, a node spent 36 minutes in back-to-back
wb->list_lock holds by the cleanup scanner (~6ms each, ~46% of wall
time, starving writeback on that wb); with this patch the same workload
drains in ~30 seconds. Also seen on stock Amazon Linux 2023 6.12.68 as
isw workers spinning on the list_lock in inode_switch_wbs_work_fn()
while cleanup_offline_cgwbs_workfn() runs.

Tested with a QEMU A/B setup at 100k attached inodes and patched vs
unpatched on production-class hardware at ~17M attached inodes.

Josef Bacik's patch making the drain loop report a Tasks-RCU quiescent
state [1] fixes BPF/ftrace detach stalls behind the same drain; this
patch bounds the walk itself. The two are independent.

[1] https://lore.kernel.org/linux-mm/20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com/
---
 fs/fs-writeback.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e744f9f9d43f..69a452b12b12 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -725,21 +725,37 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 
 static bool isw_prepare_wbs_switch(struct bdi_writeback *new_wb,
 				   struct inode_switch_wbs_context *isw,
-				   struct list_head *list, int *nr)
+				   struct list_head *list, bool rotate, int *nr)
 {
-	struct inode *inode;
+	struct inode *inode, *tmp;
+	LIST_HEAD(scanned);
+	bool full = false;
+
+	list_for_each_entry_safe(inode, tmp, list, i_io_list) {
+		/*
+		 * Rotate scanned inodes to the tail so the next scan resumes
+		 * at unscanned ones instead of re-walking an ever-growing
+		 * prefix of prepared and skipped inodes.  b_dirty_time is
+		 * expiry-ordered and so must not be rotated.
+		 */
+		if (rotate)
+			list_move_tail(&inode->i_io_list, &scanned);
 
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
+	if (rotate)
+		list_splice_tail(&scanned, list);
+
+	return full;
 }
 
 /**
@@ -747,8 +763,9 @@ static bool isw_prepare_wbs_switch(struct bdi_writeback *new_wb,
  * @wb: target wb
  *
  * Switch all inodes attached to @wb to a nearest living ancestor's wb in order
- * to eventually release the dying @wb.  Returns %true if not all inodes were
- * switched and the function has to be restarted.
+ * to eventually release the dying @wb.  Returns %true if the scan stopped
+ * early after making progress; the caller should call again to continue
+ * draining.
  */
 bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 {
@@ -783,13 +800,13 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 	 * bandwidth restrictions, as writeback of inode metadata is not
 	 * accounted for.
 	 */
-	restart = isw_prepare_wbs_switch(new_wb, isw, &wb->b_attached, &nr);
+	restart = isw_prepare_wbs_switch(new_wb, isw, &wb->b_attached, true, &nr);
 	if (!restart)
 		restart = isw_prepare_wbs_switch(new_wb, isw, &wb->b_dirty_time,
-						 &nr);
+						 false, &nr);
 	spin_unlock(&wb->list_lock);
 
-	/* no attached inodes? bail out */
+	/* nothing to switch? bail out */
 	if (nr == 0) {
 		atomic_dec(&isw_nr_in_flight);
 		wb_put(new_wb);

---
base-commit: e14d4302cbd0de773960bec33c2281508c8d8855
change-id: 20260909-wb-cgwb-rotate-f17a75facfdc

Best regards,
--  
Patrick Lu (Anthropic) <perf.patrick.lu@gmail.com>

