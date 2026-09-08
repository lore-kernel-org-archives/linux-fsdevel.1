Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166EC52E06F
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870454; cv=none; b=AehLi1DP3m0ceR9NfomR/97DSogr/PIf7QCiHMN0hhFOU5LTpHGO03w7BXhc7D+IEVoIhBcH4AMQ0YKZchoy1BBwjF8Dr3F6NEbgAeCYr+s/dPahYaeAfBChdiP8RCthHxiZrP3YriYovR+RXjTV2ceAkqACPEniY+1w0p5V8Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870454; c=relaxed/simple;
	bh=CAWNFS566Mb/PBl/Fdw1exjQuJBSVd6ATh2wTNizWAs=;
	h=To:Date:Mime-Version:References:From:In-Reply-To:Content-Type:Cc:
	 Subject:Message-Id; b=ejwKEVQNNjEhOCWxhOAMav2cok3IZqOXVU7k7XetM9ZZ3+ZUEyLsBzW9WiXRD7phtM45sYWujP/C6Ko/sKSO+LCMIp1PmhnYrn9bSL1qtduw9mS4siqJsUptZ2IlQ1KpB5jq82ta1fYUKVaKaYlJ0D7nkG0hjlSgB9qy2amHtgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KMSJRMcv; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KMSJRMcv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788870448; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=oU1SN1evCfMvWApaJ8Az3rYN4gJaNSTnoUYsE3H6ZNc=;
 b=KMSJRMcvibOHpw8yDZ/5L3eGliGjEvwsRLTvMG1iHf0zZOuoP5fLgWAKpBY6lfOMOsqk1o
 077FfQ0obyIDZ/tdPbKrSlIUfrkvUPdnmtFLiP0q9k790PmQWInmdwlmlf3mCXDYWWpJJP
 LL1GaXUzUJWTi+OlkH4CwPz/PHM6NlEFmF2s4m9M1lqZazeCZuWA2xeGf/vRc2TVwLePE+
 WVqQVGHSIOeP1vUF5kT/OzBfsU3KadMipgUOuBRBx3/xFnEYXTtKd2EIrhK+YBMDb0qZL3
 blcbRk+GRYYJY5ReT/MfD/aXQbSOSc0r+UpoVy3MgljgbQOdwYCVsnEMGnbo+A==
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>, 
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>, 
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>, 
	<vschneid@redhat.com>, <kprateek.nayak@amd.com>
Date: Tue,  8 Sep 2026 20:24:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908122446.56708-1-lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260908122446.56708-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>, 
	<linux-doc@vger.kernel.org>, <lizhe.67@bytedance.com>
Subject: [PATCH 4/4] Documentation: Describe per-process NUMA balancing control
Message-Id: <20260908122446.56708-5-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a9fff2e+f29522+vger.kernel.org+lizhe.67@bytedance.com>

Document the PR_SET_NUMA_BALANCING and PR_GET_NUMA_BALANCING operations
near the kernel.numa_balancing sysctl documentation, and describe the
NumaB_mode field in /proc/<pid>/status.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 16 ++++++++++++++++
 Documentation/filesystems/proc.rst          |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index b6328cd0f43e..7f665c28828a 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -754,6 +754,22 @@ different types of memory (represented as different NUMA nodes) to
 place the hot pages in the fast memory.  This is implemented based on
 unmapping and page fault too.
 
+The ``PR_SET_NUMA_BALANCING`` and ``PR_GET_NUMA_BALANCING`` prctl(2)
+operations can be used by a process to opt out of automatic NUMA balancing
+or re-enable participation for the whole thread group.  Any thread in the
+thread group may change the process setting.  The setting is inherited by
+fork(2), is shared by threads created with clone(2) ``CLONE_THREAD`` and is
+preserved across execve(2).  The global ``numa_balancing`` sysctl remains
+the top-level control: a process-level enable does not turn automatic NUMA
+balancing on when it is disabled system-wide.  Memory policy still applies,
+so the process setting does not make VMAs participate when their policy
+prevents automatic NUMA balancing.
+
+Disabling the process setting stops scheduling new periodic NUMA scans for
+that process. Existing NUMA hinting PTEs and already queued work are not
+actively cleared and may still drain naturally as the disabled state takes
+effect.
+
 numa_balancing_promote_rate_limit_MBps
 ======================================
 
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index c102b62023cd..a4e9037a3161 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -188,6 +188,7 @@ read the file /proc/PID/status::
   HugetlbPages:          0 kB
   CoreDumping:    0
   THP_enabled:	  1
+  NumaB_mode:     enabled
   Threads:        1
   SigQ:   0/28578
   SigPnd: 0000000000000000
@@ -274,6 +275,11 @@ It's slow but very precise.
  THP_enabled                 process is allowed to use THP (returns 0 when
                              PR_SET_THP_DISABLE is set on the process to disable
                              THP completely, not just partially)
+ NumaB_mode                  process automatic NUMA balancing mode:
+                             enabled or disabled when supported, otherwise
+                             unsupported; the effective behavior also depends
+                             on the global numa_balancing sysctl and memory
+                             policy
  Threads                     number of threads
  SigQ                        number of signals queued/max. number for queue
  SigPnd                      bitmap of pending signals for the thread
-- 
2.20.1
