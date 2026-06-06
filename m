Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0880F2D9EDC;
	Sat,  6 Jun 2026 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780719673; cv=none; b=aJ9ljH4DvXgR4DIEaIjSR26CqZNcfO01nmXYB71+gNpPNxz/x8YLHtlqWX9Z8xGWUcqmeACKt88073naXpr53Ju1lSsBaPhc+mmd+No+0rRdNYy7MKJ2F/9Uj61l5zKJ5RLGDLeFBKtG8domkpqVJJEXwQe4DvwEpj/V968p/m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780719673; c=relaxed/simple;
	bh=rX45yuNPRSmAeuDaDm4TFkteDPWb/BM2nwwNR9P2Slw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcKYeokkD13xaW3Aztu1Ls72h7Zo0qHB+WI/ykUwpH76zve64vrIcEArc642pCPpoCU+HbusfiNojJJzXvfXqmsAB/tYoH8Ce7d5TmVG0lot5QfVqAwATk3+koFXZkAm6ZwHOOxhssT7vG4fq+oeTI72UpYN2FtzGiusAA0f+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xl3c+oBl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xl3c+oBl"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 893371F00893;
	Sat,  6 Jun 2026 04:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780719672;
	bh=ZmRX1cwyxZPiFbrMlkspevoTwd5x4seE6y7bMMX+VOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xl3c+oBl/qvUtTrpx2gGpLRMJkHcrRw3nS5LMa7W+yt4IZyhui6GAfcyC3FI6XOHh
	 9KPwKunB3hEqiHum5gr6LJIV5pkjvspN8iVNtsXacNqdpdPtwnyA7MI1wmkElUrAzE
	 ByX52+5LNYdps4rY4yOAoPNUaeqRh5rYxbg6QnUgHA2CIQHn/CUASzKp8R5dk996/O
	 UNhnQlMmeMgHy8XnuBqcUrexridN31Zr9WZ02s5ZPEfeXsH/Vp3XvPfpN8ys7a7qjT
	 p2AUhnamB/aM5sKOF2lmNEPc/oWLQGlvcZLCTGntEeeC/LDF2c6rtFckGDwssH1BEH
	 x0uuYo/Sbjc8w==
Date: Fri, 5 Jun 2026 21:21:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] Maintainership of the EFS filesystem
Message-ID: <20260606042112.GA6060@frogsfrogsfrogs>
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
> 
> > Why shouldn't we just delete it?
> 
> Because in my eyes it's an awful practice to just delete something
> overnight (probably not your plan but still), I think we need to have
> some maintenance for some time before this gets removed.

How do you plan to do QA with the EFS driver?  Is there a mkfs or fsck
program for it?  I don't see one in Debian, though I didn't search that
hard.

--D
