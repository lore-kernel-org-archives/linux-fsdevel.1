Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314C81A682E
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 23:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773875923; cv=pass; b=d3mH4Udw5AS4jSr4FbZ8Qhu3T0NnAvGLxRLNjH1qK1ajK0gtenMrV3hWm0YOBkRwrKRrsOSzv/6zEKi1cjluzeKjEJ/SVn6DjHLfcE1K+minI1oES6lIKWLIS7CavxqKO2Vw7qlc1O3Ws0y4hl99KC8xOPpCU4/DiO3o8vQMf5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773875923; c=relaxed/simple;
	bh=QqHM1G4TF542aN+D7aV04h0wo05V21UHGEVdtqdeazg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMWyHN/X6aYeKCBoQbREQE/rc2kCrLj0/0AZTUhZLOdcChUfM8ApS9NMtAXqCLxWY7zJXszsbcxSvVr2owrXzWXtue8SxNtKgjKP54KRWRNhTqlyY0BlIw6+Vf6RYF6TtFIvrKpbpEFIld37PLtrjesPsdB81FzQdNPiTlw3POI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDAJKnyQ; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDAJKnyQ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso33983f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 16:18:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773875920; cv=none;
        d=google.com; s=arc-20240605;
        b=YEVj6HRVjgik/0cxSJel8dOMOBxtR4geiLFM1MJV0TWgGMxCN2F6UcnqLXVJaa4Bp/
         0kGhyzs3B+LM42WnDfVvdr8k2WpO5rfUgZXytW3GWQALyowFdd8XAVrRbpao73b1mwbK
         m0Syx6SEor6pw3y6Zb53WV5AXc6+xXbV+ZL7bBLYcjDQgH1ECz5Moyc63DgxVjTk5eeT
         d6PdqeAbrX8wiPb6bjgqTiZbNi+mEcbjs0qXqpzCOhq2ZGofBqTReBRO7GA9PccxAOg5
         1CnWkuOb5wT2OIavH4lMXc/qacxAtLylJPWF8UAiPOFUfEVRxe3KI7weY84zKwUqYeV9
         bgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l6zEobww8tMpuKHxKvKqnb6/TMdq+OEibxnE1bSLksE=;
        fh=c5rnFQAxxu409SauCoVuRmVEFz3klHISkI00+TWc5WY=;
        b=hXnF2rYHhEgNi3kr0RDHlAK7toqn3Oc+TbhA/bL5XU4FkZp0OMXtfCmxwSc7gqniza
         /87cnR/bjFzjRDj0g6CXC3NoSz69aK2KOBdc1urDIpzeO5IiDNnBjrUJxpV/S8JHceW9
         pyY0iMrQ6Ef3o5uuo63GGDvByx8EEp91Fvtma8sQiteutUQQBAUyBaSAGljXZpHgUVl8
         RxYfCYJ7zfZdiSbjmS6rSSVIevAbE4fWsaQ0iT4OPLqpXrKL0mgMyFKoH8x8i5oY7t2/
         oKGmUXeA1soigZHAOsnNnpnP+C5XQXeE23KQsJgR5e4xFwGl9dqcLeI16OS2qEH0NS7P
         ZPYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773875920; x=1774480720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6zEobww8tMpuKHxKvKqnb6/TMdq+OEibxnE1bSLksE=;
        b=dDAJKnyQn0dfN4KlcX8WmJB+UM9WrckJyD89zwMiSuw3BUA/iU0Gvr0xYln1bCudv4
         NpFCFGPu1wAxmSJEUaZ8yCRn86yMGNOJEybCsPnbysgb+iYkBmizUQMab42S26vBBj9D
         nE1tV3tJFNlzlm+heMcBGP7uC7wK7ZMhyDJ6PVgjNjv8l4N8pF6YGgudVC5pTy1OuE2g
         s+I8s4NSW8Ul2yq5keZanhNX7CpLCvHsu9OGspHw4pMzpU2kO6y2XCwaRATVpdGLmJmg
         jumHyenSK1dt2ep4fdc/e/5IfzpAD69zN5oDA8LC6Nc/i+frntMdSkmauL5Yt/UHRSYF
         /Feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773875920; x=1774480720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l6zEobww8tMpuKHxKvKqnb6/TMdq+OEibxnE1bSLksE=;
        b=s0ABEdr+ZQq9DUPiH6eSb4Kt9Q/aOsmOOiXHfV8s08VztWYd2bNcvAHVYdPIJXaTE3
         zTd101ifDutYAfcT5V8lGgeibZKdRZ1nyOLsfHP84C70eB1Xyl5NOMl53ImuXQPER0RA
         1nCKdCfKCoAeERBdon7kSXKRI9e17TO2fWNHqultMTxnQsFvdR0VnUsKsCrAtXjyqkfj
         gr5ma9H6lzybvUaSA6J/jQ7CZdGtERZqvr6FrfJfMJIZygdM48aEkdyeq7tRjVS6jspX
         ZNFpwttdUpOczwSfLXtusSBOb7tCVbWwLkxANfB90LYoX3lZ0elsJNVCgIbkUtj2MRLR
         8w8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhpYP47KMYLpQLl4y9Lmb3U6865Im6KLAwje6honFFRfMqy/q9ATKj4j1xZWcZuxEtAqqQu2BDrPWoMMtr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9omF4HBvb2xm5KUkg2yzIQyZU0psJ3hoHU/GLInw4neN/ch7P
	wEDE1+hQKYQkzHj/C8oYKrIxQlwicWHCdTMspTy9IgoOIEtiI97ttoCOfEHq4cBnNcl7i5J/gGv
	1oooK4dEXMiKQm+dt7prqhrLaFhF1NE8=
