Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C4B40DFB8
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 00:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776211308; cv=none; b=GfN99QvGeR2UAkbXryakjRkYqgIrM+PEz+o8JUQUvX6Fl9lFfwEHnJF+53DaUz5S3ba+AT/0H3mwphqTmA/Urs9O5vKR3xrC6HTqwb0Yo88UlO3gVO99pBh4Z/aRRfEEUWPALzJxsaZeEMdKZ4HNibv2Uj+LhkUtNp5NS6yZT5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776211308; c=relaxed/simple;
	bh=wccTecuzRdfgDOA2hHJuZDPrhB+ynXcQbsoNuTtX/10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSDVasJ3H3QgZ53MAUtblSuNG1NAxR2V/+mf1RDlwPxgj4gczNDYHOsj6Z/zY6eTuj/qJUITbK/8rNRtpcdg0ZBN+r5kpnPRvpuBAWh1wybxI3Y0AM05GqmF3D/vqHN4pxsxHRqyufpgLD2PFbaZuhuNXZaI8oW5QJoy43/QgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lk43pyK4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lk43pyK4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E604BC19425;
	Wed, 15 Apr 2026 00:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776211308;
	bh=wccTecuzRdfgDOA2hHJuZDPrhB+ynXcQbsoNuTtX/10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lk43pyK4ScSa9L6xkh0Cz40SVqdtJ72TOmbNYKj1fkLJYoP/FSVPWzEg4o4nsna82
	 LcjP6lJXzYlHLUAvqOH88A5GQk1Pjm5VRDVRYVIr76ObquJEeJv3Tb9glNf6R+siGZ
	 +NZbhs1bQnapAWqrYLrXkytA0Q193LWBY4tca6W1/dkZ49zjTbgnMFYbu4IdWwqmVD
	 w0Sh3uqKGVgMa7RHq7AqMMpQx9KnDf5CxJrlMg5+JsJIlm7mc+rQ+2kb+GnwgJY5rX
	 MN0hd+2kpm03xK1SDhgoBE96uOxfN9C8T5raKesqOu9nR3Ww3loeS2RjX2lPsWZ9tB
	 DCK8qZRCV4kew==
Date: Tue, 14 Apr 2026 17:01:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu, neal@gompa.dev
Subject: Re: [GIT PULL] libfuse: run fuse servers as a contained service
Message-ID: <20260415000147.GE148064@frogsfrogsfrogs>
References: <177577271287.2064584.12214566734023027732.stg-ugh@frogsfrogsfrogs>
 <549999df-d6eb-43a0-840c-43310de667ca@bsbernd.com>
 <20260410155601.GS6254@frogsfrogsfrogs>
 <5de6956e-dce5-4095-a2fa-199c2dc1408a@bsbernd.com>
 <20260410221210.GV6254@frogsfrogsfrogs>
 <20260411024835.GV6202@frogsfrogsfrogs>
 <774cac3c-0ee9-4bd3-a32c-249953cb32d8@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <774cac3c-0ee9-4bd3-a32c-249953cb32d8@bsbernd.com>

