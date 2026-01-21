Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C442322C80;
	Wed, 21 Jan 2026 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022018; cv=none; b=g+JFHeTaFEr5iyJNlKwcpJ4lILihseWPJP70CZ/PnM6XeE5YDDZYtqSV1lugluRd8yGKQdhpulxX9yKXuZ5i48ZEzAG4gOw6Q46dQQnluStj2ksdeG8MeeAkBCiY3pR8N0u9ZC4rvshyJDsf1gkYfRuC3wXI2XsD+w5QDKAKz+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022018; c=relaxed/simple;
	bh=l2/DvwO9Q5GOJLxXiXOoPh4OM9mD3QxLK3B/f5YuIpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHmMawD3mW1atjfJs2ZeXS2wv9KyOD85JvMbGVW8F/QbiUs6OjvWWgiXIasIVSAwjwXssTOHEBFWE+/ORcbiiFoW+ViBTP7K8WMeGpnDg9QZmI4Ggab6DXP+rz1hfbkx8yrOtRGmXsVPSYIaG+qJqGoclUdHpIOLnWeMm65bMLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 0247FE0811;
	Wed, 21 Jan 2026 20:00:11 +0100 (CET)
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 21 Jan 2026 20:00:10 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Luis Henriques <luis@igalia.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>, 
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
Message-ID: <aXEhTi2-8DRZKb_I@fedora>
References: <CAJfpegsS1gijE=hoaQCiR+i7vmHHxxhkguGJvMf6aJ2Ez9r1dw@mail.gmail.com>
 <b2582658-c5e9-4cf8-b673-5ccc78fe0d75@ddn.com>
 <CAOQ4uxhMtz6WqLKPegRy+Do2UU6uJvDOqb8YU6=-jAy98E5Vfw@mail.gmail.com>
 <645edb96-e747-4f24-9770-8f7902c95456@ddn.com>
 <aWFcmSNLq9XM8KjW@fedora>
 <877bta26kj.fsf@wotan.olymp>
 <aXEVjYKI6qDpf-VW@fedora>
 <03ea69f4-f77b-4fe7-9a7c-5c5ca900e4bf@bsbernd.com>
 <aXEbnMNbE4k6WI7j@fedora>
 <5d022dc0-8423-4af2-918f-81ad04d50678@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d022dc0-8423-4af2-918f-81ad04d50678@ddn.com>

On Wed, Jan 21, 2026 at 07:49:25PM +0100, Bernd Schubert wrote:
> 
> 
...
> > The problem Luis had was that he cannot construct the second request in the compound correctly
> > since he does not have all the in parameters to write complete request.
> 
> What I mean is, the auto-handler of libfuse could complete requests of
> the 2nd compound request with those of the 1st request?
> 
With a crazy bunch of flags, we could probably do it, yes.
It is way easier that the fuse server treats certain compounds
(combination of operations) as a single request and handles
those accordingly.

> >> Thanks,
> >> Bernd
> > 
> > Horst
> 
