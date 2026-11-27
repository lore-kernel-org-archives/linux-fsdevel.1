Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795764476;
	b=WSGqrh88HJTqzv0P4P+ZccxbJDaUoT/QQcrUsx1HZ/YbVy5tSpJ0OAj0AbQMj+AdS+qo
	 UHE4gIOTDFrNGefALOrtg2nZhGY3CYlCwfgQjkZ9n+8OV5kUPn0OkH2hIhEKW9GDQqtGx
	 8v5uGCeZ9a/sVjLUQbKrQ1sdsBkOlMr4c3HDkCzZejXVosO0FRpd/Vh1Fo2vZZaQO5WrG
	 H3QBjatY1F+av4PJmj4FnevRlGnmVLee6wpjJBA3KyFBvnudKlSlUoU4qsZwJMmcZTFHE
	 CTsoH1dnOoevnuY56onKrKdpOuO3LL8qhmzweQvaRj+kVwUe0qT5ux8E7+9PxgjWI4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795764476;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=3mfDHnWE/ppy5wNx9fT4XmkuC/X6iruw/VTvXe3oRI0=;
	b=i6kh3ezWER/ac1uMnh47ul7rG8wOZl4P1x7088WQiXET1yQ7Oypf/4JS02euxLMPuwFm
	 T/YOJ+AbmeaUDR1ZXcm9CLubf6nMqYSu0JMp5r1yfJysgtO9Udzzi7UHN0aP8TuNaLmaU
	 DSItr6o5fHymo6CIQ0XcsQEh4V6KgI7vF5QD4S0aPWu1G2oy0gBy9ZFdJTelCGeZAC9VD
	 ycRT76yCyPdIRwGySauAnMGpDbGS9Qt2uWOegBNcCaR7A03cGgOI6jy0L0gmUziO8caYG
	 swIIZNfkqGG3G4ueN/NDeUwLoZypzQ8nMXtJbwDM83y1+3VgDYK9OMgDaQ22djmtMpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mails.ucas.ac.cn;
	spf=pass smtp.mailfrom=mails.ucas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C2606A31C;
	Fri, 27 Nov 2026 07:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D38C2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from localhost.localdomain (unknown [159.226.43.6])
	by APP-03 (Coremail) with SMTP id rQCowAC3wZLoMAlrQsjrAQ--.1927S2;
	Fri, 27 Nov 2026 15:27:36 +0800 (CST)
From: Xinyuan Zhao <zhaoxinyuan24@mails.ucas.ac.cn>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] gfs2: spinlock bad magic in ifs_clear_range_dirty due to non-jdata quota inode
Date: Fri, 27 Nov 2026 15:27:16 +0800
Message-ID: <20261127072716.28360-1-zhaoxinyuan24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3wZLoMAlrQsjrAQ--.1927S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyrtrW7Jr1UZFW7GF45KFg_yoWxJFyrpF
	95KryfGr4kXFyUuFW0kFyFqryvga9xXr43Gr1xWrnxZF4jyr1xW3WIganrXr4UKrsrurW5
	Zr4jqrZ2gFyDGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8Jb
	IYCTnIWIevJa73UjIFyTuYvjxUkU3vDUUUU
X-CM-SenderInfo: p2kd055lq13trqsuqzpdlo2hpxfd2hldfou0/

Hi Andreas and GFS2 maintainers,

While fuzzing Linux 7.4.0-rc3 (upstream commit 4405c18) on x86_64 with
syzkaller, we encountered a "BUG: spinlock bad magic" in
ifs_clear_range_dirty() triggered during unmount of a crafted GFS2 image.
The issue is reproducible on an untainted 7.4.0-rc3 kernel. We also
checked the latest mainline (v7.4-rc4), and the relevant paths in
init_inodes(), gfs2_adjust_quota(), and gfs2_write_buf_to_page() remain
unchanged.

Summary / Root Cause Analysis
=============================

It appears to be a folio->private type confusion between struct buffer_head
and struct iomap_folio_state on the hidden quota system inode:

1. In init_inodes() (fs/gfs2/ops_fstype.c:859), sdp->sd_quota_inode is
   loaded via gfs2_lookup_meta(master, "quota"), without checking whether
   GFS2_DIF_JDATA is set in di_flags.

2. If the on-disk quota inode in a corrupted/crafted GFS2 image is a
   stuffed regular file without GFS2_DIF_JDATA, gfs2_dinode_in()
   (fs/gfs2/glops.c:475-476) calls gfs2_set_aops(inode), which assigns
   gfs2_aops (iomap-based) instead of gfs2_jdata_aops (buffer_head-based).

