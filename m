Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729F83932F6;
	Mon,  3 Aug 2026 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763998; cv=none; b=Mi+NokxIwCRvEJevdhYrqXtzreiFomHB2AD8gF/6L+SWHLL7tid/vO4YAGPTV+k1gXpJx6Qn5GoVUPErFUgGC6yg0ZLjwbF5eOxfDWaO9EA3V57AlBcMuWDboGa/Z72s8rsGHc9ZsN58p13vcjH++4Lq/Xy0PtaHfqF9GHJl0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763998; c=relaxed/simple;
	bh=JSpGertgkmlIUa7Z5u+NYVW9LPA1dB7pVe7IQsSWW2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr9c3IBCWTodo/c0j5jQcBwIZKxmx9+XC+pNOfan6+p8r23m7oY22j3wq9s68G23w6myrb6XWM9uy+Xct+GPNLiMb8kacoq30ecFXoe0wQD0FuOyoPM+DxiM2x1DIUpzlUOmu/g6+3a26xRQ/OdDE8pt28bgGv20HO1hJFV41T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=s5KmJV2W; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="s5KmJV2W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FuDOeKJb/BipJJjn0IDNvf2CLnN0XHmqFTqfauPQ1Sg=; b=s5KmJV2Wpnvy8iwsD10te6U4WY
	U7+3Xu70FLt/jNoTv30WGdKtn93wgjEVEc/c84UlSveKoH6BWsoVsylIch7MT6/d3AopRPsTkoWaU
	Xgl0LUvK76LtBqoT1cbmmJvNDEyevCZ9aCLmNTXp/2Rcp2nPArk/r0dgwktyiup3l11aSDWbUd5JR
	l/EmBnrOof6Z9qL/ng1nbGbzEd3bcS1O6wuCxCSO9hvsZIAhkvvYXrxfg7rToVROkRtytkd+skuEZ
	BCJLTUQQGLeguKPnsFPYII4ZGYkMJLv5GMZJAPmutI4iE2WZVuAeYDaGY0KeL1L07zaVWBw1rd23/
	eSrUQuVw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wqsmo-00COOB-2U;
	Mon, 03 Aug 2026 13:32:58 +0000
Date: Mon, 3 Aug 2026 06:32:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH v4] pipe: only enable the extra wake_up(rd_wait) for
 EPOLLET consumers
Message-ID: <anCYWrlQEFd7I0xd@gmail.com>
References: <anCNoW-x0bcB2ggg@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anCNoW-x0bcB2ggg@redhat.com>
X-Debian-User: leitao

On Mon, Aug 03, 2026 at 02:46:25PM +0200, Oleg Nesterov wrote:
> +	 * Currently io_uring sets EPOLLET for multishot polls, so it gets the
> +	 * same behaviour.

I got the impression that Linus wanted the comment epoll-only, and
wanted the io_uring case treated as something to remove, not to bless.

