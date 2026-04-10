Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBD83CD8D1
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836562; cv=none; b=nqm7NrQ06kS8IXuVMM/HYzmmvJ/X+uF0kz5kVwPpaQLB7CUJ9JO41mxUTr+a7Pk3C8WGOi0Gwav3pXIkZgLmSNVsmxczkCe1J/E5nTu+0aXymjZVvhoXcwGhcxtDnPhTHaXsvG3aEBAMIJd55tRo5DVhrC3zjc1pPWl7dmasT1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836562; c=relaxed/simple;
	bh=FbW47ktZ2lnheBZykc/N8L/KHvU1qhX3nlST4ZfJPIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eO1nZN3d8SbJEXu4rOIpgxj3CfDzZOxX2TydU/hSqqB3zVPzQQuGF/4TYqICiub7s1+5Lx7EuxVXBy7rpIuL96qtB3sUsYETaIaY1Sv4TdhYi7/4d+0KLsz2bFHU11uQYq6V2o0N1MkkEOOTki1T5EVI8QKo0YgIdkvYe8xIM1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnLTRtsu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnLTRtsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E32C4AF09;
	Fri, 10 Apr 2026 15:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775836562;
	bh=FbW47ktZ2lnheBZykc/N8L/KHvU1qhX3nlST4ZfJPIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PnLTRtsupfTjM/QDfsCPOcZuNKQiKovBMmU+SxKv8dascwOxh9AJXFceslEZlK12g
	 LbveS8BC7X14kiuncE7j7ecSnsKiJzJwnkBL0RDLCz4OYZzmN5mAQA6cHblcCpWo3E
	 b8uUmf0Gl3VAa9cZXQ4TnQTHwlQOyI6VSzxHNvrB7SNLLUb5HGb2STnrARSETYY4yf
	 RerxcLUFviPHgCjHkEWAsFLAv34ymhubW2f++eQyi1xxLuVbX8V7PXW9HIfhdXEAZY
	 cVyYXqcRHKiYUBL0SuyQJ4Kq61RQYPOtP9B7pK7LO49ANWOks4L1Hx3veUTaN3DWsL
	 w3TF6DwjwdlyA==
Date: Fri, 10 Apr 2026 08:56:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: bschubert@ddn.com, joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Subject: Re: [GIT PULL] libfuse: run fuse servers as a contained service
Message-ID: <20260410155601.GS6254@frogsfrogsfrogs>
References: <177577271287.2064584.12214566734023027732.stg-ugh@frogsfrogsfrogs>
 <549999df-d6eb-43a0-840c-43310de667ca@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <549999df-d6eb-43a0-840c-43310de667ca@bsbernd.com>

On Fri, Apr 10, 2026 at 02:24:28PM +0200, Bernd Schubert wrote:
> Hi Darrick,
> 
> On 4/10/26 00:24, Darrick J. Wong wrote:
> > Hi Bernd,
> > 
> > Please pull this branch with changes for libfuse.
> > 
> > As usual, I did a test-merge with the main upstream branch as of a few
> > minutes ago, and didn't see any conflicts.  Please let me know if you
> > encounter any problems.
> 
> I had already merged another patch beginning of this week that
> introduced a new merge conflict in
> .github/workflows/install-ubuntu-dependencies.sh
> 
> I resolved it myself now.
> 
> > 
> > --D
> > 
> > The following changes since commit 3bb9cd99b3688df1bb7536de158ed9e532b277fb:
> > 
> > Add the codechecker/cppcheck github action (2026-04-07 10:08:49 +0200)
> > 
> > are available in the Git repository at:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container_2026-04-09
> > 
> > for you to fetch changes up to 0db39a8f8844ff88496ed36da417554cb4f3751d:
> > 
> > nullfs: support fuse systemd service mode (2026-04-09 12:31:08 -0700)
> 
> I had quite a busy last weekend, because I got libfuse security reports.
> In ordert to avoid lots of reports, I just added support for CodeChecker
> + cppcheck and CodeChecker+gcc checker. Clang CTU is is prepared, but I
> need to let AI work over the weekend to fixes for these (obviously will
> need manual editing, as last weekend).
> In the end not too bad and I don't think and urgent need for a new
> release. Although I should probably make a new 3.18.3 version soon.
> 
> That also made me to add new checks. I actually already that github
> codeql checker in place, but only realized last weekend that it didn't
> generate any reports. On your PR that gives
> 
> New alerts in code changed by this pull request
> 
> Security Alerts:
> 
>     4 critical
>     3 high
> 
> Other Alerts:
> 
>     4 warnings
>     10 notes
> 
> 
> Some of these, like "This switch statement should either handle more
> cases, or be rewritten as an if statement." can be suppressed. With some
> I probably agree
> 
> 
> 	cmd = malloc(iov.iov_len);
> 	if (!cmd) {
> 		int error = errno;
> Note
> Declaration hides parameter
> Local variable 'error' hides a parameter of the same name.
> CodeQL

Oh yikes yes.  I probably ought to have added the same "turn the gcc
warnings up real high" patch to my branch that I use for xfs stuff.

(Huh.  No warnings.  Well, that's good at least.)

> The new CodeChecker (gcc,cppchechk) actions also complain, the GUI
> should give the output, but I don't see it yet.

<nod> Any reports you get about my branch, please feel free to lob it at
me and tell me to fix it :)

I can run cppcheck locally, so I'll try to fix all the warnings that
your copy is throwing out, and send you an updated pr.

> My plan for the weekend is to address your comments in my series and
> then to merge it. If still some time left, I would like to fix all the
> reports in your series and merge that as well.
> Then maybe next week to combine some mount code dup that comes from both
> series.
> 
> Ok with you?

Yes, that sounds good.  Let me know if you want any help. :)

--D

> 
> Thanks,
> Bernd
