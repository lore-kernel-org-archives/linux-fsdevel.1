Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D772D9787
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 23:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776468365; cv=none; b=JCWZrW9nykHUgLu3jU0V9+txABnd0EglPIvSVkBzvvLOLrstkjLjxvsjLkSHSOYpHRpqh+cX68yaEzFbXB6vr+KmxT7VrP0Y9JfPeVtYAbxWD7Q5Hp061OZI0tnIB1XcL2Uiw/ALDNyvcvsyqo3bmdEHIB7LAG8Nrg/MQ6qiSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776468365; c=relaxed/simple;
	bh=jucJQOaL+lPLohw2TvgWiPVpLDYnCQzUuL0D4v6ocmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCRqAoez+5FzcgXV6IS6++8888VCPMKx/KhCqOl58CupfkjoecSwP0mxN2yrwVlZSKemlE/8YFOdjFk7QEPnVA3Os2svPPN9EXeZjzMNT2Aan/N0mpD+lydwPMRhsjy0DWxASM7caHU/EZfcSn2lSnk0mF84lfx0ufCBnaJkr4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXHN6ZaX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXHN6ZaX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206C8C19425;
	Fri, 17 Apr 2026 23:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776468365;
	bh=jucJQOaL+lPLohw2TvgWiPVpLDYnCQzUuL0D4v6ocmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nXHN6ZaXZYUWjLISUP5LNthra+5a2sioDUJGnzuzVyjRUXXiNOgixCMKPQKoLo6zW
	 mDzyut9XJQh7bvv5K6O2s3ucgBZG55ptzL694ZWzXxvuEhz8fNChO5xv8pc/ZWH/HW
	 brlw8DgdqyF8STnYmOLPWGqF0+D2GaioOrtktqnqg5irKewT80YuItO+FEABEtNpL1
	 /nGa9ga60QTQ/QqyGH/D8vy/b0V3nbE2QDvU0dsDhVfZx4ff96U4u15C6McFSjTo4I
	 jWEcRFUdyqWLrK8FGocpRFF+R1lxyFAVRJ/KSq31Blxbfq30pHoHJRqBUK8O2fkHYK
	 mSdwhy9xsD0wQ==
Date: Fri, 17 Apr 2026 16:26:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu, neal@gompa.dev
Subject: Re: [GIT PULL] libfuse: run fuse servers as a contained service
Message-ID: <20260417232604.GI7727@frogsfrogsfrogs>
References: <177577271287.2064584.12214566734023027732.stg-ugh@frogsfrogsfrogs>
 <549999df-d6eb-43a0-840c-43310de667ca@bsbernd.com>
 <20260410155601.GS6254@frogsfrogsfrogs>
 <5de6956e-dce5-4095-a2fa-199c2dc1408a@bsbernd.com>
 <20260410221210.GV6254@frogsfrogsfrogs>
 <20260411024835.GV6202@frogsfrogsfrogs>
 <774cac3c-0ee9-4bd3-a32c-249953cb32d8@bsbernd.com>
 <20260415000147.GE148064@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415000147.GE148064@frogsfrogsfrogs>

On Tue, Apr 14, 2026 at 05:01:47PM -0700, Darrick J. Wong wrote:

<delete a bunch of stuff>

Hi Bernd!

> > alive, but not operating...).
> > I will get to your patch series the next evenings.
> 
> Ok.  Here's today's branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git/log/?h=fuse-service-container_2026-04-14
> 
> along with all the changes/fixes I mentioned upthread.  Whichever day
> you think you'll get to it, please don't hesitate to reach out and ask
> me for the freshest branch.

Here's today's branch, with all the cleanups and bug fixes that I
mentioned in the patchset:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git/log/?h=fuse-service-container_2026-04-17

AFAICT it doesn't introduce any new cppcheck/checkpatch complaints.

--D
