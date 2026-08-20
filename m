Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798682F3614
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219238; cv=none; b=RcmwOf8yUIwoo98IFdozmVXQrsaLMU/cnnZakFtTXD2WJVvzdYKkUqQr23qr3CVmhO5HO3T2drLBQ84pDsGA0ylawEKDUDhEYKQlS33sQ4cOzRSnYUuV67BDSmGTbprLFgcZ8NakrVv0epzmmVy8RcHexBSsO6fJr6MHvNU/pfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219238; c=relaxed/simple;
	bh=RBA+20Wa7VTk/zHXlotHY/RE6v/RD6D8rHGUfDI4L4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADkq2YjzD2NWLNRrtFIYkvdTHLt0pyW7+S4MFRwauBVBxkpIez5Zn1/aysOKFOuBsEvXeobRxDLnr8p5sSDUrDkQbvaWh4d8PneX5ncd1rK31vVL6r34ymgsI/3t2bh92x/mE0/Q4bwkkIb3Q6/WhcjNuuO+8Ysj8PxKCBPvzwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Abx4AY4C; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Abx4AY4C"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3811f512167so2847091a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 02:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787219227; x=1787824027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8e+fOyON/SbAUU8WoHWfPyNmaOSf1udt8NJoA3KGL/s=;
        b=Abx4AY4CSb7Yawcw4wqnX5a9Kg/98hcygdZyBOnV4/pR8EaBiogol7ylBLKi4MzWWY
         r+IBUonXn2bJz1HNj5JHz4ATbSvT4zgj4i6IvpSocRUDLQcXHxa36UrvjHT9Vd7ulU6/
         2qO9QZGlJjMXP4gNIKFWJ4iYqWhIbvmeCK6hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219227; x=1787824027;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8e+fOyON/SbAUU8WoHWfPyNmaOSf1udt8NJoA3KGL/s=;
        b=RkyR9bkFhhA7O7WCXlk1pDGZrCiJACXFgrLKuw/SSjR/3xXlvvfurakDLWQdwvDlVh
         yvFnJB6Gl1Ss6lyLPicTAoCbTAgE3l2ROj3XkgE7VYjYm1fHrjxrjdqqqe49J+c5PPmz
         JKLCzqckLLiN60oQcyIqVBkshFcDVuEnCpowDIYj3zlATXSuqSf8GOt+Va1HadbMy0Ka
         Ziyniu0dakYKdrJFUQraF/OLuRJzbCcfXQneWjo1MoebWxd3ZMHYjSasvy9NJlEFaEkD
         KWonmHigF5tIE4v2MEvN71HF7yoDqT3Ku28Ie7bPpAh3duNHgX+67ENwyZAbc0K5+mt2
         LFVg==
X-Forwarded-Encrypted: i=1; AHgh+RotLoDQnz703edpsmJUd/Yj2O835J0wXU/nRNlCmsgwWv9VHQGf4LU435PDB0ZZguyfMSaWJi7MKsp+LrCr@vger.kernel.org
X-Gm-Message-State: AFuF++m/AVRZDuKGGuttVTlU9ALldp7p2r6rKTJvz5aFfA+751kZ9sLh
	tRx/iyNJTBw31xIfiDs4+zFdFvUG/k+10wipijKzj2lXD4zjx07pXjCuZqvSfnEh2A==
X-Gm-Gg: AR+sD10v1kC5Lhnju+wXtqSdY/R1WRFboeNxdgt78nTz9Bt+v2QS4C1d3N1aow4N8gP
	xFt1MP2fXqyQ2UxHN0EYrJxnHyzhthd/27m3qsZhnPbBiBAYJmYWwEJFzglatMyA/beK0xRGQBU
	ubMjh8xKYSInkzho1Yrx9HomcVhCL5BhQhjsFWtZFm6PTJFOpCMRdwV8lj39GOvDbeokKEnTq5L
	h7rMjcRKv9NpC70p46JAb/6L6Hoa3+QvK7c/fXPf34O58h8hH3MVVX53lk/p0Fl/s6ZJnAiXwm+
	lyJcG5rFXtI7dHhKDmW+dqFdrTi+855/Hs+mP25qKS5CymMqbu3QwDnhu6pgKjLBrIyPsRyWnXI
	l9Hi8ZoZcNz86QWJdGUpwpF7Ivgh2n9bvWxYb3iy+v2WnQOex1Jb6/0IymnAiCCQ84PjmGXF9xH
	OHTRYj/D6ZU5mBn/qT8LB1Zo6hUpZQYbW6gkXoSGLuL09XpR4eJVQI5o2YQgkHe0Y7YuifxNfde
	zx/GlxN/iiyD5esbzMIjKKpuZk3
