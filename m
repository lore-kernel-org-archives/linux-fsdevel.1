Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955958;
	b=adAw5rapXzgwdnnF6soiOpfZ1V+a1cpUYfD5C1SUvU+CiLvbt3bPKj8NV3icGT0ivvTW
	 yIFRva3uX7BrVJ97hl4Tj3IDPdUp0oLDvFfFM0908QDdsjjPdRSaHjyJDTh7wO5xL7CdD
	 PvDqz6Pv/Zn0yjrzLcI0qvuc93aBpRuTHfMeCsCscBZCFKvyaRWXW5LUcA0CaoZYisIVs
	 36Mxyjvkd3ov3J4JR+1djMiUrdJJWBogK/Gbi7jXnjNz/cukEAaean7kBwORt9Rr/wKgS
	 +iMXVtBwv9AZhf584Onh02dOYnbPnMwvTfV1EAnwyH8/Y5W7rRTSmOYjPgaHcY4lI/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955958;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WPuD57JlYcSeWtGJ9evE1GvVEReb3TMJbzr2AWb1TC0=;
	b=zO4gcf9IcMFK9rZByoqWmG4McCBYKcPoRLUAqHHOE0Dljc40uzxTdCahKbraR6+kRJKb
	 CSAx/yPIHt0sJ0Ku6YtQfdNvZoufEAPxHkEZSO13XGmJuWZcmhvV2Qpfm/5evda3cDQqk
	 9yyHVZXj0dmqJw5uBRx9afPDKzF1+Tx8b+JEZN1u33ET4s9I8/5rsRAd2sJqyvx2h+F1M
	 9K/tchl7aAWxYpugEqXuBrNEM0Dm6mPMSqvz6sVm2/Kle/9MrD7qbjV1E7xPhVlbIk2Zo
	 P667C/ZHDkrjf6Te+Tn19um/qmzl/kfj1hPGN/7rGUkNt4qsrBWmBl03AH/eVaVQ7kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQeXbXSj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C541E606A328;
	Fri,  6 Nov 2026 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQeXbXSj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99D11F008A1;
	Fri,  6 Nov 2026 09:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793955957;
	bh=WPuD57JlYcSeWtGJ9evE1GvVEReb3TMJbzr2AWb1TC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AQeXbXSjATO/WDYBekds4BBIebSW0WG9iHKpPgnTW28ettxwmkwQ0/xjfwFmL7Mmc
	 zLaFuwzibEv7sVucctAshKhoqTa6Y4F6CLIuyt2xUHcgwjPUiVEAOB7ZRwHuevtQK8
	 tEuLn4+B+ovonEjxMceVJMNt9vz7ECPKWvy9Ty8m0BHZuoXTH9KFJF1o4a3OYhNHkk
	 uBa8bjFXC/gqDwQcsxJeeMaTzTNN7wG1thV9mmryXl+VTCGomvbaTMxgO9r1LHKgQZ
	 Kg1I3zPLD7bRNkuNuGRQaNt/Xvb9uxKdWEZJGv8FGjdqIlS/3raZEGUBuHBhR7wh/4
	 CB2tL81t4MbvQ==
Date: Fri, 6 Nov 2026 10:05:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bence Csokas <bence.csokas@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/2] Add scope-based cleanup capability to eventfd_ctx
Message-ID: <20261106-hinein-lagebericht-abbezahlen-cb826d68d175@brauner>
References: <20261027-efd-autofree-v3-0-caa2442e1beb@arm.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261027-efd-autofree-v3-0-caa2442e1beb@arm.com>

On Tue, Oct 27, 2026 at 05:22:00PM +0100, Bence Csokas wrote:
> Add __free() support to eventfd and update drm_syncobj to use it as an
> example consumer.
> 
> A minor discrepancy I encountered is whether to put a semicolon after
> DEFINE_FREE(). It seems some in-tree code does, some doesn't. In the end,
> I followed the example set in core-api/cleanup.rst, and omitted it.
> 
> Signed-off-by: Bence Csokas <bence.csokas@arm.com>
> ---

I'm really having trouble seeing how this improves anything
significantly. Probably others have the same impression which is why
this doesn't get a lot of review.
