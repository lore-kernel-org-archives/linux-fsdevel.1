Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40D638C2A1
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773213014; cv=none; b=If/q2Gy/4nLWmk3SP55+NcA+fobzKAz1CUVEXiy0ccT5jV5S/1KzIdcXu4Eo+hWWK5llI2ctwj53Zx4JLjht+kSfkgMK9QDKUMT7AHg6EOF01e7Sc10Eeo0IcFZFGzLKv/xNvgbOMHSx1VnWxHRn+zVWOxClURaIKIxVb+k3eB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773213014; c=relaxed/simple;
	bh=tth2sDeYYs4wv3bFHLXcOGrGwqFIeU4s7rHmM4Da0Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUfo+2vMvzJznWunslJvBZPjaVzPHlIkM7yjuie04tDB521L5Yo1gyxFJIAq+C7gI3CSOZJSA5RxtbYJroq/MI/dP5VhfQLcXefoEUrBiV3U6fY2dEcXCjgq5Zv+dyvI6YStMedTwtSC+vB/Rxsl9uI1mcjKpk5NLFFf2PjOVJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pqtK713F; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pqtK713F"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773213010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LLwzKZ2PI4LHLWSyi3YiUSoKijuVeO/Lb89MwFsYc4c=;
	b=pqtK713FeBwvM0YhcPJIv/xNqGZZC/p/o3B3iM0enbhqyfxCMQhylBrbe5PBYPXaaYvJL8
	RS7BCS9k/nhGLu+0z/V8jD2NyHoZv3VU3IfzmShrLqTKP7/remb3jOLWyTMPG8T4WigtlY
	vTUHPpuPmFL7b++GEmtZH++f3JBgsGc=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	"Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
Subject: [PATCH] docs: proc: remove description of prof_cpu_mask
Date: Wed, 11 Mar 2026 15:09:40 +0800
Message-ID: <20260311070940.94838-1-zenghui.yu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>

Commit 2e5449f4f21a ("profiling: Remove create_prof_cpu_mask().") said that
no one would create /proc/irq/prof_cpu_mask since commit 1f44a225777e
("s390: convert interrupt handling to use generic hardirq", 2013). Remove
the outdated description.

While at it, fix another minor typo (s/DMS/DMA/).

Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
---
 Documentation/filesystems/proc.rst | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index b0c0d1b45b99..9a943b9f20ee 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -727,7 +727,7 @@ files are there, and which are missing.
               in the kernel image
  cpuinfo      Info about the CPU
  devices      Available devices (block and character)
- dma          Used DMS channels
+ dma          Used DMA channels
  filesystems  Supported filesystems
  driver       Various drivers grouped here, currently rtc	(2.4)
  execdomains  Execdomains, related to security			(2.4)
@@ -861,14 +861,13 @@ i386 and x86_64 platforms support the new IRQ vector displays.
 Of some interest is the introduction of the /proc/irq directory to 2.4.
 It could be used to set IRQ to CPU affinity. This means that you can "hook" an
 IRQ to only one CPU, or to exclude a CPU of handling IRQs. The contents of the
-irq subdir is one subdir for each IRQ, and two files; default_smp_affinity and
-prof_cpu_mask.
+irq subdir is one subdir for each IRQ, and default_smp_affinity.
 
 For example::
 
   > ls /proc/irq/
-  0  10  12  14  16  18  2  4  6  8  prof_cpu_mask
-  1  11  13  15  17  19  3  5  7  9  default_smp_affinity
+  0  10  12  14  16  18  2  4  6  8  default_smp_affinity
+  1  11  13  15  17  19  3  5  7  9
   > ls /proc/irq/0/
   smp_affinity
 
@@ -899,9 +898,6 @@ The node file on an SMP system shows the node to which the device using the IRQ
 reports itself as being attached. This hardware locality information does not
 include information about any possible driver locality preference.
 
-prof_cpu_mask specifies which CPUs are to be profiled by the system wide
-profiler. Default value is ffffffff (all CPUs if there are only 32 of them).
-
 The way IRQs are routed is handled by the IO-APIC, and it's Round Robin
 between all the CPUs which are allowed to handle it. As usual the kernel has
 more info than you and does a better job than you, so the defaults are the
-- 
2.53.0

