Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791083C09EA
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954517; cv=none; b=kphTvVlybOzv3y57saNzfyOyKCiIo9bQfDT1yLDN0UALJscc5h9SVV8BI3v+GCWS1k3t8bfcoVkaVU9//H+cdVNI0orE9RjUO2/hVXzlooflWNg3VrF3ESV+vpqZh8aGEpZYtheCwBjPpsXFaOhZ/wij+UrpE1fSfidcK6q6kvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954517; c=relaxed/simple;
	bh=7zExxZFZQe9SsEFg2kY4sOMNSg3WP5NaxbQbgHMWqN8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3OP0BhbQxLrIm6xlq3ljSnSpmBBTJxt0/dTZ90/f2PEuB1Jqn9rliAiMb49SZj++YOFyjQqNtbb2ELpgR1STeERRU6F7Sxcwrbw4+x/AAkNdgjH908/g+ij+CYPqGorKhQoQqjaV8u/q+eo9v9HTPf4goEKClgzkcC4AEQEgxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4V0Uwrg; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4V0Uwrg"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbb7926836eso2067691a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 01:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786954515; x=1787559315; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9JMAzOs5+LtBIqUezQL36zcGBLXxM2/IsK2lzs3jOBk=;
        b=i4V0UwrgZlHv8pmS8La4aciGUBUQuHlsD/p4BmCss+TbkVizGVrTkLnHsAvSArXSsp
         L/GtQb1wDVc1fcXHuwICN4NBy/18IBSzsQNFIHDM8TU8a+qO4XSvjDKUu4KgeOeBiKm+
         bp1Rfkz9w2ma9Mh2SFwnnPYfQpN4mY5ToRXsXyh98IB1hu4Vqewu4eZ1YPmrzf7kscsz
         uoGDD7m4mpwC8ouOOtBBa+/aMT4gvGkVFM8shVFwXNkFIfCPdVMb5E8Ujjnw1m0aPVva
         ekDAcKE9MbKb8I16Uvh963xbWPLJuRsgJ9yVElsgCQ3uVFHY65EbBhm7SnS39cPrzD45
         znOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786954515; x=1787559315;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9JMAzOs5+LtBIqUezQL36zcGBLXxM2/IsK2lzs3jOBk=;
        b=sLqrFe9PYsyKRd+6TBumHvg1pAmR2n1hPRBx79gRkMXse1zQzlxz1E2iTbJHyMkMhQ
         yCtQOoAXIeu2XP3WdMIBz8z8u9WalvUXfaz3Mlc1tZk0QZRIlbNsD/VcM/jODXzQ/pk4
         5Sy4VFNah7gZnxpQvicbI0yKvBcRHkVzrd4DDbSQkqVL0EVq1fsUlTh3isetWf4g/vB9
         V3hSwzYYyCwRc+kLi6xYYk3mYBmYzsfhOmuWaP4zM7jygWC5GBPwMsIssJz0JYQu0uQH
         socy8Vr8TMaJYkzQmmRyQPey3+9/lkSMjwAdUGQv7WLir62+Bbeenp0qe35KlDVqvfj5
         nXBA==
X-Forwarded-Encrypted: i=1; AHgh+RosQmtsL+PA+Jd3gfcl9AI1NPF1tVstX8aPimQwFNRv65P1D/GKUFlBKquLLo1JDAdEW05hXGmXH4pz5HXv@vger.kernel.org
X-Gm-Message-State: AOJu0YyQD2wbupRxhOyLRG5R4O+iFmBpeie4nEW+G5/5jvPflE43gD9n
	enXVCM1AYypcc8CN4BpGTnNXxhjFJcJW/xUpXFEEEZM+jQrJHZCGfZxj
