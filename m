Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3613FCB10
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 06:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763312; cv=none; b=fpLpGlbSiVKb6p6KA00wuSYgydjzn1gju5J9xl7AcaOQHKuutzTVy4h/PF9Rb7NiVzgjpz38epEZVJZtVAUHqVZd6T1BRfVJ2vsUKosPa7PKYN5yYl3EnGFLV0ZvIlFPS0bUr994ANP/6bvs8mNpB+MW3+eIZNvN6oSTusXh084=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763312; c=relaxed/simple;
	bh=eafPgUhy9IynSAtvFbXAit1hK6ESnxmns9zqLM/jKZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGKrPk2x4trXunmh1/igiiPVmdivSQMqsnyjQepWjruZqKCa6mJ9ODnZM3ACFe6+41wOqa56yZDM4t8fL+dqqwxAwAQMEZITO33hLz9L0ohN+wnC68H8tmBId0s3lWlLE0UyYM+AVR5GH7p4ivLK+iO1yHCJib516uSEWLnMK6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+xAe+Bo; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+xAe+Bo"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1bcdb3c4cso2093659a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Sep 2026 23:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763309; x=1789368109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AeK2I1AiWRpjY7VAGe4JrwBL3S2TxoFeFpHn4sVFSG4=;
        b=e+xAe+Bo0nwJI5oTNV94ciTCBgdy2KejrvEjAMDuSqgoRVOI64A62mILLxFCvhC1aZ
         /PRTqjm6Gj29RCLscxvM0fGwb+xKx//LzPP/4mVB0VGPonwPvyqXFHv8YvjV/7+2zwB2
         AMj482hST5UTYoQCQg/Co3sNVhYpGvAjhTtde3s/wJxjp2MOiIs8Xk0aiFUehuX/1kbA
         qaHTUg0eaSbyHGCNjWZhH+ukQoqA1sHk8IfOuXcdk3yIeU/fqiQbkqSiehgY8S96JXNp
         44klfgp+18i0gQWBXAiTlQH4vVvwIvFlGKo2x50shy4PomIN+0RcaWir+25YhLS86Bo2
         7p3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763309; x=1789368109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AeK2I1AiWRpjY7VAGe4JrwBL3S2TxoFeFpHn4sVFSG4=;
        b=huslhwBDsxxfVMruwKhECf2RZ+c3xVOsxOHoStQqc/MmAD5OnWiMJ0rMarWKRTQiik
         NO0xzrgEktif2UMbsyUuACi5GnyQWTZwvfeRjWkDYdkIkUDOe4FeqM5w9byv53+qW6oK
         OhgadLQoAgRjwZQgtfBQY4zVfo1UkxgeYsqFejK1xYJKKtL8Vh+UjNsVlM9O/gWQMbXe
         47+w4tb+YIabjOMbzzB+0hakPRdQUZB4tmWx70IzmsPCWnAIejl9jesXq8roPJf9uQZV
         Hmjf2Js4xpBlRZcNI03K7B0m0RqoBrzRhWrQUUTXcu95ulAP+J9GPad3McDJuTpX3YDJ
         vuOg==
X-Forwarded-Encrypted: i=1; AKwUvByWONwuMyTM0/gfA/n/xboEOhsx7jJTybcufMmLYisDVlcQ4YTw6KGoRE9/AphrQsv5lp5iqg0DC1KBO980@vger.kernel.org
X-Gm-Message-State: AFuF++masvEyc7sMDymqIJGpqMFmO8f5CjMUuWihtnbTnH9/HTLQEmZ+
	Sl0Si4alBK59j8a4QDtKfkiIC0LliGrKdPAffGhtA6ux/XlgwXdtB1tO
X-Gm-Gg: AYBFou2CIm+un14Gi20P2WKur6z4fU8imDF2XPP0q0BtsJySPxiPGR/UM6Mveko3IGQ
	cpc8pVNHBSBuqoau685MJDWRpO7Os0EODElqS/YpP2DfTxOASoJ8dw9mxfeVe+XIKmNo1fVKtwj
	0EhEXELi4fRwuhJW65N5BoN9NONPnjML/l+Qp5zQM3vn3OQMALftfPSxMjSdhcYmOs2gf1fehKi
	c+x9dGvEHIiQSw89rwlLQ+CxA0QxPBebg1oHjQstByJ5O7mca1tkN91PVKBOxUmm/Wa1jqgcnE5
	DPLKJ0pL07/APokKi/WrXDvsWDWpgSPBrOJ+UZ4gIfFtD2I8IBl3orIQ0iD+ABqkk7DTCmel3c0
	VnVCE9z41pDfcQtYuWG3+boRNmmwTKlFzgsWTPgOpLSQF5MLU45TAGmsvYhGw2LXQEAhHEQL8ws
	CJKcQc7KQqrnz9A0OBsS/52Ahyv4dJeRj7k/E9KpM9q/yVt3lqcDyd2uKO7hbS7FPbdCxKGz+ty
	NGTXoHkpAbsINYribt7g8GD
