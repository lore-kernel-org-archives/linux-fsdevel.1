Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BC63DD85C
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323545; cv=pass; b=oJEZWgJqCzFHrTZ2bhmPBvizXuQJevcMEiBfYsH2B8K+jCJjcVJv+kWcgK6Xe+GrSqGM+nYCgM1KV7NIp0xZ3g6ANibit/6mVJmCceyaPRUNbyQupyliHaR9blLcSE1LUUu1kOYtHrsk8y/jCt+DHK5kY6+k69J6TEJGnFhI1HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323545; c=relaxed/simple;
	bh=BUqTLbaqUYoKdg3iiW+mLowzEHeWjN5LiDlT2QPIVfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2K18MdEOYg2/mjMQiXEr0WlLEPX83UYr25K/hrozq6hbYro73+QC+Xk10tRQdDwChKE18umdaT1rgiQnOyXxEDDapcK5IbI3zmC//qa0e9ROzIppr4BugFVI8zxGyUGAx9JqZTVG+3H7yADw2XgN0Y+/zVk+Q4lHW2acmu/ILo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpkHGD01; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpkHGD01"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-69de9bc590aso985433eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 10:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782323543; cv=none;
        d=google.com; s=arc-20240605;
        b=ieXQVoyop9sHWo0BuYKOPM2cQ5qHprezM8imt/XGukb2yzSOvMwoqfKUwAXFyRyfXB
         wakzon8l4nZulOvIukNZ/eIrWLw+sPqkSXbUB2iIRN7GoabscTleQQUykZ15rAeHC7eE
         kshfzDzWt0H7BlYnt1KjqSD7/Ayaq0XEggrOY5mUXUxEePx4HMqxQvcehfJ3zDL6Jcci
         hVlj5W5f2t+1skjZYqXYPj+3FL4c9s9Q9wrsBXGIJHOLo3gbPTSPaRq5D0OK0vDd4jZA
         6wr+kvz+eKO3OmXtRMHeSkU9FUqSbowmk8T5x14SUq9bk+7T1ssUW3NsCYGYRQqfmDhc
         a8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3yIQCK+bzs9AyvsQ75CttiaMe1DqI5YJnh3974Pl4HA=;
        fh=YFcwFz+qeZfJDUzXWp6LE3Udk8y2poqP02HJNKi/PXU=;
        b=VY7bHAhl6mdm3S+NyqR6d9t1ndHEsGTNYPC3+AnDgPXAbo3m9FcQ69DV3SRC4R4BYd
         a25ZHdBGZQ1re6uxmBdtewBWHzvgkJ2q99NYQqwFX9MWpKWMtQQGvGYHfvNRkD+yHFWC
         3ATAEMHfBtz7yQPIELit+aSo9jXadSUH802FbROavHq7jD2zGW2CoI45VWfN6/0WTH4J
         rIpAhJ2yIKmNXlHl0XLZwDF6lW4QWWMOC5jNqeYGizSKNk8LdCBYQdQ2+6cWESwEm/go
         9d3mZM330Xfbe5Uuec+FUQRVCHbbWbUdd5aNQdH9fnyBY5X+kQL1q93RHDWQgvdSWU3d
         Jpow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782323543; x=1782928343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yIQCK+bzs9AyvsQ75CttiaMe1DqI5YJnh3974Pl4HA=;
        b=dpkHGD014kNzTRmym8Xmzhh8Uh3XEehN1LpWs11WjWLOwbVCSfy3LK4k12qPPzlUI8
         9i89Gf/7LdY5kOKX3E9NlLyV2BVEERCY3dARyBZQRO9GOh3T2jtI5mYBD/nZzIP5vR9u
         7G3nK9LtnnR+BtGBzQyuj+dDtwmlLx+HYSOClLHbyu4rV0nHz6aB/SOU1l5rVdMlryG1
         +5SRzsGt0xe4rKkknnnaypLkt63oIH3LQfmV+h57Kq7m/UYuq5qnHPbaxmg4/QPGi4YM
         5uOkKOahVS+/BHS9n1K4Q7yHOdaAZy0Bf7YACl2rlmQ0PmgaZIQL/GE1UBWyknVXIueL
         fEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782323543; x=1782928343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3yIQCK+bzs9AyvsQ75CttiaMe1DqI5YJnh3974Pl4HA=;
        b=gBV3IxxEkV7UfHyM2cnL07CMvTa29/qFJIqhqe3q3xp//RNMy8j+cX35WxP0Mnx2k9
         FuYkEp9z534W5rQZ2cxWRCzHp1CO0zyDjrcENk+j5t3UxZONO7eMRPuKJWWO3vzu0U2r
         GwxrTSIiU9ZOR+Kh14agT+ZkccwF68VMcAhMFXSRM8824HmL4qeU4iPOOjP3g0XTHgWj
         9QZ9nS06kKsPkXzA9W1aXrgGMabVX449dS67MnBDSjggeMTpXRNgd4GU4t6wtzxCsLc1
         ynWHqRG4CTR9qEIJL5/qfWb/7I2uNG/reWSrrQV/5GPqlpdJCAv8CmCFkxbZ1p5PNIjx
         2oQA==
