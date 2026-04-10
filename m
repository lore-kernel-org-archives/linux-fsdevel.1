Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5311A9F91
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836400; cv=none; b=XlmOODTqaeo32lZi7ArLH/0p9beTDjVKkRGvhQtiForTEZKMacE4Z5kYbAFXq+RbFKb64OpTf5FO2vpDAp5CCiVeqftZu4x22yP0JdCZwboKwGHJEJucNhU3M2jdGLP9POELYQyqZEpwQCEuz5ZRw204AfFFvaNN/YkTdqlYwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836400; c=relaxed/simple;
	bh=6fUbRn4DAzDNk+1O9rvZYSOGaXmIy4VNN1wwj+ZWJc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWNnNS8L1BH5CioFknTt+VBevMoAC00FMDTA1FqmgEkpA5etIog6F0HyM+2cxiLl0yVkSTNraZEX8TL2CiJ8fRrM+4X1hIZkVurRDG5S6CKiofAHMQyqe9wHX+bRiZwEJ7EjMepS5kBfUDT64gcQN5XwbauhxlzjGdV1nG477As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HdaUj7cr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HdaUj7cr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WEWLvoNIdNjFYIOUVGfTzC9qQTlEyTIF00FptGvBYuU=; b=HdaUj7crxbsyn4pivgZCnoQClx
	tdZPkB5efuUeY0SfZoKjB1MvUtBZPxUQC4J7ZdVXMS7noxjNYRLuhyBIzrdCDQ1grSVrX9/6X2JdO
	G/DopehDrcSkQpAk7X1Tjj+REV4G8a5ppWe0eACpTXV8bLee7cQitgpwHWyRdhGJct7f1IcA8QuCz
	RrwT4DLOHS+e+PlZftgrtOYJrxw8g28/ZF4cHZ2AF38auk7eTn7RluQJzuXXfNH4kaX4U3ALPSYXe
	z83kMMbfAYOgocWTXOahfKmL6Ixapr6v//9+lfBVFZ/h0exJh0z+zEXYDXk5r4kwVKT+7tUB7rquf
	rWUFqS0Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBEEA-00000006zyU-1fXr;
	Fri, 10 Apr 2026 15:57:02 +0000
Date: Fri, 10 Apr 2026 16:57:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Helge Deller <deller@kernel.org>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
Message-ID: <20260410155702.GT3836593@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
 <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
 <53b4795292d1df2fe1569fc724325ab52fcab322.camel@kernel.org>
 <20260409190213.GQ3836593@ZenIV>
 <41cfd0f95b7fde411c0d59463dce979be89cb8ef.camel@kernel.org>
 <20260409215733.GS3836593@ZenIV>
 <20260410084839.GA1310153@ZenIV>
 <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjRgHLvSnEY3P45hSQ0ycKxdz-xqnccAMPuGRrwsvWdig@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

[belatedly Cc'ing Helge on this one]

On Fri, Apr 10, 2026 at 08:25:27AM -0700, Linus Torvalds wrote:
> [ Adding RCU maintainers to the participants: see
> 
>   https://lore.kernel.org/all/20260410084839.GA1310153@ZenIV/

FWIW, the thread starting at https://lore.kernel.org/all/adQO8B0rkR2ftusI@p100/
might also be relevant - another UAF report in the same area, this one
with more(?) reliable reproducer, parisc-specific.

>  and the fairly long thread associated with it  for context ]
