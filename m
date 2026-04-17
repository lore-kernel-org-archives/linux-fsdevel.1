Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6ADCA45
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776462602; cv=none; b=tVs0yazCyFryFBpsSch4sqqmaDnA6UeW7ECxFEdbfK0DVU3oHP0v/0zTzwJe10mwvYLoeil9fKTmk3WjdXaIdngdAdt9dWYOTwENGF3tdk5D2aSr2qMD7nPflZg0lNUVz80ucQkDqhCXdV3sfDnQ0U+vEYqfsofyBFt7UiI+4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776462602; c=relaxed/simple;
	bh=uwdaRuJlqqLWO1ARSbKkEDQdBOHxWjsO7CpVq/Hp0HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdGEQDi8VBZzNVRTi5RVVNGoJtKH+mAlgUp2kg+mCC+zfBLu+qhN1Y6/CqTCAr9rwrvXFdXuCLdMomNOCcrjyZvZowlxzbsQlMtS0NopdHIw9spOHHs2mFP/pfXh0ypfwi81IElsL5T/4USBhEPMiav6WmYA3Q/0KXlJaTmM2bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=CXTV/gU1; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="CXTV/gU1"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79a46260385so12166807b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 14:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1776462600; x=1777067400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9lw53x2B/WFMjhVIcmq2SE67xL846MbI1e+oYyMRRA=;
        b=CXTV/gU17hB19RezwWX7WrpFKVDP8vA1DgbgbT2zWduU/uQ8fzf9DPvouLo/R/6uok
         VKpfbctUJtYpUBWOjred+EdcPGbYygg0NaSFD4I2BbeDd7MyfypsJWuwX+DzlIK0nMB8
         MBEghuHlk7aphtvSTszu9UODiVxYvEgbHdihG2uEYnVt/cam0pzD2Awsr0WuzXzV3/Ny
         VCXG1fsy22Rebj4MBa9AnB6QYwoB+B0cMVzPwvkH5wasT80NdGrZ4pgclrR4T/gjnyvJ
         7B53Bg8JbDEV5cTh2PIDX8Sfd9IGdTRqt+tSvvuIYKBBkAQSn7390J+1MIBVU/iEpISX
         tdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776462600; x=1777067400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9lw53x2B/WFMjhVIcmq2SE67xL846MbI1e+oYyMRRA=;
        b=OjR6qEyqaYGRxRrtnsnnMQ7lRXVOHjJT28OtJdatwuhZDfraob4xlXDD0K1cimIgaD
         AXx259aT0c51W7ui5JBxXudK7mCfNPj3K4DKrKOAZwkMSg6E9YrU73srdGJlg8T0BKvf
         OzR6vsC5M3+Fl0nZyLNCs4ox9HExgYEOqji18zGKWtxZdkLnxCoBQP8C5fojWNt0RA6D
         l7KCAjjHCL5cZnZFFh0ULi4OlA374mWEWThc2aDVEx0+YWPHjR5pORI5NEKlp8x72CqO
         5lJy4jJsYZhgvt01JmChyN4S1oEOCf8xbeW/qziVXggqacVS8w6teg0mcXazcy7TJE8G
         lgoA==
X-Forwarded-Encrypted: i=1; AFNElJ9t6CVyCgzy2bpYNFLSB5DRt/PYD6z5aqESYCD/WFlLcq8StlY5JVy9ybsDn0a0RzJFYm/bZylZfmUNzeuv@vger.kernel.org
X-Gm-Message-State: AOJu0YxnRsuM1lGnZKNAgddYlmYpVAXWYHMz/kFa62cNecT9eHfhtYJ8
	+EU/+r6XU6WMTbSfg5rlb7ioOFDOw7QSdvPTeM62BlLmZbt1Q1V6cx3gpV0lrul3eto=
