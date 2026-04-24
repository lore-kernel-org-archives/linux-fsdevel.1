Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F4038910E;
	Fri, 24 Apr 2026 09:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021704; cv=none; b=ObS3T5f6QXqB0lqUsM8LqqWkb6IjnL3grsiRSXxQqeXBVXZZq75hlkVc/DUMheQyfoc+wTbz/06ffO1GwYAie72zUru5hlMRvHyLi5cpSV3trsxv91WpCg4alSL3rvcwd4t4dzgCMTgQ1xSKunMpOYfQfTsKF2MjGAUOLuf8fjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021704; c=relaxed/simple;
	bh=YLYU8XfQw1ShZha/3LAE4XUUIXuxyEoIlVbIlIaxSrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JG2SVxMl38LDsiPyGt3if2ExptpygxXyT/9dnDSIwKWyKpHpua8YSiuSfDYfzddvXOCKZwrBMPn4zrSRJLhAVLuDS5bEfbpnCL/4Yb6AtT4ZfQEwtkSuyCCog/FV7vNLgGq/3pDPOcQhTJYqoJDSnojOK+B7UKtKT2xkVeUXrjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GXrWdr4R; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GXrWdr4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=jZ
	DM/MPL4KN6SxEBTt3RvBNteI30ONR7LBkpXjDMaaU=; b=GXrWdr4RuHBIn1547y
	ovmOC82hUJe77xr5aNgsT8EJIysedKavU3IEohE9TCKywTlx4M2EkPftUeVf8bhP
	2wxdTPEMW75WG2TkBTwboYVlxNn79ARMU4oAFFvHAV57HftEB9KZ8zjLTykOwICy
	tbAFhjxa3wjNGjMGEU+T7t/io=
Received: from liubaolin-VMware-Virtual-Platform (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wA3fjuxMutpJmUNBg--.54442S2;
	Fri, 24 Apr 2026 17:06:58 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: corbet@lwn.net,
	skhan@linuxfoundation.org,
	cyphar@cyphar.com,
	vbabka@kernel.org,
	surenb@google.com,
	rdunlap@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v2 v2] Documentation: proc: fix section numbering in table of contents
Date: Fri, 24 Apr 2026 17:06:54 +0800
Message-ID: <20260424090654.19229-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3fjuxMutpJmUNBg--.54442S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWfGF17KFyUur1xAw45Awb_yoW8Xry8pF
	WrAr1agw18GF1UWw17Ar4xWrW7Aa4Ika1jqa9F9r1ftrn8Z3sa9w13t3W5AFy8GryrAayF
	qFs7Kryavr47AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbAwsUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwhIO2GnrMrK28wAA3B

From: Baolin Liu <liubaolin@kylinos.cn>

Commit e24ccaaf7ec4 ("block: remove last remaining traces of IDE
documentation") removed the IDE section but left its table of
contents entry behind.
Fix the stale entry and renumber the following sections.

Fixes: e24ccaaf7ec4 ("block: remove last remaining traces of IDE documentation")
Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 Documentation/filesystems/proc.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 7ce02573a3d9..70db35987ee1 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -23,13 +23,13 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
   1	Collecting System Information
   1.1	Process-Specific Subdirectories
   1.2	Kernel data
-  1.3	IDE devices in /proc/ide
-  1.4	Networking info in /proc/net
-  1.5	SCSI info
-  1.6	Parallel port info in /proc/parport
-  1.7	TTY info in /proc/tty
-  1.8	Miscellaneous kernel statistics in /proc/stat
-  1.9	Ext4 file system parameters
+  1.3	Networking info in /proc/net
+  1.4	SCSI info
+  1.5	Parallel port info in /proc/parport
+  1.6	TTY info in /proc/tty
+  1.7	Miscellaneous kernel statistics in /proc/stat
+  1.8	Ext4 file system parameters
+  1.9	/proc/consoles - Shows registered system consoles
 
   2	Modifying System Parameters
 
-- 
2.51.0

