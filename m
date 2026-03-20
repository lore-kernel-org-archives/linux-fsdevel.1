Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2495627A461
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014065; cv=none; b=O6FLf+HDb7UTI/tul3yQM3KwOM/GzyJue+dCcjyW01m4KlDz1INdrC2OBVSwy2AtZtbHJN2vENrytTu8m5sWdBB6qyvM/UgLF1t/wddZzqdGT4PmEMVyDmrY8xSCsE1VDuSZ3Vz1u0FsNa8LIBPiugIUkT5qQTGoFT4bghgKW4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014065; c=relaxed/simple;
	bh=eVF1T66NsyH5OXbWtS937CWiK2GdkHkxdpzAA+u7in8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H34ZFPpXh3Y6r8BGEkp+1kl/nPV0jcUAc71KVsKGQmA/45po2aGUroouf+TBrEWfmrmRG1Nj+EzKn8+GWLPWbJU2/cETSFtAK8Oa38ag97he+S2N36vB6LBN8oLTmjNyzWuH7MU0BZ9rBR85rivP9opVNOa9QnDG67JhjL3XGGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBawjlTl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBawjlTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0985C4CEF7;
	Fri, 20 Mar 2026 13:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774014064;
	bh=eVF1T66NsyH5OXbWtS937CWiK2GdkHkxdpzAA+u7in8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBawjlTl/wecYT/TEaTxotIJzZPdEFB42+yh9z6uW+WQ87ZLS/Oi32v3uUxOmnpyw
	 2qinajF6XCoRe9aZUHLUfSua9cBxH39wx4IwhHx+WDWI7gLBRMKywVm9hYP1UtG4P9
	 XLgnGvFNZKpFILjWTOGY/UPmNuDhBcB/5DoJgUSuMw5aYhEVZdSYjSC8gz77IXWfeQ
	 WzegnEO3Jwv1OTE2xyWUSFNHgB065NJKMVf1LrWSMDtYJLYSqzOcpcv4OX37t2/+TW
	 9PSqxH392Bwp7sbLOmMtKauY7PkFNvzoYBpYh7ZwW2FWIafsa/SaXnjzPVURcMMPVF
	 C+GMJN1G3AT4g==
Date: Fri, 20 Mar 2026 14:40:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 3/7] mount: add FSMOUNT_NAMESPACE
Message-ID: <20260320-herkommen-jodhaltig-3d873a2e77dc@brauner>
References: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
 <20260122-work-fsmount-namespace-v1-3-5ef0a886e646@kernel.org>
 <ad810bc9-5755-416b-a810-5c1019b85b76@sirena.org.uk>
 <20260211-eurem-rinnen-3569a208531b@brauner>
 <b884608d-a719-4551-b8a3-e469a4e3570b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b884608d-a719-4551-b8a3-e469a4e3570b@sirena.org.uk>

On Wed, Mar 18, 2026 at 08:16:58PM +0000, Mark Brown wrote:
> On Wed, Feb 11, 2026 at 01:13:17PM +0100, Christian Brauner wrote:
> > On Wed, Feb 11, 2026 at 11:47:39AM +0000, Mark Brown wrote:
> 
> > > On Thu, Jan 22, 2026 at 11:48:48AM +0100, Christian Brauner wrote:
> > > > Add FSMOUNT_NAMESPACE flag to fsmount() that creates a new mount
> > > > namespace with the newly created filesystem attached to a copy of the
> > > > real rootfs. This returns a namespace file descriptor instead of an
> > > > O_PATH mount fd, similar to how OPEN_TREE_NAMESPACE works for open_tree().
> 
> > > I'm seeing a regression in the LTP fsmount02 test in yesterday's -next
> > > on arm64 which bisect to this patch, the test reports some unexpected
> > > successes with logs like this:
> 
> > Thanks. This is postponed until next cycle.
> 
> The patch is now back in -next and I'm seeing this issue again on 32 bit
> arm:
> 
>   https://lava.sirena.org.uk/scheduler/job/2577791#L5864
> 
> and arm64 too:
> 
>   https://lava.sirena.org.uk/scheduler/job/2577791#L5864
> 
> with bisection pointing to the same commit.

This isn't a bug in the kernel. This is LTP testing the value the new
flag took to test for invalid flags. My advise would be to always use
the uppermost bit or something...
