Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC973A962E
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859131; cv=none; b=AQDNxMAKa4jl6pRxMmi1WGAm/M4ZFZMzoqYQeNBfewdyslbuao7Rhzdl0Q97nF94GvvaL7I2WIxOVVFDcVvtpFvZe0HYhgdv1qoN04oo4MEovXcYJeQ+A7LgjslfeouqTRvZSJBtp/YmB/HFjT6/GbS1mbSWZ1POF3D5q7oQ9BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859131; c=relaxed/simple;
	bh=PtNDE4tN4d7SAuz8aeKtNDhjZ+731dMhReMbpWVY3JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewIxh6OiByJ+lHDSpTwM9ilUkJe1H4Wi4/lnxLeujJ66x0FPKL2pA/boVMvhLVduZd5ab8p0/SKgH9oeeaXuPQexvI7vV9KuWi5neJpSW8rgqXvHhfWmk4czNy9ulltqddcqaSE3djQFMO1AN09Nk59MLzrTFRdGsz0/DzuDMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssB7q/iY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssB7q/iY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AB1C19421;
	Fri, 10 Apr 2026 22:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775859131;
	bh=PtNDE4tN4d7SAuz8aeKtNDhjZ+731dMhReMbpWVY3JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ssB7q/iYyHSg/La1opvgZWuHn+kc+oTetCK75/V3JaAek0QqM2NL+SXcKKJA9olDq
	 A9IjYlAp0uyffjXldZIU4Oa7WqpsJUrLEA5wkFZ43eFodCAlEVZhe6s4QxcHRr0mWs
	 5rJWrLKjOvQ6Wnw+M8gRzy0XHno6bBQp/9OYM0Wh4hkNjLa9r0nPoTclF/we3zJ5gy
	 M2YS1fLOfJkgFJY0ZFOt9wNB3xnCG5QI0m6y4l9RXEnAl0bsv6j0Sa/ERPfy7PQk55
	 Pl5JX1q9hooECdXDta43I76JKyeDTW5M3LvhiM4r4eJtixCzuIHAL97j53PPceMQGu
	 /wM2RgAYpgnmQ==
Date: Fri, 10 Apr 2026 15:12:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: bschubert@ddn.com, joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Subject: Re: [GIT PULL] libfuse: run fuse servers as a contained service
Message-ID: <20260410221210.GV6254@frogsfrogsfrogs>
References: <177577271287.2064584.12214566734023027732.stg-ugh@frogsfrogsfrogs>
 <549999df-d6eb-43a0-840c-43310de667ca@bsbernd.com>
 <20260410155601.GS6254@frogsfrogsfrogs>
 <5de6956e-dce5-4095-a2fa-199c2dc1408a@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5de6956e-dce5-4095-a2fa-199c2dc1408a@bsbernd.com>

On Fri, Apr 10, 2026 at 08:30:49PM +0200, Bernd Schubert wrote:
> 
> 
> On 4/10/26 17:56, Darrick J. Wong wrote:
> > On Fri, Apr 10, 2026 at 02:24:28PM +0200, Bernd Schubert wrote:
> >> Hi Darrick,
> >>
> >> On 4/10/26 00:24, Darrick J. Wong wrote:
> >>> Hi Bernd,
> >>>
> >>> Please pull this branch with changes for libfuse.
> >>>
> >>> As usual, I did a test-merge with the main upstream branch as of a few
> >>> minutes ago, and didn't see any conflicts.  Please let me know if you
> >>> encounter any problems.
> >>
> >> I had already merged another patch beginning of this week that
> >> introduced a new merge conflict in
> >> .github/workflows/install-ubuntu-dependencies.sh
> >>
> >> I resolved it myself now.
> >>
> >>>
> >>> --D
> >>>
> >>> The following changes since commit 3bb9cd99b3688df1bb7536de158ed9e532b277fb:
> >>>
> >>> Add the codechecker/cppcheck github action (2026-04-07 10:08:49 +0200)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container_2026-04-09
> >>>
> >>> for you to fetch changes up to 0db39a8f8844ff88496ed36da417554cb4f3751d:
> >>>
> >>> nullfs: support fuse systemd service mode (2026-04-09 12:31:08 -0700)
> >>
> >> I had quite a busy last weekend, because I got libfuse security reports.
> >> In ordert to avoid lots of reports, I just added support for CodeChecker
> >> + cppcheck and CodeChecker+gcc checker. Clang CTU is is prepared, but I
> >> need to let AI work over the weekend to fixes for these (obviously will
> >> need manual editing, as last weekend).
> >> In the end not too bad and I don't think and urgent need for a new
> >> release. Although I should probably make a new 3.18.3 version soon.
> >>
> >> That also made me to add new checks. I actually already that github
> >> codeql checker in place, but only realized last weekend that it didn't
> >> generate any reports. On your PR that gives
> >>
> >> New alerts in code changed by this pull request
> >>
> >> Security Alerts:
> >>
> >>     4 critical
> >>     3 high
> >>
> >> Other Alerts:
> >>
> >>     4 warnings
> >>     10 notes
> >>
> >>
> >> Some of these, like "This switch statement should either handle more
> >> cases, or be rewritten as an if statement." can be suppressed. With some
> >> I probably agree
> >>
> >>
> >> 	cmd = malloc(iov.iov_len);
> >> 	if (!cmd) {
> >> 		int error = errno;
> >> Note
> >> Declaration hides parameter
> >> Local variable 'error' hides a parameter of the same name.
> >> CodeQL
> > 
> > Oh yikes yes.  I probably ought to have added the same "turn the gcc
> > warnings up real high" patch to my branch that I use for xfs stuff.
> > 
> > (Huh.  No warnings.  Well, that's good at least.)
> > 
> >> The new CodeChecker (gcc,cppchechk) actions also complain, the GUI
> >> should give the output, but I don't see it yet.
> > 
> > <nod> Any reports you get about my branch, please feel free to lob it at
> > me and tell me to fix it :)
> > 
> > I can run cppcheck locally, so I'll try to fix all the warnings that
> > your copy is throwing out, and send you an updated pr.
> > 
> >> My plan for the weekend is to address your comments in my series and
> >> then to merge it. If still some time left, I would like to fix all the
> >> reports in your series and merge that as well.
> >> Then maybe next week to combine some mount code dup that comes from both
> >> series.
> >>
> >> Ok with you?
> > 
> > Yes, that sounds good.  Let me know if you want any help. :)
> 
> Would be great if you could fix the cppcheck and gcc codechecker
> reports. For cppcheck you might need to inline suppress some wrong
> warnings - needs this patch
> 
> https://github.com/libfuse/libfuse/pull/1477/changes/0322af4d9bba93aad5f6445346aa83a549bb3d19
> 
> This commit also shows the path how to run it:
> 
> .github/workflows/codechecker.sh
> 
> Fow now we we ignore everything in example/ and some cppcheck warnings
> are ignored for now - these were too many for now.

Ok, I got the cppcheck part working, and the fixes were fairly straight
forward.  As for CodeChecker, is this the one:

https://github.com/Ericsson/codechecker

that the yml file tries to find?

--D

> 
> Thanks,
> Bernd
