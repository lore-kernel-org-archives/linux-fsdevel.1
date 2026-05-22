Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B121639AD41;
	Fri, 22 May 2026 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779455478; cv=none; b=Uuq2nwwHT5qGUpA77j602sVIK78zgQ0BWPkKgNiqNja8+/k1KBI3ETVkSVu99syb9VsHuWQ9IMoNnMi/IBr+X3ljulWdCTsAQOcHHGfILmUJ+vpX0Uz/iRljEvgb3PFa+JWmt4XDt21zsyCp2qCarKimt629BVG0TskcEGrRvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779455478; c=relaxed/simple;
	bh=g4tiLej6yCZ2ZNHOanffuTAJlssE9yYgA4axNTP0NW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecmNCh7sEszE+Sg6f6q11Z4FAZErOuuZQMbH+f6s1yWlp5fNFCsGUBXEzIU1F5NfiZI4wA3YLBRETfgQnusgbtpsUyafI3rZCy87k13SYJOTwVCMuq67FnYIZfWZRne+QL82hmO2E/NHg03XfcxLO4d4cXsR82Q2+8bF8HtJhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnn6LREn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnn6LREn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD09D1F000E9;
	Fri, 22 May 2026 13:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779455476;
	bh=Nrj1M7t7JdiUm31R6wOAJFhKfFY3UAipdy+ym3Mbjk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nnn6LREn6/bKi8ue8FsN6NzABofKHHhWhj0eDDZKPN0gZAbnxKO41Zk0931LtkEuD
	 RTWoM6MjferN2trIWxeogd1ghjN35n8EzjCXzlDz5D2mfPH5P8XuwjuJZ2YjaV50E7
	 mBq6MenX93+6+aK72iVdc88QS2g8AHCBPNcSBWhxYEQWPtK8UwpvSIF4f++U0b1D2I
	 NMKbhQ2nm5JA/UTW/+yQB/qBq5Rvu9eMq4zNSZTRe+rwJtpLjK3qZUU9yTHSgeXcEH
	 Bh6yQjx5ePW4RHVFMs1YZKqkwBwtjKvoG9F+urOozEDp34XlUnWGaz4XMEkEpHaqrQ
	 SFwWMpRBQcWhw==
Date: Fri, 22 May 2026 15:11:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
Message-ID: <20260522-haltestelle-laufpass-volltreffer-3c69a6d84fc4@brauner>
References: <20260516182126.530498-1-pfalcato@suse.de>
 <20260518-starten-messdaten-3b8aa670ec85@brauner>
 <CAG48ez0jbSUgT3ZxPKZP7Eu=K7ce2cX7k2NzHCHNMOxQjOGT9w@mail.gmail.com>
 <177918418452.771415.4371785688744608623.b4-reply@b4>
 <CAGudoHFtecdkcYpFrtM5RAAPSU11eL_ALPGp_jhtHW=WxyHE4Q@mail.gmail.com>
 <177918837114.804096.3977912252785122973.b4-reply@b4>
 <CAGudoHGSZOEzbXHOAGqrdp6D06JQQ5Af759TQ+HiQx7=ruQa-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGSZOEzbXHOAGqrdp6D06JQQ5Af759TQ+HiQx7=ruQa-Q@mail.gmail.com>

On Tue, May 19, 2026 at 01:56:42PM +0200, Mateusz Guzik wrote:
> On Tue, May 19, 2026 at 12:59 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On 2026-05-19 12:51 +0200, Mateusz Guzik wrote:
> > > How about denial of splice usage or degradation to copy are still on
> > > the table, but based on a different criterion: whether code involved
> > > is "known good" for lack of a better description. iow the kernel would
> > > maintain a whitelist of "safe" cases. Random-ass AF_NOBODYEVERHEARDOF
> > > does not make the cut.
> >
> > I had thought about that to but I felt a bit iffy about it. You could
> > envision an FOP_* flag for this:
> >
> >   /* Module may use splice-like apis */
> >   #define FOP_MAY_SPLICE          ((__force fop_flags_t)(1 << 8))
> >
> > But that doesn't address how fundamentally broken vmsplice() for example
> > really is and that probably no one should get to use it in its current
> > form.
> 
> I never looked into the area on Linux, I am willing to take claims of
> breakage on face value.
> 
> In this context I'm saying the functionality is used in the real world
> for performance reasons and just whacking imo does not cut it.
> 
> >
> > > Common-case usage would have to be audited of course, but this sounds
> > > rather actionable and would provide hardening without much friction.
> >
> > And that's the usual problem where rando module will just raise the
> > flag. Maybe that's fine and we will keep up.
> >
> 
> If this is a genuine worry the whitelist can still be introduced and
> managed by one person (Linus?) very easily. The implementation is only
> mildly cumbersome to get going and trivial to spread afterwards.
> 
> You could have something like this:
> struct file_operations funky_ops = {
> ....
> };
> VFS_FILE_OPS_REGISTER(funky_ops);

Unless someone is going to do that work a sysctl to force degrade all
the APIs into copies should be ok.
