Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795172371;
	b=c3PyKEUld2+isizF6iMvbf99GehXnbUWFUwbk7D7uJvZabUqGf3jO3Zw4STgis8+gKCH
	 vI8ah0b3uzp6ykbFv/0bu2k+nlpzSqf0WXovnlqztTG7m58YmEFHByiWzYyDuTRSJa8Dk
	 n2ZP/dgqCpHl/ILCddHle83u92miFaNIP6ZtHESCHAmLgOFEFZEn/AVS49UL8Aqd9GuTG
	 ieKTP1hEM2FUdZ3eMTDh9n+DJFIaI/XqnLoicQ9Hfw8C26aqYzY9PPSsayAgrwCq2LCh0
	 X2MqE5wsIbyfYgp3aFYtIaF0E3XUfJ+YFiYCLIkmXcEQwgLGyPukoUCjT7uit2FEvrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=lsuDl5Mn3UwB19cNkcSJlYu8KKq2fYppJdpOiWNy9qk=;
	b=cdmtkiKmfdux9ws9h8Nc4uD+fo+yPQT0f1d4sOHzXUZNRnHDvvTPlmnwlittXHJWGRUu
	 nqZWBYl0qz9Szy0Zjm7Ykiyh3WpdTJUmm3NRpEJz97HCZsxh/DtTcWs7ulLnuJ+MXIKCh
	 tUgjENeJLMrTK7BP8XE9I9cTNpFYjuMKjMjo+FBgKtA0gomrTUE2PtJ5W3Xqsi46UnmY9
	 DbfqROaZH6dGCAgqODCE7LHlrl8OkUpAJoUSQ45xrMbmT0stAJ/pHt3HIvQpWQhQoO+ck
	 X7cmM4M6Fo3iS3Ny0YCGLjTM1am2yEJeRCqgMGqSvxxXT6ZsDydd4mwbMT1XAzIE/ow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hjZVtA5I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.71
