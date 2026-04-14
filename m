Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC5318B9D;
	Tue, 14 Apr 2026 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160348; cv=none; b=MakNn/BYbhoVmlz11uj+jLpAjyCVLQ4wq91z+pficKVohjimAjou2bI+T2tQb5Uvg+muuPlv6dVmg/EAL1bjXbVa46jzEpdZH5YJDMnIWYOtN4zXXIRSULCJ8f8jzYHL+D4WsN/QoyJlAorFX+Ww3jyXcmNLiwEyv4EttldncN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160348; c=relaxed/simple;
	bh=xC4j98w4sZWCYmtLSTdLSIfWfef7vJkPLwgcyfZnfG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1sQoRUWE++0XiyQy30aDjaGQ2FbRAv+hCTmWpZiAlYbY+HPsihO9Vg/obHe91hy6AZk8oke97y2jvw+gRiRDJlQGbzN/kAF4/CNYcSWd5/RJzeXUvHBRbixGuviEPOAOLek7lebOZim1qO7fg1dPc28zJqvePuJsVTdOxM6QUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDIhEhbp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDIhEhbp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A12DC19425;
	Tue, 14 Apr 2026 09:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776160348;
	bh=xC4j98w4sZWCYmtLSTdLSIfWfef7vJkPLwgcyfZnfG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDIhEhbpfk26v0dBJVZmUo9Esro2i4wh2L7HITwBZ1Sz7pHDUT946PmqjO0EVgqwd
	 zAY/KYhC1k9KYw15eSpX/7YufkaBXB9oaUZEUG071N4zBq/x5fJvbbkQVUYLENzFti
	 auHomPdaiEiB5NGzw0Vb9VWb6oFzhJEpdCex2pRkIzweT4l9CizF8p+NHWx2s+hOav
	 iY2QXiLzxGb2GAVqyTuU3p4DdEbocoWzPv03bGR3TskINcNivx8BnaJM75Vb1j8iyt
	 G6fbAgC0jnP9tinKqU9Mhe+nk1+srMmyHPNinnO3kZLPSwbu0FdeXveM4OiLYSMQFp
	 mkraX4IiIGdZQ==
Date: Tue, 14 Apr 2026 11:52:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 05/12 for v7.1] vfs fs_struct
Message-ID: <20260414-garen-eckwerte-62bd3b06005a@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner>
 <20260410-vfs-fs_struct-v71-cf1d44311509@brauner>
 <CAHk-=wiW53j3vmc1Y58-E_8jUBJtjgAVxDRt+r-w3WPQN+Zm5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiW53j3vmc1Y58-E_8jUBJtjgAVxDRt+r-w3WPQN+Zm5w@mail.gmail.com>

On Mon, Apr 13, 2026 at 12:18:16PM -0700, Linus Torvalds wrote:
> On Fri, 10 Apr 2026 at 08:18, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Avoid excessive dput/dget in audit_context setup and reset paths
> 
> I really don't like this one, and I'm going to at least delay pulling it.

I don't like it either.

> Because this really feels wrong to me. It feels like a hack. Just

It is. I commented on that explicitly when the series was proposed.

> looking at some of the paths that get modified, we have that
> copy_fs_struct, which does
> 
>         path_get(&fs->root);
> 
> to increment the root, and then the very next line ends up being
> 
>         get_fs_pwd_pool_locked(old, &fs->pwd);
> 
> that copies the pwd very differently.
> 
> And the only reason 'pwd' is different is because the audit code
> treats pwd and root differently.
> 
> And that, in turn, is because the audit code is just historical and
> broken, and can't deal with chroot environments.
> 
> The pwd and root paths are two sides of the same coin, and any code
> that treats them this differently is *wrong*.
> 
> So this basically takes a audit mistake, and makes that mistake
> visible to non-audit users.
> 
> I absolutely hate it.
> 
> I'm going to think about this more, and maybe I'll end up saying "it's
> still ugly, but whatever, I'll pull it anyway".
> 
> But right now I'm going "there HAS to be a better way".
> 
> And maybe you can convince me this hackery is the right thing, but it

It isn't and I'm not going to try.

> really is rubbing me the wrong way entirely.

I'm sorry I can't offer more than agreement with you right now. The only
reason I considered it was that my appetetite for audit internals is
very very low but tbh that shouldn't have led me to accept the
hackishness. So again, no long-winded argument from me here... I droped
this from the other pr. The CI is still running then I'll resend.
