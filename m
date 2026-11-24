Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510239;
	b=sJ0Q/kpV1v0P3MJaOmDNlkQ9GgijaLJU+SKPrW+LK5pCpIZwcfUFBf/02lxTCVTzUyGI
	 gmNrQ249OqUUB5PcUcMOEyDKfDufkugH7MLtO8G+lSYt7/7yKfVCT7/wscoOdQQeBj7n4
	 7h/FPMWKjStr2W9+/TRX64gRVgCbSNcwuX5iy7qpwuxO56XFfS7AJbCxmrbtYf/vi/GNi
	 FmiF6ENyc8eSgva506tv1NDLaQgPOiPiMqitwBuB1Wcrk6DIabz1r+isyI0mmlRbwCfKm
	 XSb7hDwGqLT5e/Lw8W04GDMtSB7k49zq9EpGI+qjRUBOrIaES8ef0zGUw1rmPdYvt0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510239;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=pZxSNV99eQQD7nI0RHK3EiKTCxoH4Q/YUIR/xnmC9yM=;
	b=kXAF+ZinQoz2Aq5FJ7O7sgDz7cOBv81/CO12cSmfH7Rb9oTw+ZTe6PMl7Y3drjLsua1W
	 IMR+Ba+pVBXV5ikBGeebRh9MWH3+0e1hQBmeCYmTB5srnjvfSS3SwJIfyTccOYYCVOtfH
	 OVOr5veMcmbHEsiCoR1stHes15+1u62qR4tZG1LZmy+c8hxpv8s9yvVqQqiot2advRxzn
	 l2XPKAOYBk1BESGvvCoazstYlbKT93ao/uEe/hJ5fcJjSuVhU5+pD27+OBCMQZONzOXYk
	 O4MoVoT+Yk6VaoYmRfoneQ2eCqcRDksY15zZ9LCvYn05Cqc3H8HeJZOTz+E4x3oBXZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Biz/pg0z";
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F997606A321;
	Tue, 24 Nov 2026 08:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F997606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Biz/pg0z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795510239; x=1827046239;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1fRo1a0dLF78exZbhSV0DUhDGiKNw/pnDJfveyQyjwE=;
  b=Biz/pg0zXhr0rqvxPk70aC09U5BQGC2qXZp1SO14lVnJ6JWwgjUHj3dt
   VndP/txLFUfDHYCOU0VcTDW+Ks/wWluW26YilDtMxET6J+W690zTzOdL9
   PcxQCAAIACDt8SXAG9gs9FcpDPxBiRXPNA8/3tvKRKsHX1Swv4UGV1F7V
   IbDvhjNyuEyimt/8BfYEsMLZABALyVrSM+cu+U2/kcLMtkopx1YamNKXa
   qp6ntOyCisUwHgZTXxkgDTLLg8HxVdA42eMGntDlPPPF6HdgpEoEXLAKh
   JtYhApbiG9MhS5yswfR95Vl90BjUCifo1IfYiABG8ff9SqatJU4IouNG0
   Q==;
X-CSE-ConnectionGUID: 1dLKM7FvQZqnpCEEHmq5Wg==
X-CSE-MsgGUID: wILnpVV2R+W0K7eKMnngIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4377196"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4377196"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:46:36 -0800
X-CSE-ConnectionGUID: Leh/wT4iSS2fbKldD79aCQ==
X-CSE-MsgGUID: qYBeCo/5QjSHPyzSn0XYww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11892453"
Received: from ubu2204-pxg.bj.intel.com ([10.238.152.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:46:34 -0800
From: Xiange Pi <xiange.pi@intel.com>
To: Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] exec: annotate lockless tsk->comm update with data_race()
Date: Tue, 24 Nov 2026 16:38:48 +0800
Message-Id: <20261124083848.1430527-1-xiange.pi@intel.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KCSAN reports a data race between prctl(PR_SET_NAME) and a lockless
reader of tsk->comm such as the sched_stat_runtime tracepoint:

 BUG: KCSAN: data-race in __set_task_comm / strlen

 read to 0xffff88800d1787d8 of 1 bytes by task 3929 on cpu 1:
  strlen+0x19/0x40
  trace_event_raw_event_sched_stat_runtime+0x5a/0x150
  update_se+0x14f/0x3b0
  ...
 write to 0xffff88800d1787d8 of 10 bytes by task 3417 on cpu 0:
  __set_task_comm+0x78/0x180
  __se_sys_prctl+0xcb3/0x13b0

The race is benign by design: since commit 3a3f61ce5e0b ("exec: Make
sure task->comm is always NUL-terminated") the last byte of comm is
never overwritten with a non-NUL value, so lockless readers see at worst
a mix of old and new name. Annotate the writes in __set_task_comm()
with data_race() to tell KCSAN that the lockless access is intentional.
As nearly all updates of comm go through this function, this covers the
lockless readers without having to annotate each of them.

Reported-by: syzbot+98baf51f5cc36dcbe2f7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=98baf51f5cc36dcbe2f7
Signed-off-by: Xiange Pi <xiange.pi@intel.com>
---
Test environment:
  - Baseline: torvalds/linux.git (git://git.kernel.org/pub/scm/linux/
    kernel/git/torvalds/linux.git) commit fc1c25014ff8, with and
    without this patch
  - Kernel config: the .config provided on the syzbot bug page
    (CONFIG_KCSAN=y)
  - Method: QEMU guest, running syz-execprog and syz-executor with the
    reproducer in the background, plus a script that enables the
    sched_stat_runtime tracepoint
  - Without the patch: "KCSAN: data-race in __set_task_comm / strlen"
    reproduced in every run
  - With the patch: not reproduced in 10 out of 10 runs

 fs/exec.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a5269b5e00df..4b03bb2fcb95 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1100,8 +1100,16 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 	size_t len = strnlen(buf, sizeof(tsk->comm) - 1);
 
 	trace_task_rename(tsk, buf);
-	memcpy(tsk->comm, buf, len);
-	memset(&tsk->comm[len], 0, sizeof(tsk->comm) - len);
+	/*
+	 * tsk->comm is read locklessly by many users (e.g. tracepoints,
+	 * printk). comm[TASK_COMM_LEN - 1] is never written with a non-NUL
+	 * byte, so concurrent readers see a bounded, NUL-terminated string;
+	 * at worst a mix of the old and new name. Mark the update as
+	 * intentionally racy.
+	 */
+	data_race(memcpy(tsk->comm, buf, len));
+	/* Same as above: lockless readers tolerate a partially updated comm. */
+	data_race(memset(&tsk->comm[len], 0, sizeof(tsk->comm) - len));
 	perf_event_comm(tsk, exec);
 }
 
-- 
2.43.0