Received: from mail-lr2-f7.google.com (mail-lr2-f7.google.com [74.125.230.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75062606A326
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 10:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75062606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hjZVtA5I
Received: by mail-lr2-f7.google.com with SMTP id 38308e7fff4ca-3adf87dd550so3657071fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 02:59:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795172370; cv=none;
        d=google.com; s=arc-20260327;
        b=X8Hb0H+XBXnumxLP7Qx6L3dejmTMLVRYoh5h4BJPu8W76l4cfAKOPvd5HWZ8DsFDUj
         WD7vekPWB7C6UnyedS4bpsvMQxshGUG7MKfnsW2zRpnh6gwJORJnIprF16aK7r9fHZ+i
         OuWZihfmv0ABu4cKK+bJFCnS2bz23BUeAY8geHiwbFsdQxJZQgAwihCAntux7GMyuS1m
         nnyDfQxr2YYn0LXYDMtlaJm5H9H5srrXVltBMhC9CLMzGYX44YWaFpourVWJRsSxNDXk
         Yn1+GZesWypfWVK4VoJR3xcnY/FuORbpVw6Gbw1uIC185dhM+NyGSWvlI0cuBnEqe0RE
         24tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=lsuDl5Mn3UwB19cNkcSJlYu8KKq2fYppJdpOiWNy9qk=;
        fh=LH34DtUfy1zCIhiiXDXPfV/PtG0aREDg5++kuMvGV0E=;
        b=OyQcnKdF9w3nOxHLlFoxTdEIsJybJV+St1N+6/BjWsgI+TiSHJmNDmlrNvQN73dsel
         LbaXAoxlhBh3Orh8iDDhhrWCqfT2OmV/LEl67JgnaSgXVBWUoPLrYp2l42yFB9FnCSj6
         rvuYaF61NtbIMHQfVwTxf86n1iyfmFfeGKINP9YxuBhEvVK/Pc7JzweGM6OusQhfufyN
         unJi8QTQDKu9RYOQ2K81PNdUka2MX9TNgJm4nygIspmim9DLL0h6m4X18ZcspJqsgI+8
         mVvQeseW3nP3TjaMQ1IzobYbDRJmk4CGQa8O/85iAhrhtehQPWgcdCZ4qBnq1058kklz
         089Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795172370; x=1795777170; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lsuDl5Mn3UwB19cNkcSJlYu8KKq2fYppJdpOiWNy9qk=;
        b=hjZVtA5I3GOQ3OgGiXpAh4D/yiWo9n387+63YqmnJU8rK6mUkJsQCbGY/Ryfmj4PG7
         POiFVQfTW9uzhfKwvXmSKNLW1YkN/zO0PKc1tZpAIn2ZN71ygI5F6MJf5mRq2YhUApRw
         Jn5mUuk0f5jRbWdBzrP3tKCsIy61XMt6s5r8o4wSy9g2mZ0HqlnCZyybpySMbUvfRxXW
         KBLGqSBia5V1CZuzax3w6ZDBX/34Va8R6FA9ERAKaCf16ELD+klxRjhxpXofsKocJE62
         LOManfqKvXTvs49MVsXib5bhQoDtiYdcfP/1xv/XAEjlMM09sx+Y90rZ1rMs/DRA6Jh+
         FO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172370; x=1795777170;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lsuDl5Mn3UwB19cNkcSJlYu8KKq2fYppJdpOiWNy9qk=;
        b=alN8r0yZ/bjDMVbO/12NUrPdPE7fDcG3EqNUmRhjuE9XpBUydr4CXxrntq3v0t+joC
         +n3chB9lRv5if2+1Ju5E3VSrOhmtMCbTJGC8LKWJk7eZ8g+CKr+jr7vGJ00rqgmOix7l
         khVyHnrMJpXnkmF83c7x09kHfa4SM50jsApL1f1EeZ4XSjWanIV5Dn2ZTvJqnBYnNexZ
         BibaI8du6zPcxsmQlKZz/a6JLxRrligB0ME7nvxR3mjByN72j67HXudd3M/deTRWhh2T
         m6uiHGV3AhM9HmqDWA/ds1yItcvR6tJqWf2JSnk1wOQN4IRMmsb7PM8YfXa9xWj9NYo0
         KNKA==
X-Forwarded-Encrypted: i=1; AL+hErFH4mxyzly0f7ahQ4H1B0OWN9/nmqm4YdY7RAdXD3jc1e1se0vewJxspegnNnCX/5SzBEsQPOhysWIr9Mzm@vger.kernel.org
X-Gm-Message-State: APuU4Z8j+M8D71qfqrv0RDIc7+flfAgDXUUi+ae1v9ezREHt3lzV/mru
	FV6cVQ/DB2SUsXAUsUL2LZEVDPrujmkDrEvyJuJg/nl9bcxlnVrRdrUJ2sVmUaJl8/DRDRautdd
	6m5cMMf83YDf/0wKNqZ7QLq6kJ1O3Tfw=
X-Gm-Gg: AZFdTZcAfwcdlJGFarjvv8rrGgNdckCI6RW3yjbSPYCQ/xrYkltSLLnuycU5tYHe53g
	n9ivMNKqhkjCOAtBDlIvBb5HQg4qnGpZ6NcEQn8kBGihmEGibDeyJ4CBOCIsF8C+IpjCZruNRBe
	GYh3EMtNWvl60hfeT5NAKeLLN9UqSBreS/Ixh/hMQjfLH1k9DJmel2oXBUkdcyUTx4D7zzKvVUP
	LlzQB0RFricTZG4Zj7lceNmtEKcVULQ4nd4vYnGHI3FCdpqynewOHObfbpXiTGpRgnfWP0Ij7jq
	K4r5C5aYVB1TrzWV7boFMb+nowqM3wV0kUQR7s8ieDLxRoAZAo+dody0jBl1H1YPGdyt/amuE0s
	oKBFX5cBC8HvSHeJBTvkCqEj97I2bl7CjxuYV43H57JOzknLPOro0xwG3QZ9IovIfomVi
X-Received: by 2002:a05:6512:3187:b0:5c1:9752:4a4a with SMTP id
 2adb3069b0e04-5c1bc85a157mr752168e87.65.1795172369334; Fri, 20 Nov 2026
 02:59:29 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Zheng Zheng <fengaojigui88@gmail.com>
Date: Fri, 20 Nov 2026 18:59:15 +0800
X-Gm-Features: Aa3M54rmQkwWBhrijL1QXQXHklkFcgZIvs5-RQmIqvid1q9B1KJKQjJZfoZUeyk
Message-ID: <CAO-4RZ2pjEOpTBzqca5UxZHtaFS2Dj9zmNj1BtjvKm1yFE7_Jg@mail.gmail.com>
Subject: [BUG] INFO: task hung in nilfs_transaction_begin (fs/nilfs2/segment.c:221,
 v7.4-rc3)
To: konishi.ryusuke@gmail.com
Cc: slava@dubeyko.com, linux-nilfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Ryusuke, Viacheslav,

We found a reproducible NILFS2 hang on v7.4-rc3 with syzkaller.  The
supplied recipe reproduced on independent fresh VMs.

Note: This hang may share the same underlying root cause as the
previously reported nilfs_segctor_thread hang (issue #182):
https://github.com/nilfs-dev/nilfs2/issues/182

Repository and reproducer:

  https://github.com/Zheng-zheng-codes/nilfs2-transaction-begin-hang
  commit f1065fd59515bd55bbb5141b45e979bc0b3c9993

Hung-task report
----------------

  INFO: task syz.7.24:13081 blocked for more than 142 seconds.
  task:syz.7.24        state:D stack:23176 pid:13081 tgid:13075 ppid:10344
  Call Trace:
   rwsem_down_read_slowpath
   __down_read
   down_read
   nilfs_transaction_begin+0x323/0xa00 fs/nilfs2/segment.c:221
   nilfs_write_begin+0x78/0x1b0 fs/nilfs2/inode.c:228
   generic_perform_write
   vfs_write
   ksys_write

A second thread of the same process (PID 13109) is blocked on the
f_pos_lock held by PID 13081.

An NMI backtrace of the semaphore holder (PID 13190) shows that it is
executing the NILFS2 segment-constructor path through
nilfs_clean_segments(), including btree/bmap propagation:

  nilfs_segctor_apply_buffers fs/nilfs2/segment.c:1010
  nilfs_collect_file_data fs/nilfs2/segment.c:589
  nilfs_bmap_propagate fs/nilfs2/bmap.c:329
  nilfs_btree_propagate fs/nilfs2/btree.c:2128

The lock dump identifies the semaphore holder:

  locks held by syz.7.24/13190: 3:
   #0: (sb_writers#17)                at: nilfs_ioctl_clean_segments
                                          fs/nilfs2/ioctl.c:869
   #1: (&nilfs->ns_segctor_sem) WRITE at: nilfs_transaction_lock
                                          fs/nilfs2/segment.c:357
   #2: (&bmap->b_sem)                 at: nilfs_bmap_assign
                                          fs/nilfs2/bmap.c:373

So a NILFS_IOCTL_CLEAN_SEGMENTS task is inside the segment-constructor
path, holding ns_segctor_sem for writing while doing bmap assignment,
and normal writers cannot acquire the semaphore for reading.  In this
report the segctord thread itself is not among the blocked tasks.

Relation to the earlier nilfs_segctor_thread hang
-------------------------------------------------

We previously reported a related NILFS2 hang:

  INFO: task hung in nilfs_segctor_thread (fs/nilfs2/segment.c:357, v7.4-rc3)
  https://github.com/nilfs-dev/nilfs2/issues/182
  https://github.com/Zheng-zheng-codes/nilfs2-segctor-thread-hang

Its hung-task report showed the constructor thread blocked acquiring
the same semaphore for writing:

  INFO: task segctord:35823 blocked for more than 183 seconds.
  task:segctord state:D
  Call Trace:
   rwsem_down_write_slowpath
   __down_write
   down_write
   nilfs_transaction_lock+0x25d/0x410 fs/nilfs2/segment.c:357
   nilfs_segctor_thread_construct fs/nilfs2/segment.c:2601 [inline]
   nilfs_segctor_thread+0x600/0xa60 fs/nilfs2/segment.c:2716
   kthread

The two reports involve different blocked tasks:

- In the earlier report, the segctord kernel thread waits
  for ns_segctor_sem in write mode in nilfs_transaction_lock().

- In this report, a normal file writer waits for the same
  semaphore in read mode in nilfs_transaction_begin().

In both reports, the lock dump identifies a task executing
NILFS_IOCTL_CLEAN_SEGMENTS as the semaphore holder.

The new external verification logs also repeatedly report:

  NILFS (loop0): error -28 cleaning segments

This resembles the repeated -ENOSPC errors observed in the
earlier report.

We suspect that both hangs may be manifestations of the same
GC error-handling problem, but the root cause has not yet
been established.

We would appreciate your analysis of this additional
reproduction alongside issue #182.

Reproduction
------------

  git clone https://github.com/Zheng-zheng-codes/nilfs2-transaction-begin-hang
  cd nilfs2-transaction-begin-hang

  # boot v7.4-rc3 with the supplied kernel config
  # using a Debian trixie x86_64 guest

  # in the guest, as root:
  syz-execprog -procs=1 -threaded -repeat=1 \
      -executor ./syz-executor \
      reproducer/repro.kernsight.prog

The recipe requires sequential execution with -procs=1.
Using -procs=8 did not reproduce the hang under our tests.

The recipe is a state-reconstruction sequence (72 replay programs plus
one model-selected priming program, followed by the crashing testcase).
The crash depends on the kernel state built by the recipe; the testcase
alone is not sufficient.

Verification:

- reproduction run: two attempts verified (confirmed=true,
  status=verified), 2026-11-20T07:17:00Z and 2026-11-20T08:05:31Z
- independent fresh-VM verification inside that run: 2/2 target hits
  (2026-11-20T07:46:46Z and 07:50:15Z)
- stability on fresh VMs: 5/5 reproductions, 187-194 s to the
  hung-task dump in every run (2026-11-20, external-verify/)
- evidence: reproducer/repro.outcomes.jsonl, external-verify/,
  logs/external-manager-session.log
- C reproducer: not generated; the syzkaller recipe is the primary
  reproducer

Kernel/guest details:

  kernel: v7.4-rc3, bzImage sha256
    0c16409f8aec508ac44a63e631c2bd352536401f3fd0856df1d839fb953a1882
  guest: Debian trixie x86_64, 6 GiB RAM, 4 vCPU, QEMU/KVM
  boot: oops=panic panic_on_warn=1 hung_task_panic=0
  config: CONFIG_KASAN=y, CONFIG_PROVE_LOCKING=y, CONFIG_NILFS2_FS=y

Thanks,
Zheng
