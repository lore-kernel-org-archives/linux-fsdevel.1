Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492EAB640
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357844; cv=none; b=XYW0filC4kuP6UTLd3nj1Ae6efsB5wKeBLwLuOE85VkKUXk9Troq+gqz51imhMm7NLvdcSX94bSCn+bOOVaLVVZkBXn7nz06q7nadiDvXq4H/iANUjOeYLWehEY+c1z/SfxS8+zYtTnDM9s1ixdaG4roif0R+sOvPvYw5/2iqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357844; c=relaxed/simple;
	bh=n+D/Dcp8WAjTCEeW11ShWwxcgK67nFg/1lgxgzVfjDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kVsiiFhLVVYkaMpId5Qj6IjYcbiH1cqg4lrW5AeELj8o0C1x1OAKvVbJXSo7IduAb9EQKsOmbP6A/S1AQNfj89lE5B+3/pFzUvrH8OcbMNjAJuULDI1hnllfxJX+xp47mzXH4u5NvWWeB+gNnOeli8jGq4kmL3KemBoizphDYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mILM6Pw+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mILM6Pw+"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488c2690057so83457855e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776357842; x=1776962642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BIa43lbzdcbvCbtrNCFTDN2DaMvs51Q6LIwAUTCP1A4=;
        b=mILM6Pw+mwHJ9kfMMsYr2rJNfgoU4P2QMBgL0wU3vfcs4cf6VfnDBrD5XmxjFV2ZPv
         wDBFh/X33dCiUkQQOdiNdJG8OgOAXx+faGiqINXmtUYkGa0iVZlO/JMMT99YZZ23NXju
         jpZHorzW+zcg//1C5atok3Y34hv0qxMnPx50VUm8YcT7Xg1eX71a5U0UlFl+bVIO6MVV
         Rt3phE//1m4iDUiTN0FUs1usYqf9hylI2QitOTasyXgmAaZLyK+wSHmNoi/YJUpHapuQ
         mA0+Igz6FggZ9C9K2526U2r+mOeXNfcXcll2Hz1ZMzcszPsG5iNp87wWsj06oR+bg4SA
         lc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776357842; x=1776962642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIa43lbzdcbvCbtrNCFTDN2DaMvs51Q6LIwAUTCP1A4=;
        b=blvjgGtdAaAPqiR9IyXpm9SIsDUDFCLvdFo/WB1alynP1jfROKA+h4UFEoCDqAGoxv
         EQ6f6CcRsITKHWLip/0PAIUXhNF+5oG6KlQavYklLGgIu8Kj/sHm167W1K5EMnXDIE3k
         JaivrkbHqk9mBPuUAZooLTwbaRqnNVihiXMOJujItM3iJIvVuwK1WXGN5sLG6OozqlIS
         silGh4Y8kgKsTtecHd+q0k/ykWaxlB032+fwLJg7SnoN235YW1yxoNBODsEi8/uKZ/6U
         k8zV7BdlSkuXua2prApHRChovdV6haRhgwEosLH8BVzpsZ4cJz9C7t+7jlOF5d+SeI+K
         V3fQ==
X-Forwarded-Encrypted: i=1; AFNElJ8FQfeL8DyhcFaMvMMmHoUBwIPCmYm3AHJh1wn45WpACQvM/z7SV37We6PCgYOAfqav7VPRsIoS87ZlLosr@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjg0i8cJ5w8IX4iny+aHGv/k7VG4XLm3I2z8CAOzDt6y1SCrw/
	RXjhINovG7Qmunf+eE3252kcXvqdqGQFDdKW9IpPSrC6rZJZjbP7Leo=
X-Gm-Gg: AeBDietrnc6y+QByi+bw3rql9dwCUblbl/DYbxSc2SNY/ijA+Ekn1Mi8ZMhjKXEQ3/D
	HlMRZx1qNLDny7QVErh2+KyglCI4P46w86gz+4jpQX5KWQffIGwqFxaVlRZOLYvbJaUR4EuEvkz
	zJmBn4Q2oi1ESgBTorZ4o3bV2ioz+pcVIMNc45OPSsos4+8CdYDrBxw0qaVBgS2QgpXHrKJaBpy
	ZZDYx6zuWBtTHqI9JSKwGROoLV3orcAN0Vrc7fB+YRoUE66EEMxVrJmwnqQSlUklaD4uoY9X4bT
	s748ucJOK08TT21L5BGrCAEh52ZSNm0M9OxdeWxGiFOdqFEzdHl4Mm9o66JmlkF/8w7I6MCVzfc
	Auk3NqKdYuHq1mCp3z3QaLW82VF65Q2WlSlg2qCMGb90CsNt6zM2kIdH536d7M9UD+s6g8ldeEG
	D+lNaJ++wSkvNDsFKFIVus7Z9v3E9ZMx/ZMQ==
X-Received: by 2002:a05:600c:c108:b0:487:12c:e7e1 with SMTP id 5b1f17b1804b1-488d68539e3mr256362065e9.11.1776357841598;
        Thu, 16 Apr 2026 09:44:01 -0700 (PDT)
Received: from p183 ([178.172.147.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f58163cbsm66810835e9.1.2026.04.16.09.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:44:01 -0700 (PDT)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: adobriyan@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] proc: add tgid_iter.pid_ns member
Date: Thu, 16 Apr 2026 19:45:54 +0300
Message-ID: <20260416164555.77430-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

next_tgid() accept pid namespace as an argument, but it never changes
during readdir (which would be unthinkable thing to do anyway).

Move it inside iterator type and hide from direct usage.
---
 fs/proc/base.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d9acfa89c894..f2db455dbbfd 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3543,8 +3543,10 @@ struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
 struct tgid_iter {
 	unsigned int tgid;
 	struct task_struct *task;
+	struct pid_namespace *pid_ns;
 };
-static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter iter)
+
+static struct tgid_iter next_tgid(struct tgid_iter iter)
 {
 	struct pid *pid;
 
@@ -3553,9 +3555,9 @@ static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter ite
 	rcu_read_lock();
 retry:
 	iter.task = NULL;
-	pid = find_ge_pid(iter.tgid, ns);
+	pid = find_ge_pid(iter.tgid, iter.pid_ns);
 	if (pid) {
-		iter.tgid = pid_nr_ns(pid, ns);
+		iter.tgid = pid_nr_ns(pid, iter.pid_ns);
 		iter.task = pid_task(pid, PIDTYPE_TGID);
 		if (!iter.task) {
 			iter.tgid += 1;
@@ -3574,7 +3576,7 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct tgid_iter iter;
 	struct proc_fs_info *fs_info = proc_sb_info(file_inode(file)->i_sb);
-	struct pid_namespace *ns = proc_pid_ns(file_inode(file)->i_sb);
+	struct pid_namespace *pid_ns = proc_pid_ns(file_inode(file)->i_sb);
 	loff_t pos = ctx->pos;
 
 	if (pos >= PID_MAX_LIMIT + TGID_OFFSET)
@@ -3592,9 +3594,10 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 	}
 	iter.tgid = pos - TGID_OFFSET;
 	iter.task = NULL;
-	for (iter = next_tgid(ns, iter);
+	iter.pid_ns = pid_ns;
+	for (iter = next_tgid(iter);
 	     iter.task;
-	     iter.tgid += 1, iter = next_tgid(ns, iter)) {
+	     iter.tgid += 1, iter = next_tgid(iter)) {
 		char name[10 + 1];
 		unsigned int len;
 
-- 
2.52.0

