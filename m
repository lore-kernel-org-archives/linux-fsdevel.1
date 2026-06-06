Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCE62DCF74;
	Sat,  6 Jun 2026 04:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780719676; cv=none; b=Dq+Yrk4+ZXm1ulqOFEAS1kzt4Jel1x4NWt605O7iKYzKttByMVXyNF2ec84hIAIDkSWDr8C1ja0xC0hxkFqu+fviqCAdIfCRpC44YEt+1yEpV/73temYrfbof0INm/9boigTr0uiI7uVfXNyUk2K68YLmF89w2lW36Z8ATUhilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780719676; c=relaxed/simple;
	bh=/5T4r/4YuEXxXmTebYRrDOolY7stlmS9/wCMdd1GX+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOcdVdMSv1Kv7jtLTLBjg4jCHGXttd6C9DQq19hzWXOhpf727WCKChHYxxdugE4xIaAB6YV8fVAGh8o19XLP3X4he173N9fytAczXnEC8d+2GuPaOD49gpA3+C2KjkdisOCjj5SvikOHnD7HlQU5KzOgA7djB5bPy2j6LlQup7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XRW1f4xS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XRW1f4xS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=Eow6c9zH9y/Hjd7YHg26Ev6R5zFqZVxOpvcWsnD5eGg=; b=XRW1f4xS4mTUInQiDrWRusBxYQ
	37aT+IhgcoDF1+lGygfiJ/9poavTrfVXHMv0/je52q/ddpbe4xip3MCgFG8qWfV8v6NA1Aelhz07H
	coN8jJMS2EeBS/Q/S939pdqbJEiz2bPi2densR2TM7iFNI7eCiAJJqBtD/oYIk6dEH0ATYgJolhyx
	LguI9VKaGEKCQzFVmegXbOGhTDpzYCcoBCr2i6zCopT5wXNSvNhRcBlYQBhjGvI0YMfKdP2ajrHQ+
	ruhDoONzAQjjbNhGxloLS2+qHcyphDcQQKQfsdLRx6CBYFWO1KXdjya38KS99mO1X2AamI0RBJk2a
	l8/x05/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wViWz-0000000AogU-1nXP;
	Sat, 06 Jun 2026 04:21:09 +0000
Date: Sat, 6 Jun 2026 05:21:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] Maintainership of the EFS filesystem
Message-ID: <20260606042109.GG2636677@ZenIV>
References: <CAKqfh0HhN4zzV2=WJwC4ejRQup7Q3L6MkUegC9Bc0xFmzK+Msg@mail.gmail.com>
 <aiOXiumEOIPOQm93@casper.infradead.org>
 <CAKqfh0GNMAnNVvTu-aydHWywR4w-+E+FBtHEV_TCXxzvh6F4uA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKqfh0GNMAnNVvTu-aydHWywR4w-+E+FBtHEV_TCXxzvh6F4uA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 05, 2026 at 11:02:44PM -0500, Maxwell Doose wrote:
> On Fri, Jun 5, 2026 at 10:44 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > As I said, I don't see the point.  Do you have any EFS filesystems?
> 
> I don't personally have any EFS filesystems but that doesn't mean that
> others don't.
> 
> > Are you volunteering to do any major development on it?
> 
> Like I said, we've already found some problems, and like I said I'd
> like to fix those before it becomes a FUSE as you suggested. So I
> guess I'll volunteer to do some major development for it as well.

Out of curiosity - had there been anything beside the "some code that
had been ifdefed out since forever doesn't even build these days"
I've seen mentioned a while ago?

FWIW, I've no preferences re efs fate; a simple block-based r/o filesystem
is not a serious burden, provided that there's somebody to take care of
conversions on API changes (mount options parsing work, stuff like that).
However, that really assumes that there's some way to test such changes.

So the first question is whether such images can be found.  If not, there's
no point whatsoever - neither in kernel nor in userland.  If they are available,
it might make a useful learning experience...