X-Gm-Gg: ATEYQzznr40YrJ8BNKq+8IXeB0ImPXjrY5Dq4O8rS+Qv//9EriP0vz+9yLPFvGK4oWv
	PNmEJa+/05+241vX7Wh8IPTg/KXk0uIWrz8ZxhQl5mDDCkq3V/YDv1zN80ulgqDaUwQJ4J7W5Ni
	HgJ4iza1YX2f92w+0RzmsE5PIgfdbJzgQixqGXq0ysA/GFZHyufkdJbMhq05zTpb2JLCtlFIN5l
	MQrakHKJx/ao0YvEWSEBzZ0U7RtTxiGwh/dcNLvs/HgIaXip3e6QLWW7tisf6MGCkmUb+WR6cqr
	ZTKtNw==
X-Received: by 2002:a05:6000:40cd:b0:43b:3d4f:e17a with SMTP id
 ffacd0b85a97d-43b527c7920mr9194805f8f.37.1773875920393; Wed, 18 Mar 2026
 16:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312194019.3077902-1-mszeredi@redhat.com> <20260312194019.3077902-4-mszeredi@redhat.com>
 <20260313230934.GG1742010@frogsfrogsfrogs> <CAJfpeguqNU_Q62vDS6nL_w3wBtGU8osE4d9pRFKFMVq-ATRFMw@mail.gmail.com>
 <20260317233913.GS6069@frogsfrogsfrogs> <CAJnrk1Z4ntEKfDrvsUJLoTP2tfvUo9Sth1ogUqN+5dxP3p+y_g@mail.gmail.com>
 <3397736e-611c-48ed-896d-8bb31be5cdcd@bsbernd.com>
In-Reply-To: <3397736e-611c-48ed-896d-8bb31be5cdcd@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 18 Mar 2026 16:18:28 -0700
X-Gm-Features: AaiRm51cvrL-zLad8TKufZ2qOpYANyoOh8PsarGC53aWAkL1FgeJtfXGzLWvAqM
Message-ID: <CAJnrk1YFW67p0yUfXSMSmkxCSaVH4-OcHKwe0uDubHNA011UuA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] fuse: don't require /dev/fuse fd to be kept open
 during mount
To: Bernd Schubert <bernd@bsbernd.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Kevin Chen <kchen@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 3:15=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 3/18/26 00:49, Joanne Koong wrote:
> > On Tue, Mar 17, 2026 at 4:40=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> >>
> >> On Mon, Mar 16, 2026 at 12:29:53PM +0100, Miklos Szeredi wrote:
> >>> On Sat, 14 Mar 2026 at 00:09, Darrick J. Wong <djwong@kernel.org> wro=
te:
> >>>>
> >>>> Perhaps my broader question is, what /does/ happen if a fuse server
> >>>> thread starts processing a request and crashes out before replying? =
 I
> >>>> guess that means the request is never completed, but in the case of
> >>>> !(synchronous FUSE_INIT) we'd just see the whole server terminate, w=
hich
> >>>> would then release the fuse dev fd?
> >>>
> >>> Right.
> >>
> >> (I forget, what was the purpose of synchronous FUSE_INIT?)
> >
> > "FUSE_INIT has always been asynchronous with mount.  That means that th=
e
> > server processed this request after the mount syscall returned.
> >
> > This means that FUSE_INIT can't supply the root inode's ID, hence it
> > currently has a hardcoded value.  There are other limitations such as n=
ot
> > being able to perform getxattr during mount, which is needed by selinux=
."
> >
> > from https://lore.kernel.org/linux-fsdevel/20250827110004.584582-1-msze=
redi@redhat.com/
>
> Hi Joanne,
>
> the libfuse work for sync FUSE_INIT and selinux support is here
>
> https://github.com/libfuse/libfuse/pull/1367
>
> I think Kevin had already tested that selinux works, so far I have only
> tested the basic mount. Currently doing more refactoring so that
> fusermount link to the new lib/mount_fsmount.c.
> Should be done by tomorrow (will send out new reduced queue io-uring
> patches once I'm through and then eventually work on letting the
> application own the rings instead of libfuse - tight plan till the end
> of the month ;) ).

Great, really looking forward to seeing the newest version of the
reduced queue io-uring patches.

Thanks,
Joanne
>
>
> Thanks,
> Bernd
