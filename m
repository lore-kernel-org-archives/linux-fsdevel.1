Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE0C3FE645
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594293; cv=none; b=Ct4kN97Cz02BlifcuvKu+TOF+j4lIpwavnGzyVGOkjQfkzW/SrQ4AirXGhRNJBmV514GOoHE4gl8aLF7SbjMRpaxCSORqHcvoAtr2AxDce3Y+aF+Sq3jURb4nl5tFmgrl+RBzvUjq84JtpD8CcDtk5WpuedGM5kKyE4ctC+UTP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594293; c=relaxed/simple;
	bh=uqlQvdScwoBzmQn/c1/mBv93mD6k+faE9VIzXA560cY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WvX8XcbbIRmm7XD1/MIM8Q5L9e/zE5tcNf0Yo1ieOYfQ75dPnyKXoG0ZhKQ3yko36U4T1oNHUg3vBRHwYRxI8z6t+FRWWTGmVR89URxaHkEhv45+0DgYN1ko58dLAyg1dgVxNgVHIwYTVGIdIINmxjriNOpBgaGkdVT63yURwbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Edvv1bvH; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Edvv1bvH"
X-KPN-MessageId: 1ea80930-7b84-11f1-a59f-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1ea80930-7b84-11f1-a59f-005056994fde;
	Thu, 09 Jul 2026 12:51:20 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 1ea6a99d-7b84-11f1-9b0b-00505699693e;
	Thu, 09 Jul 2026 12:51:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=RuYVCmMFg7qFW+g2fseoQxNzTNWrwE/jj6cCLH2QD5A=;
	b=Edvv1bvHjmHDFMeLLtkvb+cljVmZz/E1eseA3FjFNbJEb404uT7mgaNAU2A4dg1q7o/0rF2TWoEVD
	 215I6jeSRE4C+S9uZ7lRPbspcdiu2S2i2Liyu4qLAJHUu60TVuyy7a2HQGHlByEwesxvOZNgSTsLmZ
	 8S67t5QzXM3cjEw8zForKuTalqMnY9C+jaOl86TP7Aj+3OW4H+QfbQIcVt8gtB/WXTLiTUQDSyVK1Z
	 /8conm15Nv4uQ4yEOpct12JDZRzmITrr5ByAkYHnJmDe6LOmoXgeWgq45wcsd6we8iuub7gLajB4qB
	 SctRwlLhhwWeOS7gxbcFetpzMn5aRzw==
X-KPN-MID: 33|gFrHFyOwlJQf3T7uXOBth9m4dhyFIPNJmg0VU7iONI2bVluPd8ZwGBXpPQ/oxrN
 piUxfCoYE93Wo+5dQI6Utja0UIn+/Lgj4D6GLHcsSYpM=
X-CMASSUN: 33|5n7+E2ITMTAL8v6yLVFgqJK7w9maM+4Nu1c/ycbfDdcC3CxmpaViYUad9QarTpy
 Q6z2xk41cMKy4iZUmVAncBQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh08 (cpxoxapps-mh08.personalcloud.so.kpn.org [10.128.135.214])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 1e9b1b4d-7b84-11f1-916a-005056995d6c;
	Thu, 09 Jul 2026 12:51:20 +0200 (CEST)
Date: Thu, 9 Jul 2026 12:51:20 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christoph Hellwig <hch@infradead.org>, Pedro Falcato <pfalcato@suse.de>
Cc: Aleksa Sarai <aleksa@amutable.com>, Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <111142800.451666.1783594280454@kpc.webmail.kpnmail.nl>
In-Reply-To: <ak8-lSfOy0oL78N9@infradead.org>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <1464441345.181098.1783418805206@kpc.webmail.kpnmail.nl>
 <akz_Ik8_eTnXav1H@pedro-suse>
 <1400609680.217714.1783433931054@kpc.webmail.kpnmail.nl>
 <ak5rHOsvtMX1j7S3@pedro-suse> <ak8-lSfOy0oL78N9@infradead.org>
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


> Op 09-07-2026 08:24 CEST schreef Christoph Hellwig <hch@infradead.org>:
> 
>  
> On Wed, Jul 08, 2026 at 04:39:54PM +0100, Pedro Falcato wrote:
> > Because it's a black box:
> > - Maybe this feature lands in 7.3 or 7.4 and enterprise kernels (and Android)
> >   backport it to older releases on request (as a random example, XFS atomic
> >   writes were added in 6.16, but were backported to 6.12 in SLES, and UEK 8,
> >   and possibly RHEL/Ubuntu too)
> > - Maybe the feature is posteriously reverted, disabled, changed
> > - Upstream LTS also does its backports, so the O_CREAT | O_DIRECTORY EINVAL
> >   only landed in 6.4, but was backported to 6.1, but not to 6.2 or 6.3, and
> >   not to 5.15 or 5.10, and the behavior will again change as soon as this
> >   lands
> > - Sometimes the kernel perfectly supports a feature but you're running under
> >   a tight seccomp filter that rejects unknown syscalls (or ones that it can't
> >   filter, like SYS_clone3), so you get a mysterious -ENOSYS that uname() will
> >   not be able to explain.
> > - You can technically even be running under the uname26 personality and now
> >   your uname() is completely nonsensical
> 
> Exactly.  NEw features need  to be discoverable, and O_ flags that
> get ignored by old kernel are not.

Maybe just backport -EINVAL to every kernel since introducing openat2(2) then
that can be used as a test.

But that is an issue if openat2 is blocked. I don't know enough about blocking
syscalls to know if that is a big issue or not or whether it can be worked around.
But something like this seems reasonable.
