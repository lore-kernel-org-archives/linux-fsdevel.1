Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61D23B813F;
	Mon,  6 Jul 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359593; cv=none; b=ZFwtDZ9LDbaOX4rIZhIcZy9wrlCo+275DlyVho9uBy9241jrS+hQ2kyXyiqsgopnaerhPxPLgpCHdLdZL6StPDOwpw5vYrv50oChOWOCFcGBNc2laLOMSo+o1zokqflPuyu4hlfkrc5LHjcZH6lXPhRQNQUjohaeJHq5wowbvMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359593; c=relaxed/simple;
	bh=Fe/TgMEwEFtOLD5NgM12ngh0eH5Edmg0GYEZu1Ylcz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3fe1mcHZCElZSTiSW1mEMLlCs+9OZ4A7T68HndKCOa3QwZ5Eg7M24nmvcg8gTm791W1M++Ta/yBRjVPfF77pUeL9UFIFuY8xAG7HNNsASSBqHcx42bjuf+rOZQqp6r075229s0lpq+rasteUFAJScxTzOyWK1C+vY3iqegeldI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=df8qxhis; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="df8qxhis"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243581F00A3D;
	Mon,  6 Jul 2026 17:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783359591;
	bh=k5bcAbvr05RJ9SxoOp7CqnnWDHfU+AYRUK5wYjva7Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=df8qxhisD9j26nAwVFJHmDhjInoLVtFijD6NSxRBCwJXoJAIrlhVn9cn6xfNmVvVP
	 mDhrv3Saf1xTfc96ZzaY+x7aUzHzLFoPG1y1w/A1waAUgvRPPoVSKDiiF8Pr9Y2XCf
	 4Lz+BY+b1PYmMEuNghV3ivUlGTZdg8Umk10eJ+xNYuOaGqNlqXtYCXsbuOSVgaiaVe
	 skGIu/w5nu/NZgWNNFg0gj3G282I43Onj2LX7uqSoYyUYtQwgAQxcBgOb+ZxPiEiWa
	 IdGaMJvjG0qb8fjok/4IX5OsjuTin6wp5iyGJXg6ac4khljG04jyV364BGJ9zyhjYO
	 j9UdSqpAyvKNg==
Date: Tue, 7 Jul 2026 02:39:49 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Wei Yang <albinwyang@tencent.com>, 
	Zijie Wang <wangzijie1@honor.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] proc: only bump parent nlink when registering
 directories
Message-ID: <20260706173922.GA265195@rocinante>
References: <20260613211005.921692-1-kwilczynski@kernel.org>
 <20260617-zeitig-umlagen-ortseinfahrt-1389d7457b0f@brauner>
 <20260629054007.GA2410937@rocinante>
 <nmzpiovepu4fi2ls2xrgserszqy3vwyoud3u4ze7cz53wwjvp6@jmenhf5qni6e>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nmzpiovepu4fi2ls2xrgserszqy3vwyoud3u4ze7cz53wwjvp6@jmenhf5qni6e>

Hello,

> > > > proc_register() increments the parent directory's link count for every
> > > > entry it registers, while remove_proc_entry() and remove_proc_subtree()
> > > > decrement it only when the removed entry is a directory.  Regular files
> > > > thus inflate the parent's count while they exist, and leak one link
> > > > permanently on every create and remove cycle.
> > > > 
> > > > For example, /proc/bus/pci/00 with twenty-two device files and no
> > > > subdirectories reports nlink 24 instead of 2, and SR-IOV VF enable
> > > > and disable cycles, each creating and removing the VF config space
> > > > entries under /proc/bus/pci/<bus>, inflate the link count of that
> > > > directory without bound.
> > > > 
> > > > [...]
> > > 
> > > Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> > > Patches in the vfs.fixes branch should appear in linux-next soon.
> > [...] 
> > > [1/1] proc: only bump parent nlink when registering directories
> > >       https://git.kernel.org/vfs/vfs/c/552864f6ac8f
> > 
> > I assume this got lost?  Seems its missing from 7.2-rc1, sadly.
> 
> I don't think it got lost. I'd expect Christian to send the fix for 7.2-rc2
> (he merged it to his tree only during a merge window). I've checked his
> tree to verify but apparently Christian didn't push out vfs.fixes or
> vfs.all branch for a couple of weeks.

I saw the patch landed.  Thank you for help!

All the best,

	Krzysztof