3. During quota sync (e.g., on unmount via gfs2_sync_fs() ->
   gfs2_quota_sync() -> do_sync() -> gfs2_adjust_quota()):
   - gfs2_adjust_quota() (fs/gfs2/quota.c:863-864) calls
     gfs2_unstuff_dinode(ip). Because !gfs2_is_jdata(ip),
     gfs2_unstuff_dinode() (fs/gfs2/bmap.c:84-85) marks the folio dirty
     and adds the quota inode to sdp->sd_log_ordered via
     gfs2_ordered_add_inode(ip).
   - gfs2_adjust_quota() then calls gfs2_write_disk_quota() ->
     gfs2_write_buf_to_page() (fs/gfs2/quota.c:760-762), which
     unconditionally calls create_empty_buffers(folio, bsize, 0),
     attaching a struct buffer_head to folio->private.
   - Next, do_sync() (fs/gfs2/quota.c:1000) calls gfs2_log_flush() ->
     __gfs2_log_flush() -> gfs2_ordered_write() (fs/gfs2/log.c:730) ->
     filemap_fdatawrite() -> gfs2_writepages() (fs/gfs2/aops.c:175) ->
     iomap_writepages() -> iomap_writeback_folio()
     (fs/iomap/buffered-io.c:2045) -> iomap_clear_range_dirty() ->
     ifs_clear_range_dirty() (fs/iomap/buffered-io.c:203).
   - iomap_clear_range_dirty() interprets folio->private (actually a
     struct buffer_head *) as a struct iomap_folio_state * and calls
     spin_lock_irqsave(&ifs->state_lock, flags), triggering
     "BUG: spinlock bad magic".

Possible Fix
============

Since gfs2_write_buf_to_page() always operates on buffer_heads and
journals quota data via gfs2_trans_add_data(), validating in init_inodes()
that sdp->sd_quota_inode is a regular file with GFS2_DIF_JDATA set (and
rejecting the mount with an error such as -EFSCORRUPTED/-EIO otherwise)
should prevent this mismatch.

Crash Report
============

BUG: spinlock bad magic on CPU#1, syz-executor/30690
 lock: 0xffff88804ff7b0e0, .magic: 00000000, .owner: /0, .owner_cpu: 1341632736
CPU: 1 UID: 0 PID: 30690 Comm: syz-executor Tainted: G             L      7.4.0-rc3 #1 PREEMPT(full)
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
 do_raw_spin_lock+0x1f7/0x270 kernel/locking/spinlock_debug.c:115
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:156 [inline]
 _raw_spin_lock_irqsave+0x42/0x60 kernel/locking/spinlock.c:181
 ifs_clear_range_dirty+0x1d7/0x250 fs/iomap/buffered-io.c:203
 iomap_clear_range_dirty fs/iomap/buffered-io.c:214 [inline]
 iomap_writeback_folio+0xd93/0x1de0 fs/iomap/buffered-io.c:2045
 iomap_writepages+0x138/0x2a0 fs/iomap/buffered-io.c:2089
 gfs2_writepages+0x165/0x2a0 fs/gfs2/aops.c:175
 do_writepages+0x27a/0x600 mm/page-writeback.c:2562
 filemap_writeback+0x225/0x2d0 mm/filemap.c:386
 gfs2_ordered_write fs/gfs2/log.c:730 [inline]
 __gfs2_log_flush+0x4cf/0x21f0 fs/gfs2/log.c:1135
 gfs2_log_flush+0x35/0x50 fs/gfs2/log.c:1217
 do_sync+0x55f/0xd30 fs/gfs2/quota.c:1000
 gfs2_quota_sync+0x322/0x570 fs/gfs2/quota.c:1378
 gfs2_sync_fs+0x44/0xb0 fs/gfs2/super.c:664
 sync_filesystem fs/sync.c:56 [inline]
 sync_filesystem+0x117/0x290 fs/sync.c:30
 generic_shutdown_super+0x82/0x3a0 fs/super.c:702
 kill_block_super+0x43/0x130 fs/super.c:1852
 gfs2_kill_sb+0x4a6/0x580 fs/gfs2/ops_fstype.c:1796
 deactivate_locked_super+0xbd/0x130 fs/super.c:558
 deactivate_super fs/super.c:586 [inline]
 deactivate_super+0xe1/0x110 fs/super.c:582
 cleanup_mnt+0xb7/0x160 fs/namespace.c:1396
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x24c/0x810 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
 do_syscall_64+0x677/0x800 arch/x86/entry/syscall_64.c:107
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

We also verified the same crash on an untainted 7.4.0-rc3 kernel with the
standalone C reproducer:

  BUG: spinlock bad magic on CPU#1, gfs2_1591/26353
   lock: 0xffff8880631c7620, .magic: 00000000, .owner: /0, .owner_cpu: 1662809632
  CPU: 1 UID: 0 PID: 26353 Comm: gfs2_1591 Not tainted 7.4.0-rc3 #1 PREEMPT(full)

Reproducer & Config
===================

The C reproducer (gfs2_1591.c), syzkaller program (gfs2_1591.prog), and
kernel .config are available at:
  https://gist.github.com/ilidanZtormrage/beffb7a9573d7d0873f06a99dc2cde64

Best regards,
Xinyuan Zhao

