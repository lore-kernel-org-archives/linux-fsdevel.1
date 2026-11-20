Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795173900;
	b=AfOy08z9i/h1QW1GkLpsG0TKzVijCtzBgsqfx44P7OAfZ5TJ0b/N1UKZzbXcYFRsfyJt
	 3MXAZzM/AwQQUGI23YPkO8OmQEscbwcVgFx1c7ClllDui77u/D92kxQNJ+nKxULhPzJfU
	 JIcoovMORBve5RTqRe//dcMDFtYNcoFKREop5UZiRFQzzzpMyUEryIEEY5zs8W5Gw32Tx
	 KUNJY1ZRx0akDdqAALY03g75ewmbJL2IH6iUFjfsXDTd3T/HJiQZLoUy7+dQ5ssziflB5
	 RQdZAYtszws8oNnbbMnHKtN4rBzygBceRHv76sqq0IhNGzvLg+UIsMm0tazNsoef/BA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QtxjPtWyAORLLdXxS1zO3pkCCQgK9BiQlfjTBORq21Y=;
	b=M2q+U0umGw5z67fgOR+VF/kfAm9ueouugZ7fUD5U88nGMqV8MAPe0NPj0yr4Jqwz1/b+
	 5DbCqZD1zDvNze9yaC0Z1pSZiXe/hMu0lbFMK4/X1HcVy3VoooBKtnyHLiWhpSHxJBIzU
	 I0O2HbC+YGhWwHtx58N4cWX8ya6Ih/R9Fq5HdB3V17Qp7B64BYyS5m4KvUKxgM/KAAA3n
	 ayp7Ng5RU2U/TeHPsyjncj1iuIKRtJLjb5jS8VYM/PA2YXW71RcPkcrwF/ui2w/aGP0ts
	 uoola9W8ees5Z+9f4No36uCMlY4hRIo5V7+dhXYz30Y/GOjwtgedDovCKzT2XU1qXug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZYX6o4lh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A69A606A325
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 11:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A69A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZYX6o4lh
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so6260955e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 03:25:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795173899; cv=none;
        d=google.com; s=arc-20260327;
        b=HiVjgNxyLS1MNhTuCZpHKYw3s9XNz703Ri/3zpaaqmdc3jbE9nw/LSC0DV8ElTq1oV
         1PS8GMI4ip5eDKQBIjWDNL3GYvUaq/M8s1sycDiFPDC85j2VM5fhvnTFsidToUTTVPui
         UjIZ/RjkxVNYxbp2C9P+cx1rVh8R4RX2fwlpjhJ5lBy9hOHRAUkXifwPl1kKj6KEHQ3/
         IIS4RS01eMOk2zBVhTuUZH6khOTqHNhvLmVT31vKVWJtcvFX/F3bKK12cBl5VUM4oD9C
         RBPpWmQDZ/ZmrqQDrVVRJnTY0zUH1r0unhxEfN+OFgv3/u4ssRoRR5eVPMd0L1rCCFS8
         JYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QtxjPtWyAORLLdXxS1zO3pkCCQgK9BiQlfjTBORq21Y=;
        fh=FU8Qbv96WPOi4tQu3QS6mk73xCGdRv2G2WQhFLF3VeE=;
        b=H8rsNOc1NUbQNdukmt1fII+knx6sGUAc3BWgrbOvHC8ApPd4UaAxqzjtSAM90vRox4
         2eDY9TheHRDfmg99rU9x4YCDAOcJqycckWG2I7AM2STwQh2joScb2vd54e4pmLK4mhG1
         DNR8VHp896dW4xksSc+VBeYQ1Ldal837hUoy57DJoR4eoeAec6L/zS+VKbpMupuqOZ1H
         9BKkY416d0pRobEWTyN3Oq0CWjbFCJVKAGEhk//TAdGJsEC8J145TMZLFEmIjd3lm745
         7Wmj6CrQBTT3ovlaEQFkyfRhAd2DOqaworlviV8rGIihVNiVSvReJj8mr+tev6Wv1Cgz
         M8ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795173899; x=1795778699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QtxjPtWyAORLLdXxS1zO3pkCCQgK9BiQlfjTBORq21Y=;
        b=ZYX6o4lhmeOQeWdznHmyaZLd4Rk3J1q2E8T0FvsLzBqC+pq1lIlrU2+4AvMCIGLeMu
         jxmnizU2cQ9Tzf+9pS10mXnkYvswFAR9R3bdCi1aMqSwE0aPii7MgkJVGnHFrhP3dTpC
         eBFTWCnU9AL5MTVuE1YRMktGQrgUfd53U0srC2HXpAsvQXaGkAb/8nvB4yjdkYd+EgI4
         GROSDhXNN7DToDT4hHHK8li3OGFEkpmcfqkR2vuwZv56hZBhxl2tkBWNRc8uqMMFUey8
         OCh6jCqQPUe1IBG4m19xWs55VprqYxorlG2E8kqyb7RVa0IrtV50x+WR0j/0sAM8SfSX
         oBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795173899; x=1795778699;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QtxjPtWyAORLLdXxS1zO3pkCCQgK9BiQlfjTBORq21Y=;
        b=fIpz/N8zessJKEu+eIUHXzd8xXNBJ51/41aVVngkEQB4UfngBs/8hzIP6sQM0LGea6
         MlAhzgVuZwK8HW4abiDkpMQ5k8acBAwaUgiAVi0cXFvuHFt7XXQdWY+rwReRalBGi517
         PPzz8Y1Soz5IA2hQq8sK90js2Q4KTrviSq1LyLWvTfin9mmbeUnadUB4uxwH72GlAthU
         eiuXfoGFyo1FwZozE0mUcsMxNb83g0MFVw5166vqgOdIo9zF7k1SwnDtFq877qR6LCHC
         rVqUfytdJWA+W3dLlIKw7UyZAs4FJMuP4U1C1zGhDSIoTIG/KxLqBR5sUI9q9KKDRrCF
         2Tlg==
