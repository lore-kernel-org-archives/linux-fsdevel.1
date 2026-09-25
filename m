Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16C04AB3C1;
	Fri, 25 Sep 2026 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346147; cv=none; b=NzUYSf+BkYVQq9AY+5ALbu3nimzFn5M37F9goMLGJKgSw0HXv7+jUUJrvuFL6uvXEWD38TbbmSCcAGgQHvM+VFeENQkyfwf+zvwLF4m8gQq2lyMLZwKzvahGgrNffTlAQbh3NW4m7HU3b4IIFBe4g6o3zOT7dHiYyrqpuEytOKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346147; c=relaxed/simple;
	bh=6OvlCDBlqfe+Wfi51GEcsiAcHeLuRaFZd2h+Mb4Ww9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6hi+efvsFW1XEUNQc3O9UqxUkGyrpBel8s+fRBPZAXnY9Ys79FZC+A35PGQhw8QL4hD24zhojgqGcUlegXGDmC8sLZjYYN5nFyRKwv1PwqyT00PxY6eRZoGQFDwo7U3b6ZERBAbsQBTMOtGboYTHW+8t1OggmFtnvn5QkV1CdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqohbjGS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqohbjGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320A51F000FF;
	Fri, 25 Sep 2026 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790346143;
	bh=O2c1usmYKIZDPcYrY9Y3fobPzqHu/U/QvOM1YjiSoII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FqohbjGSf+vx72YIqf9tGk/fKK8ZPWJh1gCj04tgPFPU0EhF/7oABLZRW7joMylDR
	 DqkRaAURcI/XWNvWHa+XYyfbu6sCf+zTrYbP9XOezGiJxHQz7bLpfVSA9GICtLrYBZ
	 oRIPJdicFAvkJy08oIvSRNSFlnBfIE4eASBxcu8RA3FCIMeBthTX6a73czN+nSpXon
	 QLRWq6soDSDoN8ijmYcYx5Y1UAMbMilexMcemxRbBP0Yb1HY71BDWRG05wNV3/9Jz8
	 pvgZjZNgLVdGw5ZoBRh7AtD96Ij0JWaTvyi3oAa7k1ev8Y6VYoJnRhHFPBmwU1VASJ
	 SKbPXCX54ZFcw==
Date: Fri, 25 Sep 2026 16:22:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Mark Brown <broonie@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Daan De Meyer <daan@amutable.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the security tree with the
 vfs-brauner tree
Message-ID: <20260925-anlocken-winkt-glotz-d9135b11a8a3@brauner>
References: <aqffHOsZaT92Fkg_@sirena.co.uk>
 <1264706227.899081.1789391881838@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1264706227.899081.1789391881838@kpc.webmail.kpnmail.nl>

On Mon, Sep 14, 2026 at 03:18:01PM +0200, Jori Koolstra wrote:
> Hi Mark/Christian,
> 
> @Mark Wasn't aware that Christian pulled this already. There are some obvious
> errors in the v5 of the O_CREAT|O_DIRECTORY that Christian also pointed out.
> I messed something up during rebasing and somehow forgot to format-patch
> again when sending that series out.
> 
> Anyway, finally got back from holiday and fixed everything in the v6, which
> I sent yesterday. So please don't pull this just yet. I am a bit surprised,
> because I hadn't gotten an explicit reviewed-by on every patch in the series.
> 
> @Christian, could you review the v6 so that we can fix this for next quickly?

Sure.
