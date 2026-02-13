Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940618DB26
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771023682; cv=none; b=pbzMki4vn4vfrRnl7jKwt1BJ5s1y1NrLgsoAtm7m7FAq3SUs5Qhze6X8NE1JJyZc0WYeGgQXFNenCTGLaX3YFd0M/YVfFoBTxd2Ztx5rBLhJX0VECq9LRfZdXFVQNKgHmaUQ4SLQOqCtkEM9TN2j0pbzYMJRvmZIzTf4W6ePXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771023682; c=relaxed/simple;
	bh=5bLlB3I/+cw2OgWhuLuhD0BeMZUMLcAay97qvGp7YsU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=A9PEzVu7AvkgAxyQJ28aW8SttvWsJYYTh0XITh/9TN/232Ml/J88Vl7WeV77nh4n2ALMzxUUFM228oQB/wRN/VC4UCeJR82j7uIol6GlegDLIiau46pM7W7TMu6+utbZGw+Q87AS9HVUsZx9NeQCh7FlW6P8fHShqxCqwfRYnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=u0Ct9js/; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="u0Ct9js/"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61DN0wur1011814
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 13 Feb 2026 15:00:58 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61DN0wur1011814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1771023659;
	bh=C07ptLNhCfwsGY//X4UO8hWzzvT9F638A224bPZWtlE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=u0Ct9js/5yJr0c8hUxJVwWoWFaOw2sYLctjK3mqZvoP5tK7RevMxWy9GEFiXF0TJ4
	 YqcDEFmiBYZRUYfDTiIKoDdQ+POlOIYtnpMtTkUv0apThPz7SNV4dXSeuxFMKz1ubf
	 G0k3F7n1U+076LURGuZrWzekYmpJjMHUOwoZtGe0duBHp6At2udUYYA7iVb0rLw0il
	 HuW72rKeaTXawRJAnjgCWE7SSe+egzNU4vi0WbmntNQpJMATnV2wQpdysj/VtFeimV
	 eaJ0Op/5mU7uw+kBRXygrjVRFR0Y0cQa44IQIIouylgxLP9DU0toYYtWvWtu+8oWKe
	 3rtMceOJfrbiA==
Date: Fri, 13 Feb 2026 15:00:49 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: Askar Safin <safinaskar@gmail.com>, christian@brauner.io,
        cyphar@cyphar.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
User-Agent: K-9 Mail for Android
In-Reply-To: <20260213222521.GQ3183987@ZenIV>
References: <1FC2FB1F-BDA5-472D-A7DB-D146F6F75B16@zytor.com> <20260213174721.132662-1-safinaskar@gmail.com> <1caf6a70-e49b-42c7-81d0-bd0d6f5027bf@zytor.com> <20260213222521.GQ3183987@ZenIV>
Message-ID: <92837188-C667-4A2A-9D34-85E5F1A5D597@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 13, 2026 2:25:21 PM PST, Al Viro <viro@zeniv=2Elinux=2Eorg=2Euk=
> wrote:
>On Fri, Feb 13, 2026 at 12:27:46PM -0800, H=2E Peter Anvin wrote:
>> On 2026-02-13 09:47, Askar Safin wrote:
>> > "H=2E Peter Anvin" <hpa@zytor=2Ecom>:
>> >> It would be interesting to see how much would break if pivot_root() =
was restricted (with kernel threads parked in nullfs safely out of the way=
=2E)
>> >=20
>> > As well as I understand, kernel threads need to follow real root dire=
ctory,
>> > because they sometimes load firmware from /lib/firmware and call
>> > user mode helpers, such as modprobe=2E
>> >=20
>>=20
>> If they are parked in nullfs, which is always overmounted by the global=
 root,
>> that should Just Work[TM]=2E Path resolution based on that directory sh=
ould
>> follow the mount point unless I am mistaken (which is possible, the Lin=
ux vfs
>> has changed a lot since the last time I did a deep dive=2E)
>
>You are, and it had always been that way=2E  We do *not* follow mounts at
>the starting point=2E  /=2E=2E/lib would work, /lib won't=2E  I'd love to=
 deal with
>that wart, but that would break early boot on unknown number of boxen and
>breakage that early is really unpleasant to debug=2E

Well, it ought to be easy to make the kernel implicitly prefix /=2E=2E/ fo=
r kernel-upcall pathnames, which is more or less the same concept as, but s=
hould be a lot simpler than, looking up the init process root=2E

So if needing to do a side trip via /=2E=2E is the worst thing then I have=
 a hard time seeing a problem=2E

Incidentally, how is =2E treated?
