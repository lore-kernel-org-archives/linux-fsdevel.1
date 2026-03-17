Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5623E3C5D;
	Tue, 17 Mar 2026 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757032; cv=none; b=WOfFoGBEjwc0V9iSJJTsofkMYKYBEWxr+WgCys0Ah1I4ZE0nGa8a0Ke8eMUJporTZNOc1jyYPdm65i3IYCg3Wn3bnl+6G1tODDmHXx3PzCbgCiYTHPzmjwKeBfbwl967zJvdxs/iXS5Y8G5j6Owj/JXOrwZHnt/BxuW05ivTTek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757032; c=relaxed/simple;
	bh=8OvAu5+Nc5+gftAvvo92Qu9CCSdYvSPDSwxu2oBdyzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSut99/hI4bXZWfk3PjJm4x6jzINjjd4FcFxQMk6wk9nCRLy4yNruneZjsE79mk5YqZudNlraoR+Ns1NdcFo9VTN5zgnt+1oh1anzcWBRRlNM6RVfMRTbnY3Xkvcd204c5GBT4CVQ/NDsNEwWrFD0W9XRFJLP4cnOloZYl9+myI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1R/uWyx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1R/uWyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09940C4CEF7;
	Tue, 17 Mar 2026 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773757031;
	bh=8OvAu5+Nc5+gftAvvo92Qu9CCSdYvSPDSwxu2oBdyzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1R/uWyxb3tzUfzJXwVY6Mp9RsZtmC3jI9aK+DNrxFWuiNrvdp20hErTDOQihs480
	 DVRgKIlnuLMPnW1AoX/HCoTXRGf2req4Wt6m4ByNTuAwByoW2qipPFiGdiW7Bpngq6
	 /R/N3QTM8qNHQHG8gb++7aBxMaX5RjGP1uzr9HOWdvKhNakLIFoPpTHCSxVRA05nDE
	 kdLzDgTMumCGCv/wDbUxQYdZ5B7wELR1Zopu3ZoGXEc0LGuw1ZwdcmW1qlYuk7ihpm
	 lY+NRe3XQaU2YQR8D2muqc0LPTjitSLhm7ajC8GL0jYakkN8RhfVsBmT39Ee9DIChL
	 2D0oQV2zZeZ4A==
Date: Tue, 17 Mar 2026 15:17:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: VFS minor improvements policy
Message-ID: <20260317-ziffer-dahin-f1e651b5de70@brauner>
References: <1046306323.1691628.1773494663411@kpc.webmail.kpnmail.nl>
 <pjfdjimwb3br5wtut4a5q4xdys2mgf2d3hkajvinyphhoziaum@u55pnnlrfmgz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pjfdjimwb3br5wtut4a5q4xdys2mgf2d3hkajvinyphhoziaum@u55pnnlrfmgz>

On Tue, Mar 17, 2026 at 09:31:20AM +0100, Jan Kara wrote:
> Hi!
> 
> On Sat 14-03-26 14:24:23, Jori Koolstra wrote:
> > I submitted a patch a few days ago about fixing the docstring of
> > hash_name().  This is not a reminder of that patch, but today I came
> > across something else in the VFS code, while trying to implement a
> > mkdirat_fd syscall, that I thought might be slightly improved. We have
> > this anonymous enum:
> > 
> >    enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
> > 
> > but it is also used as an out parameter in filename_parentat() through
> > int *type.  Now you have to look up what this int might hold, so I wonder
> > should this struct not have an explicit type that filename_parentat()
> > uses?
> 
> I guess this is a bit matter of personal preference. I personally would
> prefer explicitely named enum in this case and use it where appropriate but

Me too and it should be cleaned up imho.

> Al? apparently preferred brewity and used 'int' everywhere. The borderline
> between "useless typedefs" and "documentation by types" is blurry. I'd say
> trying to "fix" this would do more harm than good.
> 
> > However, my question is really this: what is the stance of vfs
> > maintainers/reviewer for submitting these kind of patches? While going
> > through the code in more depth I've noticed wrong/unhelpful docstrings
> > here and there, and other minor "issues". Now, Greg KH has taught me to
> > be really conservative with what counts as an improvement, for instance
> > to not sneak-in white-space fixes in a patch.
> 
> If the documentation / comment is pointless or even wrong, that's
> definitely worth a fix. They are just not treated with particularly high
> priority but they are definitely needed.

Agreed.
