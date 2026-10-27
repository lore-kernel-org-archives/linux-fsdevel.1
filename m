Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793095994;
	b=5Pu0VNrrgiohUh7eEbERYbjho1yXRlJvk6Gk+QzyVUwndRDMeRZQv49mCm2EjFHYm9l/
	 xDJL9Ma7tSxdu+MQnY0jQriSUN8fGDz6wGR0lS71gEYVpcPZ06krPnjGWlLL0jPAUwYS4
	 2RFLmt0YvEcl9qtTOldsgqU8crtCBgoM7P5Ry/zvz0RewmgjtzeynlySIj3hSSJMbVSlu
	 0drfEemwq3mIsxRJtuC7JB+Eq1v8/vhsC58LhmUYdtamvEYBp8WOnAXSj5u3Fjz/4XFIO
	 GWUhvipWuXHuJFoeckAhBOdFHMoBZ5AjZX5KOLT/uO1Sy8PZAd5ChxfT1nCjZ/oi9KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095994;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tLAa1UxQOJzLJH3cJItPLav+g5tE2gLo5zLoFWT9FJw=;
	b=opBNcrEM0gYP5Zv/ILBEeAiOWgrXIIWgKk6sER+pz/TLNXNczxSWK6WVUAgSwIHWTqDi
	 iibfXqDYAxU+8YZrWDFqPHGCT1U3IHogt6cZcKgfaBFvciAEOG1eb6XB2MacJRmDZqqTE
	 RttZpflReaW7947Oyi/Xs4yo6p+FhAjXVNJgJ/FHp59JE6UrMmebhn1SEmnYY7Znjrq3J
	 D97ug05NpaRX8K7xzobskPY7MmYNZg3F0G1/Rr5RAKtGWfcfekb/yKY1DBN7CYGnwcj5h
	 W0t0tGwsmnWRupFukNXAE1wbeqmv76puji9Jzu2ePiWxoDjrH9Wp+h8B9OMeYLQSSYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZS8vr6vT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C216F606A31A;
	Tue, 27 Oct 2026 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZS8vr6vT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1684C1F01825;
	Tue, 27 Oct 2026 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793095993;
	bh=tLAa1UxQOJzLJH3cJItPLav+g5tE2gLo5zLoFWT9FJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZS8vr6vTDVmEV4BuB4alcoDZt3ZAHU3d23Kc1ClbaZlK3l54RjLe61XaE+q7itSrA
	 P0UZCqchjP2G84fbW/XnH1UJR03H4v3oYHGqiW0QcxTkekwLwtyOcn2GRF08jwESlL
	 M+hqPY86v2kyEICwqh08j6DpAUQr75dgAT+OAMQvG8maEX5fw4dPJAUVEiIdS20YHY
	 dTjC6vyYkf9QKwGxBSJ6u0hpGdizekrY2dpbtrFXKVXnem83Jprx9M+lQTlWVRn/fX
	 zozt8Pz65hV7X2Vy6NsbzvSikmttom3yB/4UswBqAL9Fe6gqXMkz8FKFd71eFdEMmf
	 YrkxRLCJtTkeQ==
Date: Tue, 27 Oct 2026 11:13:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] super: make sync(2)'s wait for s_umount killable
Message-ID: <20261027-wedel-lenken-seehund-d85c9ba29aa9@brauner>
References: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
 <20261023-work-super-lock_helpers-v1-4-d0fcb3f2f275@kernel.org>
 <tqgqwii6it4zxhtsfgnkri2mppbcijvsdnywrsbsyrsc3ey6w5@ts5aqmpikwyv>
 <20261027-spargel-laterne-verirren-9d984ac342d4@brauner>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261027-spargel-laterne-verirren-9d984ac342d4@brauner>

On Tue, Oct 27, 2026 at 09:11:42AM +0100, Christian Brauner wrote:
> On Mon, Oct 26, 2026 at 01:02:46PM +0100, Jan Kara wrote:
> > On Fri 23-10-26 11:41:04, Christian Brauner wrote:
> > > iterate_supers_sync() waits killably for a superblock that's being shut
> > > down, but it takes s_umount of a live superblock uninterruptibly. So a
> > > freeze_super() or remount that's stuck under s_umount, in
> > > sync_filesystem() or ->freeze_fs() say, still hangs every sync(2) on
> > > the machine without anyone being able to kill it.
> > > 
> > > That's inconsistent with fs_bdev_sync() which already uses a killable
> > > super_lock() for both waits. And the reasoning is the same: if the task
> > > is killed the walk stops and ksys_sync() returns, there's nobody left to
> > > make a promise to. The emergency sync and the sync before suspend and
> > > hibernation run from a workqueue where that can't happen. The PROM sync
> > > on sparc32 runs in whatever task it interrupted but that one could
> > > already be cut short while it waited for a superblock being shut down.
> > > 
> > > Let __iterate_supers() pass SUPER_LOCK_KILLABLE together with
> > > SUPER_LOCK_WAIT_SHUTDOWN for SUPER_ITER_WAIT_SHUTDOWN. Only
> > > iterate_supers_sync() passes that flag.
> > 
> > This might get surprising in the future, I guess SUPER_ITER_KILLABLE flag
> > might be a more explicit way to control this but I can live with what we
> > have now.
> 
> I think you're right I'll fix that up in-tree.

I've folded:

diff --git a/fs/super.c b/fs/super.c
index aff2169ca94d..cd6f57ababe0 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1015,6 +1015,7 @@ enum super_iter_flags_t {
        SUPER_ITER_REVERSE      = (1U << 1),
        SUPER_ITER_WAIT_SHUTDOWN = (1U << 2),
        SUPER_ITER_SKIP_UNBORN  = (1U << 3),
+       SUPER_ITER_KILLABLE     = (1U << 4),
 };

 static inline struct super_block *first_super(enum super_iter_flags_t flags)
@@ -1040,7 +1041,9 @@ static int __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
        int ret = 0;

        if (flags & SUPER_ITER_WAIT_SHUTDOWN)
-               lock_flags |= SUPER_LOCK_KILLABLE | SUPER_LOCK_WAIT_SHUTDOWN;
+               lock_flags |= SUPER_LOCK_WAIT_SHUTDOWN;
+       if (flags & SUPER_ITER_KILLABLE)
+               lock_flags |= SUPER_LOCK_KILLABLE;

        spin_lock(&sb_lock);

@@ -1122,6 +1125,7 @@ void iterate_supers_born(void (*f)(struct super_block *, void *), void *arg)
 int iterate_supers_sync(void (*f)(struct super_block *, void *), void *arg)
 {
        return __iterate_supers(f, arg, SUPER_ITER_WAIT_SHUTDOWN |
+                                       SUPER_ITER_KILLABLE |
                                        SUPER_ITER_SKIP_UNBORN);
 }

