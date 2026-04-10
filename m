Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C481F0991
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 23:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775862132; cv=none; b=VqmQVmMH9XK49iRUiXLeM5B+e1tacSyHOh3cH5Qrn9SDT0Jw/09gM/sV90Pe5wa2w6s5AVV0/ndnMgFyRRofLPZiZwo0gq6kxkcWS3Ln5QWIWEQKaBUR3ilEvGkgceM1tx9tjxm/Mu8myz5uUzXGXMTQYBa0Rptd+c4WVkXWHcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775862132; c=relaxed/simple;
	bh=u+sD4JLFbrmYRTtt/IJP1/6QPkPfiXBsg07Yv6C4Bj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOGk1P1Yj4uy1IxmrYJuZCdaA3CgNkVw5QSOs9p26GbSuAeUDrAv0++Ru/MnMbNLS/GQ84VtirlFT5bEKXgNZOpy1HTh8hFtsiMaFoLPNrz9j8UO5bLvXQhAervsVezL0gMhOJPzNeDlT1L1MxejIGF57FjlidmEzkh83XvUl+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wVHOR879; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wVHOR879"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3QCXLm7hTCIRCprEvrcvk4G75h3wNVPi3bdBkycM2rA=; b=wVHOR879aBwJnrrJ7QZ44lt4fw
	p43LZUVl2Z5wklgamdiLtp6YqTBqqAz5iZvnnnYf4yYhjkKbutk7t8vunl45tGIFNpVR9062zkopd
	boaX/HTpVeZTZKhkaWSeNYEIrrPXXn7W0rYooMaMW3jZDNmIDdPR4Gbcm/+bEwzMZLPiYKt5MovLd
	nLkM/3m5auOZ8GiXc/d9vcde++vKUWtF+F0oX3lt7WPfCk+ClLsinijDumsbEwYnlyVqiKrGpwdon
	m75HDu53YpkcbRQNtj58ezZ/VWERx6fS9+ziOXjS54CNefdt65n5mgKGvWUr/rrFQoOnAp2fnfSab
	F8Zah65Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBKvB-00000007qoe-3JxG;
	Fri, 10 Apr 2026 23:05:53 +0000
Date: Sat, 11 Apr 2026 00:05:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Calvin Owens <calvin@wbinvd.org>
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
Message-ID: <20260410230553.GZ3836593@ZenIV>
References: <20260410084839.GA1310153@ZenIV>
 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
 <adkk8FiLHnVx1Bup@tardis.local>
 <CAHk-=wjuOm+AGHtjF15Zx8cxJwYwbzJgi28EQ6KW=Ze-4YjN+g@mail.gmail.com>
 <4305138de599923591df7403aefc4d663f50324a.camel@kernel.org>
 <20260410191907.GV3836593@ZenIV>
 <30ac5108ada614560326636d4da353d6304c3f91.camel@kernel.org>
 <adln5vp9HFbX-oz0@mozart.vkv.me>
 <20260410212403.GY3836593@ZenIV>
 <adl2dMjN2hmVvORh@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adl2dMjN2hmVvORh@mozart.vkv.me>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 10, 2026 at 03:15:16PM -0700, Calvin Owens wrote:
> On Friday 04/10 at 22:24 +0100, Al Viro wrote:
> > On Fri, Apr 10, 2026 at 02:13:10PM -0700, Calvin Owens wrote:
> > > On Friday 04/10 at 15:32 -0400, Jeff Layton wrote:
> > > > Yep, not even with that. One thing that claude pointed out: doing an
> > > > mdelay() might prevent it from making any progress freeing dentries.
> > > > I'm experimenting now with one that only randomly does a delay, but so
> > > > far that hasn't turned up anything. I'll let you know if that changes.
> > > 
> > > Hi Jeff,
> > > 
> > > I've been poking at this one too. With the attached reproducer, the
> > > waiter will get stuck in an infinite loop apparently in d_walk() with a
> > > stock 7.0-rc7 (in my case with PREEMPT_LAZY):
> > 
> > Interesting...  I'll try it in a bit, but just in case - could you check if
> > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.dcache-busy-wait
> > steps into the same thing on your setup?
> 
> Hi Al,
> 
> It still reproduces on that branch in the exact same way.
> 
> I'm absolutely 100% guessing... but I recall tomfoolery with the "magic"
> symlinks in /proc/$/fd/* in the past... the below patch makes the infinite
> spins impossible to trigger with my reproducer, does my explanation make
> any sense to you? Apologies if I'm off in the weeds...

What it's doing, AFAICS, is a weird way of opening arseloads of files, mostly
the same ones again and again - the reason it needs that prlimit (there's
way fewer files in procfs when it starts) is that these threads keep running
through each other's /proc/*/fd and opening what they'd got again and again,
adding to /proc/*/fd/* as they go.

IOW, you are opening a random mix of files, both procfs and ones some processes
had opened, then exiting.  That triggers invalidation of your /proc/*, with
a _lot_ of shite that needs to be taken out.  It might be triggering a livelock
or a UAF somewhere in dcache or it might be something entirely different -
no idea at that point.  I'll look further into that, but I wouldn't be surprised
if it turns out to be entirely unrelated.  Would be easier to deal with if the
mix had been more predictable, but we have what we have...