X-Received: by 2002:a17:90b:380e:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-395810c693cmr20983198a91.13.1787219227414;
        Thu, 20 Aug 2026 02:47:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:7beb:7701:c87e:f611])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957faf6849sm5851279a91.10.2026.08.20.02.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:47:06 -0700 (PDT)
Date: Thu, 20 Aug 2026 18:47:03 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: permit freezing while waiting for request answer
Message-ID: <aobKfyGHkdMcleoc@google.com>
References: <20260819023542.561653-1-senozhatsky@chromium.org>
 <CAJfpegu2wOG85R6KSvCwHOuxe2fWczA1KbrFcCZz=ofUch4K=w@mail.gmail.com>
 <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
 <aobDGgivy43cz7xQ@google.com>
 <20260820091018.GA4120091@noisy.programming.kicks-ass.net>
 <aobGRjc7SE1rwIHu@google.com>
 <20260820093402.GB1837346@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820093402.GB1837346@noisy.programming.kicks-ass.net>

On (26/08/20 11:34), Peter Zijlstra wrote:
> On Thu, Aug 20, 2026 at 06:24:29PM +0900, Sergey Senozhatsky wrote:
> > On (26/08/20 11:10), Peter Zijlstra wrote:
> > > On Thu, Aug 20, 2026 at 06:07:18PM +0900, Sergey Senozhatsky wrote:
> > > > On (26/08/20 10:49), Peter Zijlstra wrote:
> > > > > Message-ID: <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
> > > > > 
> > > > > On Wed, Aug 19, 2026 at 12:03:32PM +0200, Miklos Szeredi wrote:
> > > > > > Why is this unsafe exactly?  Does that unsafeness apply to
> > > > > > filesystems?  If so why do we allow freezing while blocked on
> > > > > > sb_start_write()?
> > > > > 
> > > > > Getting frozen with lock A held, while another task is blocked on A in
> > > > > an unfreezable state results in the system not being freezable.
> > > > 
> > > > Right, but then the system says "suspend failed" (tasks refuse to freeze
> > > > after 20sec) and just thaws everything back in?
> > > 
> > > People don't like suspend failing. People like to close their lid, throw
> > > laptop in bag, and expect laptop to not cook itself to death.
> > 
> > Sure, that's exactly the problem I'm looking at.  Throwing TASK_FREEZABLE
> > addresses some of the cases.  Failing laptop suspend because of uncontended
> > VFS lock is not an uncommon scenario for us.  Ideally, however, we need
> > some sort of server/client aware suspend, maybe moving clients to cgroup C
> > and server to cgroup S, and freezing those in strict order.  Or teaching PM
> > that some tasks cannot be frozen in random order during suspend (e.g. a
> > special flag PM_FREEZE_ME_LAST).
> > 
> > fuse is not the only subsystem that doesn't fit current random order suspend.
> > Another troublemaker for us is notify, which basically has the same server/client
> > architecture (where both sides are user-space processes).
> 
> Then propose patches creating freeze order.
>
> PM_FREEZE_ME_LAST is going to be trouble I think, before long you'll
> need PM_FREEZE_ME_REALLY_LAST or somesuch nonsense.

We probably need more than one, yeah.  This doesn't take into consideration
relations between tasks within a priority group.  If client A holds a lock
and enters freezer, and client B sleeps on that lock, then this group
cannot be suspended.  We need clients to reach some freezer checkpoint,
instead of doing in-place freezing.

> Using cgroups for this also doesn't sound right.

This begins sounding pessimistic.

cgroup-s sounded solid to me, because this moves all the clients to that
save freezer checkpoint when they don't hold any locks.  The only
problem is that if a task never reaches "return from syscall" then
we fail suspend.  (I'm only talking about user-space tasks here, in the
context of fuse or inotify.)  Why don't cgroups sound right to you?
