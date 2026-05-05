Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671DD3A8F7
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778012930; cv=none; b=kGj/XItTXs4oTH30RMtu1dAcFzQvB4LSuUfxlDu4MnNZsVEkd5UayaZSw2RObxGTwDPL2bp/sXG28evnDobBrh9pxU1qF3g+udJQL0jhtjA/NbbDVx98Bqz6Co+WR4WfJPwE7uDUbil1OMMUKTmCYi8NCR9h9FZh407kxXiTv/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778012930; c=relaxed/simple;
	bh=L3lQuz51YbpOJZmCb0rL7xSh4HKevO9kmwtWCsmkuh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0w3bwihoQN6kUINTP0ZSyvNiqC2+2E9SDps78goM/4nnhgVa2ly/RtxCBNHTQ725/znb5OW5siGnWhwP1+gHrjDMhkp0Ox0HoP5QKmEJgQKIo2TAU9nDHbkRrs6mCYXzcS22i4iIbARdtjIXehUhsjFg45TX5q4o4qZHUQ3Hno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ccrwX10A; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ccrwX10A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=As/cZ5HPyH3zNCjVk22IRnmhgn1KQIkmJdr0ClJAPag=; b=ccrwX10AkeY4bAVVpMsN4fR+Xo
	a+hA+8d1mLNwTDZ00jYGDpuKaawUAj0s01CMks+QVVWJs+2ne9gKfv0nVgGi1IYMU7SgmstcFomdR
	AH+18uI8IofwcKpY4UmJTTMLez5OmT0Ey0IzITc9gKHQdwFrcxtTyh4hZqhunSBly/hTTsbT4WMpg
	0rRaPbX5wguUomWM0z7dcn5MRzlrYqnGe54jllMywpehZXohkzVOcbTMMINUE8q1fdHzrFd7ejfk9
	mm+x21j6DOiOeXWGaTSt/Kv1eup7rJfORO/QvKrQH7cZWgFR1x0+Hd/hdBxRL72RTZftw+0OGCPBv
	Pq70cvsw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKMOA-00000008Coa-2qlO;
	Tue, 05 May 2026 20:29:06 +0000
Date: Tue, 5 May 2026 21:29:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>
Subject: Re: [RFC PATCH 03/25] fix a race between d_find_any_alias() and
 final dput() of NORCU dentries
Message-ID: <20260505202906.GG3518998@ZenIV>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-4-viro@zeniv.linux.org.uk>
 <CAHk-=wjSmm8r9yv6EvjaDYqMgBa1OwCi=W+NM9ZLzEgaGs66Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjSmm8r9yv6EvjaDYqMgBa1OwCi=W+NM9ZLzEgaGs66Bw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 05, 2026 at 10:06:06AM -0700, Linus Torvalds wrote:
> On Mon, 4 May 2026 at 22:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > +/* dentry->d_inode->i_lock must be held by caller */
> > +static inline bool __dget_alias_careful(struct dentry *dentry)
> 
> I know the double-underscore pattern is the standard pattern we use
> for "internal functions that have special requirements you need to
> care about" and I'll take the blame for that pattern... It goes back
> to the very beginning.
> 
> But maybe in cases like this, we could just instead document the rule
> in the name instead of that "careful" and double underscores?
> 
> IOW, how about just calling it
> 
>     static inline bool dget_alias_ilocked(struct dentry *dentry)
> 
> or something like that?

Makes sense, will do...
