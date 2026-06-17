Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3122C027F
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697520; cv=none; b=SdEVUevf1s+UG2ajv7H+oY0yFrSNAEepuTsY8qQmB4W+27SpU6NUsHuC/r167mC96/RgYyHqdxpS2zW8NgyxrLaLv6hDmOfn2fHlpQ3qrE/fZezesyywcMB0w8k5Qsn3BQGNHC2xKO+Sr88NfFpLnAK0LNXOyi+RhLM+kn1j4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697520; c=relaxed/simple;
	bh=QDE4pWUCieChBH6stg70tQGlE/RFXMTxm3YogIOpY+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwueRVh1U5sAecTfrXsqCCLl4te9gEFjAJ9qcqEjYLwya98m5ytqekbg9fsrICzYFYH1KlILasEUfyuC/PX8IcpOmDgw/zYRYe/5wQ0+zpi84MgWbbw+YHFH0eORNYzFIydvmlg5qh9mup40cEMmwl7YLKajyCTUpIG+JjYP9Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGf7qQy7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGf7qQy7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9D81F000E9;
	Wed, 17 Jun 2026 11:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781697519;
	bh=sfP8NKcMlHtMfZcRLcHNeEjsbWbku0UoTWiakaXjTxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nGf7qQy72QyJp1CRbbYfG1VrmYLNTp5zik9OTbo52gyRXWgj1IJeENfjTl44ez8G+
	 am5gXYp8w7XN5Hr9kkeOBzjrwrqpNFXgDlORUf2G0gBnO2ixKZDf1qgwGUJM+HHLIM
	 MkVZs62N4OUS2xzmJpgC0yw3KMQySJPraKOGPXWIGD8bnCybgEztqFT6PBpaOQLavS
	 jcLWk1qOKdbGd/9Tna7P6RVDJuaUVkIxQEp67muVLaw14gUB3NcE4DY1NSp2Y9Nkau
	 i454FWNpVST1IBR9P9geC/scyn+KRjDPLzfkvR/hRitWWWXsvTmMyBsZPXpWmBpFes
	 7FE5FbJ44zhvA==
Date: Wed, 17 Jun 2026 13:58:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Andreas Hindborg <a.hindborg@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [RFC PATCH 0/8] namespace-aware configfs
Message-ID: <20260617-unsterblich-fortziehen-quietschen-f52ea8f40d9a@brauner>
References: <20260613111437.101763-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260613111437.101763-1-hare@kernel.org>

> Open Issues:
> - I've added a new function 'mnt_clone_direct()' to clone the vfsmount
>   entry (the original code just did a simple_pin_fs()). Not sure if
>   that's correct. Christian?

I think we can put that issue aside for a second as there are a few
bigger design questions.

> - The current cloning mechanism is not really a hierarchy, but rather
>   always using the default namespace to find registered subsystems.
>   Meaning you can only call 'register_subsystem()' for the default
>   namespace. But then one shouldn't call modprobe in a container, so
>   that's okay I guess.

I'm not sure I follow what this is trying to say, sorry.

> - The original content of the configfs remains visible even from
>   within the container, and the new 'mount' will just overlay that.

I again fail to understand what precisely this means.

>   Ideally I would have the container start off with an empty
>   /sys/kernel/config to avoid configuration issues. But again I've
>   no idea how to do that (or if it's even possible).

Shouldn't be a problem to implement this. Just means more work.

So the rough concept in my head would be that configfs is a
multi-instance filesystem that remembers the namespaces it was mounted
similar to how kernfs allows to be tagged with namespaces. It then only
shows/allows registration of subsystems that match the relevant
namespace tags.

The challenge I see is that configfs shows subsystems that may be tied
to different namespaces.
