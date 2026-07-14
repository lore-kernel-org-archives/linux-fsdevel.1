Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23841F0995
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025976; cv=none; b=Seu9tHo7vnKpl2R4yG3jwnIpP5cvTlhqdQCd4fH/xkLunfJH32vhH8ZrW9Qt4uGr6EUrkN9Muux80L9rFMg+o051LVz13wMiWAWoctLy3GiIsKtCPRXtm1g7bP32L/yiXPGEf2LkH7AObxgWqqnB0rTtJPxv8EMnJOXTvumBoMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025976; c=relaxed/simple;
	bh=Iba3TZBtJ5YR2ArV4lKS8xSPdu4za2kzNj+WhXaY3dA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MVmwpL3yxBUR42WIkeiF+B6AkVy+IdJUCWoWcz3Sm3hMEsRy473FwZnf5n/xSXG5anNVlAwspoJxvyN2Bji2QtWPnSVqDhlvgrrN3YRIb2zKbPYF3+rTjpH1IXFK6zgOC4mj7BLAfoOalam21Lap2kganOKe4WN0o2lRkup7SVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=HkWBEJ56; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="HkWBEJ56"
X-KPN-MessageId: 3a06df9b-7f71-11f1-bfba-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3a06df9b-7f71-11f1-bfba-00505699b430;
	Tue, 14 Jul 2026 12:46:10 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 3a0568ed-7f71-11f1-b308-0050569977a2;
	Tue, 14 Jul 2026 12:46:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=T39TFuAHKo2MI6sZ9OZj9dn7isxLnLvyZqxa1LG4Xfo=;
	b=HkWBEJ56rqkCzMnP75WLOuICeh8lJQ6+zCVDox2JG2brtCWvguK4fZ6NSKsj0lAU1vx7UAp9XJGrA
	 ssv/zf+XD1D9p0S2FyXyyIH3Bgg+VyDi6iQUXuDnDQ8EgVQOLbU3RG49AnnnUCi8hTTsSLqneJjL8L
	 ya6tefdVfwpnvc99Q4uHBlv7A2+xOGUACic2g09HgXavTr8tPbws9i0dZPFJ8XnYGTaMJ9gCVVg3Hl
	 roHNh+z5yqfTGvfCZrbCIbM/U9rdUjguu2cGp9lUdrYl1ehRWy9i5exFW2jzkFht7ypIK95uVNQPl2
	 yel0u/4caDHXeStMUz3CMtpkX+LlMBg==
X-KPN-MID: 33|La5TAm1Rn85DvCANldJXD9i1pWfrEZUvCFI7Q5YwM3Aqg4hn/VoW2fgwkpG/iAQ
 tuMySEDznFBQpbiV0yDTp/9l+8OSDpBmbZXccPwgV9Yo=
X-CMASSUN: 33|ftwHEuGD3/zH88vPo2q+tcrh0qNTm+FagXo+bYDKNO5gi40z02z+Nwjm4707aGg
 mt4mkqgZZp/0lw4XUAt2AUA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 39f648f9-7f71-11f1-8edb-00505699eff2;
	Tue, 14 Jul 2026 12:46:10 +0200 (CEST)
Date: Tue, 14 Jul 2026 12:46:10 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <607788097.964718.1784025970563@kpc.webmail.kpnmail.nl>
In-Reply-To: <alS10NN_OduZEqvt@infradead.org>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <20260707-vorteil-unhaltbar-apotheke-47bb105161ff@brauner>
 <alS10NN_OduZEqvt@infradead.org>
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
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


> Op 13-07-2026 11:54 CEST schreef Christoph Hellwig <hch@infradead.org>:
> 
>  
> On Tue, Jul 07, 2026 at 12:04:18PM +0200, Christian Brauner wrote:
> > I don't think any of this is really an argument worth considering.
> 
> It very much is.
> 
> > This is a lot of handwaving for the sake of portability and concerns
> > about past API mistakes. To both: so what. If an API is useful it's
> > useful, POSIX be damned. We're not going to be fenced in by some
> > standard.
> > 
> > 90% of our interfaces blow way past POSIX already - in most subsystems.
> > If we'd back down ever time someone shows up with "what about POSIX"
> > Linux would be irrelevant.
> 
> You can totaally ignore posix.  We need an interface that is self
> discoverable on Linux.  Any combination of flags that was accepted
> by previous kernels and gave different results than the new interface
> do not qualify for that.
> 
> > It's been years since O_DIRECTORY | O_CREAT has been made consistent
> > which means all LTS kernels have consistent behavior. We often make flag
> > combinations work that didn't work or where inconsisent before. Nothing
> > here is special at all.
> 
> No, we can't rely on something being backport to old enterprise/cloud
> kernel.  Doing so makes the interface unusable for actual applications.
> 

As far as I see it there are two types of UAPI change, one is almost never OK,
and one can be used sometimes. And O_CREAT|O_DIRECTORY falls into the second
category.

1. We have some UAPI that is used by user space and we wish to change its semantics.

2. We have some UAPI that is not used by user space and we wish to change its semantics.

In case 1 we force user space to update every use of the old UAPI if they
wish to be able to run their applications on a new kernel. This is unforgiving
and gave rise to the maxim "never change user space."

In the second case we don't require user space to do anything. The new feature
is opt-in, not opt-out. If the user space application wishes to use the new
feature they must either keep the fallback or update the minimally supported
kernel version. This is mostly fine.

We can detect which of the various behaviors of O_CREAT|O_DIRECTORY is active on
the running kernel, albeit somewhat an ugly test. And Pedro proved we are in
the second category UAPI change here, so we should just go ahead.

I am not opposed to using openat2(2) to have nicer feature detection, but it
should not halt this series imho.

Best,
Jori.
