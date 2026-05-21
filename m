Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F13DCDA0;
	Thu, 21 May 2026 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373878; cv=none; b=T1Mg3XFdrJftuc/3Wr320PD1bFmXzXNFXy+U77MTJU2mBfkw9PNFBdZi4hyf0qFZa2ad63/ThkHiSace/qSqms+bR8Ec0ONpMSL95z6mMHxum5ReLcZkJTuGRdCUY0GgNJMzgdASLCEtctuQ55WyeGWe2JX426S7oQHsJFP0uEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373878; c=relaxed/simple;
	bh=p9giPgy6O+8btEZPCI7DWpv6PbVzKviFMKO2tD875N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqqDcPMs8kzIDpJE5gCbn1PBxYmrUoQ2qkLTeH6aQeohIwLnDLU6l3LyqilrKCfMDDnoHFBx6x4nLOPXcGpzApRfauzg14uqBCh6EK0FlPq8V8Zi3X3YpAnSfnnrdEV/ClWOTQF6H2NUvnshEbcjSQrOdqGyooTgWbOoVlps/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G69L5B6o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G69L5B6o"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 043561F000E9;
	Thu, 21 May 2026 14:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779373877;
	bh=7t6++dlPHd+cGdK1Lr56IEyglhmqc9bjZcvHuYJNxIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G69L5B6oy/fz1opoG36rUQmzmzbHIKa04nNoQgnjSZPDhVZ58wRdbGaReR2dnIcH4
	 d2jXRvv8GxxH34Ovpg+4usD+HHR34eVIgp1Sdxp/ZyOhGyCsoYC3L8m/GVEqUm9j5S
	 BWkAR1JhtbumzjkWJybgRIyV5Opgepmo6ipn1+9j3D4MjOep19do9O3Rg+VRj5v2wM
	 49kdx4Dm/HPLlXfQxkL3zAbZ+MIGzV9T4XhUNUNn379xItqPurLlJatVtoyVhepw0X
	 bs7vxO9mCKkIBRFsyimIXB2kh2gDY/ImHgLD/OwkjHu+qLflo53tXRycuYG7aoJZo/
	 Ufb7OyV/BF+ug==
Date: Thu, 21 May 2026 07:31:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: joannelkoong@gmail.com, neal@gompa.dev, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 4/4] fuse_service: fix uninitialized variable
Message-ID: <20260521143116.GP9568@frogsfrogsfrogs>
References: <177933241435.3536631.9946604261928168710.stgit@frogsfrogsfrogs>
 <177933241518.3536631.717770834444587345.stgit@frogsfrogsfrogs>
 <9954c0ab-3d5e-4318-9b04-4d636520d6ce@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9954c0ab-3d5e-4318-9b04-4d636520d6ce@bsbernd.com>

On Thu, May 21, 2026 at 11:15:38AM +0200, Bernd Schubert wrote:
> 
> 
> On 5/21/26 05:07, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Initialize the sockaddr_un variable so that subsequent comparisons won't
> > fail in weird ways if getsockname doesn't fill out the object.
> > 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  lib/fuse_service.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > 
> > diff --git a/lib/fuse_service.c b/lib/fuse_service.c
> > index d14aced29e8268..4340304eaf57b9 100644
> > --- a/lib/fuse_service.c
> > +++ b/lib/fuse_service.c
> > @@ -388,7 +388,7 @@ static int check_sendbuf_size(int sockfd)
> >  static int find_socket_fd(int nr_fds)
> >  {
> >  	struct stat stbuf;
> > -	struct sockaddr_un urk;
> > +	struct sockaddr_un urk = { };
> >  	socklen_t urklen = sizeof(urk);
> >  	int ret;
> >  
> > 
> > 
> 
> Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
> 
> And hmm, we kind of have a test issue - they passed. Uninitialized
> memory is the only reason why there is still valgrind.

In theory it's unnecessary because accept() will initialize the relevant
fields, but it's easier to add the explicit initializer than to spelunk
every C library in existence to make sure it actually does.

I wonder, do we want -ftrivial-auto-var-init=zero ?

Downside: only gcc>=12 and clang>=16 support it, and it adds overhead.

--D

> Thanks,
> Bernd
