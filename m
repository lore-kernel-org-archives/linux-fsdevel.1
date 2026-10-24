Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792861573;
	b=ZGBatJIFVUxB/2gA1B9qAsjUTU5xEWmCS5fEy8s070JY/ilWmQQZq0lmuJ4BfDdkv184
	 /cwPSEmfUt3blN25mSSdoiu2uyZpww27UGjGhtekWSmigNcry086N3BjwOjvfOVB3D68L
	 bVeyuHoTfKcptZb2aUQN3EGedKbGi0fpyKPrMWzIzKPapGUTlvif3Lb2JbfSqDWZng4og
	 k3XjUoA2vNAdHQo++dRCVlOJMgSDmxtA+zh9cwpnkSBnzTtweqM/SvadUy1cSQF5ppsp1
	 Gp6xzG4DUKBfQ7vrjBtz5Wt+xJrpi7PnoacH+yA8UfNwfH9XpGZGCl53t/QRD7bJ99A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792861573;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VD0DJQifxWqmFqvxgKLhw5iI9/XvTtH/bBB6CwZQaeQ=;
	b=g5kEZETL0SQ1h2QEJJ6I6OCj7KbOaXlT4KkflBM3b3I2FTFprIvQ3+4SScGR/VlSkYps
	 /auol/wqc4kJ37a3hjF7JexSnQeV/V98ZA/GAsaowsfRjw2l9Fs2eDOOSqc3hDgiuMB8/
	 SpO4bKt5MVA9+d1GFcJ2mbNPPxWLTQBbFGKOfJsY8xvuUiZTKFpB2x5aPKQ33qhIiFXIS
	 YEEet9LW3rBWxluSuZ0OBMi8YIjtjEVHXlDKj8bewgc0y8aBBl5qP2hsiXJt2lVOInpsW
	 jmdekpH4fZxmN5ShZfX3eFzs6ZBSgurojXkJ4b9MERmXRay3wODKMW4d0hT28/GwOZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hackers.camp;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F53606A31D
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 17:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01F53606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a20be3b39eso2362885e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 10:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792861571; x=1793466371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VD0DJQifxWqmFqvxgKLhw5iI9/XvTtH/bBB6CwZQaeQ=;
        b=DZ9a465CO4FBvnf0f0Z21ETIFT+3m5j4kVNGQndQS7JygRvadiuNiGNrmPcaBhJ0II
         nZRbCq9Ob7ffHweHo3Gw+ARZDu9HYoJhq8tsh76CWMzUCO8MY5Irn9jIS0HdihKP7pAS
         ozPDFRYjSqyVVqHdC+aMVB7pZM6BOnhwLiXe+EqUpky8B7KRm7/pdMv4WgC+d8c313tH
         qI5q2XGrenSDdRpgXrkNednLNejVo9lwYe9BBMKT2eLZt7Qjb7+62r3D2QL0aZKzDAd9
         r8u9Q+FcxiV010FEEvqub0sL8JYk/PwwXIP9OLBA5H05gPboFLGceqhCR4WDb3gS0Blr
         DsXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwEJgL58XnUQgeIZKV70PDSBAB+/ooQIaNVoOmBZEuSRVTpbxiRiW9tHchXGwBZPD2M8zU+DF9QmQRnOngb@vger.kernel.org
X-Gm-Message-State: AFq9FYJqwbs/tFbEXwIfY32rq5iefxQgrdLXn5a9OjFM1L2C0GvVxpqu
	FedlkAZeSaYgN3F2Wl3rUFWJTJHusnUSSHc7aqUrcVEZHKP8n10tgTcu
X-Gm-Gg: AYBFou1zUz23q7L8hj6EqbysDe82KMAemaXz2Ozn7o6E6Z7HzbUIZ7RCjkFr0bGTlYP
	I2d6WiEtA98l/PF1mJsd64vyUaMvU7inpo5/O4zsOCB7lsKvSV5Bc6pLJBbFiaSiAqKT9gNAR6q
	nWYCIyonYQJXS5KWUCkHTyx3dsKVi6QQ0p52VwP6h0NRA/BXzQG9OhzbGUIpjj0T3BD4Y2cils5
	XwSQy11iu0Fux7e3vbLbMZv6LDFNRVQK9Fg7FIk9KJfHgA4unufpaH47/P09JSKo5aX1Tsz3R6q
	Uu8K44cSg/ouWowIq4idDdkJusP2HdiEwHsO2EDcRRGJQmu+8ZBpXg55Dvnf6dNpeQW7aibRmT6
	A/eQdKl1MjBkauFTiGrO8bZJgn6uo9EuwScuYNVsXGFBPYs+IxSSY7XgLZqIRY4AmNFmEqUZA44
	WPwXRY6BSkgJbcTogOr4vMBCx7gUAWThL066+2uPK54t6OqsjHLKgMStZFm0mp2OJcelcxfNrKH
	HXCh1aEcUFEi0jCUc3PLTdoTyBU+FRSdkIOqFhV7reQpqP9guGcw74UApJajqsclLO+hoMwP4Nu
	AbldvuDl8GCqFIZqSQ==
