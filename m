Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141852DF719
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506090; cv=none; b=Yz/XaTmb7JQw/eFwyKdXIBW6uFFWNL95fyu11Fp8NKKV/St3yNa3D3cjxmBvpx/Dt6TcHvJOP7YqDnqTvp+Kh4K3sud7QeT2dMOZXNgTcbscnBJpp/YuRnylNKlltMEBAe170SC0vtvPu+qHRzUJdiimrLJpIEZNGIQKHCZIOQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506090; c=relaxed/simple;
	bh=EFlqNOd3Ej+dPnws+fZnQfNFUDEaDuuOWCcNT+cyAgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjG95YOhwfytpxRFrIHlcSJ77/YmyMuf9fQfdeBCav/E0BuaYUztP7QYCDN0bEmeYquxj526zP7DTegGar/2q3J5TeZovFpftgN2CZhduUVe6XnRN1FUDc6wR0K/EA/2C9/Hg8dftQwdUR8WeZkJvXTlGOfPSzmmPYBXwa2t3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/OfkjI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/OfkjI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706C91F000E9;
	Fri, 31 Jul 2026 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785506088;
	bh=KmQK5+zoa4q3AO/prE6ZcVpVb9B86sW1UoslJEguf1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C/OfkjI6Ext1XHVTCrazhxNEaF4Ev5ZsVeZI4IYIptqZd/JmgBc8e12Ln48Mj40sR
	 H+ndgmnuWkHOre8DoyJGY3yha6ZrkDhh+cOGVludrKQOdNRWaQ0eqE6EhM9wOHPfDO
	 nkVGP4XNs6Ud8ze9ZVtui+55c0iL2yDh8KbBdV/uiZASxYXJltORI7ye7lUSjq6B6r
	 uAbknO6IeSpc37QTuHBCJpQ+ukQ3v7QCGjw4N5I9dOQC6B2P+NthPXEnW5S4yDz7IC
	 iSkCKd9ceXGlLEpN/OwTj3txnGz1zuYkv7Xly2h6SJYzQ7g4wDftJaso6jEOx7DdLB
	 9CFCD2VZtTLXg==
Date: Fri, 31 Jul 2026 15:54:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: how about enabling Sashiko responses on this list
Message-ID: <20260731-rundum-gliederung-vierzehn-700809aa7863@brauner>
References: <CAGudoHGokvqDNBz8EW5fwudfz_q-0+2eeon7-hyxZ5k=QOpF0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHGokvqDNBz8EW5fwudfz_q-0+2eeon7-hyxZ5k=QOpF0A@mail.gmail.com>

On Mon, Jul 06, 2026 at 11:07:24PM +0200, Mateusz Guzik wrote:
> I think everyone agrees by now Sashiko reviews are a net win.
> 
> The bot is able to respond with concerns over e-mail, see
> https://github.com/sashiko-dev/sashiko/blob/main/sashiko.dev/email_policy.toml
> 
> Seems like a good idea to enable the feature for the list so that
> people don't have to explicitly look for the feedback.

I tend to agree. I'll talk to Roman.
