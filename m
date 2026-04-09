Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FACA40DFCC;
	Thu,  9 Apr 2026 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742043; cv=none; b=l0AYfBBHJZzGHmhxc3LrSTORqwiGIhfq6BkAiWEq8XTj3plBkrQ/u7tohQi4vswcuYukdYD/DDXNbH0UG858mOtUjB1Fj6Mi/J6yWoPFx+YFV1WTqs6OqZ4XtHcfm6HJQLtwACY+fAnBKSjXeW0TVdO7y2Nm2/e22PwBa4XV1PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742043; c=relaxed/simple;
	bh=ceyLircT23qxl5OTtwUMU1E9O2wWy5XtvTc4kbO4HXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtgS+dX78WE4P9iIZM/6IX1OjRgQ1Jplg6Z0yH6NVBwo/CBqWnHlseHuZzjOenmJOXkehyKUMdjR7xj/V/XW6yHMACXbWphxmUfVz6eFa974rMx/xj7JdataGTzRT8L4C4LUBXEMOKWDa5EEu2EO4OBy7CX9zz1gqLf4CpMVpac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKVJh+uQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKVJh+uQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B91FC4CEF7;
	Thu,  9 Apr 2026 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775742043;
	bh=ceyLircT23qxl5OTtwUMU1E9O2wWy5XtvTc4kbO4HXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKVJh+uQUVk1wDoCIPKJubzRmDalRP1Sh5/KRRHFAqLMwGfN7zY+Vg0hD26Jooxd2
	 CfsPtfu/URiEawUWbBQOyFBaP1KhuOV2ni9eE2PVlVy8I2jb6BQWdbhp7KS61DhGrN
	 yTpH97LNaZVY9dzBNj53jm0V7lePG+Pabgt0nJQiVvJzE5vTLwTvAnApysbB0hVyxD
	 MijAHPMDwJCd2/7AfgPQUebeQzQeIydsPbVjtXtqISg5clzE5zlKduusu9arzUSOgA
	 nQRyJaID/vgv5yQHUpNtvz/36bXCz5bpGuB1+S3kQhtbQ1XVXjykBAC0fnSCUmPGr4
	 Zlw3/02/D9cmQ==
Date: Thu, 9 Apr 2026 15:40:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] fs: handle potential filesystems which use
 I_DONTCACHE and drop the lock in ->drop_inode
Message-ID: <20260409-weben-obstgarten-1465edb3d7bf@brauner>
References: <20260331160851.3854954-1-mjguzik@gmail.com>
 <20260331160851.3854954-4-mjguzik@gmail.com>
 <itaix3v2pgkrlvhxetyepfzrbyg7bnigghrkrdofznas37nsyf@irriakb7cwzj>
 <CAGudoHEBkMu=mY12U6WmXDReY5EUXehP6wG45XmLyQ5qHiMA3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEBkMu=mY12U6WmXDReY5EUXehP6wG45XmLyQ5qHiMA3w@mail.gmail.com>

On Wed, Apr 01, 2026 at 08:50:39PM +0200, Mateusz Guzik wrote:
> On Wed, Apr 1, 2026 at 7:45 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 31-03-26 18:08:50, Mateusz Guzik wrote:
> > > f2fs and ntfs play games where they transitioning the refcount 0->1 and release
> >
> > I don't see ntfs providing .drop_inode at all in current Linu's kernel? The
> > f2fs case is indeed ugly and a gross hack. But I don't see easy way how to
> > fix that for now.
> >
> 
> This was generated against next-20260327, then:

Ideally don't develop against next... If you already know you're going
to do a bunch of work in an area. I can just assign you a branch to work
of off. Easier for everyone. Also makes the CI easier.
