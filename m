Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795097249;
	b=ACx+55DdMJpkyEtqaV4UCO4h0ZK6fMDvXXKwa5GRetfN44pBHKPs1ZnN0JxhdfzVzWM7
	 ofuk/AJMc7HKuypgY7RCeSUuf7lE0XJSe87nbv4mpgAkRM2N/6eJhzwtkgn7MydwyupH7
	 nYUNGmguFtdedEDMzuTltxr2Z2ndxd604iMxF9LzMJMi0neZAC2ABq9niFs07V6tbDe2E
	 YSWv7Me31W/x61tV5dEuuLSjwM3Qss0ckT1VGYW9CK0zC6cXVqrRmELQGoMSTFyPNG+ef
	 kj/FOgZomUJSZNhK2dZCEYRhqBYzNVz8r/2V4QFMEW2y3aNkfEFmQEKCeZPA+ZPs/jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=5fdfxp+3cN1O7P0/cteggQR2R9addmyAbUwlKtxIGuI=;
	b=5gVNsXFdvlCOBndVz0XuhA6F2cz6dQllYjNDImPWtflvAPLH5m4NiARkLWveKOSVx5pE
	 J/zezTSMKbUeWgzq4kuSMnzxjR75P8CoRdugvujpu81WyWrBf5nqYk+GuTJe2u82goGVf
	 LWvtP50f5GA4bGAc1kZu1laypARWX6c6j9kVWPATbPaMpqylHUy5yrtV2fkWDC8bXNDU9
	 3bavhwcisGQoJWJdpV/NSM79N7LozvMv9MDEzm1KlpoDZOLz18DXosrkkAgVS3mf5bWLW
	 SoQFjl1pN1zfnwEuBueoNzI2HTGn7iXRER54EHwZQR2aCJQtGqyNruuIifwsrAJ5mEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=apSCs1mR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.72
