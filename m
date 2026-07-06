Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456B395ADE
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783372048; cv=none; b=o31qYnlielR/GP94Teuv1VDAqGfkx7EMLYlIHsbTBLfWHNM0qQJIlcDzs8KZWalqj3mbLVrHl0HaiJ0JQyhtdo2opK/jg6o2f6e31X9tgC7qYcoA2wIpGsm4BuxebAqA1mapUctfsZBenoqTYRoMCmPjJwIBlbTppMRq0RQLt90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783372048; c=relaxed/simple;
	bh=Pqs8zy0BxEt/K3LdaGIP9jatK+bPAI60Bho4i00PEvQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Wn+QFvy/dQ1X5awhICArOuJSi9BHac6XMu07XtQEIkONbmp97rJznozc31ANpTNHapMr8mlVnXXl4e2lNPDwdusz9x1H6YQU3y2WfE4Mdtm51paMAQbYfa8QBG65wXgF3ffDgjTNF+nkggbOqKeVR6bN6HObm+ETjsLFvAE1ZOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=XBbQ9n7K; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="XBbQ9n7K"
X-KPN-MessageId: ac2f9678-797e-11f1-9e8e-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ac2f9678-797e-11f1-9e8e-005056999439;
	Mon, 06 Jul 2026 23:07:18 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id ac2e5698-797e-11f1-ae6a-0050569981f5;
	Mon, 06 Jul 2026 23:07:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=aP0QmH1SwB1RvtxlnUtNfm9zNL1UKxAAvLV3C3MIWjo=;
	b=XBbQ9n7KjBwmGfZaNIScTTK/VfamDDSfyx06SuFdskAS/zm4HOyR6r6AMeZWBbMEguZ0DYv4e5f6l
	 tBzTwMZtnrK9EEBBsy6HKvLVT7nwsHauCsu0vbF5iYOBwLnN69/aym2fzNGJPE0HHPby2/rOfRRCs3
	 f6mbJsigOvNg1y7y5pyegRwmmzc5s734Piji6fheTdQamgmfSmrfDplRrYqSIuN4wUfC7J2K3Pvf9A
	 tS75zgf1zbPmjlUz3iF5XVK5HG0FH9bFBv+XVTjymnAf/uKJCAWCHOrNn+S/n4FWkNUpWrsbS1dqps
	 DHJ76Xhf5iiE69JaFqRMiMB7lg4NgPg==
X-KPN-MID: 33|lfmqK8rnbfVQCyLCi1J2RsUt7x9AnEAfVXlmSoaymz0XPFS4FF04Y+rPoIm6dFE
 PXHDcfcEfNsoZvGYYxn6I1PGSQyXKFp7IezBdN0/NsAQ=
X-CMASSUN: 33|SLdroU+O6ZHMQ3n7o0hKuA/o2iHiRiI1vvju0xYMWM199uSl6wDnPfpLhjPQGDp
 582kPaSnBcNnmsMX9tIUzsA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id ac20d07f-797e-11f1-8edb-00505699eff2;
	Mon, 06 Jul 2026 23:07:18 +0200 (CEST)
Date: Mon, 6 Jul 2026 23:07:18 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <62519570.129360.1783372038576@kpc.webmail.kpnmail.nl>
In-Reply-To: <178331747789.27465.4739600418387513587@noble.neil.brown.name>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-14-jkoolstra@xs4all.nl>
 <178331747789.27465.4739600418387513587@noble.neil.brown.name>
Subject: Re: [PATCH v3 13/14] selftest: fix headers in fclog.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 06-07-2026 07:57 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> On Sun, 05 Jul 2026, Jori Koolstra wrote:
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> 
> Maybe say a bit more about what needs fixing?
> 

I should really be a bit more explanative, it's a skill I am working on :)

> I guess the ones you removed are already included in 
>   kselftest_harness.h
> 
> and fcntl.h is needed for O_RDONLY etc.  Is that all?
> Lots of .c files in tools/testing/selftests include fcntl.h.
> I wonder if it should go in kselftest_harness.h too?
> 

Yes. Really it does not belong in this series, so maybe I should drop it
but the filesystems selftests don't compile for me without adding fcntl.h,
and clangd was warning me those other headers were not needed.

Let me take a look at kselftest_harness.h; I like your suggestion and then we
can simply drop this noise from this patchset.

> NeilBrown
> 
> > ---
> >  tools/testing/selftests/filesystems/fclog.c | 4 +---
> >  1 file changed, 1 insertion`h+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/filesystems/fclog.c b/tools/testing/selftests/filesystems/fclog.c
> > index 551c4a0f395a..593a5136e991 100644
> > --- a/tools/testing/selftests/filesystems/fclog.c
> > +++ b/tools/testing/selftests/filesystems/fclog.c
> > @@ -6,10 +6,8 @@
> >  
> >  #include <assert.h>
> >  #include <errno.h>
> > +#include <fcntl.h>
> >  #include <sched.h>
> > -#include <stdio.h>
> > -#include <stdlib.h>
> > -#include <string.h>
> >  #include <unistd.h>
> >  #include <sys/mount.h>
> >  
> > -- 
> > 2.55.0
> > 
> >
