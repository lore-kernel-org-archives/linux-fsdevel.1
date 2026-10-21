Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576223;
	b=hilvPx1GjtXCt1kyGhwqsfcoNwt/CX27et6sn34uA7YLC+6T6nk0I2kNk/eVGrXUErEi
	 oCJm4ZMqrXWKhtS1ESWwWwOo0bIrNUzEsIYpTUeX0XlUx3Fw+VD5jo3gXkPxsuXkW9Qui
	 MNxnEZsE1G3E4M8rh5tWbfsMZqkG507/lH/gayWjagOQs1lTZ5gLyiRl8BoINqBocEyUQ
	 jmHd2Sm5u4QCY4BQtsGO1vH/Fo5MrXwuDnJEnzKxFNXD0mpiCL/u3Pt63pWM7jEE0Ul9Z
	 dETVJZXsvRTUJmLMx/9BqHPL/RcThdfyY4YLhDmCKAzOK6qG4Y+eGW10lB5oGt1l2QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576223;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MAk9EOQt8j+91PKPkCAlD938YO3Krp5viJ3jkwtfXeE=;
	b=g5fk5yYJJHT+oej+tFyg2+qkkK2vKjBgqoVHjBC5wJSf1gKQ+5CTooj0YrLUHAnVdRZK
	 MPYevjYZgVAWy+Bu4PYgB5NdK0HWUCdG+l6TW11XSEibri0Y0GmDpXlIjLyweSimUyckY
	 jT1B9NUOc38dvRm0c+clh0zoOFtiMrszqpIqikTdtnojDwucv1mh+nfOu8K08zXyDjnkM
	 ZxGKB37ejyNCG3+cv7ctqEWyg+oJoARnB4PQD5C9rN03wtEWmUIsAdNal7UkP2MFlQ4Rt
	 gFQbtEZ+tXeEHgp/MfnAZehFnyHFaThdrLavEGfSxafvgq4SV6D9IdEAuu3KfONQgJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i6/muOwY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01DD606A31A
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6/muOwY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE531F000C9;
	Wed, 21 Oct 2026 09:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792576222;
	bh=MAk9EOQt8j+91PKPkCAlD938YO3Krp5viJ3jkwtfXeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i6/muOwYhnjIDbBIppJXkMDtPoPtNh94NT3KfG0cLYeok3wDafG6qcz3IJMpFcCJG
	 8MJLXOz5ZPJIKesusr6G3VPA92s1Z0CIPNb4+LfhIvlWEJyC8G/aA6w+lliZ5+HfLZ
	 cf9r+peoS6/xYztrA52PU6RbqoOTxpf0Nys/8hWCX4lLBj1i7FV5GAl0G4PTP+k8Oc
	 oYcaUsrFBkOpMEwI7NB6fXT0CCa6KKXK1gWV+Sjzk25G0/bcBocZ54UPYrCk9+JHeJ
	 l7q5CEt6DaqBpsWgvNEvjhBwmhY5c6q5QBUzjRr8elYmIZHtK7zlGTiT8nJU1YxtXq
	 4XFnz2GZB8BSg==
Date: Wed, 21 Oct 2026 11:50:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-afs@lists.infradead.org
Subject: Re: [PATCH 0/9] afs: prepare for locking changes.
Message-ID: <20261021-auftischen-bootshaus-hochinteressant-fe85ff2d472c@brauner>
References: <20260926030052.467448-1-neilb@ownmail.net>
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
In-Reply-To: <20260926030052.467448-1-neilb@ownmail.net>

On Sat, Sep 26, 2026 at 12:57:19PM +1000, NeilBrown wrote:
> I am working on changes to directory locking.  The medium term goal is
> to lift d_alloc_parallel() locking above i_rwsem, so d_alloc_paralle()
> can be run unlocked, and consequently cannot be called when ->i_rwsem is
> held.
> 
> The requires:
>  1/ the d_alloc_parallel() not be called while i_rwsem is held.  NFS does
>     this in a few places. New interfaces d_alloc_trylock() and d_duplicate()
>     are now available and can be used instead.  In one case we must drop
>     and reclaim the lock and LOOKUP_SHARED helps with that.
> 
>  2/ a dentry must not be d_drop()ed while an operation is ongoing, as an
>     unlocked d_alloc_parallel() would then be able to create a new
>     dentry with the same name.  In particular d_rehash() must be phased
>     out as it won't be safe. This particularly affect the mechanism to
>     block lookups/revalidates while an unlink/rename is happening.
>     The mechanism is changed to use one similar to how NFS addresses this
>     needed, though using the new LOOKUP_PRIVATE flag.
> 
> The patches depend on patches recently added to the vfs tree.  I would
> prefer these land in that tree too with an Acked-by or similar from AFS
> maintainers.

I can take them once David gives a nod. I already take a bunch of afs
fixes.
