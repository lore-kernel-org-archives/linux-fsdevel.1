Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51838480947;
	Tue,  5 May 2026 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001587; cv=none; b=EUkx0V61FESigt9HULXa0fcBAC35FAYLYwTuftYxw1+awSRlWI4zO6ZfJWk5LYagNrdm64rW0dFAUb9eVGyQeH7/fYMNpjknpgo16OFbJkdi2VBUe51PQ4cKsfAZmxKMOg+qxB/iMu+8pWSvzQTAfJyjKkICfzQCzh7Ail4/uT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001587; c=relaxed/simple;
	bh=w366vW6gTE7PZjWFzruIX59ph/Eyj/Rm0AE1LoX/bA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4K2Z+YC/mo3uQdhh5VyGURB5LOb2qDVYJzUg2Sz8pmmGOd5M4IRE5AVzM9vck4ZIRqTUO+AE/yAgpYQe1Jrf4mgWNRZiiEyF834nY4QecC7m+HGL6CISkvxa5r0gsbJ+3HIPEeeL9UeaKJM56UJonWkqy+AsH2WiR4CWKTlK+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYEEPYce; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYEEPYce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6322C2BCB4;
	Tue,  5 May 2026 17:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778001586;
	bh=w366vW6gTE7PZjWFzruIX59ph/Eyj/Rm0AE1LoX/bA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYEEPYceM8fVn3kV6ErEhtso5FJDntRnhKqeL8R0VYHS5EfD/2BN3p69PadjSrlhG
	 8vXYdoP3QVXBVHyw74rmZrYQIiYYbCU1G9toxt6shpr5X+uOjdaWAWUbPsnfBuNyZz
	 AYBPKwsy0wbIz//ucgag4heDKXRuHBXRggnSP2cRDOhlj4+CE/SqQ4LYnrDh+1Gtg7
	 FzEtuka8YfP38rerV0YJRo98RXPPwjGjoUa+X9BWK89JJVmjEvMPatml4MQ+jwZGGf
	 lxhYn6JSFGHEE2RJVLmL6JFQ1YQPbf2Q9RSzXak5kfZAzAU2GbaL83CVQNDTAcJ5vv
	 L2paQT3teyV+Q==
Date: Tue, 5 May 2026 10:18:27 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Colin Walters <walters@verbum.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	fsverity@lists.linux.dev
Subject: Re: overlayfs: verity validation broken since f77f281b6118
Message-ID: <20260505171827.GB2291@sol>
References: <bf0ba588-002b-4860-848e-e806b193840a@app.fastmail.com>
 <afXCoGk2Bu9rBKvJ@amir-ThinkPad-T480>
 <7baedcfe-534b-49f1-b00c-a8280c2703c0@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7baedcfe-534b-49f1-b00c-a8280c2703c0@app.fastmail.com>

[+Cc Miklos Szeredi <miklos@szeredi.hu>]

On Tue, May 05, 2026 at 12:51:47PM -0400, Colin Walters wrote:
> On Sat, May 2, 2026, at 5:23 AM, Amir Goldstein wrote:
> > On Fri, May 01, 2026 at 01:14:54PM -0400, Colin Walters wrote:
> >> Hi Christoph & Eric,
> >> 
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f77f281b6118 broke composefs's usage of overlayfs verity=require, this was reported originally in https://github.com/bootc-dev/bootc/issues/2174
> >> 
> >> There's some output from an agent run I had in the <details> there, but here's an xfstests patch that passes on without that commit and fails with it.
> >> 
> >> From 14231122bfd1e41337e4fb847acbbe038457c32a Mon Sep 17 00:00:00 2001
> >> From: Colin Walters <walters@verbum.org>
> >> Date: Fri, 1 May 2026 09:45:58 -0400
> >> Subject: [PATCH] overlay/118: test fsverity lazy load through metacopy overlay
> >> 
> >> Reproduces the regression reported at:
> >> https://github.com/bootc-dev/bootc/issues/2174
> >> 
> >> A recent change in how fsverity state was cached in memory
> >> I think caused inodes not in cache to appear to have
> >> missing verity=require for overlayfs.
> >> 
> >> This test catches that.
> >> 
> >> Generated-by: OpenCode (Claude Sonnet 4.5)
> >> Signed-off-by: Colin Walters <walters@verbum.org>
> >> ---
> >>  tests/overlay/118     | 62 +++++++++++++++++++++++++++++++++++++++++++
> >>  tests/overlay/118.out |  1 +
> >
> >
> > Please use free test numbers below 100
> 
> OK, I can resend with that change if that's the only thing.
> 
> 
> >
> > Is there a kernel fix for this? please mention it.
> 
> Not that I know of. I did have my agent framework (opencode + combo of Gemini+Claude models) generate one initially, but I intentionally didn't post it because the generating is ~easy, verifying it's "good" is another thing and my C has bitrotted a bit (in favor of Rust mostly but I have to deal with a lot of Go too).
> 
> Anyways, this trivial change works:

Please do a fix patch first, and then any cleanup second as separate
patch(es).

You'll also need to submit your patches correctly, otherwise they cannot
be accepted into the kernel:
https://docs.kernel.org/process/submitting-patches.html

Thanks,

- Eric
