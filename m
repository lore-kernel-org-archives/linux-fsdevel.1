Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD836A367
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352111; cv=none; b=TeJOuFTzlTDKjGKo6uyw7RGz2FSk2O/38E/gQqRNGzy2nsFcgJHtMcZDvSZKzFgUsPqUPaV5p+ySVAzBjMvEfqgQSZU9wSih1GnlW66wE8B6ya9n9qMEkyWN30HGIRZXqz0wEHD4kDoblyKjh76GuEBp+0kWYMc2S1BBWn7AIk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352111; c=relaxed/simple;
	bh=/gVb9fcgCocEtzC143LuvTCFiEqmzkG9HTHCEdEVpEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8mdfwik5bq2T9UBNTwyzKh1HAJ/iPS9nz6Iqm1KCaZoD/ADU34IG/+jxWLBuilX1DJ1f8gYomL+3ChDVQakYJlvg/uCC9W3LYjD7gx3eLLe9Zlogne6TwBiFNzaMI4GvExQnwDiI/w5ts8ulToM8t4AM2xyPPkR1auQvMnHzzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je7f6tZg; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je7f6tZg"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5174dcdf88cso15596651cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 15:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780352108; x=1780956908; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1HquVhkpS8yFsVoW4Qr9xr3pJd62muz8BoFdSfaaUUY=;
        b=Je7f6tZgmG0mjQrzTqv2cANsiVlGrLHOXZZNgwqCSn74k7C2iSbf9uG/jbycGj6rUZ
         Z+41n+3Vuf2rRbszaMZQVcok14cmBRtp9fe5+rgGY13ofLfsveRpzFQ2eNw3ugmyLOR0
         RzPXrPiGHOL2XkcEGXj65Rrp44Df1Mjo07hHxjsUw6JH/N4ZkZKIumyLLYqAK4cd/WfT
         EJXO2eyeJyDquyy+3DV6G/XHtYqGpll2nsIZBATKRzEj70gr1rEAXtEqV36suUl07GI1
         Ibt1UUkKqXuL64UdB/Llpfuc29rLTbc/chjXtYAoNsP4OCETuo8udIgjoAnruRzLcGy+
         FFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780352108; x=1780956908;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HquVhkpS8yFsVoW4Qr9xr3pJd62muz8BoFdSfaaUUY=;
        b=m4lWefQT3JhOIAeAea4zmaAO8vBt+CJIXQos34LfaEPhb2uJse+BDYF+xDgXKMfNBp
         6DRohjYqHp4iTqYnfwBqP8YQeSsiwnidtQL7ADBmQ9PAevt++K8W4N/a7+gsK128mIoq
         ohguOrV9z6MiNsEEhjJk6YPEZntB9BeRTC3y5Qoq6vutwEAArJ88S9XJIYzn1efnzjwd
         Ow/P9svp0QAfoiq1LwdUifxoaMnNSv45h6lJiubhbSiC//aS3dQNUX21sqml8TzWTWgS
         TsAyZJOIifko9GKf5NlpBvM+OwzZqdRZkz30RVXfEvr3+TGwAq8PZgZ/I3uZvD0aTAZq
         3/zg==
X-Forwarded-Encrypted: i=1; AFNElJ+iXOyvVxDm2+/6NfZOVED2SCK4ErsOiTEonnaDbGcDjjOVSAmuIiwANYyGtpJhdiyaNBVakZopUcBH2aLa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9hu4gE/RlsaugObuIvB3mKEEVuuC4hpHN538WDaqgF7bz3sBF
	jmFKqnDPdih1I8b75AVKdgXc4fI5IDwhLVwhQ/7M1ZOS2Jb281dyNo6m
