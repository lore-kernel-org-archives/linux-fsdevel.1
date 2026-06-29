Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B0441166B;
	Mon, 29 Jun 2026 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739028; cv=none; b=ei4bgSHfqAu3E5/CTDYIQ7LVNTSn1t8F6Jcltu2Qaku1zzWlqMs+IZv/l+nXCBT19kuBPIbbPUdIqZIaqPpkVS/kXFkwiEew7AmxvTU2hfBYFD37RtPAW2OCt517swR55MrkGMiIQwHGq0E8fvAqhrM21hkZ6Oy1RFYMuCZnoy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739028; c=relaxed/simple;
	bh=usjwmwe1NPGAOIizfdUcxvXq/lNzhW5HlgiBwmhWZx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwKfZPVuK6P5JYNfZHiIMl1UCraxmhswgRI79txUnIrm90SY1sgTfdICXEKCx4z/DLvETnzdjBHpa+0xG0Q8A3BuDdIp11Ag2PlDz6UXspRVqaQD3ybQwgV5weof0F/AXZnuooyI1KE1/iZONEtouAN3jH5ZNC2scWVGuQeQpNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gpmyb0l7mzKHMLc;
	Mon, 29 Jun 2026 21:16:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8D2D840574;
	Mon, 29 Jun 2026 21:17:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCHWodMcEJq7PD9AA--.51645S4;
	Mon, 29 Jun 2026 21:17:01 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: hirofumi@mail.parknet.co.jp,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huaweicloud.com
Subject: [PATCH] fat: reject name longer than NAME_MAX in msdos_format_name()
Date: Mon, 29 Jun 2026 21:09:43 +0800
Message-ID: <20260629130943.3671939-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCHWodMcEJq7PD9AA--.51645S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uryrGFW3Gr1rAFW5Jr1fZwb_yoW8CFWkpF
	WFkF9rt3yxKry7uF1DZay8Z340vws3XF13twn3Z342y345uFy5uryrKw1jgrZ7G34rWF12
	qFs8try5JFyUta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

msdos_format_name() performs no upper-bound check on the input name length.
It silently truncates an arbitrarily long name into the 8.3 form (11 bytes)
and returns success. The subsequent fat_scan() then matches only against
these 11 truncated bytes, so it returns an inode as long as any entry with
the same 8.3 name exists on disk.

For example, passing a 300-byte name of all 'A's returns 0 with res set to
"AAAAAAAA" (8 'A's + 3 padding spaces), reporting success for a name far
longer than NAME_MAX.

As a result, when a user calls open() on a path component longer than
NAME_MAX (255) bytes, the VFS only enforces PATH_MAX, not the length of an
individual component. The dentry keeps the original long name but gets an
inode attached and becomes positive. Later in vfs_open() -> fsnotify_open()
-> fanotify_info_copy_name() triggers WARN_ON_ONCE(), and the event is
reported to userspace with an empty name.

vfat is not affected, as create goes through xlate_to_uni() which refuses
names longer than FAT_LFN_LEN.

Fix this by checking 'len > NAME_MAX' at the entry of msdos_format_name(),
the single entry point for all msdos name handling, aligning with the
NAME_MAX check that xfs/9p/ceph/simple_lookup() perform at lookup.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/fat/namei_msdos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 0fd2971ad4b1..c93e05d35ef8 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -27,10 +27,13 @@ static int msdos_format_name(const unsigned char *name, int len,
 {
 	unsigned char *walk;
 	unsigned char c;
 	int space;
 
+	if (len > NAME_MAX)
+		return -ENAMETOOLONG;
+
 	if (name[0] == '.') {	/* dotfile because . and .. already done */
 		if (opts->dotsOK) {
 			/* Get rid of dot - test for it elsewhere */
 			name++;
 			len--;
-- 
2.52.0