X-Forwarded-Encrypted: i=1; AL+hErHMFHl3RRmcUiZYotlVhwCk1+Hb0IZ/b9emNVgPwHoky4IBhRNR2s3dJlO7jjWoDcW137jzxCWR6k6UhemJ@vger.kernel.org
X-Gm-Message-State: APuU4Z9zW2OqY6klJcgw82nelnlabtMI5zMJRe605OtNeGk97k/kpWOK
	IXY9rAkrHJmH2fWhdZ5+TkHDRV01/rur0+VaB8Neh6BFUaTVNSjZ31Dru3ta216YZJmnTXe7QFD
	VT6X2yW6JKGt0TVD/9LaYo6Vfgavn+9zKA20R
X-Gm-Gg: AYBFou3reHWOcIhQZrV9xMVcZLnOWVOvsdcF4JiQ53djbEajTPb6jVXDwIX/zHcqqGa
	kpvFbqPPpm5LlTtvxwg+0DVfHohxz/O0SlpES6WA0sTu30osN4Trgzj0AYUZtmAP/xAxzuVFFu/
	is+EbE63WiA4HEP02eIcgtKkWnt7HyGwtFZRa07PnFKcqsfCwNs6OE63ok332IEQy4TDX8PnJh8
	iKQsIzWIrlqeYQ0Hfwovyt74dh/R2G8kz50n1hds4jNiRkBMvOM6TsEeJWZK6cln9niv6P0kcrF
	XVlmMeEi4GmLxTa0TxYD51IJsPZPzg8g67msvlEuQoL1sT3WNVyYv7I2h1krmhPezEjzELSUTGL
	8lr5UXisvvno09/RLmsChpHHftJChK7GhxbOivA==
X-Received: by 2002:a05:600c:a088:b0:4a2:1a:a120 with SMTP id
 5b1f17b1804b1-4bb8880ac02mr60110345e9.6.1795173898451; Fri, 20 Nov 2026
 03:24:58 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAO-4RZ2pjEOpTBzqca5UxZHtaFS2Dj9zmNj1BtjvKm1yFE7_Jg@mail.gmail.com>
