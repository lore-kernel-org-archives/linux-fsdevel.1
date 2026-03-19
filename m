Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C6B3FFAAE
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773964536; cv=pass; b=BKh59PnKLRrhy5ElVNjnE4pxsmpGs3JDbTO3u2pA2qMD7oAa6DfWG/ETZCMKxmHa91rCzX7QUgwDytngboMZ5ktOvkyn4WK8FQeOmtAzFLckRaBi93pY5FwHtn0PwehMGztqAqf5owtS0bwFC4QE3D50Gt1/+VHXZ+cAv2oS1qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773964536; c=relaxed/simple;
	bh=YqQWHG7sQVFE30nL5cwSU7IIyU4kUNqSrNwlZahbGjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEk6s2ctodJFBdWSdrvbPG0DjMQf/5FIFVdLw8pxVqEGZ1pyVsdsJK6u5yK6U6SyFdCm26HJbw0EUwPj/JVuN7CCeoDk5XqzJ2PwBhcLMZ3F268nhCYzTEKROwf/gQnxnT/cMW2VnQr1kXiH8R4RqVk7gRpqnIwMD+cTBKsqSAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCoeykvI; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCoeykvI"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso9255465e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 16:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773964532; cv=none;
        d=google.com; s=arc-20240605;
        b=WWQDS76p3/tqvzhNYjnZJuxqr2ZeEjv3zhIM+g6jmAZfwETgVOn552kCQXvnncPekx
         GVXsDL9TCf0rpGm9HkUHUv+sMFlgQRr5MCHJAsv4UZINkluW+qUlZUTlHbEr50MNL6o3
         PPfAYqSYqUdr1g1hC1ZiHTDKwQ4bUY8JsDvyzxCyVOrDZB585rWoOiRAR0+qA9QSmdNi
         98ShO8Rs6WHW78jAiorpIMOaL0/jAJiG7qEJWBQ+005ueXVvOWfdzRTOx2SuHnUc5PXl
         kfOiJlgWHgKupqhCsHK+EtoJov7SVz3ux7tcmmtMj7DrDV0yg51asCIz3LHEEZhHi4wt
         zNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/mhKg6xVvWfMaz63hQEXWdsh4Rp4Y+bSTphJUnzWMR0=;
        fh=5HE5gAGRgfFsjphsUHYLZQ7DoqzDuM3yrOW1GbXh7Ts=;
        b=SHXWhcknNNdoL6FkBcYvIbfxoTFoG8oVCHTQcdShwjjYxuXQT5AwpP1bn56ikRGNQ9
         xy0E+vJCCI+ABmyqipHDv3R/4y75guRD95Ir/4zWD8QFHza5v1dG7HB2wZgTCWjEWx7d
         VmyZwMOVBTH6A1mw0MtlACilqFySUn2e25XnSLREMXHuCFFt/2W9V8GqB/ENwXYyg2Hx
         9QywfYSCH/p+QWAU4AVJlSW/Y4a/p7ihZS1vo5cO6ga4vvTvOMKnpRVgNLVWS35QBebT
         CUi+TUs6dKnCEt887JxArPMkUFmwFSgfsfkEg6QPen7qW36KBej5wWGaZ+vqXaXKFisg
         ef+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773964532; x=1774569332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mhKg6xVvWfMaz63hQEXWdsh4Rp4Y+bSTphJUnzWMR0=;
        b=BCoeykvI88QnQL/8jSCcXfFTOwf2O/IBfmBjqBllJqKJdTX+YDgnHKjnoUEE1j3G7l
         tT8wt3kFWyGjs0GyS/wVMu4O6WIl8UF37kZNLRoPJBE4sAHM3lziHAt2w0I54Eon5jKj
         xl3HiD+HXmubN6/8F6XE5kZ2DTpK7UJrEkgR1f0Y0ckGSTvOX3maIkry6QZG10f4g1Hz
         8f6pvoRnIfViKcne0eBgrswOmCIVjgzVpCIJMQoslyUUvy/qidFk6E816I3vI42LOspv
         J46EGjZKYP/2c9t8/LSVeMzTJypoJ5li56QI0jJMqrQUI3znlB0Ri55bgnXiDF/IL4FG
         Bu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773964532; x=1774569332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/mhKg6xVvWfMaz63hQEXWdsh4Rp4Y+bSTphJUnzWMR0=;
        b=MRgbH7BOPDdROL0dog/c6FcPDNhKF2wgjd5e7oq99JNlaRW3qutWLQhnuXk2iB7j81
         yVW+8XPTcddiPUvmDK9WpW3QLgNzxLzEYiB3TV5ejICzxF+bsTdk0AeG4NsF8wdDRg22
         I4MW/gZB6ENfvJg+/kmMokk3002GZyPJJ8VkrQtXfuMSOwDyK8UroOB5AWDftWN5AXqN
         tsVT0wYSxZvJ5qDtGpE2NJK4QsBJTh0TxUfmohanvNWNNHXcykQQ+CUKEHJLci1zYN9+
         VtB2oRWGJbmByFaRvf5jAoY9hBlLIKk7Z+rfFbA+iSwxwNGUnWW7nvGtBvEbKmBWSTHc
         Z5VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0n8HvsDT64v0I8YpWDlnlXapnQJ6PzDoMW+jU9CspX8T6fLZeIr2sdREwnJkIyb9o60Nas2CtJKAVJ/G@vger.kernel.org
