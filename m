Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10626C39E
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863837; cv=none; b=WFZZmwyZqjY/RhZNRdpLn7GvnBdFslBT3Jt3CrM/Z9mnhvwFVkA7UNts1fjDqM7bOj6eiu3nL+0fgBTtnV2Pvhm03oIp3idZJ0TMY7gh7GeT4FjuBhbgOai1GpoYd5I1RYKZBRixQjO4MKxjPiHqzvLsvC+06ms0OhvESLfW9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863837; c=relaxed/simple;
	bh=dcDmvzADvLAa9s73l6GbiE8iEYUbIBGgrJgrTQzXJgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mrr/tHp8sVvhcx/LlV110RWOUXAtuFUnbedxbNuC6QPt0EUozGW4aa6n4opfPvngxGmtikt2kLJPJiQu+i1xzlqO30AA7M/9jt2hdNEScn7/6aEF5Z1VOChHzydbGOl6wSmbN3xnYE18TOaFhw5S1S0sZ+d7d3EWktrIXkPusAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=OW4WwDrG; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="OW4WwDrG"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2cf1646bd11so4633773eec.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 16:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1775863835; x=1776468635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHttyiBQABFZFJ9QRm5pPYMSzKpe9Fu10AMSmNwuwNU=;
        b=OW4WwDrGtY6LAy57yFyn9ICMWKSc19ZwVgPwfFvaXrmR+dLBsj4g7wuT0vpa0V0guW
         5h3O6IY4IxKrunsN2fXO8smW/qoTUocBm/XOF2DbhyFFEGEa9JeBKRx5cMa2lufl6SM1
         Dr8myMLEZyuhIlWLwN3xmase5zDnUorccUla/bT396hH1ZmaAQNA8ah5RfWmEClx2Tpp
         LwBEfbo+288pKl5vyT8hpFS1MsQDOevQaM+MLnCF6tbNwIMCAs/vPcAFH/I0aObf1BFQ
         qYALrqWKCIQ/LX+jAabY2Gzgow2SyiAhSGI5uhsNkMSbt4uD9IUaNblBUDMvKYYiR8sl
         Gfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775863835; x=1776468635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHttyiBQABFZFJ9QRm5pPYMSzKpe9Fu10AMSmNwuwNU=;
        b=ZUc/6ws15FdIlfT69w3KuzPphngrLC3P367vCj98hkmvOaEsmt5VyKzm2Xoi04Ducx
         0vP/rn3E4tx9IFX2nTReeZ1+Wnuv2BvcLg67kLJKOlS/2vx7BOt5vb6Zep0sHFotRTPD
         Jn+CG9QsqQddfMveM0vkOiLskFUpjDBHhIIc1NXra9dAMAHjiZaIdclonck2+SmddH/P
         2EW74i75FQMm/z10/qhN7sjMYglx/71Kq/voar5YjYT/du9kugbWp54wb+SCZ8UxyO6U
         hCp36EocSK74FCKmUMo/4aEE/my88mjg6phL9Bf0X51JWc06mtBlfymkpcq4ewpyk30J
         HIHw==
X-Forwarded-Encrypted: i=1; AJvYcCVprmyuvWsK7uX6YQ19aDFwEUw77f6qybS6+DI20qn0SvyJ3oE8oGK+qRcguHF7BY12iqr/fiFh+jFuxwbp@vger.kernel.org
X-Gm-Message-State: AOJu0YwhjUURLrGQcqCChmhP2VFTyEy6mOlUOjUEfxnbH+mBXcoh7TOk
	xSEKNtAyVN5ToxHCjiVnAjfmZxZep0nnbZnpKt5wMyPcHDTv8x7UK9+ryNcxgnEfJqU=
X-Gm-Gg: AeBDietMJDg1voU9ir+BXj3dFUbKFotoAA92acD0sqvxrMrvtwn2xMWnmIsM2r5WmWE
	hQmR/bGp1juK2jWZGOMHcKJOdnjl5ytSr0e2flBfgX8o4hORD/mWz988g76VNPrxW9SSBrsBJTr
	zqsr8QZC4hcK5yxLq6uG6ze48zWajlJk5/rcyUp0gYQQSvr2HYyEuJH9kzmKK7pkI7gKopLzV/N
	FlRO24FIOb4STevEmGnPKsPIUwrdaKcyBe5KZCYXKAkZxPSUo3Ir9LcXirJLSoo7wimMEiaA3Fu
	p1J52dd6sUp53r8lbYmK7feXb76xTJuTo+C0EctUzVcI1Ec62OTep7LeQi9C2oez5TlKfv5JZmP
	wsyDB0grtizlgh3pgjqBtq7U09zJVUeqm52XNLqSR2gdfPZO+v3ai21gERlTplpUkY3FmCH/KQa
	hyYkR55FQg+HWqUEBVtC8Z4AQqw9/ZhDsXwj0=