X-Gm-Gg: AR+sD12+ozEBItg/IUd+4Pmvh0ObuJTtZ0ySJU1/lx6DowSZIrVZ40hyXaUPZ0d2kOB
	WS+uYpR8U/EtaEuoFk1cHjyCJbmfzmkABB+9I+WMMUagC2guxg6DpIxrUBHAxv+9CWb7mqljGgX
	UOWTsHXNWsUKzfaZmF4LMLajpl7P5P/uuNfzer9GKXSWVAcfIKWrsTfiTz88wDDPAnCyzXwbVDn
	S5+CgwAqHsituMe5aSlgiUAryq78w/1w++rk+bMZuaAxDqsdrBJg/+L4KHnouy0JrDEt0A8EGWk
	k0eDiBrrMZhMyudBFN77jNUrQytqv4WzN+5Bbh3LphrBflaYdsOiPrTwyCKXqiNjrqYRXEbNhfj
	3hVOGDxuM3QPyCnR8v3zTCGBNTGXDsNAGrHoKc7rfjfjQ/MbJH3f03HoDLQt8aaCGfZ0OxGfDvz
	qSsOHxgctvH13w+jUw3IiWb6ol27GzuaLsvR2lNLC7GRncrXxvVM0/6bFR24CA3NmLZtt4+/gUq
	fyMARuIpVikdDW74adGf/2cG1JmkskXDH4DDnAAOomSb10afp/rcvpouKkYuDwsIqv6LrU9PY0m
	OhWRMgYM5iI=
X-Received: by 2002:a05:6a00:4481:b0:847:770f:da4c with SMTP id d2e1a72fcca58-84fde405e20mr22174169b3a.16.1786954515325;
        Mon, 17 Aug 2026 01:15:15 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d223d97sm2255073b3a.28.2026.08.17.01.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 01:15:14 -0700 (PDT)
Date: Mon, 17 Aug 2026 17:15:11 +0900
Message-ID: <m2se4dp3hs.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: ljs@kernel.org
Cc: daniel@thingy.jp,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	geert@linux-m68k.org,
	arnd@arndb.de,
	willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] mm: nommu: fix an issue on map request to /dev/zero
In-Reply-To: <an8PTKUAuZh3BtJm@lucifer>
References: <20260813063401.1786548-1-thehajime@gmail.com>
	<20260813063401.1786548-4-thehajime@gmail.com>
	<2026081355-remold-sterility-84f9@gregkh>
	<CAFr9PX=zC8GnxwrR=wTwA4xQq89cHYpxZWooS+-=Q-WuNbjanQ@mail.gmail.com>
	<an3COKVbgQKdY52d@lucifer>
	<m25x1crhym.wl-thehajime@gmail.com>
	<an8PTKUAuZh3BtJm@lucifer>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


On Fri, 14 Aug 2026 22:02:21 +0900,
Lorenzo Stoakes (ARM) wrote:
> 
> On Fri, Aug 14, 2026 at 09:42:57PM +0900, Hajime Tazaki wrote:
> >
> > Hello Lorenzo,
> >
> > On Thu, 13 Aug 2026 22:29:38 +0900,
> > Lorenzo Stoakes (ARM) wrote:
> > >
> > > On Thu, Aug 13, 2026 at 09:43:37PM +0900, Daniel Palmer wrote:
> > > > Hi Greg,
> > > >
> > > > On Thu, 13 Aug 2026 at 21:26, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > > Given the age of this issue, I don't think anyone uses no-mmu systems
> > > > > anymore :(
> > > >
> > > > There are a few of us using it for hobby stuff[0][1] and there are
> > > > apparently people using it for actual commercial stuff.
> > > > There was a session about this at LPC 2025...
> > > >
> > > > One of the big problems for nommu seems to be that everyone is
> > > > convinced it is completely unused and totally broken. :)
> > >
> > > No, the issue is that nobody seems to do any testing or contribute any code
> > > aside from at least Hajime (thanks Haijme :), and possibly others (forgive me if
> > > I am missing people's names here!)
> > >
> > > There's been situtions where nommu has been broken for a year and _nobody
> > > noticed_.
> > >
> > > And yet whenever nommu comes up people always seem to pop up and say how
> > > important it is, then mention a talk etc.
> > >
> > > Well if it's important, test it. Test the tip kernel. Report bugs. Contribute
> > > code. Any or all of it :)
> > >
> > > Meanwhile we in mm have to _constantly_ fix stuff up in nommu because it's a
> > > total mess and has real maintenance overhead.
> > >
> > > Having to account for legacy systems that make no sense in 2026 when you're
> > > trying to make improvements to systems people use, or not being able to do
> > > certain things, really grates after a while.
> > >
> > > I mean if you don't believe me git log mm/nommu.c. This overhead reason is why I
> > > now co-maintain it.
> >
> > after spending more times to look at code, fixing issues, finding
> > other flaws, etc, now I become to understand what you meant in past
> > emails, when you're saying a more maintainable way of implementation
> > of nommu.c.
> 
> Yes :)
> 
> Thanks for having some empathy about this :) It seems a lot of the nommu
> advocates simply assume it's little or no overhead and is 'working
> code'. No and no.