Received: from mail-lr2-f8.google.com (mail-lr2-f8.google.com [74.125.230.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A5606A324
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 14:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 923A5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=apSCs1mR
Received: by mail-lr2-f8.google.com with SMTP id 38308e7fff4ca-3adf0b90f98so2807721fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 06:07:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795097248; cv=none;
        d=google.com; s=arc-20260327;
        b=rYe7BMwjo5Et96cyGTI5c8h+Qf2GUrGjLdonV0G+mMCr08Nv2+XSANN85AL0u3ELTI
         X+NLDfI+4zd4quI01l4qwux0mzGJAK/EjhUlcB1ZVuUxCuIb3cu47p3nkm8XnXW89edP
         dXi44o9EPLZhuFUfJkUhToqhVk/0KdO+ON/zcrIJh01ln4zTHz8Wk7Kf9JBwnmWPmHVC
         gTetPrIvlfwu5QJN2OEj3h/1sQ7Yv/5uOHEPlhVgujo/MTe2wo6Kbjn/5KyHjmgWfs3r
         gRNY2aOfzWvFP7/+8IZANHEEI/ogs0OYx3FoTRdeMj1JZWDRd+LEKjH6IJpaqXeFTf4a
         Ff/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5fdfxp+3cN1O7P0/cteggQR2R9addmyAbUwlKtxIGuI=;
        fh=mKyb0hkTes7kcHGeKf9ZnMdOsyAzcB7fa7Z+DdQHeRU=;
        b=UpXtdq+KAeHDrwwteEmRncVq27AckUkoEWCLNb8RiTyiP6PlxYDxySRX8ubWQKAAIw
         M9XcJGYvt1MPCMXA5vKKRGKlg3QstjyXjxbzfuqdSradT8eOwV1iCseW7mhIFQHRH6im
         yq6NG+ijiwZC0yu8w5ldTR9PDPebN0GYlvZOubKBzwQkV72hyi5o8EbVDM6qbnRCGKjW
         IjeM5KxHgM63+I4GZ6hdfzbbpJtW2gqFmlinrMOZf09jNPbo7xs0SupU3TGVTx3iCOgR
         /OsplzchFhgE1tjztGZt943kzUAa4e/CpZgkxbndgTG5+ZKBkK3y1aQzXOLBuWUxNr+e
         Flpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795097248; x=1795702048; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5fdfxp+3cN1O7P0/cteggQR2R9addmyAbUwlKtxIGuI=;
        b=apSCs1mRbYfiyuOplCR30hz6MbUxMYh93+x2cpTBQxkIrqhHyPOfu03EV9FN9SyUzc
         g8F0ElaX571dOfSmkhssW3ExTSEbPitJw/hWlwoN5aZk7mMMclNinfzG03Hd4XqD9zAB
         9Oibl2aZyxObNcMzHt5OY7pL6UvxVwDosf/MNfFrrj8C/lI5/kmOXM7kpAq95K8u8TG9
         i5414Nz9Qseu8tXH9DZPMf2+fQ1SWkdHCUUzYHqqLK/gAOZvixGnpV5EBsXuw3Hd51+/
         vVl5gXDeSqVAqiyh+9VAt8mFBqntpq5S28BxgBbavYRi9P2kqQ16/oS9wlxDFryhPrQm
         7Vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795097248; x=1795702048;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5fdfxp+3cN1O7P0/cteggQR2R9addmyAbUwlKtxIGuI=;
        b=UTy4mG05dcVsPOdy8ya/01pn2jGTzSfaiduyJ8cRn6a2t41LIwootE2P8mTuBBC/oU
         DqeP9XR9mc+xamz0FXE+3V4bIVhPHHPRyhtUlFJNoSxEbLsabx6wP41eS9t/nLbzSBVn
         SqG5V6xgrHSPu5yRb0b8aZzvZAsKKamxpd+lV0dR/M+OCQ6zy2Be5DxSaNvd9iQrekq2
         XPNCSz7ifbaRe7RcXDPlKK0N/rJnIbfcSWbyNkcXBIoP2jXRL9JTxley7kx+4cRrc45r
         Ac/EXDikN+k3/r0rz9LvEcBQrjE+I04cFLnXzrljfG6TZUpo7DQK//NX5R5xbq8jQkco
         0UhA==
X-Forwarded-Encrypted: i=1; AL+hErGluu+ldvFk1GX1fGDUU6gA+F7aGzS4+iq20IZxzw6Ud8ZJkXT8CAB7gaUDYgnM/8jnJ00w/Muii3S4/I4t@vger.kernel.org
X-Gm-Message-State: APuU4Z9OqiyZLQ8sMD+N8SQUQA4A9UNk8F2ectwq9eaET9PvrDtfn1s5
	6OQHGuuLnN1xmFEfQM6kOZslFlebM0QPaZwFjCXsHFXiOHVIsxQgsbEo+2niqqzI7TX1rNBP6E2
	+TipxyZSJjiSsEvJUVZCRim9MWd5GYiQ=
X-Gm-Gg: AYBFou0SPZZebtWu8HlgMtbXAgv8x15sd/b7FV8apGdYBnr23LMvm1hCc9PKOTBM9Vz
	uWikZVLrFMNlCesJKpzw39RyJwyxa0oWpQLi4s2SefKhT8OK+9fByv3qoje8xODXtDC++qTTh9L
	MneQ0qWNi6NzThNhrrwKGLBF3ikNMGACuus/fMK7f0N06zK6ztZ33Wicm3IyB12MrH0AH5mYh/I
	lEfavyd8H7qC4O1HvLs20O6EQbphKVK1FsE+Ed/WPIYaqdNyiTpSULRvv9odbwS4+IQCaJPqgYY
	uHaoHs4MJB3Be7yiD7kXxE7Wvz4vP+qzuCcHJZ330n7k2DJUpsBm9V5weowiH6jcRkToMVdV0H8
	XLgMCV0NzQPtCzzeXozqBlOq5pkqDQ5VBFBVmiKB3us3KImOWEvY7M6rMuOn83QraYhI=
X-Received: by 2002:a05:651c:2105:b0:3aa:f4c5:8920 with SMTP id
 38308e7fff4ca-3ae7b7b4759mr3971431fa.12.1795097247395; Thu, 19 Nov 2026
 06:07:27 -0800 (PST)
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
Date: Thu, 19 Nov 2026 22:07:12 +0800
X-Gm-Features: AclHuK-b4i_d8VXZZJ0Fe5n8p466ow-YpKHzxH9f5HZX4zjZqSLG9FFtE1oPG30
Message-ID: <CAO-4RZ1Q-HzRCd+S1uHZJRdN-ZCtv47f=pXTxbq4YaJgn_DALQ@mail.gmail.com>
Subject: [BUG] INFO: task hung in nilfs_segctor_thread (fs/nilfs2/segment.c:357,
 v7.4-rc3)
To: konishi.ryusuke@gmail.com
Cc: slava@dubeyko.com, linux-nilfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Ryusuke, Viacheslav,

We found a reproducible NILFS2 segment-constructor hang on v7.4-rc3 with
syzkaller. The supplied recipe reproduced on three independent fresh VMs; no
state snapshot is required.

Repository and reproducer:

  https://github.com/Zheng-zheng-codes/nilfs2-segctor-thread-hang
  commit 2d94e07741d28d2dccaba174d06d6a5255ce0134

Hung-task report
----------------

  INFO: task segctord:35823 blocked for more than 183 seconds.
  task:segctord state:D stack:29568 pid:35823
  Call Trace:
   <TASK>
   __schedule
   schedule_preempt_disabled
   rwsem_down_write_slowpath
   __down_write
   down_write
   nilfs_transaction_lock+0x25d/0x410 fs/nilfs2/segment.c:357
   nilfs_segctor_thread_construct fs/nilfs2/segment.c:2601 [inline]
   nilfs_segctor_thread+0x600/0xa60 fs/nilfs2/segment.c:2716
   kthread
   ret_from_fork
   ret_from_fork_asm
   </TASK>

The blocked thread is waiting to acquire `nilfs->ns_segctor_sem`
for writing in `nilfs_transaction_lock()`:

  for (;;) {
      down_write(&nilfs->ns_segctor_sem);
      if (!test_bit(NILFS_SC_PRIOR_FLUSH, &sci->sc_flags))
          break;

      nilfs_segctor_do_immediate_flush(sci);
      up_write(&nilfs->ns_segctor_sem);
      cond_resched();
  }

The lock dump also associates `&nilfs->ns_segctor_sem` with a task in
`nilfs_ioctl_clean_segments()` holding `sb_writers`, while `segctord` is
blocked in `down_write()` on that semaphore. The serial log repeatedly reports:

  NILFS (loop6): error -28 cleaning segments

i.e. `-ENOSPC` from the clean-segments path. The reason why the
clean-segments ioctl holds the semaphore
for an extended period is not yet clear. We have not established
a circular lock dependency or identified the root cause.
We would appreciate your analysis.

Reproduction
------------

  git clone https://github.com/Zheng-zheng-codes/nilfs2-segctor-thread-hang
  cd nilfs2-segctor-thread-hang

  # boot v7.4-rc3 with the supplied kernel config
  # using a Debian trixie x86_64 guest

  # in the guest, as root:
  syz-execprog -procs=8 -threaded -repeat=0 \
      -executor ./syz-executor reproducer/repro.kernsight.prog

`-repeat=0` enables indefinite repetition. The recipe has 227 entries: 226
replay programs followed by the testcase.

Verification:

- Main KernSight pipeline: attempt 2, `confirmed=true`,
  `status=verified`, 226 replay programs, 2026-11-19T11:10:28Z
- Pipeline verification scope: `snapshot_restore`
- Independent external fresh-VM verification: **3/3**
  - run 1 hit after 422 s
  - run 2 hit after 257 s
  - run 3 hit after 320 s
- External serial logs are in `external-verify/serial-{1,2,3}.log`
- Runs were counted only when a `nilfs_transaction_lock` frame appeared next
  to `segctord` or `nilfs_segctor_thread`; checker:
  `external-verify/verify-logs.py`
- C reproducer: not generated; the syzkaller recipe is the primary reproducer

Kernel/guest details:

  kernel: v7.4-rc3, bzImage sha256
    0c16409f8aec508ac44a63e631c2bd352536401f3fd0856df1d839fb953a1882
  guest: Debian trixie x86_64, 6 GiB RAM, 4 vCPU, QEMU/KVM
  boot: oops=panic panic_on_warn=1 hung_task_panic=0
  config: CONFIG_KASAN=y, CONFIG_PROVE_LOCKING=y, CONFIG_NILFS2_FS=y

Thanks,
Zheng
