Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0053B27DE
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775856021; cv=none; b=fi9T6PnqXjpSzJZr7EH4WSqFpev7jtuzn9+mWRsK5/n0Ir0//CaiIMG7HbyZxEcOGkGawlKhvmTQjYZ6fHyktUQdyccivpxhoJqHueldHTYVp8w/EtRFvTac1xUksPYFoHn78SN3EhnIz+ZuSILYOg2Ajb3bc1gSN/QSbzlEz+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775856021; c=relaxed/simple;
	bh=2+CepZtOh18fxVZHlepH9B+wHSV6mnU0B3Y5f8xPB5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFYym8TU8gxqqCF72qHzQHJhq2+DCWc46viRp+oKuLg/BJt0KOuNgQ6PyP/2UFMCiAJ9Xc1e2t55EfwvSJ3o+XAwcOK3ilecY+d+7itVJlbwCZGs6a1zJ6/oCSLStvSijm2Lna2rQDFO7icJhFKo4YqepxImJ7w3BtvL+tA7c2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sb/MrHBz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sb/MrHBz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vEo5/tRB06ZLFTtadNPD7Jq0xaU0j1A5jGAMg+L/ElA=; b=sb/MrHBz1xtfVDQpTTDvV6WP0J
	LI3AQpJmVmXwa5jFoMf34M1FDNe+oLuhZdAbeLmxdXQYVLNn1ubTbzc4hrCKf+toCQQJF6kV6EZt0
	LPElIU86rRlaNj+Ak4/ggLkKqL33b5gVINulyHbP9FmF4E6pM7mWd7pOGNCmRnPNYyJxbGwpFVmZC
	P/la88TqTOVGCtdSfdDpgy2ZHmNyhvHSSIheaPLCF0kDdGRXhQ9uN8OdhigbYGI+nAtpRzhHOWXzq
	S2QgUiA8nzEXd8n4fGIBuBgkSdd38EW1xdOyFnj+ejRfO2wMzMVFBk0VGFxgKOL7bdpr7oxhhgHO3
	Y+iuzZXA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBJKd-00000007gCB-2jPV;
	Fri, 10 Apr 2026 21:24:03 +0000
Date: Fri, 10 Apr 2026 22:24:03 +0100
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
Message-ID: <20260410212403.GY3836593@ZenIV>
References: <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
 <20260409215733.GS3836593@ZenIV>
 <20260410084839.GA1310153@ZenIV>
 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
 <adkk8FiLHnVx1Bup@tardis.local>
 <CAHk-=wjuOm+AGHtjF15Zx8cxJwYwbzJgi28EQ6KW=Ze-4YjN+g@mail.gmail.com>
 <4305138de599923591df7403aefc4d663f50324a.camel@kernel.org>
 <20260410191907.GV3836593@ZenIV>
 <30ac5108ada614560326636d4da353d6304c3f91.camel@kernel.org>
 <adln5vp9HFbX-oz0@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adln5vp9HFbX-oz0@mozart.vkv.me>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 10, 2026 at 02:13:10PM -0700, Calvin Owens wrote:
> On Friday 04/10 at 15:32 -0400, Jeff Layton wrote:
> > Yep, not even with that. One thing that claude pointed out: doing an
> > mdelay() might prevent it from making any progress freeing dentries.
> > I'm experimenting now with one that only randomly does a delay, but so
> > far that hasn't turned up anything. I'll let you know if that changes.
> 
> Hi Jeff,
> 
> I've been poking at this one too. With the attached reproducer, the
> waiter will get stuck in an infinite loop apparently in d_walk() with a
> stock 7.0-rc7 (in my case with PREEMPT_LAZY):

Interesting...  I'll try it in a bit, but just in case - could you check if
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.dcache-busy-wait
steps into the same thing on your setup?
