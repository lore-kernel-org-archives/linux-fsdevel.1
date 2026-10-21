Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792544217;
	b=p2d+u+r8O44uC75FWV8zMOLM/kY60WTBrIdTpH9DmPgCP7km3haoiI8BhZwCil2gdp8x
	 XMsnDqpEcoU/Ca0RJAuubH0RrS8sblAbSjg6c2hoi3KccSltfZRpKV5Bq4btBwQAsC9iN
	 IwxQ23U+m25rHTbBQol99WHaEnyFXL5JaJI37AkA8dXG3TipP48d+sFz/070YVC9O3qAc
	 NlYQUEKPXSBZ+fYDQEeeuvemRs0giQlkvteGDQ5Wnudc8RIrHnqOmun1sXo1TB4aS8Ts5
	 AZwUm6fGSEj36RWNEA8Rx/nqp6SheCJgEe2edM2EKduFGWbC2bTdr9S9w17IMYdJ0tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=c8FRBRNRn8bl0SDKL7RuaEvjORkG9mV5zlR8I8Ub4DQ=;
	b=R+e0m5RQUQhA14kSsknt0svS1ZoqU9KdG/82ynznAy5UM7j/KNUjjqmkdNe84ogiyitz
	 HCHpWyQvxBDVVQBRwsLvbmLKJ8TOoAq17Jg4zpFpmS2+BoyhPckk7dXVYXt/NN48jlQX7
	 Uaugnwv7dIP61a0h7t/KUxo9M0VOn0l7vT0bs6V3UGbYiAlq2WcHwBiHWyJNwTBJyF5px
	 NQg+kP7FbNvySyuYOU8GUzZ0jfndUF8EaccB4mHtzquOAJRNB+XVAbQ9sQXNVv8BjHu1g
	 RX3qBqGueQMbb+2dDAtlHzNjvVXRsqoB+uSou2Pv4tch+6Qan/td8NtxMy2jyzNzTkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="c/UKGOP/";
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1576606A31B
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 00:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1576606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=c/UKGOP/
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f20b304c0so22640285a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 17:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792544216; x=1793149016; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c8FRBRNRn8bl0SDKL7RuaEvjORkG9mV5zlR8I8Ub4DQ=;
        b=c/UKGOP//P4Vy1pvkRSgj0C4zU+mEuwgmPHVUKvXP2918pFdxn+Qo6mCsGCS7TkrR6
         XnPb/zetbB61WiyPVf3F6M93Jl6lwRrIDbgqAzeAjCvucoF6flSmHTUqEwHIDAvAKoYG
         bBMswTy1jiKqZIOPr+U6+FYIg57Lc1BpCMxnPpnIWGDfwfBW5nfEVGZMeycSnAdnpD2u
         vUMlzJLR6oQIYi+oJcFtitXmwVhZGO7R+mEkbwMKrqGgOqGZt/gNMU+NHcxXTTONRUCI
         mMd85WOPK7iVrjZweWWabLwGejgOPeZVxANyGzq/xnFqv6SiYw1bI4xr+UU8p4L/9lrg
         m3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792544216; x=1793149016;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c8FRBRNRn8bl0SDKL7RuaEvjORkG9mV5zlR8I8Ub4DQ=;
        b=pWXlmyZ7DBOXng7LXOCj6KxoNWVRE+ul1oO1hetvtoVHdUWPt8PmmFo1C5SosCAiuB
         EOJCYgDZB96XX1yYqa2oOna50VksI0qPt904tt0IBMn7gCWiWuknezQlHaqM2hFDKgPb
         FHVJlf/9p93Foizsni/henW5iBZuR5cmqEgXN7haaqjLru6oFho0SEQcjIfkJvZbINb2
         UxgZVP1gkkieMMT5cjAppObTAn5o+mk7KNDhZjUGm7r6Fksp4YN16GAWEDYz/vTlYW2U
         aub/GNETTizQKsvn/B1N+OLYoiIf8Xfqyqbkn4s5mvFJJkIjHzQBeEsKOZN09OG7ubbC
         lQWw==
X-Gm-Message-State: AFq9FYLnaU1QxjvC7v7mGiApNawAKe8d21jBvW8WrcITBS2KsrrXgER2
	gs6iZULH0Pi7VSD4VwFaH9/GDqdpTIMs1ntoHh9kS/LKhw3yMr5XovZa5DROZG3WJNo=