X-Forwarded-Encrypted: i=1; AFNElJ+CPUILfhDBZbHN+64aI/BqjljnDpoC8FTdTjSILxWfF0SPDJz3Nf3lLz3y9u3w4zb7wSQKSvDskizg6EIM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw68uH1Czxh/1Cu+GMONdc/AhFRZo8P2XZc9smNlslXd2I3igHm
	yFCIbtK5kNBJ50mqJXd9rdi0T9z5UaJf7WEWGf2ZgUqjz0VNotdgnb4yoAjKR/s7kbTLLqRWtVp
	sMibWaze/SYWkVBdzfCpvrWaeuYCzA88=
X-Gm-Gg: AfdE7ckQlPHD+6nSOz1YQvkk3xdVxE0LsKaoq3qxvhBehEBLHNm6teQIHgvPErjga38
	xv9Jfff+L3o/VRkd9I+pkuFhBckq6Z772+Gy/OQFbyqFnzw7db288hu+cTh0e+A4Q8f+0nClEpq
	MOcL95z1y4OfgeXgm8f2+UW59Vs0pE3F8kh6qJ3HmET6y2mvDU8auD9667x/VIkadM0cL9aLNlp
	gEq1DSEEUe2GYRELikIMJpGh3tuGzPQOvlcNzXTTG/Hd9Hw/nDj0MwW0/VxD6a1AvVDiWc=
X-Received: by 2002:a05:6820:4d03:b0:6a1:10da:ab9d with SMTP id
 006d021491bc7-6a123056b05mr2754013eaf.15.1782323542879; Wed, 24 Jun 2026
 10:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANaxB-zK5q=Xw6UZTmeFtXsDZjUsPkFk=p485m-wtNTBnf4hgg@mail.gmail.com>
 <20260624071226.2272209-1-safinaskar@gmail.com>
In-Reply-To: <20260624071226.2272209-1-safinaskar@gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 24 Jun 2026 10:52:10 -0700
X-Gm-Features: AVVi8CfO4ShP8XHn8pnL2N4gaP9BD3pzKdndivNRe-NdNvS8dpf9qzg05LfmNXE
Message-ID: <CANaxB-xUrLQYGiRJZc4Boi+KX=0TJSWymErNovANVko20fMDVA@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, alexander@mihalicyn.com, axboe@kernel.dk, 
	bernd@bsbernd.com, brauner@kernel.org, criu@lists.linux.dev, david@kernel.org, 
	dhowells@redhat.com, fuse-devel@lists.linux.dev, hch@infradead.org, 
	jack@suse.cz, joannelkoong@gmail.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, rostedt@goodmis.org, 
	torvalds@linux-foundation.org, val@packett.cool, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 12:12=E2=80=AFAM Askar Safin <safinaskar@gmail.com>=
 wrote:
>
> Andrei Vagin <avagin@gmail.com>:
> > The CRIU fifo test fails with this change. The problem is that vmsplice
> > with SPLICE_F_NONBLOCK to a fifo file descriptor fails with -EOPNOTSUPP=
.
> >
> > It seems we need a fix like this one:
> >
> > diff --git a/fs/pipe.c b/fs/pipe.c
> > index 429b0714ec57..6fc49e933727 100644
> > --- a/fs/pipe.c
> > +++ b/fs/pipe.c
> > @@ -1253,6 +1253,7 @@ static int fifo_open(struct inode *inode, struct
> > file *filp)
> >
> >         /* We can only do regular read/write on fifos */
> >         stream_open(inode, filp);
> > +       filp->f_mode |=3D FMODE_NOWAIT;
> >
> >         switch (filp->f_mode & (FMODE_READ | FMODE_WRITE)) {
> >         case FMODE_READ:
>
> Does CRIU actually rely on ability to do SPLICE_F_NONBLOCK vmsplice into
> named fifos? Or this is merely a test?

Yes, it does.

>
> If this is just a test, I think we need not to preserve this behavior.
>
> I did debian code search with regex "vmsplice.*SPLICE_F_NONBLOCK" and I
> found very few packages. And it seems all them use pipes, not named fifos=
.

In short, this isn't how such cases are handled in the kernel. The fix is
simple and should be applied to avoid breaking random software.

>
> (On speed: I still think that my vmsplice patches are good thing,
> despite performance regressions in CRIU.)

I already explained that this isn't just a perfomance degradation, it
actually breaks the pre-dump mechanism in CRIU. vmsplice is invoked from
our parasite code within the context of a user process, where execution
speed is critical. A heavy performance penalty completely invalidates
the pre-dump logic, making the feature useless.

Under normal circumstances, patches that cause this kind of breakage
would never be merged. However, since there are exceptions to every
rule, we should let the maintainers decide how to proceed here. In CRIU,
we have a backup plan to utilize process_vm_readv to dump process
memory. We already support this mode, but it isn't the default due to
performance concerns. If these patches are merged, it will be the
only option left for CRIU to implement pre-dumping.

However, we need to look at this case in a broader context. This is yet
another example where the change introduces a workflow breakage, meaning
there might be other workloads out there that could be broken by this
change.

At a minimum, we may need to consider a deprecation plan where vmsplice
with SPLICE_F_GIFT triggers a warning for a few releases before these
changes are applied. Alternatively, we could introduce the proposed
behavior alongside a sysctl to fall back to the old behavior and explicitly
state that this fallback path will be completely deprecated in a future ker=
nel
version.

Thanks,
Andrei