X-Received: by 2002:a05:6000:2905:b0:48d:f14a:9186 with SMTP id ffacd0b85a97d-48e3eb97829mr4555971f8f.6.1792861571101;
        Sat, 24 Oct 2026 10:06:11 -0700 (PDT)
Received: from spartian.home ([2a01:cb1c:76:ed00:602f:c5f4:d108:b925])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb40733sm4164240f8f.0.2026.10.24.10.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 10:06:10 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: jack@suse.cz
Cc: brauner@kernel.org,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aurelien.desbrieres@gmail.com
Subject: mmb_sync: b_mmb NULL window races mmb_mark_buffer_dirty
Date: Sat, 24 Oct 2026 19:06:09 +0200
Message-ID: <20261024170609.125348-1-aurelien@hackers.camp>
X-Mailer: git-send-email 2.55.0
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

Hi Jan,

While measuring beamfs on vfs.all (2c3ba1f1cb41, on v7.3-rc7) we hit a
list corruption in fs/buffer.c that I think is a window in mmb_sync()
rather than anything specific to our filesystem, so here it is with
the trace. beamfs was attaching buffers that several inodes share
(bitmap blocks, parity regions) to the allocating inode's
i_metadata_bhs, so the same buffer_head moved from one inode's list to
another's. We have since given those buffers a list of their own and
the problem is gone on our side; the window remains.

The window

mmb_sync() does, under mmb_A->lock:

	__remove_assoc_queue(mmb, bh);	/* list_del_init, b_mmb = NULL */
	smp_mb();
	if (buffer_dirty(bh) || buffer_locked(bh)) {
		list_add(&bh->b_assoc_buffers, &tmp);
		bh->b_mmb = mmb;

Between the NULL store and the restore, mmb_mark_buffer_dirty(bh, mmb_B)
on another CPU sees !bh->b_mmb, takes mmb_B->lock (a different lock),
its cmpxchg(&bh->b_mmb, NULL, mmb_B) succeeds, and list_move_tail()
writes bh->b_assoc_buffers while CPU A's list_add() does the same.
The second loop of mmb_sync() has the same shape (remove, then
list_add back to mmb->list when still dirty).

The old mark_buffer_dirty_inode() took the bdev mapping's
i_private_lock, shared by every inode of the device, so the two
writers could not overlap. A per-mmb lock protects a buffer that
belongs to one mmb for life; it does not protect the moment a buffer
changes hands. The comment above the cmpxchg says it is there for a
corrupted filesystem with multiply claimed blocks, and the kernel-doc
says the buffer is added "if it is not already on a list": that is
exactly the case the window lets through, so a corrupted ext2, fat,
minix or udf volume in which two inodes claim one indirect block
should be able to reach it as well, given an fsync on one inode while
the other dirties the buffer.

What it does when it hits

With CONFIG_DEBUG_LIST, __list_del_entry_valid_or_report() refuses the
del, list_del_init() does nothing, and the first loop of mmb_sync()
is `while (!list_empty(&mmb->list))` on a list whose head never
leaves: the CPU spins holding mmb->lock. We lost the node to it
(soft lockup from 48 s up, then kmemleak and the OOM killer).

  list_del corruption. next->prev should be ffffa26a6e8d4820, but was ffffa26a63804190. (next=ffffa26a432e1238)
  WARNING: /lib/list_debug.c:65 at __list_del_entry_valid_or_report+0xf6/0x110, CPU#0: dbench/16440
  CPU: 0 UID: 0 PID: 16440 Comm: dbench Not tainted 7.3.0-rc7 #1 PREEMPT(lazy)
  Call Trace:
   __remove_assoc_queue+0x20/0x80
   mmb_sync+0xba/0x300
   beamfs_write_inode+0x45/0x190
   __writeback_single_inode+0x480/0x630
   writeback_single_inode+0x11d/0x4d0
   sync_inode_metadata+0x46/0x70
   simple_fsync_noflush+0x55/0x90
   simple_fsync+0x16/0x40
   do_fsync+0x50/0xc0
   __x64_sys_fsync+0x13/0x20
  [...]
  rcu: INFO: rcu_preempt self-detected stall on CPU
  RIP: 0010:mmb_sync+0xc0/0x300
  [...]
  watchdog: BUG: soft lockup - CPU#0 stuck for 48s! [dbench:16440]
  watchdog: BUG: soft lockup - CPU#0 stuck for 413s! [dbench:16440]

xfstests generic/241 (dbench) on a 4-CPU x86_64 guest, kernel vfs.all
at 2c3ba1f1cb41 with CONFIG_DEBUG_LIST, PROVE_LOCKING and kmemleak.

A thought, not a patch

The NULL is observable only because the buffer is unlinked and then
relinked. Keeping b_mmb set while the buffer merely moves between
mmb->list and tmp (list_move() instead of __remove_assoc_queue() plus
list_add(), clearing b_mmb only when the buffer is actually dropped as
clean and unlocked) would leave mmb_mark_buffer_dirty() nothing to
race with inside mmb_sync(); the lockless check would then see either
the old mmb or none, never a transient NULL on a buffer that is about
to come back. I have not written or tested that, and you know what
else looks at b_mmb.

If a fix is wanted, we can run it against the module as it was before
our change, on the same guest: that is where the race showed, and the
same test passes 24 of 24 trials with the shared buffers on one list.

Aurelien
