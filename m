Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F42FE596
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772161040; cv=none; b=T24hkwCpixxrLUfZGoTMsrocZnwq1JMhIgknNLJ1FoCUJMuBr/6X+B/0psXlnN6DTUyukGkQPW2XMoom61hUF2Bk3eeL31LO576aj4SVHu+DGW7V6bgFCnxUrKojCeLyxnTFdK+TJHI4aLdmLJRIPZmPJl6IxBaOH1vC3wra/Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772161040; c=relaxed/simple;
	bh=IMB/WNlvgG/KqItUDfSrW+6x5oBguOJRjkDAVKAJ27U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZmvpHK09fM7m8AG/BuJJ85to0tNShHN6HLu/eXyg16GPGSURkf4+bIiQk1hdS+qcD3ufzAl2pWKNsp6KwV2Qx9cbPZsmi+1Y+5TP8c+EZegSoccIcN5P5RPXinsrKWmpyUbYVhwaL1DOpRmJ4RZWJnOslBCTAs9CQqhXlsy51Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fMXym6ry3zKHMSp
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 10:56:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3772240575
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 10:57:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP4 (Coremail) with SMTP id gCh0CgBXuPgJCKFpsEGdIw--.32070S7;
	Fri, 27 Feb 2026 10:57:15 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-mm@kvack.org,
	yebin10@huawei.com
Subject: [PATCH v3 3/3] Documentation: add instructions for using 'drop_fs_caches sysctl' sysctl
Date: Fri, 27 Feb 2026 10:55:48 +0800
Message-Id: <20260227025548.2252380-4-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227025548.2252380-1-yebin@huaweicloud.com>
References: <20260227025548.2252380-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXuPgJCKFpsEGdIw--.32070S7
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW3Gw18ZrWDZw15WF4fuFg_yoW5JFWrpF
	ZrAryIgw18Xay3WrnxXr47tFyfXay8JFy0q3s7Kr1rZw15CFyj9rsFyw4YqFy7GFW8C3yI
	qrW5Kwn8Ww1DtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOGQ6
	DUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

Add instructions for 'drop_fs_caches sysctl' sysctl in 'vm.rst'.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 44 +++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 97e12359775c..76545da53e20 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -37,6 +37,7 @@ Currently, these files are in /proc/sys/vm:
 - dirtytime_expire_seconds
 - dirty_writeback_centisecs
 - drop_caches
+- drop_fs_caches
 - enable_soft_offline
 - extfrag_threshold
 - highmem_is_dirtyable
@@ -286,6 +287,49 @@ used::
 These are informational only.  They do not mean that anything is wrong
 with your system.  To disable them, echo 4 (bit 2) into drop_caches.
 
+drop_fs_caches
+==============
+
+Writing to this will cause the kernel to drop clean for a specific file system
+caches, as well as reclaimable slab objects like dentries and inodes. Once
+dropped, their memory becomes free. Except for specifying the device number
+or file path for a specific file system, everything else is consistent with
+drop_caches. The device number can be viewed through "cat /proc/self/montinfo"
+or 'lsblk'.
+
+To free pagecache::
+
+	echo "1 MAJOR:MINOR" > /proc/sys/vm/drop_fs_caches
+Or
+	echo "1 /mnt/XX" > /proc/sys/vm/drop_fs_caches
+
+To free reclaimable slab objects (includes dentries and inodes)::
+
+	echo "2 MAJOR:MINOR" > /proc/sys/vm/drop_fs_caches
+Or
+	echo "2 /mnt/XX" > /proc/sys/vm/drop_fs_caches
+
+To free slab objects and pagecache::
+
+	echo "3 MAJOR:MINOR" > /proc/sys/vm/drop_fs_caches
+Or
+	echo "3 /mnt/XX" > /proc/sys/vm/drop_fs_caches
+
+You may see error messages in your kernel log when incorrect path or device
+number provided::
+
+	echo (1234): drop_fs_caches: failed to get path(/mnt/XX) ERRNO
+Or
+	echo (1234): drop_fs_caches: failed to get dev(MAJOR:MINOR)'s sb
+
+You may see informational messages in your kernel log when this file is
+used::
+
+	echo (1234): drop_fs_caches: 3 MAJOR:MINOR
+
+These are informational only. They do not mean that anything is wrong
+with your system. To disable them, echo 4 (bit 2) into drop_fs_caches.
+
 enable_soft_offline
 ===================
 Correctable memory errors are very common on servers. Soft-offline is kernel's
-- 
2.34.1

