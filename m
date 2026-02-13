Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D27C1F9ECB
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771008189; cv=none; b=Hyxbkh0X/o6vuifEeOTDvYfDdzJtnQlOQWsXxHMQpXSYDJl071z7L/SZYjxFxtWXvrMVdXIqXd2v60z/RAOtm/dep4PvzflmoDAMAjRgNWD2tmXbGKR9N9bCfYXk5DPXwgl/9TSr6psi/AFkziewxd3bLfIlTDlD1EnX/Eggrpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771008189; c=relaxed/simple;
	bh=Y/lWCy/aCQm/3EpU5nT8AvIowm3sJ9GnsLImBq6gKhU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=efGcgD2flStbUHbZLEI8oYY7l0YA9FTbQtdhyI1Z8694rD7x6Kr1vQ/TUQ7FBNcH5jSA2D3I26EC+mwlJ9khFqIUzm4nPK9B7xvFThfreLnCyrXRer8fehHrWNlv0OYjLiDc3fjPFc00aAf6t/HjA8wtKy0tW2eLYM8x+OBPIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=vw0poPrp; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vw0poPrp"
Received: from ehlo.thunderbird.net ([172.59.161.192])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61DIgWOt917300
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 13 Feb 2026 10:42:37 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61DIgWOt917300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1771008158;
	bh=CGo43RtHMq2IDqhbVQj8KLcUha/7N3xDHb8tWNT830U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=vw0poPrpfNsw7arwPE5NjhGuae0u216ni/Rz/c1/nv0r103luImpKdGctpclURoKq
	 gzEDMJbL1tPQnocATZAdoiz3QUdXAq15MVzBVC/bjOvhtIJT/cl+kUggL5FAO/sJLX
	 TKk1ywDZbJ4AmrJDMDL21mrsObIJjf5xBfLS1uFJVjKdjLGLVX8aKDREDJOg/9bzp9
	 VTEZ7fmmmClzS+AEsEt0y91L8NLJYN00thkq4f4kajtpvvBv8Srp12hGoAUYrGKm+O
	 xLruF56xQ/+XagAhc005tA9eP4de0/YI5pY3SCFdAV+yWGmhBWhS7Xf0LEwSWhLB67
	 akfzwfulRzYhw==
Date: Fri, 13 Feb 2026 10:42:26 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Askar Safin <safinaskar@gmail.com>, torvalds@linux-foundation.org
CC: christian@brauner.io, cyphar@cyphar.com, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, safinaskar@gmail.com,
        viro@zeniv.linux.org.uk, werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
User-Agent: K-9 Mail for Android
In-Reply-To: <20260213182732.196792-1-safinaskar@gmail.com>
References: <CAHk-=wgQDOUff_F28xaTB-BvSHs9YC3bxXJa0HjpSTAUyPF-Ew@mail.gmail.com> <20260213182732.196792-1-safinaskar@gmail.com>
Message-ID: <FB150663-6D01-4249-9880-118DC7309521@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 13, 2026 10:27:32 AM PST, Askar Safin <safinaskar@gmail=2Ecom> =
wrote:
>Linus Torvalds <torvalds@linux-foundation=2Eorg>:
>> +	/* Special case: 'init' changes everything */
>> +	if (current =3D=3D  &init_task) {
>
>pivot_root is not used by real inits now=2E
>
>pivot_root was actively used by inits in classic initrd epoch, but
>initrd is not used anymore=2E
>
>pivot_root cannot be used by inits to switch from initramfs (in 6=2E19) b=
ecause one
>cannot unmount or move root of namespace (so everybody moves new root on
>top of old using "mount --move")=2E
>
>Very recently (in 7=2E0) pivot_root became viable to switch from initramf=
s, because
>of Brauner's nullfs patches=2E But distros didn't start to use this yet=
=2E
>
>So, inits now don't use pivot_root=2E
>
>So there is no need to special case it=2E
>

The question isn't if most use it, but what's fraction, if any, is legacy=
=2E

Not sure how to find out, other than maybe introduce a pivot_root2() or eq=
uivalent library call if it is now possible to do without the system call a=
nd deprecating the old one, alternatively making the legacy behavior a conf=
iguration opt-in, possibly a "once only"=2E