X-Received: by 2002:a05:693c:2a03:b0:2d6:3ff4:5dbf with SMTP id 5a478bee46e88-2d63ff46040mr1554512eec.6.1775863835349;
        Fri, 10 Apr 2026 16:30:35 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:3c8c:e28:ae12:f28d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c69d5sm7408208eec.3.2026.04.10.16.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 16:30:34 -0700 (PDT)
Date: Fri, 10 Apr 2026 16:30:32 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Layton <jlayton@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
Message-ID: <admIGCR-xGfKgIQ-@mozart.vkv.me>
References: <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
 <adkk8FiLHnVx1Bup@tardis.local>
 <CAHk-=wjuOm+AGHtjF15Zx8cxJwYwbzJgi28EQ6KW=Ze-4YjN+g@mail.gmail.com>
 <4305138de599923591df7403aefc4d663f50324a.camel@kernel.org>
 <20260410191907.GV3836593@ZenIV>
 <30ac5108ada614560326636d4da353d6304c3f91.camel@kernel.org>
 <adln5vp9HFbX-oz0@mozart.vkv.me>
 <20260410212403.GY3836593@ZenIV>
 <adl2dMjN2hmVvORh@mozart.vkv.me>
 <20260410230553.GZ3836593@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260410230553.GZ3836593@ZenIV>

On Saturday 04/11 at 00:05 +0100, Al Viro wrote:
> On Fri, Apr 10, 2026 at 03:15:16PM -0700, Calvin Owens wrote:
> > On Friday 04/10 at 22:24 +0100, Al Viro wrote:
> > > On Fri, Apr 10, 2026 at 02:13:10PM -0700, Calvin Owens wrote:
> > > > On Friday 04/10 at 15:32 -0400, Jeff Layton wrote:
> > > > > Yep, not even with that. One thing that claude pointed out: doing an
> > > > > mdelay() might prevent it from making any progress freeing dentries.
> > > > > I'm experimenting now with one that only randomly does a delay, but so
> > > > > far that hasn't turned up anything. I'll let you know if that changes.
> > > > 
> > > > Hi Jeff,
> > > > 
> > > > I've been poking at this one too. With the attached reproducer, the
> > > > waiter will get stuck in an infinite loop apparently in d_walk() with a
> > > > stock 7.0-rc7 (in my case with PREEMPT_LAZY):
> > > 
> > > Interesting...  I'll try it in a bit, but just in case - could you check if
> > > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.dcache-busy-wait
> > > steps into the same thing on your setup?
> > 
> > Hi Al,
> > 
> > It still reproduces on that branch in the exact same way.
> > 
> > I'm absolutely 100% guessing... but I recall tomfoolery with the "magic"
> > symlinks in /proc/$/fd/* in the past... the below patch makes the infinite
> > spins impossible to trigger with my reproducer, does my explanation make
> > any sense to you? Apologies if I'm off in the weeds...
> 
> What it's doing, AFAICS, is a weird way of opening arseloads of files, mostly
> the same ones again and again - the reason it needs that prlimit (there's
> way fewer files in procfs when it starts) is that these threads keep running
> through each other's /proc/*/fd and opening what they'd got again and again,
> adding to /proc/*/fd/* as they go.

Yes exactly, I was trying a lot of different pathological behaviors and
that was the first pattern I found that triggered the d_walk() spin
consistently.

Initially I made the reproducer ignore itself in /proc. But it turns out
to be much more reliable if it *doesn't*. I realized it was opening its
own children's files in /proc/*/fd/*, and the children were also opening
other /proc files, which is what made me suspect the magic symlinks.

> IOW, you are opening a random mix of files, both procfs and ones some processes
> had opened, then exiting.  That triggers invalidation of your /proc/*, with
> a _lot_ of shite that needs to be taken out.  It might be triggering a livelock
> or a UAF somewhere in dcache or it might be something entirely different -
> no idea at that point.  I'll look further into that, but I wouldn't be surprised
> if it turns out to be entirely unrelated.  Would be easier to deal with if the
> mix had been more predictable, but we have what we have...

I'm sure I can narrow down the reproducer more, I'll try a bit.

I appreciate you taking a look. I'm happy to test anything else you like
if that reproducer isn't working for you, it's very consistent for me on
two different machines. Hopefully it works for Jeff.

Thanks,
Calvin
