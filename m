Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5E2E0902;
	Wed, 24 Jun 2026 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782262116; cv=none; b=ZsPW2eKPOq5zD9oVZL8nq2PeTTgd8SKzkK8f0JDEM5gKPvmBLOVYoOzKkXj68vEqDYktmyygMBx4UMxWH/yvxg5pzd65SDoCdxccYT6Ec+JUfJuf2QfP6jL7RFkokAj9WgRFNsRvDiBOAi7kYgv4loNcF84jVtekx67aqMjzqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782262116; c=relaxed/simple;
	bh=PjAHeB7E2BaIHkRzrRF00bTHpYMgpR4Dh7VSTYWu9lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmKlXTSgyDFzA/A/4S/cEURmRW+qXbbAF6HmlEQHorlqXc3lj+WH7M9AlXI84ntlc0JneKExtmqz2lmQxmDb2vjGISW/Of42jmHXNT9pdediBzcDBh0pLZzn7ujI9QKhlkBo3SI099oUJgKMZ8kC+cZEPePoX0dDcIIuCrLBdSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WjqTrHpW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WjqTrHpW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X2EYlWrDIggaFS1Cm6S9FY0dqVECZJtXN6I4L2cEQ1s=; b=WjqTrHpWtqnYLeJO8gl/AWhGiP
	Jj1v3S+TKScnKZyFylAt5oIXL60KtuUD9g9LHBgyQVxgSXgY3K10dhRfGjktP065GaQIaeUdXEF+e
	FvO4plR96u8zaxmefNyCBkt+K610qm097kwbe4QGinHOy0L7yI/Iov0t9FZoEXKtpU9YZTieyzAGi
	JfJSkmj2xKsajTcUAyeoV0+lC8nDomcd4wti3rlvDMLgYykXnpZDSsGejuEZAcTT6fb9f7h7zGj7x
	d5zTykfCq2IOIgwtJ5KtAUq/MGvSj+kbA/0DZIyPL8rAvlVWnrEvhX/qDzi7waRZsYHrmwsRJ5k4y
	l5svrOKg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wcBn2-00000001S2J-26im;
	Wed, 24 Jun 2026 00:48:28 +0000
Date: Wed, 24 Jun 2026 01:48:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 00/10] kmem_cache instances with static storage
 duration
Message-ID: <20260624004828.GI2636677@ZenIV>
References: <20260611171425.1671254-1-viro@zeniv.linux.org.uk>
 <20260613050951.855141-1-viro@zeniv.linux.org.uk>
 <151b1c96-0ed5-44ce-b9d5-86a48d8ad592@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151b1c96-0ed5-44ce-b9d5-86a48d8ad592@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 23, 2026 at 10:09:41AM +0200, Vlastimil Babka (SUSE) wrote:

> But the argument for doing the static duration support is that it should be
> faster, not just "not slower"? So is runtime_const equivalent or for some
> fundamental reason it's slower than plain &?

Yes, on any 64bit RISC.  And if nothing else, arm64 has enough users to care
about.  runtime_const for _shifts_ tends to be nice and easy; for pointers...
not really.

Compiler does *not* build the address of global variable in a sequence of
shifts and bitwise operations when it needs to pass it to a function.
runtime_const_ptr() must be able to handle an arbitrary address; it can't
avoid doing the general "build a 64bit value in register", which tends to
be nasty on RISC.

If you want real ugliness, take a look at riscv - AFAICS, they wanted to
avoid a long dependency chain, so they load chunks of constant into 4 registers,
then shift and combine those.  arm64 doesn't bother; IIRC, the hardware does
recognize this sequence, but I wouldn't swear on that.

> Or is the advantage that static caches can support modules and runtime_const
> can't?

Probably, but I'm not ready to give examples at the moment.  There definitely
used to be __getname() users in modules, but that stopped using names_cache.
