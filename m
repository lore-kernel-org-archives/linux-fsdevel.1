Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360653AEF56;
	Fri, 10 Jul 2026 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672699; cv=none; b=ndsqdkK+SrVqj/UQmBnPIDvcwJjc4XR12I2zE84o0tm9UpCqz52Str45iKL6aDtS9FCE4w/wTlJnj0J8p8vc14wkRmz9ziXfiSsiaGSYbGeo4tcMsmUZbLKBBgPXsWZ1NTmQPh6MoMv+ec3Jke6amnzDwb80tmMAKyQ9AW1rnmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672699; c=relaxed/simple;
	bh=KZEr+70xvNwt/ePK09t8pxH31qLq064dGjVom+JyhdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Umyky4haiUB38o1KrMfJnJt1BgIIUJv3skjWzaO9cmh91N+cGlwAAp28yZ65H/iZvY9GLE0sBdLkgY1M2ux3uU6Zd+69+ee7yCVrIUitpzB/l4CqK+7TWAZ6oqw70+Bj9OYKcr6PfYu57LWyrf7GGtWGhbooNomfpfyQ1x/IzsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=H/d6sl8H; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="H/d6sl8H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=wXbQgJQyxvMFVCkak7sKFzG10NGfRvmu5GWYMXjJXgI=; b=H/d6sl8HjXdueLOAYUef/0tLcx
	4/E0lYzY7y+beOHuz5VpYTwFNvrDA3HGPyG9/kHmQcC3bHwVvxHJmKz4cP2sCl7r0m2+tnv5rJvcq
	khHSn9faoev3+OUfjSDncFBqwNUpEVlW/Gjhv/vclRYA5G/EsyLQNdhj6O86La6vY08E/Cp/8ewCq
	SKICma4rgGtmWpydGhtoEedAibbtFtOR49oaICm/SQukIwXE/sQThVJEjHmFpMkwRal6oOv9Hbsgv
	cjDBVveHjVJTOBEE0/ySnfCZLhBVRO7AZLZkvaYiaqOvnfLg7oHty+VSc146pjv220pwQGoIjJgEJ
	GrTuvPPg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wi6kD-004M0t-1H;
	Fri, 10 Jul 2026 08:38:01 +0000
Date: Fri, 10 Jul 2026 01:37:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, oleg@redhat.com, josh@joshtriplett.org, Jan Kara <jack@suse.cz>, 
	jlayton@kernel.org, axboe@kernel.dk, shakeel.butt@linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] fs/pipe: unify the page pools into a single per-pipe
 pool
Message-ID: <alCvQuSpsRHV6JQc@gmail.com>
References: <20260709-b4-pipe-unification-v3-1-80cafe097681@debian.org>
 <CAGudoHHEKHzdc6nQCNKP6jN=K7oOaeAKso83At_X_==L76Zd6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHEKHzdc6nQCNKP6jN=K7oOaeAKso83At_X_==L76Zd6w@mail.gmail.com>
X-Debian-User: leitao

On Thu, Jul 09, 2026 at 03:53:21PM +0200, Mateusz Guzik wrote:
> On Thu, Jul 9, 2026 at 3:38 PM Breno Leitao <leitao@debian.org> wrote:
> > anon_pipe_trim_pool_and_unlock() trims the pool under that same lock
> > before dropping it, then frees the excess.
> 
> One nit, but probably not worth respining: the naming is slightly off
> in that either both routines or neither of them should mention 'pool',
> as opposed to just one side doing it.
> 
> Perhaps Christian would be kind enough to either
> s/anon_pipe_prefill_and_lock/anon_pipe_prefill_pool_and_lock/ or
> s/anon_pipe_trim_pool_and_unlock/anon_pipe_trim_and_unlock/
> 
> >
> > A huge thanks to Mateusz Guzik <mjguzik@gmail.com> who has been
> > a solid collaborator.
> 
> well I wrote like twice that this kind of credit is not necessary
> here, but i'm not going to insist :-P
> 
> that said, the patch reads fine to me now, so:
> Reviewed-by: Mateusz Guzik <mjguzik@gmail.com>

Ack, let me respin it with the two items above fixed.

Thanks for the review,

