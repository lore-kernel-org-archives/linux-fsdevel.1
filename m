Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7F338BF96
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660607; cv=pass; b=l+Gvmv7icrw3ZHRbK2Rr/uejHHkNtbm0tOd4+k4fuzw95kWOdbJWjNtioxxMyhYNkRNQEl+XA/8Mf78rx/kV863HNal+QbIRqe3mv5183fHcCUl4yfWBN6I4Dw51555p9x0+/Kc2eeg0bnzZwJJgk9zePZSRJC2zMNcqR3ZGxP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660607; c=relaxed/simple;
	bh=CXGXujAhZ+g9w+A+wUSY5mfJzTVfvtl5vTRyY5y2mIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YH1Vamv+/2ZmMQW0CswoqKeAzoCPOsIKMi/FU6vuYyM6+CmTe1NXu9K4JdwZVy9jv/zs121TTq/6eTQ1xthoayAC1fECBoo7jvdD+jDxMaBb93ojntS0fQvwVAEONzyz+cBG8gvZvGZoJ8VKNTQ6R6dlDWv/qF+KESnXLPBsrtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jsvGQEN2; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jsvGQEN2"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cd7284782dso281671685a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 04:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773660604; cv=none;
        d=google.com; s=arc-20240605;
        b=UW4tROUTBrYnU8xIRP5d8R9t9dRC+8cwmRyRvHgkA+Gzx+y6eggzcwKsLLdNMoK7il
         se2uWhcJvd1IwUinNyw6mTbGQZ0fYEr9tm6EZyZ9O9P2uMdIsa25176vS51JfkhXsHun
         6uICINGaDrIXpgiaarQKouskucrxbVaax83qcvjBPuf7kum25wBCRzpkSZj4AsDT/WWj
         gZuy3C5PXMbQ5OYwppDwllGqVgq9IrapLC7wCxVfe3+G48/pMD/R6Sv+0hreooBFqpBH
         fFoQOXigfsnmeawIi3je1mxXAkb7p1cLocadZ7oRblmP/onAyG26bQcURXRG1wXdeagU
         3ywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=giZL+nHcZL2UiBrs8cUiZib/ELUOox3RiTPyme2k7m0=;
        fh=5uecRp7d+xhFrfSsyrTCiTUN1+hU2UiO1weOv+3IXzo=;
        b=QgjlqAnXF53Ngc3QdEwjdjBdpss+/LKAwh/JqFEkj/RjB7laLidur4xmYNBEdITTX7
         kXEqyQ9K+Y3s2fAht7Q5y2zGj9YU5uErxB3zbRKQqeA0SsNo0XxJLBdsVwpPCxuD9eC9
         M3KhlQgK0/B2nGZj/VMOHKuhCgwYjBFTNurgMmOc6B93qe8jNcke+8Hpz5oSQlm9z63H
         JPb/17IReK0LWSt/Urcf+GQU2i7QaEyAwY8IwA9a9hzoBIGhGgoDpZy9MfBTwjiZb7NS
         nND8PZHtJc5DYgRqcIDV+7R9IqbEVowSRTAz/ZBRRuENuo7H8qf2dZVBXL7ExsgQ4bQj
         FFVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1773660604; x=1774265404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=giZL+nHcZL2UiBrs8cUiZib/ELUOox3RiTPyme2k7m0=;
        b=jsvGQEN2Vz+A1yzHnGwBCsqY6BFur6WOZdTucN80oKuaWBHlHvp6dQvMRrEV6qeILR
         YevvZR6qUwpW5PFzw74qbeM6VLBDwmzYBEEvzEH/ukuUlJfdKGgiZEhzr3MKR5uReD3K
         xlNFPbfrTTWWDlNJWkovevNf0AnMyiSWQjC9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660604; x=1774265404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giZL+nHcZL2UiBrs8cUiZib/ELUOox3RiTPyme2k7m0=;
        b=RvLi/7AiJA9vkLwXTkx7GV6SRfpGDyz3TkfgjC2564d5i71Dk0CYRK2qKytBqGXE4M
         HVpEO1QMjXuVL+7C+7TnjJH0PycyT2Y8vH++FuRQORx3SRVzafvlUrmbNsfPWG8aTs18
         1nu8oH78iT7GLCX+SasH5aX2SW5XwNOJot35XfWAu+OH3h4FbPWvuaHgzSvwvXCa1vvo
         nReh6f2QrOjQo5KwyhDarY5et/2cezXXWGcShqz1wAzb5ab5AbYtef5CA7uLjNXv2jwR
         GRbV/73zlBpm/wgE/h2pnQOzxLPWEfL3nJzSQ0bmu1bxEwpbiy9q7rmu2+WRADH82C4J
         +/TA==