X-Gm-Message-State: AOJu0YxQthzB4J/AFgSRnvXLrm/x2gqDQ/facmm+JOAdf/6i9AshIUac
	MHqYR5aXhaSBjZkrTsxVpIQpgGYL8lClyuPLvTB7O/TG8R2r5vdiD9t2MqrAZdn3T1D/J3yZlgS
	uOm6MLkKpe6LwAwyI86KeDZbrcFhYik8=
X-Gm-Gg: ATEYQzxbcNCS+ljDV907su9NzlJvt9jlnA4sWS90nr8kizLsudOKZiDjdYK9MMBIfbc
	nypIxsrHDASRlOuJ2HL2UQxA0yG2PvgZJAKzLyDG+Ax2afeiBdZJj6aoVU6hW6jGKgiVoL2Wnwe
	OM2ZGHVFK3YYeyqEfT9tF2QZz3aWlMmMIwGBsSlveATPjQyB8+00uD4m27kWjpppSBIR+zP4S4P
	owZta4NF8LMCC/NSmQVWdkozDbKgJn4GsO7y4AjMv/GA5TFDi+RYQYCDAGSMdppVG3AIukZtvRH
	MQWCmA==
X-Received: by 2002:a05:600c:3495:b0:485:3b00:f939 with SMTP id
 5b1f17b1804b1-486fedf6b7amr17160365e9.8.1773964531889; Thu, 19 Mar 2026
 16:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319194540.3463371-1-joannelkoong@gmail.com>
 <20260319194540.3463371-2-joannelkoong@gmail.com> <1f1dafa7-54c7-4eae-a19e-5ec1be391079@kernel.org>
In-Reply-To: <1f1dafa7-54c7-4eae-a19e-5ec1be391079@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 19 Mar 2026 16:55:20 -0700
X-Gm-Features: AaiRm52BrVoXuXp1mgrMWHCIO62znYxeTnQ2oKGY6jvIBiTwB0i4w5xIYrFYXBI
Message-ID: <CAJnrk1atiw4v5OHsvE6uov3aWpQPerRW_eo6Rxg3Z6hPO2uC2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] writeback: don't block sync(2) for filesystems
 with no data integrity guarantees
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, therealgraysky@proton.me, linux-pm@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 2:26=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 3/19/26 20:45, Joanne Koong wrote:
> > Add a SB_I_NO_DATA_INTEGRITY superblock flag for filesystems that canno=
t
> > guarantee data persistence on sync (eg fuse). For superblocks with this
> > flag set, sync(2) kicks off writeback of dirty inodes but does not wait
> > for the flusher threads to complete the writeback.
> >
> > This replaces the per-inode AS_NO_DATA_INTEGRITY mapping flag added in
> > commit f9a49aa302a0 ("fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
> > in wait_sb_inodes()"). The flag belongs at the superblock level because
> > data integrity is a filesystem-wide property, not a per-inode one.
> > Having this flag at the superblock level allows us to skip the logic in
> > sync_inodes_sb() entirely, rather than iterating every dirty inode in
> > wait_sb_inodes() only to skip each inode individually.
>
> Makes sense to me.
>
> [...]
>
> >       if (sb->s_user_ns !=3D &init_user_ns)
> >               sb->s_iflags |=3D SB_I_UNTRUSTED_MOUNTER;
> >       sb->s_flags &=3D ~(SB_NOSEC | SB_I_VERSION);
> > diff --git a/fs/sync.c b/fs/sync.c
> > index 942a60cfedfb..aedbf723830a 100644
> > --- a/fs/sync.c
> > +++ b/fs/sync.c
> > @@ -73,7 +73,12 @@ EXPORT_SYMBOL(sync_filesystem);
> >
> >  static void sync_inodes_one_sb(struct super_block *sb, void *arg)
> >  {
> > -     if (!sb_rdonly(sb))
> > +     if (sb_rdonly(sb))
> > +             return;
> > +
>
> Should we move some of the comment you deleting over here?

That's a good idea - I'll bring back the comment block that was
previously in wait_sb_inodes() and move it here

>
> > +     if (sb->s_iflags & SB_I_NO_DATA_INTEGRITY)
> > +             wakeup_flusher_threads_bdi(sb->s_bdi, WB_REASON_SYNC);
> > +     else
> >               sync_inodes_sb(sb);
> >  }
> I was wondering whether that handling should be moved to
> sync_inodes_sb(), so it would catch any (existing+future) callers.
>
> Alternatively, we could catch abuse by adding a warning to sync_inodes_sb=
.

Thinking about this some more, I think you're right.

At the vfs layer, the only other relevant callers are
generic_shutdown_super() when handling an unmount and syncfs for
syncing a specific fd. For these, I was thinking it'd be more useful
to return after writeback has actually completed, since the caller has
to directly invoke the operation on a specific fd/mount. But that's
wrong, we shouldn't be picking and choosing which syncs are ok vs not
ok to wait for. And I'm realizing now there's also the
hibernate/suspend call paths that call filesystems_freeze_callback()
which can also call into sync_filesystem() -> sync_inodes_sb()...

I'll make this change for v3.

Thanks,
Joanne

>
> --
> Cheers,
>
> David
