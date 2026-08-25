Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9BF43E9FF;
	Tue, 25 Aug 2026 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661315; cv=none; b=e4ecrJ4yeCBW0KQhE7oPJZQj8lu1Iqy+uwzoOX9L++3n40alMfWfyKAHu32SvSGFxbRqFZ2Q3To7vzW3cIfvXSt+gtwW1b4A5PcTd7gpgeJ/vBqK3NEelTyc+HJjVOe444Zx6hno0JnLovLdpYTf4sNxZIhNJFc3Q3+6KyLb4Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661315; c=relaxed/simple;
	bh=cZXteSz/utHhHiSrCBBCyCWmQj/fq90AoRPRarsxUF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4ztmndfWnAtrPWWB9X7/EFCDLBxisd84QM4vFuJ0//BcCQ1zi5VXRIMiEuvtDyjh6+MgxQIu7vbr4EYuY5NZs047sYxxrkLUdxw54yw40qmdmISy5k4k4wP/V2Dq8FKwlUP1osxnsuBffYcNR0yooZsyg8rCWZrdCN6EHaoGCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVi39Ej6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVi39Ej6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258891F000E9;
	Tue, 25 Aug 2026 12:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787661306;
	bh=BiStTaPB5uZkDbe9eyXr9SDNpBIg6f8BTQ3VzLFCkIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BVi39Ej6Q+I8AZrZrYR8QuKBYkB7DHV4lyiHOMuMnLEixNDi2RER2vghxSnubjmjc
	 AJYYkyDDYuuscJ184dVSzP8GHx57Y/9hD/9DAuV8QofOgMHAqR50PrLa3p5kRx8+j4
	 P6/+T5jCE3HYin/imftkIJSf2kOEBLkkMLSG/XHb3evJZ899DmwAdGPMyszpL0Y4tL
	 l63Z2tfUNTNxX7dCgqYCkoLlCny73WFUM7CX30na1FV0yOAJIl2/LxdLmZRLFP7BZt
	 snOvHiFlsUMeXoOInn24t0Uw7hCBZ/Kf5kj2nQ60AiSkQV7cmLlbCkxeJ2QxyfqOrt
	 WfuISvD97R4vQ==
Date: Tue, 25 Aug 2026 14:35:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, 
	codemender-patching+linux@google.com, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] vfs: Add KUnit tests for fdtable
Message-ID: <20260825-mondfinsternis-waage-hyperaktiv-8574b542495e@brauner>
References: <20260810204118.1981755-1-morbo@google.com>
 <20260810204118.1981755-3-morbo@google.com>
 <202608101713.34DEA00E9D@keescook>
 <CAG48ez1VBBkukXH17RRSnAU7rMu0St5x59rkTDVkcMebxuS4-g@mail.gmail.com>
 <202608111721.06C99CDB58@keescook>
 <CAG48ez3R+WKhcoJMTbQpkO+62eSDn_1bSLw3ZUhgo5dX4SJG=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3R+WKhcoJMTbQpkO+62eSDn_1bSLw3ZUhgo5dX4SJG=Q@mail.gmail.com>

On Wed, Aug 12, 2026 at 05:06:37PM +0200, Jann Horn wrote:
> On Wed, Aug 12, 2026 at 2:22 AM Kees Cook <kees@kernel.org> wrote:
> > On Tue, Aug 11, 2026 at 05:42:05PM +0200, Jann Horn wrote:
> > > On Tue, Aug 11, 2026 at 2:16 AM Kees Cook <kees@kernel.org> wrote:
> > > > On Mon, Aug 10, 2026 at 08:41:13PM +0000, Bill Wendling wrote:
> > > > > +static void fdtable_test_alloc(struct kunit *test)
> > > > > +{
> > > > > +     struct fdtable *fdt;
> > > > > +     unsigned int slots = 64;
> > > > > +
> > > > > +     fdt = alloc_fdtable(slots);
> > > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdt);
> > > > > +
> > > > > +     /* Check that max_fds is set correctly and is >= slots */
> > > > > +     KUNIT_EXPECT_GE(test, fdt->max_fds, slots);
> > > > > +
> > > > > +     /* Check that fd is allocated */
> > > > > +     KUNIT_EXPECT_NOT_ERR_OR_NULL(test, fdt->fd);
> > > >
> > > > Nice to add these tests! Can you add one for each of the conditionals
> > > > in alloc_fdtable (e.g. ENOMEM, EMFILE, and the power-of-two rounding-up
> > > > logic, etc)?
> > >
> > > Wouldn't tests for stuff like the rounding-up logic get into
> > > implementation details too much, and break if implementation choices
> > > change?
> >
> > It seemed to me like we'd want to notice if that behavior changed?
> 
> Why?
> File descriptor tables are often power-of-two sized, but they aren't
> always. That is an implementation choice that doesn't impact
> correctness, it just affects performance somewhat. So I don't see what
> the point of a test for this would be - it seems like it would just be
> in the way of making changes, a "Change-Detector Test"?

Yeah, I don't think this makes much sense.
