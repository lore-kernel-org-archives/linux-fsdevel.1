Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3005D386436;
	Mon, 23 Mar 2026 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260733; cv=none; b=npUz6tiT0WiwiXwgpdsVO/3a6PHM3XxdHgK4RzNtYkpcJBfk4/qD+6G/CuSRLNMU4Me4P1gQyTLKdBfl6pxU0ahAaeI1TunKqup4Jzef37Mo9ei5eoZJgFkR71HnYRiMqi4z795lFearfofHtQSCMFKEGMZd5mHUR9KFjBWqnp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260733; c=relaxed/simple;
	bh=BMXA0k3ogmuFjhThaTr758jyefhVZwTXJPYYsvNrBAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgF5nebAZvCZ0z6poBGnNz4px/nFgetZbfULjv4Tsr/yTHIUC16SohmpU4oUrgS2DqBSa1HXH7PEQ8u1j4YTCxXTCTcdDXrNhdjOhGTkCPtV09VmpwUmOprlXDOfd6b/yylXuloil8BXLldT4DwiqFcKYWattYn1dvmItNAY98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlCAi9cF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlCAi9cF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA45C4CEF7;
	Mon, 23 Mar 2026 10:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774260732;
	bh=BMXA0k3ogmuFjhThaTr758jyefhVZwTXJPYYsvNrBAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LlCAi9cF7TvHstavvWsK+nr9+BX9SmJz4CjmQwQ2lyqNgJAVmlMkDcRfPQvXjvUYb
	 gOFXn/UWHb5A9EGvOijRmOFqv8DSDgCA7uRTmi47XxU+ITExahnfXbRjubf3okTR2F
	 qs8JIAbWVFT3UAN48q9B80pRAb7DAlIhXaaRCPRg4kHqSdjWVz++QBvsu7Al2GZCi0
	 lETLh/Gc0Poe3vyyQQYsUS3eKPyfzJqUxemce8/RdaM75ouPSci5rSv9CL4Q7QeWLC
	 1Bi68jP6aLLIxoJZyzA8nZ00uNcqPOLVWbHKvMHeAjEfto+XKV3YXm2cya4rj0Hyj0
	 7tNQIHKOkttWQ==
Date: Mon, 23 Mar 2026 11:12:08 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fanotify: replace deprecated strcpy in
 fanotify_info_copy_{name,name2}
Message-ID: <20260323-frohsinn-rudel-2f5a8bbae433@brauner>
References: <20260321210544.519259-4-thorsten.blum@linux.dev>
 <jdyy4txjjlmbwofqbsvpk53yx6cvx5lto47guv3nevpiflylhc@vjyncn6aesh3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jdyy4txjjlmbwofqbsvpk53yx6cvx5lto47guv3nevpiflylhc@vjyncn6aesh3>

On Mon, Mar 23, 2026 at 10:14:24AM +0100, Jan Kara wrote:
> On Sat 21-03-26 22:05:47, Thorsten Blum wrote:
> > strcpy() has been deprecated [1] because it performs no bounds checking
> > on the destination buffer, which can lead to buffer overflows. Replace
> > it with the safer strscpy().
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> I was a bit undecided about this one because I was wondering what
> additional protection does the use of strscpy() bring here. But I guess the
> protection from corrupted qstr (where the length doesn't match the real string
> length) makes some sense. So I've taken the patch into my tree. Thanks!

Fwiw, patches are now auto-tested on vfs-ci:
https://github.com/linux-fsdevel/vfs/pull/860
Just for some testing data. We should probably hook up the relevant LTP
tests for fanotify there as well.