In-Reply-To: <CAO-4RZ2pjEOpTBzqca5UxZHtaFS2Dj9zmNj1BtjvKm1yFE7_Jg@mail.gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 20 Nov 2026 20:24:39 +0900
X-Gm-Features: Aa3M54pngFl2bEEaSiGVCZXRR4_jUeP31-DZipStF-kFqq9kWuqVkgu-WIQdrq0
Message-ID: <CAKFNMokyeDzig1aJMjTN0nid4DGdnFPKC9G-xk3L30yMikgpRQ@mail.gmail.com>
Subject: Re: [BUG] INFO: task hung in nilfs_transaction_begin
 (fs/nilfs2/segment.c:221, v7.4-rc3)
To: Zheng Zheng <fengaojigui88@gmail.com>
Cc: slava@dubeyko.com, linux-nilfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 7:59=E2=80=AFPM Zheng Zheng wrote:
>
> Hi Ryusuke, Viacheslav,
>
> We found a reproducible NILFS2 hang on v7.4-rc3 with syzkaller.  The
> supplied recipe reproduced on independent fresh VMs.
>
> Note: This hang may share the same underlying root cause as the
> previously reported nilfs_segctor_thread hang (issue #182):
> https://github.com/nilfs-dev/nilfs2/issues/182
>
> Repository and reproducer:
>
>   https://github.com/Zheng-zheng-codes/nilfs2-transaction-begin-hang
>   commit f1065fd59515bd55bbb5141b45e979bc0b3c9993
>
> Hung-task report
> ----------------
>
>   INFO: task syz.7.24:13081 blocked for more than 142 seconds.
>   task:syz.7.24        state:D stack:23176 pid:13081 tgid:13075 ppid:1034=
4
>   Call Trace:
>    rwsem_down_read_slowpath
>    __down_read
>    down_read
>    nilfs_transaction_begin+0x323/0xa00 fs/nilfs2/segment.c:221
>    nilfs_write_begin+0x78/0x1b0 fs/nilfs2/inode.c:228
>    generic_perform_write
>    vfs_write
>    ksys_write
>
> A second thread of the same process (PID 13109) is blocked on the
> f_pos_lock held by PID 13081.
>
> An NMI backtrace of the semaphore holder (PID 13190) shows that it is
> executing the NILFS2 segment-constructor path through
> nilfs_clean_segments(), including btree/bmap propagation:
>
>   nilfs_segctor_apply_buffers fs/nilfs2/segment.c:1010
>   nilfs_collect_file_data fs/nilfs2/segment.c:589
>   nilfs_bmap_propagate fs/nilfs2/bmap.c:329
>   nilfs_btree_propagate fs/nilfs2/btree.c:2128
>
> The lock dump identifies the semaphore holder:
>
>   locks held by syz.7.24/13190: 3:
>    #0: (sb_writers#17)                at: nilfs_ioctl_clean_segments
>                                           fs/nilfs2/ioctl.c:869
>    #1: (&nilfs->ns_segctor_sem) WRITE at: nilfs_transaction_lock
>                                           fs/nilfs2/segment.c:357
>    #2: (&bmap->b_sem)                 at: nilfs_bmap_assign
>                                           fs/nilfs2/bmap.c:373
>
> So a NILFS_IOCTL_CLEAN_SEGMENTS task is inside the segment-constructor
> path, holding ns_segctor_sem for writing while doing bmap assignment,
> and normal writers cannot acquire the semaphore for reading.  In this
> report the segctord thread itself is not among the blocked tasks.
>
> Relation to the earlier nilfs_segctor_thread hang
> -------------------------------------------------
>
> We previously reported a related NILFS2 hang:
>
>   INFO: task hung in nilfs_segctor_thread (fs/nilfs2/segment.c:357, v7.4-=
rc3)
>   https://github.com/nilfs-dev/nilfs2/issues/182
>   https://github.com/Zheng-zheng-codes/nilfs2-segctor-thread-hang
>
> Its hung-task report showed the constructor thread blocked acquiring
> the same semaphore for writing:
>
>   INFO: task segctord:35823 blocked for more than 183 seconds.
>   task:segctord state:D
>   Call Trace:
>    rwsem_down_write_slowpath
>    __down_write
>    down_write
>    nilfs_transaction_lock+0x25d/0x410 fs/nilfs2/segment.c:357
>    nilfs_segctor_thread_construct fs/nilfs2/segment.c:2601 [inline]
>    nilfs_segctor_thread+0x600/0xa60 fs/nilfs2/segment.c:2716
>    kthread
>
> The two reports involve different blocked tasks:
>
> - In the earlier report, the segctord kernel thread waits
>   for ns_segctor_sem in write mode in nilfs_transaction_lock().
>
> - In this report, a normal file writer waits for the same
>   semaphore in read mode in nilfs_transaction_begin().
>
> In both reports, the lock dump identifies a task executing
> NILFS_IOCTL_CLEAN_SEGMENTS as the semaphore holder.
>
> The new external verification logs also repeatedly report:
>
>   NILFS (loop0): error -28 cleaning segments
>
> This resembles the repeated -ENOSPC errors observed in the
> earlier report.
>
> We suspect that both hangs may be manifestations of the same
> GC error-handling problem, but the root cause has not yet
> been established.
>
> We would appreciate your analysis of this additional
> reproduction alongside issue #182.
>
> Reproduction
> ------------
>
>   git clone https://github.com/Zheng-zheng-codes/nilfs2-transaction-begin=
-hang
>   cd nilfs2-transaction-begin-hang
>
>   # boot v7.4-rc3 with the supplied kernel config
>   # using a Debian trixie x86_64 guest
>
>   # in the guest, as root:
>   syz-execprog -procs=3D1 -threaded -repeat=3D1 \
>       -executor ./syz-executor \
>       reproducer/repro.kernsight.prog
>
> The recipe requires sequential execution with -procs=3D1.
> Using -procs=3D8 did not reproduce the hang under our tests.
>
> The recipe is a state-reconstruction sequence (72 replay programs plus
> one model-selected priming program, followed by the crashing testcase).
> The crash depends on the kernel state built by the recipe; the testcase
> alone is not sufficient.
>
> Verification:
>
> - reproduction run: two attempts verified (confirmed=3Dtrue,
>   status=3Dverified), 2026-11-20T07:17:00Z and 2026-11-20T08:05:31Z
> - independent fresh-VM verification inside that run: 2/2 target hits
>   (2026-11-20T07:46:46Z and 07:50:15Z)
> - stability on fresh VMs: 5/5 reproductions, 187-194 s to the
>   hung-task dump in every run (2026-11-20, external-verify/)
> - evidence: reproducer/repro.outcomes.jsonl, external-verify/,
>   logs/external-manager-session.log
> - C reproducer: not generated; the syzkaller recipe is the primary
>   reproducer
>
> Kernel/guest details:
>
>   kernel: v7.4-rc3, bzImage sha256
>     0c16409f8aec508ac44a63e631c2bd352536401f3fd0856df1d839fb953a1882
>   guest: Debian trixie x86_64, 6 GiB RAM, 4 vCPU, QEMU/KVM
>   boot: oops=3Dpanic panic_on_warn=3D1 hung_task_panic=3D0
>   config: CONFIG_KASAN=3Dy, CONFIG_PROVE_LOCKING=3Dy, CONFIG_NILFS2_FS=3D=
y
>
> Thanks,
> Zheng

Hi Zheng Zheng,

I have filed it separately at:
https://github.com/nilfs-dev/nilfs2/issues/183

Since these GC ioctl reports involve destructive corner cases that do
not occur under normal userland usage, we are addressing them
step-by-step at a pace that does not disrupt other tasks.

As these reports seem to stem from the same underlying error-handling
issues that I am about to investigate, it would be helpful if you
could hold off on further reports until the initial fixes land.  That
will help avoid duplicates and allow us to process the reports more
effectively.

Thanks,
Ryusuke Konishi
