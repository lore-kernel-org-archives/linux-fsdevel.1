Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795201092;
	b=RKvbhVcATPSXRcu4fzuXfu+I+3g7ugpOugM1ybuQQpOfAM8zcf0mb8vLEr8n1Tjgf3cv
	 W9o3FxChwUuIu66xuYNAZBplVflhgPSLuq1c3jhPZbI18iVUj9wei8k2K2CIm7yWbRIo0
	 f8LKep/f8Q2x05mmb83KGyLxIlIZQx21bUwk7eCSu0jeBHUEqW+qbC9UiLsr2WMSLItH8
	 IShl+oI1A0R/Cf3XG/77qrHdqguy0jY1pARedREWYImAte82anJQejsMeQtOSH76x52pU
	 8zYWVGv4eMESP4WQRSh3xZ/nAjhGPUs8A/NxaMQCd6ntbZKbYdHeR8WFMF3HL5Io7Vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SUSmUAsFropF9N/rs+U4cpsjS2D8qF6cpjMI0ccZ0f4=;
	b=JbmZpWk4mTccYmduwxcm/8cvLBJ7ospmvcY+qMtj2J1V9/T0TGKg6d2fdkE+zRLPVaRb
	 qMEw6RcF9vyTNlMUqFSLpQEHhLgLMecMxPThLuDBahrDyGfMM7j5c3Y3uvQoIvGGt4+1A
	 /ISDdAgcrBfIX74cL4qlE+xbsb+gdkcePE8KfX9v2zQeAi/DnjtK4wX9LvHTBf+gfOt6Q
	 ZgSgX6+IeDh6epf9h/jbYwnnQ7S0SnHgTzDzpTB3ghNBh4Ju6ZeGl8h0zl/UHbMqHAmdy
	 IZcSp6DccgojFKywwZRG40h4mw7zXi/IpqXuLf3+sWwqAWIieMD35dDv+i/fLbjT2dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a6Rz3SFw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C7160A263A
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 18:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49C7160A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a6Rz3SFw
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb6860f867so4685e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 10:58:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795201086; cv=none;
        d=google.com; s=arc-20260327;
        b=shPK7reGb3QtmupC4c0vkJO0gourzWweK3LxmUTN7Sd4SpKcsQjIje5hnajXEIwi5Q
         zyeYqQ1qjcI7O22wPC6FfBcQ0wQXrlQCj84VRuXZBpLnIt3YRNoIRVya+NA2Y78IK75e
         h4IpxtXU2I/oj2jYjLnZQMbi1QTSvlMed8+v4cx32xXvsxUFlb3FRbl4BboFXh0M+UhK
         og29N5sbUPsiR7wKN/GNP2ammEzX5isEWYS3vnhHWtNgrLVAEJbC+qW+hL7iZ21wVwpi
         PZ0DmwPbm0R+gl7krDEgQgEBjUmwG2fK4TVmyTZHBq7lDW7uwIvEnA8pycDER7ATKbCA
         foVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SUSmUAsFropF9N/rs+U4cpsjS2D8qF6cpjMI0ccZ0f4=;
        fh=1quAEPRDTsr5GZqtSFEetLQcVXWrFTxLIfScj6XvK7A=;
        b=FYaJRaK8MFBaWf7nBGz52sz2iFlp7zBZTuHTXlPrbqO181t8XoZqvTTZIRe0AoMn2B
         ommlPSj/Ig5PU/nVg/jgfLNLBDECCSaOR5FdQhkkvAYC/b10rPnVsjuBnTHUD0kZdnN6
         9Z1Qt8RjlNJfdfzDHC7JIF/8cw65GnQspLKYHRpzjVTprKnzKCncX49T5mRLtTnSPotP
         xH4b4fhsnMGouX752I9b2lz+mjdDEl49Vyq7WUBSYU0x4cLrbhawFTJ89ADi/HXh017K
         vbRp+OCpnAhV4fV4HQODrKXfenXOPwf3CRPWTY0neR041e9o+ogfIm0Hxu+K+lOJmY31
         34Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795201086; x=1795805886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SUSmUAsFropF9N/rs+U4cpsjS2D8qF6cpjMI0ccZ0f4=;
        b=a6Rz3SFwLU/l85Z6gFtgpiNGTLOXe8g79Sw3flJHb7F6ccuFn63e+a/y2x7Px9F7cT
         N9ml4MzoD3m9ZHlntSy6L4+Qj3TO7Dk02QL64xw02D6ED3fvky9if8fI+prvPjlbbFaA
         UfqlFTHfE5hgx3Rd1Vt2wKbRbhOU/LrBYmw5tuJ2dgpH9J7txXgeu8yO9O5RcsttCPZD
         Aci0XPIkCb1+FF9WSxwNVVmVVIt8yqydwS5jeF1zYDK42+NCZ3QFwE78LN4I6KBHYsLg
         I4ur610HDRWXLXhc4cRf0squcxXUFgThZehO06h+wB6GZuORX5eWvsGz9FX+ePDAmBmb
         1AUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201086; x=1795805886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SUSmUAsFropF9N/rs+U4cpsjS2D8qF6cpjMI0ccZ0f4=;
        b=ReIecv4AzVZk6f26INDzZfP0xwVm1BFqQYCJ9O5P6jP2HyJjddlV5Gr2TLlv2D3m8k
         2ySin2AqqW0pTGP+g5aaEJxgZ3bVyYBQiMDeu6lmx+ijrYznOEfeUCD+y0qdMq9BQDnc
         MooEzhKlB2Y0ssoL6iFCPJJO2NUHTOfuF6fosikUkcdslXDb0ZF5E+srN1WhGOpusN+g
         a1qYs9oHynN9bRzBw0zB/Ozf4gphIc0LdUOp/LIendC6x9fYKpO/UlIdcaGu23jgtPs6
         co0wv4b/lemYhuFqvhAtu//HwHAA0V2P4s94LaiuxlX8+agBGml93bNfRB6p4b4PaNO+
         Rg8w==