On Wed, Apr 15, 2026 at 12:00:41AM +0200, Bernd Schubert wrote:
> 
> 
> On 4/11/26 04:48, Darrick J. Wong wrote:
> > On Fri, Apr 10, 2026 at 03:12:10PM -0700, Darrick J. Wong wrote:
> >> On Fri, Apr 10, 2026 at 08:30:49PM +0200, Bernd Schubert wrote:
> >>>
> >>>
> >>> On 4/10/26 17:56, Darrick J. Wong wrote:
> >>>> On Fri, Apr 10, 2026 at 02:24:28PM +0200, Bernd Schubert wrote:
> >>>>> Hi Darrick,
> >>>>>
> >>>>> On 4/10/26 00:24, Darrick J. Wong wrote:
> >>>>>> Hi Bernd,
> >>>>>>
> >>>>>> Please pull this branch with changes for libfuse.
> >>>>>>
> >>>>>> As usual, I did a test-merge with the main upstream branch as of a few
> >>>>>> minutes ago, and didn't see any conflicts.  Please let me know if you
> >>>>>> encounter any problems.
> >>>>>
> >>>>> I had already merged another patch beginning of this week that
> >>>>> introduced a new merge conflict in
> >>>>> .github/workflows/install-ubuntu-dependencies.sh
> >>>>>
> >>>>> I resolved it myself now.
> >>>>>
> >>>>>>
> >>>>>> --D
> >>>>>>
> >>>>>> The following changes since commit 3bb9cd99b3688df1bb7536de158ed9e532b277fb:
> >>>>>>
> >>>>>> Add the codechecker/cppcheck github action (2026-04-07 10:08:49 +0200)
> >>>>>>
> >>>>>> are available in the Git repository at:
> >>>>>>
> >>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container_2026-04-09
> > 
> > Hi Bernd,
> > 
> > Here's today's branch, with the static checker problems fixed, I hope:
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container_2026-04-10
> > 
> > This is the codechecker report that I got (u:x p:x, I'm too lame for
> > anubis):
> > https://djwong.org/docs/libfuse/#sort=file-path&asc=1
> > from pip install'ing codechecker and running:
> > 
> > ./.github/workflows/codechecker.sh --gcc --codechecker --build-dir build-x86_64/
> > 
> > AFAICT, none of those bugs are related to anything touched by the
> > containerization patches.  Though I'm not 100% sure of the outputs; I
> > didn't see anything about a switch statement.
> > 
> > --D
> > 
> >>>>>>
> >>>>>> for you to fetch changes up to 0db39a8f8844ff88496ed36da417554cb4f3751d:
> >>>>>>
> >>>>>> nullfs: support fuse systemd service mode (2026-04-09 12:31:08 -0700)
> >>>>>
> >>>>> I had quite a busy last weekend, because I got libfuse security reports.
> >>>>> In ordert to avoid lots of reports, I just added support for CodeChecker
> >>>>> + cppcheck and CodeChecker+gcc checker. Clang CTU is is prepared, but I
> >>>>> need to let AI work over the weekend to fixes for these (obviously will
> >>>>> need manual editing, as last weekend).
> >>>>> In the end not too bad and I don't think and urgent need for a new
> >>>>> release. Although I should probably make a new 3.18.3 version soon.
> >>>>>
> >>>>> That also made me to add new checks. I actually already that github
> >>>>> codeql checker in place, but only realized last weekend that it didn't
> >>>>> generate any reports. On your PR that gives
> >>>>>
> >>>>> New alerts in code changed by this pull request
> >>>>>
> >>>>> Security Alerts:
> >>>>>
> >>>>>     4 critical
> >>>>>     3 high
> >>>>>
> >>>>> Other Alerts:
> >>>>>
> >>>>>     4 warnings
> >>>>>     10 notes
> >>>>>
> >>>>>
> >>>>> Some of these, like "This switch statement should either handle more
> >>>>> cases, or be rewritten as an if statement." can be suppressed. With some
> >>>>> I probably agree
> >>>>>
> >>>>>
> >>>>> 	cmd = malloc(iov.iov_len);
> >>>>> 	if (!cmd) {
> >>>>> 		int error = errno;
> >>>>> Note
> >>>>> Declaration hides parameter
> >>>>> Local variable 'error' hides a parameter of the same name.
> >>>>> CodeQL
> >>>>
> >>>> Oh yikes yes.  I probably ought to have added the same "turn the gcc
> >>>> warnings up real high" patch to my branch that I use for xfs stuff.
> >>>>
> >>>> (Huh.  No warnings.  Well, that's good at least.)
> >>>>
> >>>>> The new CodeChecker (gcc,cppchechk) actions also complain, the GUI
> >>>>> should give the output, but I don't see it yet.
> >>>>
> >>>> <nod> Any reports you get about my branch, please feel free to lob it at
> >>>> me and tell me to fix it :)
> >>>>
> >>>> I can run cppcheck locally, so I'll try to fix all the warnings that
> >>>> your copy is throwing out, and send you an updated pr.
> >>>>
> >>>>> My plan for the weekend is to address your comments in my series and
> >>>>> then to merge it. If still some time left, I would like to fix all the
> >>>>> reports in your series and merge that as well.
> >>>>> Then maybe next week to combine some mount code dup that comes from both
> >>>>> series.
> >>>>>
> >>>>> Ok with you?
> >>>>
> >>>> Yes, that sounds good.  Let me know if you want any help. :)
> 
> 
> Hi Darrick,
> 
> thanks a lot for the updates. And apologies, I didn't get that far
> during the weekend again :( I also eventually wanted to send the new

No worries.  Don't strain yourself! :D

> version for the reduced ring queue patches and then xfstests got stuck
> at at generic/650 (cpu off/on loop) and I was searching for the issue

Urrrk, g/650 is one of my horrible creations.

> kind of all weekend. Unfortunately searched in the wrong place (kernel)
> and only noticed when I had added debugfs support to fuse. Patch for
> debugfs support follows during the next days. (The ugly part was that
> passthrough_hp had crashed and got stuck in backtrace_symbols - process
> alive, but not operating...).
> I will get to your patch series the next evenings.

Ok.  Here's today's branch:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git/log/?h=fuse-service-container_2026-04-14

along with all the changes/fixes I mentioned upthread.  Whichever day
you think you'll get to it, please don't hesitate to reach out and ask
me for the freshest branch.

> >>>
> >>> Would be great if you could fix the cppcheck and gcc codechecker
> >>> reports. For cppcheck you might need to inline suppress some wrong
> >>> warnings - needs this patch
> >>>
> >>> https://github.com/libfuse/libfuse/pull/1477/changes/0322af4d9bba93aad5f6445346aa83a549bb3d19
> >>>
> >>> This commit also shows the path how to run it:
> >>>
> >>> .github/workflows/codechecker.sh
> >>>
> >>> Fow now we we ignore everything in example/ and some cppcheck warnings
> >>> are ignored for now - these were too many for now.
> >>
> >> Ok, I got the cppcheck part working, and the fixes were fairly straight
> >> forward.  As for CodeChecker, is this the one:
> >>
> >> https://github.com/Ericsson/codechecker
> >>
> >> that the yml file tries to find?
> 
> Yes. this one. There is also a codql yml file, which is githubs own code
> checker, it complains about these single case conditions. I will just
> click that away. I guess you cannot see the reports without a github
> account.

I created a virtualenv so I could install it and run it locally, and
touched up the things it complained about.  I haven't gotten to whatever
--infer does yet, but I hope I'm getting close to parity with the github
actions.

--D
