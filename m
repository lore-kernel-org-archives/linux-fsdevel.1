Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A6736C5A9
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 03:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786419425; cv=none; b=bSPD9+7nc2YTMUe4rcAxSRXmaR9Ipt4UyfE8YNsOWXYCXb50/J5ynnkLXKdK1ish5qTJAIg36V+dV7LOU1Na2yVWY+kmffRBQrTW1o6yAYAH0ufLNptqdnguGiSWn5ZsQEc6dTE2pnI1uJZO0R9LzQlVoTZb3aBY1ztyoOyFeBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786419425; c=relaxed/simple;
	bh=bWR4KnznzFNDQRt5mfMCgZm4Zm2R+XatTiiCOHYxjx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XSJnZWaqno8avGjgtlKiaWWQ758GMEAPWHNFKGDG4hCX+pDm7d/+nRgTeSW0Zk8qbO6kikjubGLynbe8T1fPJmVnpNLdrZLwX+y2aKi7knrk7AJWQak/aID/BITDdetzL/RSimBilSxTIJOLJR8XM+7hj9YCmx8VIDAqmMvxEP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QADIpN8J; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QADIpN8J"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786419411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3rmW+tHa6kovhH6yy177yV/pA5fI2DQqyj8ArGhMWDg=;
	b=QADIpN8JxDQrtlOR105KV7dV83Aqxk9jlF9GvAE5AtX+AS2UoxLPzvTKnQMtlHXBVlbizm
	5ZTTh3MFXu/2TgDR9L9wR+/KVcSEw0IOBFyiv7NdDxmIIciougrn3hd/De1N0MJIC6xFk1
	2Z4b9HStb+7CT7beqHooD/ItS1O8oO0=
From: Ye Liu <ye.liu@linux.dev>
To: Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/oom_kill, proc: replace magic number 1000 with OOM_SCORE_ADJ_MAX
Date: Tue, 11 Aug 2026 11:36:08 +0800
Message-Id: <20260811033609.3992348-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

In oom_badness() and proc_oom_score(), the oom_score_adj normalization
uses a hardcoded 1000, which is the value of OOM_SCORE_ADJ_MAX defined
in include/uapi/linux/oom.h.  Other code in the kernel (e.g.
fs/proc/base.c oom_adj handling) already uses OOM_SCORE_ADJ_MAX for
the same purpose.

Replace the magic number with the macro for consistency and
readability.  No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 fs/proc/base.c | 3 ++-
 mm/oom_kill.c  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6a39de424f62..58be38942460 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -594,7 +594,8 @@ static int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
 	 * exporting for a long time so userspace might depend on it.
 	 */
 	if (badness != LONG_MIN)
-		points = (1000 + badness * 1000 / (long)totalpages) * 2 / 3;
+		points = (OOM_SCORE_ADJ_MAX +
+			  badness * OOM_SCORE_ADJ_MAX / (long)totalpages) * 2 / 3;
 
 	seq_printf(m, "%lu\n", points);
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5f372f6e26fa..08bff7a55db8 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -230,7 +230,7 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
 	task_unlock(p);
 
 	/* Normalize to oom_score_adj units */
-	adj *= totalpages / 1000;
+	adj *= totalpages / OOM_SCORE_ADJ_MAX;
 	points += adj;
 
 	return points;
-- 
2.25.1

