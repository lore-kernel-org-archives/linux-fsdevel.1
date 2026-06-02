Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A893831F997;
	Tue,  2 Jun 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406364; cv=none; b=HvqjWXF+N9zwyvnZwx0xxFTQ46jbJf67GuqC9+eCoaTtpkZzjnadctwdPKCYR3z/46urVSV5IsmhKs7uniHSPw8jLQXxQGsfFf4LPZ26ADhXqpH9QHL8GwQBXwDj9xoNs9b1ga3Z89qUWkY/nCgpdbPvfXIXJ0IdfC8sqAUxHy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406364; c=relaxed/simple;
	bh=Nt/4H64NaQk44GeIizZ1ITHTVqkfyCLEtkyLtqQB1yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5gria8TwudIqxczBYbxLp2i3AxVyWn+4Ojf6Ewcm/iA62rSBecyva/l3bU15waERba+uYUGLXHyHsr3MVmMJCZJfusx0iOXc+Aj3qZ7pLA86mJO0Da/6mvj+7saQK/HbRF0Z9vW3qDGY8kGgIpoIQ+cC2OCqpcpo4eOfN0JIJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAVHKLz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAVHKLz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0078F1F00898;
	Tue,  2 Jun 2026 13:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780406363;
	bh=qIqOC0zIFENBc5vsQMZZ4aasxKCurPlnabfas50Y1Og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jAVHKLz87ZxGp1a+9DqoSudr9kpicv9cIBjG0OVBI+VWyBz8hIxNqUFqFPO5MURkz
	 a3XKpsVYvDASH3j4JutQzmbQ1Z3JjngeslxHHJAQnz30fLZiiZq/6TeOg1UgIquu/h
	 3hCCxLXyHsQNswX/RHmmZKoBeyWZ233/ZfigARYhEtwsqw3kFLZlhYis0X2U1ZR90H
	 qTXjftD3L06vFfBeckP2fGOw2izPwpn6yebbkHAgb/87nNuFThhkgEZWCDHL6OUa6l
	 7pTVc+1PfkcCMl8MBcjc4iw3dlQgFetZBmIPnsSH9faBmfLjzvkXcgW4MpRLt4op5J
	 hck8QWW1bcrug==
Date: Tue, 2 Jun 2026 15:19:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, adobriyan@gmail.com
Subject: Re: [PATCH v4 0/3] revamp fs/filesystems.c
Message-ID: <20260602-eiskalt-kaputt-baubeginn-739632ab746b@brauner>
References: <20260529171840.2576445-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529171840.2576445-1-mjguzik@gmail.com>

On Fri, May 29, 2026 at 07:18:37PM +0200, Mateusz Guzik wrote:
> The file is a mess with a hand-rolled linked list in a desperate need of
> a clean up.
> 
> The code to emit /proc/filesystems is used frequently because libselinux
> reads the file, which in turn is linked into numerous frequently used
> programs (even ones you would not suspect, like sed!). In order to
> combat that pre-gen the string instead of pointer-chasing and printfing
> one by-one.
> 
> open+read+close cycle single-threaded (ops/s):
> before: 442732
> after:  1063462 (+140%)
> 
> Additionally scalability is also improved thanks to bypassing ref
> maintenance on open/close.
> 
> open+read+close cycle with 20 processes (ops/s):
> before: 606177
> after:	3300576 (+444%)
> 
> The main bottleneck afterwards is the spurious lockref trip on open.

There's a bunch of work in vfs-7.2.procfs on top of what's currently in
there. So please any changes should be a diff on there otherwise we have
to rebase that whole branch when it's already -rc6.
