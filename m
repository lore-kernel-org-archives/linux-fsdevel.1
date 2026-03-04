Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A6C34D39B
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772666635; cv=none; b=OHh4cdTUVshQGMPC4Lyz8kUO1LRkCjfUWLBzhaFlea0mAaErFzGx7QOnaefOQIPAl5TtcqeuFj8EntNTLVFbu4Xh2aD3e4KrPbQP+9l/DSynN2eeL9ScwoJmDyTGOnjRLaLLyFuJvSmNstG6dxpx61nv4PJgGOpTQhOr2kpAMzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772666635; c=relaxed/simple;
	bh=4gBChJKhuO5s88bnCr1b9MMXfYkvIqIn5mi6p9mAlUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvliUB1W/1wKnpB30pKNL97+lr4El0uPoFIisEr9cyKLaf1btAOLgFztCBVE9BQGnB0pvphbBbLFsa2D5r1ntLMlduRWSK7sZIDIi0ALey2g7Aps/qWD4P+mOeaXGK8nT66BxnUip5Fqqd0/B4+e/fXT9/EkdsI0jZxO0DKu6f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk9ZPYdj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk9ZPYdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A7DC4CEF7;
	Wed,  4 Mar 2026 23:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772666634;
	bh=4gBChJKhuO5s88bnCr1b9MMXfYkvIqIn5mi6p9mAlUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kk9ZPYdjywtDeajJ02vaOoaG3DUF+nJEuMH+EqGK0esKusPTyyYFQNBFi/2XQv2hp
	 IlN6T9u+XQQASOnEWDVRBVgISwRK3J3CrQf465Z4ACPbX9v3aDLN6nz10KNznQKM8G
	 iLOJydZbgzXyKwj6c7v6smhpwVKKm8jXQpm4qxiewWIq1t8gHqbiqb50hUFhX+NGxP
	 fCC0p/27XkZz4uQypSWqLLhQi8Sy7iWwpCwQxpm2JnU/H8vH9GWq4dojjQsIqi6Nq1
	 huA35vp+tUn0ldcilNZjlbAE9AUvfqc/UeVpLUdOI1YSKnoY/VuoEczIBkMPCivpyJ
	 Pxbl0+B+kFFCA==
Date: Wed, 4 Mar 2026 15:23:53 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: bschubert@ddn.com, joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Subject: Re: [GIT PULL] libfuse: run fuse servers as a contained service
Message-ID: <20260304232353.GS13829@frogsfrogsfrogs>
References: <177258294351.1167732.4543535509077707738.stg-ugh@frogsfrogsfrogs>
 <0d3d5dfc-6237-4d6d-abeb-e7adddecf2d9@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d3d5dfc-6237-4d6d-abeb-e7adddecf2d9@bsbernd.com>

On Wed, Mar 04, 2026 at 02:36:03PM +0100, Bernd Schubert wrote:
> 
> 
> On 3/4/26 01:11, Darrick J. Wong wrote:
> > Hi Bernd,
> > 
> > Please pull this branch with changes for libfuse.
> > 
> > As usual, I did a test-merge with the main upstream branch as of a few
> > minutes ago, and didn't see any conflicts.  Please let me know if you
> > encounter any problems.
> 
> Hi Darrick,
> 
> quite some problems actually ;)
> 
> https://github.com/libfuse/libfuse/pull/1444
> 
> Basically everything fails.  Build test with
> 
> ../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c:24:10:
> fatal error: 'systemd/sd-daemon.h' file not found
>    24 | #include <systemd/sd-daemon.h>
> 
> 
> Two issues here:
> a) meson is not testing for sd-daemon.h?
> a.1) If not available needs to disable that service? Because I don't
> think BSD has support for systemd.
> 
> b) .github/workflow/*.yml files need to be adjusted to add in the new
> dependency.
> 
> 
> Please also have a look at checkpatch (which is a plain linux copy) and
> the spelling test failures.

I have a few questions after running checkpatch.pl (the one in the
libfuse repo):

1. What are the error return conventions for libfuse functions?

   The lowlevel library mostly seems to return 0 for succes or negative
   errno, but not all of them are like that, e.g. fuse_parse_cmdline*.

   The rest of libfuse mostly seems to return 0 for success or -1 for
   error, though it's unclear if they set errno to anything?

   This comes up because checkpatch complains about "return ENOTBLK",
   saying that it should be returning -ENOTBLK.  But I'm already sorta
   confused because libfuse and its examples use positive and negative
   errno inconsistently.

2. There's no strscpy, but the check is left on, and there are plenty of
   users in libfuse.

3. Comments at the top of files -- checkpatch complains that the
   non-first lines of a multiline C comment should start with " * "but
   not all of them do that.  Should I just do C comments the way
   checkpatch wants?  Or keep going with the existing code?

--D

> Thanks,
> Bernd
> 
> 
