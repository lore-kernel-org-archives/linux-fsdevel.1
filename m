Received: from smtp02-ext3.udag.de (smtp02-ext3.udag.de [62.146.106.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE494386C2C;
	Tue,  3 Mar 2026 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534350; cv=none; b=FHWhXYuSE1d0VkZTKpBTg/W9fTbzSefawJHQOV9pw/R5ySJEnH470RkWpFUs5rZ5YvF9FVzW5j/P3RXVoWGRBJ+GvIbIEIzi76IJzs4nDAdpIF6+eIoTM+hzZypNmzfnTpO2NjmQHscH11J9MpHfgKue5XMp55cwC871n5aKJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534350; c=relaxed/simple;
	bh=N7I4QZKEp36Fw+Gs6ImjixeyhbUmgJY170gjUUXyrtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnoEKOO6DW6n+NPiJ/kwq049haad8Pm7raRWkn3ONZK2imqEdAnm7OxR33S15MOH0mgPIrilUoc/ya0tOhY0bZcIvS2eoeq0FwmYdjBtAwJc7IztyqsIfjYrZgvw8arcC/EhOsMD8Fegi+QZURdCoDZ98y+9vjn/AFGv16d+wA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp02-ext3.udag.de (Postfix) with ESMTPA id 1FD34E05C3;
	Tue,  3 Mar 2026 11:38:58 +0100 (CET)
Authentication-Results: smtp02-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Tue, 3 Mar 2026 11:38:57 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Horst Birthelmer <horst@birthelmer.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH v6 3/3] fuse: add an implementation of open+getattr
Message-ID: <aaa4oXWKKaaY2RJW@fedora.fritz.box>
References: <20260226-fuse-compounds-upstream-v6-3-8585c5fcd2fc@ddn.com>
 <CAJnrk1ZsvtZh9vZoN=ca_wrs5enTfAQeNBYppOzZH=c+ARaP3Q@mail.gmail.com>
 <aaFJEeeeDrdqSEX9@fedora.fritz.box>
 <CAJnrk1ZiKyi4jVN=mP2N-27nmcf929jsN7u6LhzdYePiEzJWaA@mail.gmail.com>
 <CAJnrk1ZQN6vGog2p_CsOh=C=O_jg6qHgXA0s4dKsgNbZycN2Cg@mail.gmail.com>
 <aaKiWhdfLqF0qI3w@fedora.fritz.box>
 <CAJnrk1bHSRxiKNefNH_SUq1E93Ysnyk-POjh5GWxy+=8BewKtA@mail.gmail.com>
 <62edc506-2b0c-4470-8bdd-ee2d7fcc1cf1@ddn.com>
 <20260303050614.GO13829@frogsfrogsfrogs>
 <CAJfpegtTdL5Sxjtm3cKu9ZuYwceCfa2bX15Q3Wr_GQ2JNb84EA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtTdL5Sxjtm3cKu9ZuYwceCfa2bX15Q3Wr_GQ2JNb84EA@mail.gmail.com>

On Tue, Mar 03, 2026 at 11:03:14AM +0100, Miklos Szeredi wrote:
> On Tue, 3 Mar 2026 at 06:06, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Mon, Mar 02, 2026 at 09:03:26PM +0100, Bernd Schubert wrote:
> > >
> > > On 3/2/26 19:56, Joanne Koong wrote:
> 
> > > > The overhead for the server to fetch the attributes may be nontrivial
> > > > (eg may require stat()). I really don't think we can assume the data
> > > > is locally cached somewhere. Why always compound the getattr to the
> > > > open instead of only compounding the getattr when the attributes are
> > > > actually invalid?
> > > >
> > > > But maybe I'm wrong here and this is the preferable way of doing it.
> > > > Miklos, could you provide your input on this?
> 
> Yes, it makes sense to refresh attributes only when necessary.
> 

OK, I will add a 'compound flag' for optional operations and don't
execute those, when the fuse server does not support compounds.

This way we can always send the open+getattr, but if the fuse server
does not process this as a compound (aka. it would be costly to do it), 
we only resend the FUSE_OPEN. Thus the current behavior does not change
and we can profit from fuse servers that actually have the possibility to
give us the attributes.

We can take a look at when to fetch the attributes in another context for
the other cases.

> 
> Thanks,
> Miklos
> 

Thanks,
Horst
