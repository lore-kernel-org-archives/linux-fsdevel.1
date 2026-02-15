Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F5739FCE
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Feb 2026 00:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771116790; cv=none; b=LTAaVTPKeOT83E+3/BrQp/dT+gWLqlHqydYZZjbu8NTty9Cozy+t8sOEvtR+Q4ytcQV+my52xkQma9CHhXaX0+eGCjqiap/1TPuvGYRg1PUa6gGH/E8oXNSAXmOP3OQlq9Knz3b+qit1YOLrNjXFHBUp+DdQIBSMAK5KYth/Gbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771116790; c=relaxed/simple;
	bh=+Q2wruobrtQs0dBOlMv/ofXrI0fLWp+HB3BMwCe54qU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FlTtdHzMM+6iMZrAWOg+W9jhNs5V1WLYycLWQUZ0h1gD97J+vAcHKpGJ6rUwd5vKZCXG/cHaTOGe/3OiNxbo6PUu7/XsVHfnSDfXDMyz4vYEJ5e/MOvtGAZQS0BiD+tbxUrVfummHa8vqLp3Fo+VfvGk1XPd0i1ZjrfJJGbUlIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=EhSj5SFw; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="EhSj5SFw"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61F0qpDP1888656
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 14 Feb 2026 16:52:51 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61F0qpDP1888656
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1771116772;
	bh=7ZIC11ePuITUmzv3EeStGa7YGlEBXuZ80S5nn3qhteY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=EhSj5SFwKqzLBa081G0qEAO2hBPTy0qiKp9rulE+Nh3NRyQZb6tec+IYXgJJc8Dfa
	 3aV6YOuobP2TkyfkHufKX2Lc6egjDKLRWdz7MYSCQyyXtZxtkImGl4xP4HoHAqj8V4
	 pzDGngiO1rrYMohwdTWUN82sXvbYnD4Bm+YdHPgyet6Y2OQDuOWpajgWq6HfJe2PYV
	 gd/90xqARKAPoweaIpnoOYJCg0yELxZSZB67uao5WfD0oB3g55v1JYwBGieeAo4QGr
	 P7g2hbKMJ3xpXcpUKSLY85eN/QubouJ9mllLb3kfaXP/lVwVJ6OJZ/LayJ0+eQWx9z
	 EbTmeGwQQVyTg==
Date: Sat, 14 Feb 2026 16:52:45 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Askar Safin <safinaskar@gmail.com>
CC: christian@brauner.io, cyphar@cyphar.com, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
User-Agent: K-9 Mail for Android
In-Reply-To: <20260214153143.1312707-1-safinaskar@gmail.com>
References: <f5050b26-e5bd-41b9-8b3e-1b87888095a8@zytor.com> <20260214153143.1312707-1-safinaskar@gmail.com>
Message-ID: <345BCE65-4748-47A2-A8D6-EADE473B3FC1@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 14, 2026 7:31:43 AM PST, Askar Safin <safinaskar@gmail=2Ecom> w=
rote:
>"H=2E Peter Anvin" <hpa@zytor=2Ecom>:
>> Either way, the documented way to use pivot_root(8) is not to rely on i=
t to
>> change the actual process root at all [the same caveats are supposed to=
 apply
>> to pivot_root(2), but was not written down in that man page:
>
>Unfortunately, pivot_root(2) (as opposed to pivot_root(8)) contains
>effectively contrary thing:
>
>> For many years, this manual page carried the following text:
>>
>>     pivot_root() may or may not change the current root and the current
>>     working directory of any processes or threads which use the old roo=
t
>>     directory=2E The caller of pivot_root() must ensure that processes =
with
>>     root or current working directory at the old root operate correctly
>>     in either case=2E An easy way to ensure this is to change their roo=
t
>>     and current working directory to new_root before invoking pivot_roo=
t()=2E
>>
>> This text, written before the system call implementation was even
>> finalized in the kernel, was probably intended to warn users at that ti=
me
>> that the implementation might change before final release=2E However, t=
he
>> behavior stated in DESCRIPTION has remained consistent since this syste=
m
>> call was first implemented and will not change now=2E
>
>( https://manpages=2Edebian=2Eorg/unstable/manpages-dev/pivot_root=2E2=2E=
en=2Ehtml )=2E
>
>So effectively this pivot_root(2) note cancels pivot_root(8) note=2E
>
>Note: I link here to manpages=2Edebian=2Eorg as opposed to man7=2Eorg, be=
cause
>manpages=2Edebian=2Eorg usually contains newer versions of mans=2E
>

Sigh=2E

The difference between "descriptive" documentation and "prescriptive" docu=
mentation =E2=80=94 what constraints actually apply to the interface contra=
ct=2E
