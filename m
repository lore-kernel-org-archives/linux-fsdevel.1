Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B22D238A;
	Thu, 23 Apr 2026 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776927835; cv=none; b=rF/qiqL4olVyRpmBf0TdYbvREgWA8Icpl65xk43WOxg6X+Zynn0JBI8fFWE1a6clb5B4EIh8rYYFr2rC9t+zn1gopAVQsYXSfax7HQH+RbGw1lmM7VRFwbduDa5Gzo1gpPbfzhWB96iLT5S8hAZRpVIqhmZehvMdOOjotYOeiT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776927835; c=relaxed/simple;
	bh=YLYU8XfQw1ShZha/3LAE4XUUIXuxyEoIlVbIlIaxSrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwTjl1WOFKlsPEBY/0rAAxymOntAALfcQwz4m94hoYVkVlnrs8gmkOaBO898aS8wqZLaAd4q7vs2i/1AVSXOhidltPwkYyRmHn5P2kURv7IGwTmeSeBT5s8Q5f1ziuXQVmQfUfFB4F2EveY0AqzTFAWYi2RIKCBhvoWDwtV4TS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AiiMhJ+j; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AiiMhJ+j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=jZ
	DM/MPL4KN6SxEBTt3RvBNteI30ONR7LBkpXjDMaaU=; b=AiiMhJ+j81wG8sn4bM
	4ZDGVAZgWngP+KlsjXQ7XrX+M05XmiiiJcVOR58ChQdRzSe4XzI/9U94gdOVzZmF
	8qQ+VCg3M7EFg3XSpxSULncLe4zPXaCpIaPa+tAQA9u/ZNZJ3JXss2Ym0xSrWhkb
	oB1Zrp/J72GkpPnu7oxqGR+qY=
Received: from liubaolin-VMware-Virtual-Platform (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBX_3mswulp1DMzBQ--.23039S2;
	Thu, 23 Apr 2026 14:56:45 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: corbet@lwn.net,
	skhan@linuxfoundation.org,
	surenb@google.com,
	cyphar@cyphar.com,
	witcher@wiredspace.de
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	liubaolin12138@163.com,
	wangguanyu@vivo.com,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v1 v1] Documentation: proc: fix ext4 section numbering in table of contents
Date: Thu, 23 Apr 2026 14:56:42 +0800
Message-ID: <20260423065642.11218-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBX_3mswulp1DMzBQ--.23039S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWfGF17KFyUur1xAw45Awb_yoW8Xry8pF
	WrAr1agw18GF1UWw17Ar4xWrW7Aa4Ika1jqa9F9r1ftrn8Z3sa9w13t3W5AFy8GryrAayF
	qFs7Kryavr47AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6Q2we2npwq28-AAA3A

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