X-Received: by 2002:a17:90b:2808:b0:398:b46d:48c0 with SMTP id 98e67ed59e1d1-39b262aaeb7mr33803957a91.18.1788763309146;
        Sun, 06 Sep 2026 23:41:49 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143240d86c3sm22413038c88.0.2026.09.06.23.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:41:48 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	x86@kernel.org,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Ming Lei <tom.leiming@gmail.com>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] selftests: fix typos in comments
Date: Mon,  7 Sep 2026 12:11:37 +0530
Message-ID: <20260907064138.38689-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064138.38689-1-hemanth.selam@gmail.com>
References: <20260907064138.38689-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/testing/selftests/amd-pstate/tbench.sh | 4 ++--
 tools/testing/selftests/proc/setns-dcache.c  | 2 +-
 tools/testing/selftests/proc/setns-sysvipc.c | 2 +-
 tools/testing/selftests/resctrl/resctrlfs.c  | 6 +++---
 tools/testing/selftests/ublk/kublk.h         | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/amd-pstate/tbench.sh b/tools/testing/selftests/amd-pstate/tbench.sh
index 2a98d9c9202e..b54b9d0396a1 100755
--- a/tools/testing/selftests/amd-pstate/tbench.sh
+++ b/tools/testing/selftests/amd-pstate/tbench.sh
@@ -103,7 +103,7 @@ parse_tbench()
 	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-energy-$1-$2.log)
 	printf "Tbench-$1-#$2 power consumption(J): $en_sum\n" | tee -a $OUTFILE_TBENCH.result
 
-	# Permance is throughput per second, denoted T/t, where T is throught rendered in t seconds.
+	# Permance is throughput per second, denoted T/t, where T is through rendered in t seconds.
 	# It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
 	# and t is time measured in seconds(s). This means that performance per watt becomes
 	#       T/t   T/t    T
@@ -161,7 +161,7 @@ gather_tbench()
 	avg_en=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-energy-$1.log)
 	printf "Tbench-$1 avg power consumption(J): $avg_en\n" | tee -a $OUTFILE_TBENCH.result
 
-	# Permance is throughput per second, denoted T/t, where T is throught rendered in t seconds.
+	# Permance is throughput per second, denoted T/t, where T is through rendered in t seconds.
 	# It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
 	# and t is time measured in seconds(s). This means that performance per watt becomes
 	#       T/t   T/t    T
diff --git a/tools/testing/selftests/proc/setns-dcache.c b/tools/testing/selftests/proc/setns-dcache.c
index 60ab197a73fc..70389832dd22 100644
--- a/tools/testing/selftests/proc/setns-dcache.c
+++ b/tools/testing/selftests/proc/setns-dcache.c
@@ -50,7 +50,7 @@ int main(void)
 
 	atexit(f);
 
-	/* Check for priviledges and syscall availability straight away. */
+	/* Check for privileges and syscall availability straight away. */
 	if (unshare(CLONE_NEWNET) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
 			return 4;
diff --git a/tools/testing/selftests/proc/setns-sysvipc.c b/tools/testing/selftests/proc/setns-sysvipc.c
index 903890c5e587..d03aa4838f0f 100644
--- a/tools/testing/selftests/proc/setns-sysvipc.c
+++ b/tools/testing/selftests/proc/setns-sysvipc.c
@@ -49,7 +49,7 @@ int main(void)
 
 	atexit(f);
 
-	/* Check for priviledges and syscall availability straight away. */
+	/* Check for privileges and syscall availability straight away. */
 	if (unshare(CLONE_NEWIPC) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
 			return 4;
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index b9c1bfb6cc02..b6d69bf4fc1f 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -517,8 +517,8 @@ int get_mask_no_shareable(const char *cache_type, unsigned long *mask)
 
 /*
  * taskset_benchmark - Taskset PID (i.e. benchmark) to a specified cpu
- * @bm_pid:		PID that should be binded
- * @cpu_no:		CPU number at which the PID would be binded
+ * @bm_pid:		PID that should be bound
+ * @cpu_no:		CPU number at which the PID would be bound
  * @old_affinity:	When not NULL, set to old CPU affinity
  *
  * Return: 0 on success, < 0 on error.
@@ -693,7 +693,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, const char *ctrlgrp, const char *mongr
  * write_schemata - Update schemata of a con_mon grp
  * @ctrlgrp:		Name of the con_mon grp
  * @schemata:		Schemata that should be updated to
- * @cpu_no:		CPU number that the benchmark PID is binded to
+ * @cpu_no:		CPU number that the benchmark PID is bound to
  * @resource:		Resctrl resource (Eg: MB, L3, L2, etc.)
  *
  * Update schemata of a con_mon grp *only* if requested resctrl resource is
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index d98f3d612d88..88248b802c86 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -257,7 +257,7 @@ struct ublk_thread {
 	unsigned short nr_bufs;
 	unsigned short auto_buf_stride;
 
-       /* followings are for BATCH_IO */
+       /* following are for BATCH_IO */
 	unsigned short commit_buf_start;
 	unsigned char  commit_buf_elem_size;
        /*
-- 
2.48.1

