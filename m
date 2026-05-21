Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D929B3D6CC7;
	Thu, 21 May 2026 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373616; cv=none; b=MgHSAg4v5vOgP0EuovIFYu+CStkRSWFPdkONrR8FeCeScOUqHeK1TXjFWLp43+i1XM7wHc0pNfuGV8/gOXddBigocg5G0tC7C3TEylDfYsoYoJERjUjk+P0ugkNgafGj5A+h1dlJFc9/ZHdhXVdirHKeU73gJIwFF02qkFC4uCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373616; c=relaxed/simple;
	bh=cghiGfWVrPoNGx9OFKQea3uqktVt8HpL8r65firKsQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jriLijn3mnCzZYz+2pw4MRB0OHWy3v4PZ/0saq3Cvi43OCUPN1K+H/mJtvZfbXaMNaS5AgqbLE9kVxtAfS5enpy/inH4FV+pApz3uPkR/TAfEbh3LiizLArqT3HReSWV8S9Kn+Ua+PhhzWMwEcCGVq7W5fmOZ2n/h6oDJvc73dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kczus2uo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kczus2uo"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 606101F000E9;
	Thu, 21 May 2026 14:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779373615;
	bh=Yo5ih0hgMExWP66I0OJWBEKwICHMw3gCAm4u7ZLswSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kczus2uozUxTTS/o/DYwXPkDL4LgpZpV1nnYMO2GloVZuu4DceTmJfkbePQ3cO6b5
	 Bd/oCULLhFgsDX3Vmjyva8qJQpOzlOQ8Na9mDh8FHQhawlw5YQF3+8nToUctumwraZ
	 nr7VKAIidZMdHvMmEBVVkjuSkvuMJEzwW5zXJMVSsTMS1zmqaisKDb5V2kLAyRT9++
	 dxjrMzEBv7AMBo+GucJDknFZj80CVeF4PZyww9RxbsLBMqMJL99d9MyGdWEquTEN5B
	 4T/oRTiQcmO1Lqd9hzV/lRE8PQWiSjeGKiOfWowXUpHg++9tQ0TpxReg8x0tMBi1z2
	 S0dyZi4kPEZ2g==
Date: Thu, 21 May 2026 07:26:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: joannelkoong@gmail.com, neal@gompa.dev, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 3/4] mount_service: fix some pointer handling
Message-ID: <20260521142655.GO9568@frogsfrogsfrogs>
References: <177933241435.3536631.9946604261928168710.stgit@frogsfrogsfrogs>
 <177933241501.3536631.17487472051183408289.stgit@frogsfrogsfrogs>
 <fb545c0d-a8e1-4dc1-8d06-1c8ec4ec47fc@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb545c0d-a8e1-4dc1-8d06-1c8ec4ec47fc@bsbernd.com>

On Thu, May 21, 2026 at 11:02:22AM +0200, Bernd Schubert wrote:
> 
> 
> On 5/21/26 05:07, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Don't leak memory or try to free static data.  Pointed out by
> > clang-check.
> > 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  util/mount_service.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > 
> > diff --git a/util/mount_service.c b/util/mount_service.c
> > index 8b0eecf5b00ab2..a86a53c6fff40e 100644
> > --- a/util/mount_service.c
> > +++ b/util/mount_service.c
> > @@ -974,6 +974,7 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
> >  				fprintf(stderr,
> >  	"%s: option %s only allowed if 'user_allow_other' is set in %s\n",
> >  					mo->msgtag, tok, FUSE_CONF);
> > +				free(mntopts);
> >  				return mount_service_send_reply(mo, EPERM);
> >  			}
> >  
> > @@ -1036,7 +1037,8 @@ static int mount_service_handle_mtabopts_cmd(struct mount_service *mo,
> >  	/* strtok_r mutates tokstr aka oc->value */
> >  	while ((tok = strtok_r(tokstr, ",", &savetok)) != NULL) {
> >  		if (!strcmp(tok, "-n")) {
> > -			free(mo->mtabopts);
> > +			if (mo->mtabopts != &IGNORE_MTAB)
> > +				free(mo->mtabopts);
> >  			mo->mtabopts = &IGNORE_MTAB;
> >  		}
> > 
> Hmm, IGNORE_MTAB as type char is super confusing with the other define
> in mount_util.c and fusermout.c - could you rename that to something
> else? Maybe just change the case to "static char ignore mtab"?

Oh yikes I totally missed that.  Will fix.

--D

> Thanks,
> Bernd