indeed, agree.

> I know Liam had to do a _lot_ of work on maple tree to make things work
> there, for instance.

yes, I also encountered an issue involving maple tree on nommu (with
some crash of UML), and initially it was not really sure what was
going on.  It was not an issue of maple-tree itself but the usage of
it was not correct.

> And the recent VMA flags changes have had to be heavily updated to account
> for nommu.
> 
> And the list goes on. New features have to touch it all the time to avoid
> build failures even, and etc. etc.
> 
> It's a really absurd situation to be honest and the RoI isn't there at all.
> 
> There's a reason I keep going on about this :)

I still understand your pains.

> >
> > Since I wish to use nommu.c in future with the latest kernel, I'd like
> > to contribute it for, let's say, refactoring the nommu component which
> > mm subsystem currently has.
> >
> > but for the moment, I wish to start with introducing test cases from
> > very basic checks (which is in the [6/6] patch of this series).
> > Without such a base, we may not have any chances to improve this nasty
> > situation of nommu component in mm subsystem.
> >
> > # this motivation also applies to LTP (linux test project) which
> >   currently doesn't support running tests on nommu platforms (I've
> >   already started).
> >
> > And also as I mentioned before, ideally the code should be maintained
> > by people who use it.  And if I claimed that I used/use/will use
> > nommu.c, I wish to maintain this, or at least wish to help to decrease
> > the overhead of maintainers.  This series is a very fist step toward
> > this.
> >
> > I hope it clarifies a bit for your concerns,
> 
> Thanks, and I appreciate that you're actually doing work here, but I'm not
> sure a single person suffices for this, as well intentioned as you are.

I agree.

I wish that having public test cases would motivate other people to
fix/improve/extend code (because his/her patch has less regressions),
to make this initial attempt useful for broader audience.

So initially this is just a one-man contribution, and I also think
it's not sufficient, but I'm always motivated (and assumed) that an
initial contribution could open the doors to the any other people.

> And as reviewed, these changes seem to be adding _more_ maintainership
> overhead rather than less, I fear.

for this /dev/zero patch in a current shape, I agree.

for other fixes to the shrink/split flaws, I will try to improve it to
let less overhead to maintain (by addressing your comments).

> I believe nommu is pretty broken across many domains (it's fun to set
> claude on it for instance).

ah, I also have thought about that.

> And we've already spoken about broken things that have sat around for
> a long time.
> 
> The way it's implemented now is just horrendous in any case, if we were
> forced to keep it in the upstream kernel then the correct solution would be
> something that somehow 'emulates' an mmu system.
> 
> But I'm not sure that's even workable, and likely implies heavy
> maintainership headaches.

Indeed, an emulation of mmu would be one promising direction.
I would like to spend more time to compare other alternatives for this
goal (which might not be a trivial hack).

-- Hajime