X-Forwarded-Encrypted: i=1; AL+hErFHAMkRwkdhOsi3Hkjuqyrwnwpj+/OD+0f3c3MS6YV4hu6AoDtwWw50Xur+KdwO84pab4aMhrFIhbv0CJ35@vger.kernel.org
X-Gm-Message-State: APuU4Z8GgsmUn2AMINfyvVosbjKB3Bm0en/e3nF+lYA5nXFM6jCLOhFk
	rtaEeWOpedEoAZ5KQ4ISvSKLPewuszXVBN1Ksuiyz91+3ZHaYKwwfdUhN0FnuEo8lnSUxmHaJXH
	GCq8JV+z+Ovbv9p6Q8sGB9nliwaKcK25oWKOt7cSr
X-Gm-Gg: AYBFou3DEz5GQwn8oOdMB75pxziRFGE6hC8UyLnpIIpAhS6Oj5JAeFEbeELdd4xk6iB
	3Ysw+oq/zV1MsYwdBwnjL/2U3fWKJGj58rLhUofwWcH5R/aFFVDKaqokQ3qjbnaBq0Ci7XoNARL
	NjF9jmGQI64DoTeGm+8D+WOfL7wqUvmR2Ti527Tgy9fjBizcHThxWBJPdyXtW4BdmIJ5T8TKds8
	brVwYd/rLdPwZb6HpdoaW15xW9oMRkUIz9U8QI3TEIOs2OAGCDItQqYlw0lEEBBsqNbNoPBUlyW
	EYTl8IouXFCD/3br7JlpvHEAAWtyaX0EDgpTU4wpLJFMy9B9xyadXcHbHBxmwSXDQLV7eNL153b
	8aqq3wqPsoH2git2WytcLfk2OAWV8MxmQiwImWnvF26oe5kvHTTeW2EBSwfYZMr+Zi6Q=
X-Received: by 2002:a7b:c013:0:b0:4a7:1116:2065 with SMTP id
 5b1f17b1804b1-4bb851bd399mr1347485e9.15.1795201085271; Fri, 20 Nov 2026
 10:58:05 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118220154.2965621-1-shakeel.butt@linux.dev>
In-Reply-To: <20261118220154.2965621-1-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 20 Nov 2026 10:57:53 -0800
X-Gm-Features: Aa3M54oeme_MbHCPj8QJ7UbZJ3gKz6ac7ZgfFvJPWhUpehNdFPXUV52bzquf-SQ
Message-ID: <CABdmKX3DUR72jcgaH6zzEO54iFDpbAf8vGzpEi_tXEV+hJ6-mg@mail.gmail.com>
Subject: Re: [PATCH 0/6] kernfs: stop taking kernfs_iattr_rwsem for writing in mkdir/rmdir
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, Ian Kent <raven@themaw.net>, 
	Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 2:02=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> In the Meta fleet, cgroup mkdir and rmdir can stall cgroup operations
