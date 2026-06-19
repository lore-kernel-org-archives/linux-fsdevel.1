Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E681D326928;
	Fri, 19 Jun 2026 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781867498; cv=none; b=qg3AgKvXmo+sKoKZF5aPnwpI+9hez79zonRoRj3OkdXlMlOtemmYOnO1zQB+pelYBWD9N5Lcpg7Z5825tKxI9gFVDjAPEVB9xQIceMIYz/ivTfG91uauIvl6HoZsd/hq9tkZX5Y8OlRDaVlGsa7NNkEqHlV18izfBebqdYXWcak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781867498; c=relaxed/simple;
	bh=iJOKcZvygsqgxm7muAKd+76uHoZFFY5TClZKa0FpZrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwdYlpCVQ4z8ea+vJH5dqJ/11R/XWvVrgVGpBcZgS6oo4C4mXvrX+p8u3uB16Fr53bRMxOyFZE9ilFT5y3eF4GHm4vdIVC/LwiCyffs2+s2Bayu77h3I09Ofpr3unJ/I4cZptNC5LHkQpGYi+LEtM3txdcJU+OtgqlWOsZdu2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i02R1fLG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i02R1fLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08641F000E9;
	Fri, 19 Jun 2026 11:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781867497;
	bh=iJOKcZvygsqgxm7muAKd+76uHoZFFY5TClZKa0FpZrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i02R1fLGWodVSipWVNcr/NHtzTLSPn4Vwoo5KZnlFsrozVruc5I1skirY/Hh6Yc9L
	 8R+b7OuoNsli3otBv8hqVAmkK/Df76UWA2/NwJ9UnxH77HoXlL2rx8gGZhzHsF38mZ
	 MirD6gCLvbH0teVyfEPwjZvLGN1q9I7kMqQC6MebmoI21QQSVKyAlHvx8JJ12KW0W0
	 Tx+Uo3E+Q/kLwCjBHoqk2IJ7f9vdtFfVFGcKRUNXhHJ7QcRnGz3gbukp8xjcoVKEte
	 MJegk+tCRGtXs1nfC9l0Mx3DQAcJnT14ZrOoVUzxT0FVbx11etk/prYlwB+dtlrhbU
	 47iIEXXmJfNJA==
Date: Fri, 19 Jun 2026 12:11:31 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Suren Baghdasaryan <surenb@google.com>, Jan Kara <jack@suse.cz>, 
	kernel test robot <oliver.sang@intel.com>, Frederick Mayle <fmayle@google.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Andrew Morton <akpm@linux-foundation.org>, 
	Kalesh Singh <kaleshsingh@google.com>, David Hildenbrand <david@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [linux-next:master] [mm] 7b32f64bc5:
 pts.svt-av1.Preset13.Bosphorus4K.frames_per_second 45.8% regression
Message-ID: <ajUj2adtJakEG0ZO@lucifer>
References: <202606181547.617a6967-lkp@intel.com>
 <6z2rqmo7b6m2rdhqurspwya25ps4dj7lctdygnmq3rn4xt6h3i@57kiiy72epgd>
 <ajP_-zqVPtbzvc9j@lucifer>
 <CAJuCfpFed0GuMk+dE-Xn0w45Mn1Spds-pc2BE__FUoWm6+R7_w@mail.gmail.com>
 <ajQbXthzbr9xgUIM@pedro-suse>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajQbXthzbr9xgUIM@pedro-suse>

On Thu, Jun 18, 2026 at 05:32:31PM +0100, Pedro Falcato wrote:
> On Thu, Jun 18, 2026 at 04:03:43PM +0000, Suren Baghdasaryan wrote:
> > On Thu, Jun 18, 2026 at 2:30 PM Lorenzo Stoakes <ljs@kernel.org> wrote:
> > >
> > > On Thu, Jun 18, 2026 at 11:30:47AM +0200, Jan Kara wrote:
> > > > On Thu 18-06-26 16:00:42, kernel test robot wrote:
> > > > > Hello,
> > > > >
> > > > > kernel test robot noticed a 45.8% regression of pts.svt-av1.Preset13.Bosphorus4K.frames_per_second on:
> > > >
> > > > This one looks serious enough and real. It would be good to figure out what
> > > > happens in this benchmark that it benefits from the readahead across VMA
> > > > boundaries so much...
> > >
> > > I think a revert first no? This seems pretty huge for something that isn't key
> > > to the kernel, then a new attempt can be tried with this issue addressed
> > > perhaps?
> >
> > A quick search yields: "The
> > pts.svt-av1.Preset13.Bosphorus4K.frames_per_second is a benchmarking
> > metric from the Phoronix Test Suite that measures how many frames per
> > second a CPU can encode using the open-source SVT-AV1 video encoder."
> >
> > If this is a video encoding benchmark I would expect it to explicitly
> > prefetch the data from the disk before measuring the encoding speed.
> > If limiting readahead caused this regression, I suspect the benchmark
> > doesn't explicitly prefetch the data...
>
> Well, commonly video data doesn't actually fit in memory :)
>
> A quick look at the code (I think it's https://gitlab.com/AOMediaCodec/SVT-AV1/-/blob/master/Source/App/app_process_cmd.c#L821)
> suggests it is progressively mapping the file data for a given frame
> (or frames?). So the old behavior would result in page faults for a given
> frame starting readahead for the next few frames. This looks reasonable.
>
> FWIW I suspected this was a really weird case regarding mprotect or
> something, and I'm happy it isn't; but at least I had a suggestion for that -
> for this, maybe dropping the change (for now?) is the best course of action.

Am sending a revert.

>
> --
> Pedro

Thanks, Lorenzo