X-Forwarded-Encrypted: i=1; AJvYcCWQn72J8azO44zphSxeMDHXeaNCkTJkf+79uY4+5Y5PDDT0ROm92gfK61oVlknFOG/ZDmdfgqI95IL2KZys@vger.kernel.org
X-Gm-Message-State: AOJu0YxAsSOdM0dkV7nf775dgJjj7mklPmokNiVmjTx0a2QkPvfPHli6
	Ggs0PMsL0jgbk5LlzZ2JvewvTqOd46bIAbqfPGszwmcSCrP2HuEhFzqpQxfnfWzlumuXX8M+EOx
	ncxLhHEgZ0Z/06Gw5qrHyAfYr8hOexIEbqSrARlOSSg==
X-Gm-Gg: ATEYQzz3MmQwhKzs+12Lgakehx3hoc0s9TvNslqm1gnrDK3QjmWTDKtx5n7T5L215j5
	6e6v9lV+o4jXJ6ZiKemO5AVYkTi9zIRyQ1xJ4IsMew4EEKwpiiMt03ynkJU0UPhERcrZtIYSnew
	MF+O+5VyfxCsScQesCyJC4xP+p8Vmi1EzmOdlicx0KNCktDjSk2k1U6q1snwEt0vKJ7m21jl1GJ
	/a0w5gzwTmSA+XiafDrttPNJHLam8wGaTCegiEsNHfaKghT49xPj43JPcR3KpFQ63RUBSWuhkhE
	FBI1hA==
X-Received: by 2002:a05:620a:1a19:b0:8cd:8f04:50df with SMTP id
 af79cd13be357-8cdb59eb47cmr1577015485a.12.1773660604476; Mon, 16 Mar 2026
 04:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312194019.3077902-1-mszeredi@redhat.com> <20260312194019.3077902-4-mszeredi@redhat.com>
 <20260313230934.GG1742010@frogsfrogsfrogs>
In-Reply-To: <20260313230934.GG1742010@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 16 Mar 2026 12:29:53 +0100
X-Gm-Features: AaiRm50UeNXrwGjGB9iOAILoGB_XRvA7NTohaRz0pShElIRvtOxS0Ld7_McwCJQ
Message-ID: <CAJfpeguqNU_Q62vDS6nL_w3wBtGU8osE4d9pRFKFMVq-ATRFMw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] fuse: don't require /dev/fuse fd to be kept open
 during mount
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Mar 2026 at 00:09, Darrick J. Wong <djwong@kernel.org> wrote:

> Hrmm, is this https://github.com/libfuse/libfuse/pull/1367 ?

Right.

> Which syscall causes the synchronous FUSE_INIT to be sent?  Is it
> FSCONFIG_CMD_CREATE?

Yes.

> > The reason is that while all other threads will exit, the mounting
> > thread (or process) will keep the device fd open, which will prevent
> > an abort from happening.
>
> So I guess what's happening here is that the main thread calls
> FSCONFIG_CMD_CREATE, which sends the synchronous FUSE_INIT to the worker
> pool.  One of the worker threads starts working on the FUSE_INIT reply
> and crashes.  All the *workers* terminate and close the fuse dev fd,
> leaving just the main thread.
>
> AFAICT, the main thread is stuck in fsconfig() here:
>
>         /* Any signal may interrupt this */
>                 err = wait_event_interruptible(req->waitq,
>                                 test_bit(FR_FINISHED, &req->flags))
>
> so there's still an open ref to the fuse dev fd, which prevents anyone
> from aborting the FUSE_INIT request so that FR_FINISH gets set?

Yes.

>  And now
> we're just hosed?  Wouldn't the SIGCHLD interrupt the wait?  Or are we
> stuck someplace else?

The FUSE_INIT request is in FR_SENT state, and fuse doesn't allow
interrupting such requests without the cooperation of the server.

We could special case FUSE_INIT (and probably a number of other
request types) that are safe to kill without the server's consent.
Will look into this.

>
> > This is a regression from the async mount case, where the mount was done
> > first, and the FUSE_INIT processing afterwards, in which case there's no
> > such recursive syscall keeping the fd open.
>
> Is this hang possible if you're using mount(2) with synchronous
> FUSE_INIT?

Yes.

> > The solution is twofold:
> >
> >  a) use unshare(CLONE_FILES) in the mounting thread
>
> Is this after starting up the worker threads?  I guess that means the
> worker threads retain their fuse dev fds even though...
>
> >     and close the device fd
> >     after fsconfig(fs_fd, FSCONFIG_SET_STRING, "fd", ...)
>
> ...the main thread closes the fuse dev fd before FSCONFIG_CMD_CREATE.
> What if that main thread needs to use the fuse dev fd after this point?
> Or, what if userspace doesn't cooperate and unshare()/close()?  Can this
> hang be broken by kill -9, at least?

No, only

  echo > /sys/fs/fuse/connections/NN/abort

>
> >  b) only reference the fuse_dev from fs_context not the device file itself
>
> Can you set an abort timeout on the FUSE_INIT request?

I don't like timeouts, but yes, we could.

>
> Perhaps my broader question is, what /does/ happen if a fuse server
> thread starts processing a request and crashes out before replying?  I
> guess that means the request is never completed, but in the case of
> !(synchronous FUSE_INIT) we'd just see the whole server terminate, which
> would then release the fuse dev fd?

Right.

Thanks,
Miklos