> on the whole host.  They hold cgroup_mutex and kernfs_rwsem while they
> wait for kernfs_iattr_rwsem, which every path walk takes for reading,
> and they take it once or twice for every file of the cgroup.  systemd,
> clone3() into a cgroup, BPF queries and the OOM daemon all wait behind
> them.
>
> - Our lock monitor saw a kernfs_rwsem writer blocked on
>   kernfs_iattr_rwsem several thousand times on a large number of hosts
>   in 29 days (in mkdir and rmdir), for up to 1.8 s at a time.
>
> - Under memory and CPU pressure the waits become host-wide stalls.  In
>   one week, we observed several cases where the OOM daemon and the
>   monitoring agent were stuck for up to 22 minutes.  In October, one
>   batch job caused these stalls on a large number of hosts.  On the
>   sampled hosts with current kernels, the cgroup_mutex owner was always
>   waiting for kernfs_iattr_rwsem (in mkdir and rmdir).  One specific
>   stall lasted 90 minutes and ended in a reboot.
>
> The write lock is not needed for most of what it covers:
>
> - kernfs_rwsem already serialises the parent's two counters and
>   KERNFS_REMOVING (patches 3 and 4).
> - The parent's times get a seqlock of their own (patch 5).
> - Only inode setup needs to set a directory's i_nlink, so removal can
>   clear it without the lock (patches 2 and 6).
>
> The lock also kept times and link counts stable while getattr and
> permission copied them into the shared inode.  Patches 1 and 2 make
> getattr report them from the node and stop copying them, so stat()
> cannot return a stale or torn value.
>
> After the series, mkdir and rmdir take no kernfs_iattr_rwsem for
> writing.  Write acquisitions, from lock_stat:
>
>                                           before   after
>   5 dummy netdevs created and removed       1850       0
>   100 cgroup mkdirs and 100 rmdirs          7500       0
>
> Latency in a VM with 8 vCPUs, while 32 threads walk cgroupfs paths
> (worst of three 20 s runs; mkdir and rmdir by a SCHED_FIFO thread):
>
>                          before                  after
>                     p50     p99     max     p50    p99    max
>   cgroup mkdir     2.8ms   9.0ms  20.1ms    25us   37us   84us
>   cgroup rmdir     4.2ms  12.7ms  26.6ms    28us   38us  107us
>
> A write that only needs cgroup_mutex waited up to 23 ms before and up
> to 34 us after.  With 8 threads and no writer, stat() and access() on
> a path whose directories have iattrs are 12-14% faster, since the
> refresh copies less.
>
> Tested with the kernfs selftests on lockdep + KASAN and KCSAN kernels;
> with extra checks of link counts, times and IN_DELETE_SELF; with
> concurrent mkdir/rmdir, setattr, stat, readdir and netdev churn; and
> with test-only delays that force the stale stat(), lost time update,
> backwards time, overwritten setattr and stat()-during-removal races.
> KCSAN reports nothing new, and its set_nlink() reports from the refresh
> are gone.
>
> Based on vfs-7.5.kernfs.  It also applies to v7.4-rc3.
>
> Shakeel Butt (6):
>   kernfs: report times and link count from the node in getattr
>   kernfs: don't copy times and link count into the inode on refresh
>   kernfs: don't take kernfs_iattr_rwsem for the directory counters
>   kernfs: don't take kernfs_iattr_rwsem to publish KERNFS_REMOVING
>   kernfs: update a directory's times without kernfs_iattr_rwsem
>   kernfs: don't take kernfs_iattr_rwsem in __kernfs_remove()
>
>  fs/kernfs/dir.c             |  48 +++++---------
>  fs/kernfs/inode.c           | 125 ++++++++++++++++++++++++++++++------
>  fs/kernfs/kernfs-internal.h |   2 +
>  3 files changed, 124 insertions(+), 51 deletions(-)
>
>
> base-commit: ccf2a4692fed0fa77751d32d2690585127a152c5
> --
> 2.53.1-Meta
>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
for the whole series
