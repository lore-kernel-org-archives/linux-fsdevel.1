Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0E2C859
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 04:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774670481; cv=none; b=WnMWdn8SAhkxlTdZAUrfIg6JMB1zUocXjW0roP+0kRNWqO6itTgqbANfiPvOeLWnRtffhDjqFOWFJSIMTKDPudO+tsPZAvxXDLxgSzjBa5tL8viVdhjppPW2dWP0VxU07daY9O92bdzQr1Er9sqDPbTMtn1F6HRDaUJfrqI6z6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774670481; c=relaxed/simple;
	bh=spLw8LO71G4HXpzLle+yzSPun4zzkdIR+gErBdn++v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szTYclivII5gq9Uxygfa2Rb9HntD8VcgHtYDPDDAKMxXDb9Kyul/LzWx7Ba3CxFuvUsY4sHm/LQ/haf5xk6b59wZ4FdXehVrNtxCPjlAuL9Pf0rwvWgHkSGjZ2scQZH2CSxzygtcr9Z0wE+b+A1Yn0J7pyOmuQn1/kUbE/Nigd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ep4QDtNR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep4QDtNR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2B1C4CEF7;
	Sat, 28 Mar 2026 04:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774670481;
	bh=spLw8LO71G4HXpzLle+yzSPun4zzkdIR+gErBdn++v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ep4QDtNRLv0AgKzmWJk99rTMHbu/1zHUIkinwV76Ep9TOLNmo7VqCBmeheMMoinWC
	 rYvYKXySR2p5IzFUvZSFdIDNbO71Bpok8u94kj25ZT60/qybAOX9wQtG2F20Vxn3dD
	 VWSObVjj4y1HDCGtY5DVRe6H+6FfPj9mnJrUp9gbr2UJQyoz70/o/XzPnRPbg2jluG
	 qgndpV/P6MsOm8+T894q2cxydSCu2B/ojmK569yfLZSGOgvTkPaVOL6f3YrgmP7ijF
	 TNHeMmFC53ClgSRZbumVVdFBiyaILSXV5OS//aoCVYsHnikyWgHD08mi9vYfHwdeGU
	 LXxZdclACN1Hw==
Date: Fri, 27 Mar 2026 21:01:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>
Subject: Re: [PATCH v2 04/25] Add a new daemonize API
Message-ID: <20260328040120.GI6254@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-4-b1ca8fcbf60f@bsbernd.com>
 <20260327220614.GH6254@frogsfrogsfrogs>
 <db13185d-787a-41a2-9204-ba469a5cf5b1@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db13185d-787a-41a2-9204-ba469a5cf5b1@bsbernd.com>

On Sat, Mar 28, 2026 at 12:07:35AM +0100, Bernd Schubert wrote:
> Hi Darrick,

I'll send a complete reply on Monday, (it's late Friday night now) so
for now <snip>...

> My question is now, are you ok with the new fuse_daemonize API? It
> sounds a bit like you don't like it too much.

...but I do want to clear up any miscommunication: at this point I don't
know enough about the startup process in libfuse to have any strong
feelings about the new daemonize API.  In thinking about the new API, I
had to check my understanding of how things work currently and the
requirements of synchronous FUSE_INIT, in order to play around with your
proposed solution and to figure out if there were other ways to solve
it.

I asked a lot of questions because of my own unfamiliarity with the
subject, and I'm sorry that it came off more aggressively than I meant.
No hard feelings, I hope! :)

--D