X-Gm-Gg: AeBDiev4PJiIdCpv+JLMYkZwaJ3O69chbSgUrbHxmMzXzakp5H6ORHydAqGmGgGMjyb
	yqvgS55p5yk2txg2eQibVIGnmChR+8DayYpWvmR/gDYPWLWl1tftvp2vzMLbmc3tJ/MneAu/gCI
	pXRFQa55wvD0peOqWWuJ97YZ8rn84Y4TMFnF5YfHjDxuM5txdcxJSOTB9wauw/l0T/zpXSmT3uX
	mC7rjeVeHSOryAwCMfzB+750Fro5bPCl7tp7LYW0Q500SeIFXk7qKEuLNeypvvHOOUNT4I5jf7s
	rP6c7Vz+YZnXFTwFV13AIZNQ8xGnI0FjSf742QIwMRGRFuZbHLNAh3JEwn9PuRE0Q5fN3+oyrYW
	2FXaTSzDcISoGfMR0/28GHeqWVPIEBaXfAcdgdMBJWidha5GSQzA4UUQ0EVXNccnDtxBuV6wirC
	5tcNqckHenDA/wOYJ/SVxXzA30dyzzmpD/tOni2+9VBDRE9pIUTXn3fn+O+KF/td0a5SSSTVS5e
	3pE49t5uG4BeOuyWHQUw6mcwpo6b1p+GA==
X-Received: by 2002:a05:690c:c504:b0:79a:6249:a046 with SMTP id 00721157ae682-7b9ece69937mr48831947b3.9.1776462599907;
        Fri, 17 Apr 2026 14:49:59 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:321b:cbb5:cbea:1d3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9ce73fsm12027507b3.49.2026.04.17.14.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 14:49:59 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: fix issue of direct writes beyond end-of-file
Date: Fri, 17 Apr 2026 14:49:41 -0700
Message-ID: <20260417214940.2735557-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/729 fails with error:

sudo ./check generic/729
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 7.0.0-rc1+ #36 SMP PREEMPT_DYNAMIC Fri Apr 17 12:40:51 PDT 2026
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/729  23s ... [failed, exit status 1]- output mismatch

mmap-rw-fault: /mnt/test/mmap-rw-fault.tmp: Input/output error

The hfsplus_get_block() only allows creating the next
sequential block. It returns -EIO for direct writes
beyond EOF. This patch waits for any in-flight DIO on the inode
to finish. Then, it extends the file by calling
generic_cont_expand_simple() with the goal to guarantee
that blockdev_direct_IO() finds all needed blocks
already reachable sequentially. And, finally, it flushes and
invalidates the DIO range again so the page cache is clean
before the direct write begins.

sudo ./check generic/729
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 7.0.0-rc1+ #40 SMP PREEMPT_DYNAMIC Thu Apr 16 15:41:03 PDT 2026
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/729  23s ...  32s
Ran: generic/729
Passed all 1 tests

Closes: https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/210
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/inode.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 922ff41df042..e747427eea00 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -125,9 +125,44 @@ static ssize_t hfsplus_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
+	loff_t isize;
 	size_t count = iov_iter_count(iter);
+	loff_t end = iocb->ki_pos + count;
 	ssize_t ret;
 
+	/*
+	 * The hfsplus_get_block() only allows creating the next sequential block.
+	 * For direct writes beyond EOF, expand the file first.
+	 */
+	if (iov_iter_rw(iter) == WRITE && iocb->ki_pos > i_size_read(inode)) {
+		loff_t start_off, end_off;
+		loff_t start_page, end_page;
+
+		isize = i_size_read(inode);
+
+		/*
+		 * Wait for any in-flight DIO on this inode to finish before
+		 * calling generic_cont_expand_simple().
+		 */
+		inode_dio_wait(inode);
+
+		ret = generic_cont_expand_simple(inode, iocb->ki_pos);
+		if (ret)
+			return ret;
+
+		start_off = isize;
+		end_off = (end > 0) ? end - 1 : end;
+
+		ret = filemap_write_and_wait_range(mapping, start_off, end_off);
+		if (ret)
+			return ret;
+
+		start_page = start_off >> PAGE_SHIFT;
+		end_page = end_off >> PAGE_SHIFT;
+
+		invalidate_inode_pages2_range(mapping, start_page, end_page);
+	}
+
 	ret = blockdev_direct_IO(iocb, inode, iter, hfsplus_get_block);
 
 	/*
@@ -135,8 +170,7 @@ static ssize_t hfsplus_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * blocks outside i_size. Trim these off again.
 	 */
 	if (unlikely(iov_iter_rw(iter) == WRITE && ret < 0)) {
-		loff_t isize = i_size_read(inode);
-		loff_t end = iocb->ki_pos + count;
+		isize = i_size_read(inode);
 
 		if (end > isize)
 			hfsplus_write_failed(mapping, end);
-- 
2.43.0

