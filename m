Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4124E3D88E0;
	Tue, 24 Mar 2026 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342438; cv=none; b=Thw2AgLMBydj6qcDp9+8xmp7Pw9aZ7ape0nIYAxRoJeDsL4gLGZk/nvK8ZSGmsfhkX6ytKthhsR3d7rHvPnL75q5owU3OnSkBD4uub2X7vHRUGlLKOheN037Cy5xvfEzdGgJCp+ZcdH8Wpj9SnSnc7aW8Dt6/bnU3GsPA0UFZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342438; c=relaxed/simple;
	bh=5qWvjsF8SmmPhCe+4XrAgI0w4I+8AqKI8zvZ55DuquI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsK6KlzGBhTCpP8CnlALwRoKhm+PbISORs5lLXufNuJ4RcDXgdxGkzVmiHCu/JGRdPsHs7/P2cI7hlBs5BTF1gR9lyFR6TWWLxMyzt3DpeKKOUrBpdHClj0O+cDBS9cct6XB4crkIBUXbYrCg3V0vtPY3G56s7zd9ZjzIcQS2Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlZRCimS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlZRCimS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D50C19424;
	Tue, 24 Mar 2026 08:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774342437;
	bh=5qWvjsF8SmmPhCe+4XrAgI0w4I+8AqKI8zvZ55DuquI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AlZRCimSliaY6cGKV2Dy/E/X9Tq9f6KwwcLdUTLUtkVwRrGM1e9+lMGj5XQFBh5YY
	 DUI5rsyo05+ax5vi3uqhqjK2Ig6Olb00HfTryyTCg/MRSocIaaIjkkexnPQVGBCJwG
	 CsggeQwbSkECeIImeDFw8U7axeWvJLTtq4Y/imZqI3wOGdxi/EHT65jUJ532aP1K6N
	 3Uo/VGWdLOfx6oFsvE2IsSEFqXdBS6uzow2hL9XdmjZbpt1v6gLiCDYlidb/DXnZ+U
	 oIfyY431YlIEgOZ2+D61lLuHkZIdNQkph5kFPbgVooUSsH4Hc43JSyMgJXzTDzSbgd
	 x2Jv5pmD1qxNg==
Date: Tue, 24 Mar 2026 09:53:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: David Francis <David.Francis@amd.com>, linux-kernel@vger.kernel.org, 
	Alexander.Deucher@amd.com, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fdinfo: Option for public fdinfo
Message-ID: <20260324-mitmachen-wirst-65daea421642@brauner>
References: <20260316183828.3354343-1-David.Francis@amd.com>
 <20260323-neugierig-meerschwein-31b6daaa1db9@brauner>
 <10ac8ef6-56b4-4a0f-b970-18b3ce012ceb@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10ac8ef6-56b4-4a0f-b970-18b3ce012ceb@amd.com>

On Mon, Mar 23, 2026 at 02:16:59PM +0100, Christian König wrote:
> On 3/23/26 13:13, Christian Brauner wrote:
> > On Mon, Mar 16, 2026 at 02:38:28PM -0400, David Francis wrote:
> >> We want some GPU information to be publicly available to all
> >> processes for basic system-wide profiling (think GPU versions
> >> of top).
> >>
> >> This information is available in fdinfo and not easily exposed
> >> by other interfaces.
> >>
> >> Add fd_op flag FOP_PUBLIC_FDINFO, which, if set, makes the fdinfo
> >> for that file available to read for processes without ptrace
> >> permissions.
> >>
> >> Note that this makes public how many files each process has open,
> >> and what their fds are.
> >>
> >> Signed-off-by: David Francis <David.Francis@amd.com>
> >> ---
> > 
> > Eew, please let's not. Add an ioctl if you need to be able to retrieve
> > that info.
> 
> Yeah the problem is an IOCTL is even worse from the security pov.
> 
> This is for an tool which doesn't have access to the file descriptor which provides that information.
> 
> So using pidfd_getfd() or similar to get the FD and then call an IOCTL on it would be a security violation.
> 
> The real question is how should we make this information public available in the system?

Don't you have a way to make this info available in sysfs? Just like
networking exposes info about network devices in there that may come and
go?