X-Gm-Gg: AYBFou14DiFM80BcutceLseq4YCN/vb8hpVRl3fk6qREK6F1Rb7Jpiaav0JQwxky5ps
	N+RmOWexkSlDH/kgnPpFC4oXYlra5NTIAlVUIULBiVZQISWUfMgY52f9Mea4lE4f94kvUQT1xwh
	J+pXzTNZnW/hAMel4ykA+uPiGJxJC/5bNObN1ze2pdpQ6tvWxH2EpkCTn1kclnFzkjl1Ks6vaz1
	+ow085cetAV/gbz3VQAGfn2mtmg2nSjWv+rX4baCuLpDZ5gz4zGZirX3xIGNpJ4I5XWq/T5hCRe
	kqbtwWDzncdPk3yAfRvxr6+/3y0m1JE+Q7Oi3L6bzH8e9Rwhk7jabM8Mi9fooZLIr121GSC54gv
	iYhk97uZGbom4bMWs4lqlAqWoygMWkVo3gulG/xciZhIXrJOnFzPUdhNJiaVw4KMhRh+YBJxDbC
	R3ihA9RxWCdYH6eOpE2zGpr2qOAyjsyF2oPMh9CSI7Fq8wMFGGvxJL1vmH4pxbG3vKKFdeSonG+
	dFp2ffUp4+QjZOcAW0UodnUyDaxeit1ZlBk91fc9pP6dsqnJRPTNhYmbp6Li60f44Yl9xA+cVyF
	a13NMzkCCD5MOvbx0g==
X-Received: by 2002:a05:620a:440d:b0:93e:653e:6981 with SMTP id af79cd13be357-93f57e459cbmr179503985a.11.1792544215209;
        Tue, 20 Oct 2026 17:56:55 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10cf9f32sm11388256d6.45.2026.10.20.17.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 17:56:54 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 0/5] fs: don't let a stuck unmount take everybody else with
 it
Date: Wed, 21 Oct 2026 00:56:34 +0000
Message-Id: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMMN2GoC/13MwQrCMAzG8VcZORtsyxDnq4iHtI1bVLrRbKKMv
 but3jz+Qr7/CspZWOHUrJD5KSpjKrC7BsJAqWeUWAzOuIM1zqBvUZeJMz7GcMf4ltQjUewMsbf
 dsYWynDJf5fWtni8/6+JvHOaaqh+elNFnSmGop8r9fxa27QOLOgdFnwAAAA==
X-Change-ID: 20261020-b4-super-lock-dying-aad90aeb1984
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792544203; l=3332;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=wAS62HwPfAj/+XcJD7YqvP0MGbTU2mrv9OwpKNV77eM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPfEh3kXPerMOpQ8eMqSpuaOemDsTLQn/vPOj6il0zo3jNXJV0Gox6+CV/f25xuHEhfMXsjSB7B
 CnYFUxIV2hQ0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Hello,

A consistent problem we have in containerized environments is a
misbehaving mount taking out all of the other containers. We hit the
super_lock() while we've got a stuck or slow umount and everything backs
up behind it, and there's no way to kill those things.

This is because we call super_lock(), which waits on the s_umount lock.
This is held throughout the entire umount operation, so anything wanting
to operate on the super block has to wait for the umount to finish.

This is fine for certain things, sync() and fsfreeze and such. They want
to block because they want the work to be finished, it's essentially a
barrier on the cleanliness of the file system.

Other things don't care. In that case we should just skip grabbing the
super block if its s_active count is 0, as it means its going away soon.

In the cases that we do end up in super_lock() and we don't necessarily
care about the barrier behavior of waiting on s_umount, we can wait for
DYING as killable, so that we can at least stop the pile on of other
tasks waiting on the super block.

We set the SB_DYING flag at the end of the sync, right before we drop
the s_umount rwsem, so this is an easy flag to wait on to get the
barrier behavior without taking the lock itself.

This series doesn't really move the needle on keeping the host usable in
the face of a hung file system. It is the first step in a whole long
series of steps needed to make sure misbehaving containers can't effect
the rest of the host.

For testing I put ext4 on a dm-linear device, dirtied 64M, suspended the
device underneath it and unmounted, which leaves the unmount sitting in
sync_filesystem().  Without the series drop_caches, quotactl(Q_SYNC),
ustat(), sync, BLKFLSBUF and a second mount of the device all end up in
super_lock() and ignore SIGKILL.  With it the first three come straight
back, the other three wait but go away on SIGKILL, and a sync that isn't
killed still doesn't return until the unmount is done.

Freezing the device (a dm suspend with lockfs) and freezing everything
for suspend (pm_test=freezer with freeze_filesystems=1) wait for the
unmount with and without the series, SIGKILL or not, and leave nothing
frozen behind, and the emergency sync doesn't claim to be complete
before the unmount is.  On both kernels the unmount finishes once the
device is resumed and all the data is there, and 200 rounds of
unmounting with sync and drop_caches running against it are fine.  This
was with KASAN and lockdep on, neither had anything to say.

fstests ran against ext4 and btrfs, no issues. Thanks,

Josef

---
Josef Bacik (5):
      fs: make sync(2) wait for superblocks being shut down explicitly
      fs: make freezing for suspend wait for superblocks being shut down
      fs: make the block device callbacks wait for superblocks being shut down
      fs: don't sleep on s_umount of a superblock being shut down
      fs: let a mount waiting for the old superblock to die be killed

 fs/internal.h |   1 +
 fs/super.c    | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 fs/sync.c     |  15 +++----
 3 files changed, 117 insertions(+), 23 deletions(-)
---
base-commit: 2c3ba1f1cb416b81d617b92a24a4bcaa48d574e3
change-id: 20261020-b4-super-lock-dying-aad90aeb1984