X-Gm-Gg: Acq92OEKTXWx8skvRMMqRaavClX5FFWlt71k33bSFvkO+TPMOh1c7bgQ0RM/E2PPYfF
	QA6R9i531b6tyTU8T+C3ArKuG5cIx2HG0DX+VpipjAdvY8HMUKwexuZL/G7wbFfkDTGE2QMNM1Y
	l3OrZodEfuhW9m+IvvYgqdkm2tY96zGccx5ouZnDpA/7/ZshZWK7Iq/ba/P55pHB8XNSp64BNQD
	FTKoHjhKWL0R+ZSuCiDnudCdxT60FQ0FDWclQckpMCTk+D1Z3o8cgAePtljElCt0MoA3q9pmmSm
	6zxREctBn+ijdWQSlyJd8x7EL53yg0o7UyQrifI/uoPjwyKpg9HOai9Ht3c9I3woEgHtAxBUH5U
	q3EqObVezNdhHWf3dda8ch3HRUjzT8QTMH8gq9MAv5cMc/FVOxMa0uVlNMbIV22NQhKQgglb3bR
	OqAaMKbkcPVGZIIkupeumhg59RyFuRPM/JziW5qwNRbNuZ+97w9V//rfB7jo/CPJFk54sNWpnMA
	MnEEo1rdyXhBatS/mzClPLAzrjwJAE/JyObVzJvsw==
X-Received: by 2002:a05:622a:5a10:b0:50d:7c18:c66e with SMTP id d75a77b69052e-5173a6f3826mr199228551cf.13.1780352108144;
        Mon, 01 Jun 2026 15:15:08 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517417ecb11sm66209661cf.0.2026.06.01.15.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 15:15:07 -0700 (PDT)
Date: Mon, 1 Jun 2026 17:14:59 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3] loop: Fix NULL pointer dereference in lo_rw_aio()
Message-ID: <ah4EY2nhPxEETufZ@fedora>
References: <CACVXFVOSm=VpYfxUEpYk4yC2N1uAoK=vbg_A=h51GXeeArzCpw@mail.gmail.com>
 <20260601215129.1375-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260601215129.1375-1-hdanton@sina.com>

On Tue, Jun 02, 2026 at 05:51:26AM +0800, Hillf Danton wrote:
> On Mon, 1 Jun 2026 10:29:25 -0500 Ming Lei wrote:
> >On Thu, May 28, 2026 at 5:16 AM Qu Wenruo <wqu@suse.com> wrote:
> >> 在 2026/5/28 18:08, Christoph Hellwig 写道:
> >> > On Thu, May 28, 2026 at 03:11:05AM +0900, Damien Le Moal wrote:
> >> >> It sounds like the VFS unmount call needs to have something that waits for
> >> >> sync() to complete. Though, it really feels very strange that an FS can complete
> >> >
> >> > I don't think this is the VFS-controlled VFS file data writeback, which
> >> > we wait on, but some kind of fs controlled metadata.  And yes, it looks
> >> > like those file systems are buggy in that area.  We definitively had
> >> > such bugs in XFS before and fixed them.
> >> >
> >> > e.g. 9c7504aa72b6 ("xfs: track and serialize in-flight async buffers against
> >> > unmount")
> >> Considering the xfs fix is pretty old, it's before the fix hint thus no
> >> such mention in fstests.
> >>
> >> Do you happen to know which test case is for that fix?
> >> I'd like to adapt it for btrfs as a reproducer.
> >>
> >> This syzbot report doesn't provide a reproducer.
> >>
> >>
> >> Another thing is, if it's some btrfs bios on-the-fly after
> >> close_ctree(), the most common symptom should be NULL pointer
> >> dereference inside various btrfs endio functions.
> >> As all those end_bbio_*() functions are referring to either fs_info or
> >> inode/eb, thus if the fs is unmounted before the bio finished, they
> >> should all cause use-after-free.
> >>
> >> The only exception is discard, which is using blkdev_issue_discard()
> >> thus has no such reference to btrfs internal structure, but that's out
> >> of my understanding.
> >
> > syzbot log shows the null-ptr-deref  is on WRITE, instead of DISCARD.
> >
> > https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28
> >
> > Adding WARN_ON(!lo->lo_backing_file) in loop_queue_rq() might capture
> > this bio submission context if this req isn't issued via wq.
> >
> I suspect this makes $.02 sense given the check of Lo_bound upon queuing rq.

Can't lo->lo_state be updated after the check? It is totally lockless...


Thanks,
Ming
