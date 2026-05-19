Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89433B3891
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177211; cv=none; b=kRuHeGq/4SmI8+Dxj0Jw0fx0oTYHlrCDXcnTdLTjjBfVIxZimFLhTWGTHMqq8uVczj+1pVKtmbFDCwaU3+zTq0BrYeLqKXATVXA3o/2qL9Y3ms3yz5ltNSCASzhfXpqZpAZkrhvzzqDoTB/v2eHy7L+0+tcXVxAhJmxL7RSjyxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177211; c=relaxed/simple;
	bh=8i4LFYfSf6hdLzUAHOP9OlYZryfxcGXwACWUJi0VIH0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fmQ3vmzwOsRNypSNziLz9SoQV3YJC8TeapUONxob+cuJ7QsMh4mngQ8gZOCgSoog8v0nVYhwX5xoX17IvM5ON4YLlchIrmIK9eaENUv9sEs8ecNbUWuZsRfmcw3v+aSrz4Rgfnuq4stcEhFxAa+wTxKznBjhuaHSvrgdV5zMcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b=G4xkTv8p; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b="G4xkTv8p"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3664df32e91so3350245a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 00:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1779177209; x=1779782009; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sgzdZP5m+Wyrelk2WxGJY8i5HNRNOV63MQyX9prQSw=;
        b=G4xkTv8pTxAyklB+SHs8DdWbJ23eQ9S4i58YYyxcFgQvub4nZKcLl+Cjfm0UVMOGLR
         5TEN8dOGXlzmnTVL55h7A4umKbHaQLvP4AdhnWCyVWQUStQx2SoBTYUjDCSpGknterHm
         iXX5G8whdy6/4HcrRWmpaj2Aio9mW4T8f1sGFYau0jcj3t/L4f87HZHZGrtK0VC4vtjq
         r83Qh0f2MuZ0pAln4RhCD9V+kgiaTbTSzew+3M3r0wbYbg/RQX3gi50nJCvFshmkyZp/
         kCK6g0TwtzgGumKiUdY1EMElSdl4ZLiv33Y+cNhr619DyuV5ubE9QdkPSHCT8mKE2zwx
         UTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177209; x=1779782009;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sgzdZP5m+Wyrelk2WxGJY8i5HNRNOV63MQyX9prQSw=;
        b=Obun1uJPK1juUd/Pgo1NZzMUb92Oh25kjgOA8e3Gy88B5I3VR+QaM3tbTriK62bT4n
         B9TKTTcQk4GFdAH9Gc9LkOrKL0DYZbYTMs9bouWNdrH+KNpT499gZge2LYg/Q9pHjlwx
         /53T/EVfRzxbtlH9xJ7dl6Dy9UMOpJrlS/+gNRgfeTTLa4p8/GoRzgAAHPeKv9DwBOW0
         PP8dIdocU8HTUavuqlQMJ/o/gr16t2fKjLAdKba9zbumzgEEow5I1iuq/L9uj9iNyA6Q
         pHJn2ibcji/o2OHRxItIh4jS8wQP3q6WU5aCumoyr9PrR/5bn9ScRnTM57nMrgPwjsyp
         cyTA==
X-Forwarded-Encrypted: i=1; AFNElJ8VMk4VwHu/lrA8NBZ1mcTDUUW+/mJncH4Zc8IDczqyWx6u7SpgkfQYo8eHoY1gBwqiJAZFcGW2yT0VPOJj@vger.kernel.org
X-Gm-Message-State: AOJu0YweiMwTh/S0JZC8YtZZ8Wh9DtqKEREstCQ9RPPk/aNI/4dZ7dYq
	1alq87loyDRULm245jQOZTQXigK2Xe8zxpNcJEjrRzhC2bT6FWDhU7RMm26IPjHLA1JlA6xWC/E
	uLNfOQlk=
X-Gm-Gg: Acq92OHaH3lFomkigUefQZTJcmjIagCbh9ZYeRXtEHHDAiTseHyFvu7li3KqUSph+tW
	eUWIcdcuXBRjae/q532XNcfNBllV+dTZ7LF75cE9RkzrXBtj+sEWnqpBbV4LiOaCWxU331RvRd7
	TeM2v5OflLjrv3UjNuVHSV+TRWDfQqSR20TY1WRldAaRlcWdmm7eFn5164VtsGNCdVRxxZ1yCLZ
	KnfjOjcMBG6XnmlotXdeXhNXDtYlR3IMlPbcrcjkMnZvmDsAK9PYaPflvryf59cqrmqOUy8CXAA
	nXmLbcM+zNalGSUMLQPrxK+xBgZP/m8xoTVyk4CpXHx+TYGgE66QE20MMcxKtIZMDZy2RjMbRbW
	lJqK+zA65W8M4UsvZ1oYrsPTjXQNGsaL5dTbDHSyxrjD0oGl2rsETrWxPke2Gq6VAlr391A/UdK
	k4bzKbrcBGm7kwn+zloVrzo7iUcmH8dqTJaLFi2Ej2t6pq3dw6FfV6fizg/C+1Z/gPI8N88lWgn
	jc6
X-Received: by 2002:a17:90a:d40d:b0:366:4b0f:d3da with SMTP id 98e67ed59e1d1-36951ca4ee1mr19106356a91.26.1779177209016;
        Tue, 19 May 2026 00:53:29 -0700 (PDT)
Received: from smtpclient.apple (S0106a0ff70715ac6.ek.shawcable.net. [174.0.84.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369f59656a9sm1210242a91.2.2026.05.19.00.53.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 00:53:28 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [RFC] fs/ioctl.c: FIBMAP requires CAP_SYS_RAWIO while FIEMAP
 exposes identical data unprivileged
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260519033126.GD9531@frogsfrogsfrogs>
Date: Tue, 19 May 2026 01:53:16 -0600
Cc: Andy Lutomirski <luto@amacapital.net>,
 Christoph Hellwig <hch@infradead.org>,
 Cyber_black <Cyberblackk@proton.me>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Mark Fasheh <mark@fasheh.com>,
 Theodore Ts'o <tytso@mit.edu>,
 linux-api@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <53D75B79-7332-4B45-8995-114079CD659B@dilger.ca>
References: <_fcorj7Aa0YnzUmrPnqdEbTjLqS6S7t84HKrzsswvKm71LC0uVmTD2cthCwpgeI-296unEpzPZYBNdFFDXjsQvZRtGfTaQlKmcRkiSI4wiQ=@proton.me>
 <agqevS--YYBVW2Oz@infradead.org> <20260518162048.GC9531@frogsfrogsfrogs>
 <CALCETrUFMFNnJ6FLd9SkzS5E1q3x+cqGvOvo5PzU2V_+moSEJw@mail.gmail.com>
 <20260519033126.GD9531@frogsfrogsfrogs>
To: "Darrick J. Wong" <djwong@kernel.org>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

On May 18, 2026, at 21:31, Darrick J. Wong <djwong@kernel.org> wrote:
>=20
> On Mon, May 18, 2026 at 09:22:42AM -0700, Andy Lutomirski wrote:
>> On Mon, May 18, 2026 at 9:21=E2=80=AFAM Darrick J. Wong =
<djwong@kernel.org> wrote:
>>>=20
>>> On Sun, May 17, 2026 at 10:08:13PM -0700, Christoph Hellwig wrote:
>>>> On Fri, May 15, 2026 at 05:36:45PM +0000, Cyber_black wrote:
>>>>> Option B) Add a capability check to ioctl_fiemap() to match =
FIBMAP.
>>>>> This restores the intended restriction, at the cost of breaking
>>>>> unprivileged use of FIEMAP (e.g. filefrag, btrfs tools, =
e2freefrag).
>>>>> This option is a larger ABI impact and likely undesirable.
>>>>>=20
>>>>> The preferred fix is Option A, since FIEMAP has been available
>>>>> unprivileged since 2008 with no reported security issues, and read
>>>>> access to physical block layout is already implicitly available
>>>>> through open() permission on the file.
>>>>=20
>>>> No, FIEMAP really should not be available unprivileged.  So I think =
B is
>>>> the right thing.  Can you send a proper patch with a proper =
signoff?
>>>=20
>>> For anyone who might be relying on FIEMAP output to find sparse =
regions
>>> -- don't.  FIEMAP is a lowlevel fs debugging interface; it won't =
tell
>>> you about dirty pagecache backed by unwritten disk space.  cp was =
burned
>>> by that a decade and a half ago.
>>>=20
>>=20
>> The only way that I'm personally aware of to determine whether ranges
>> in two files are reflinked to each other (and the only efficient way
>> to find identical blocks to, say, archive a large directory without
>> reading all the contents) is FIEMAP.  I wrote some code to do this
>> awhile back (not in production use).  Yes, I realize that it might
>> have issues with dirty page cache.
>>=20
>> Is there some other way to do this?  Could an API be added that
>> efficiently answers the actual question without revealing information
>> that shouldn't be revealed?
>=20
> Well, yes, we *could* make yet another ioctl, but we could also just =
run
> fe_physical through a one-way u64 hash function and set
> FIEMAP_EXTENT_UNKNOWN if (say) you don't have CAP_SYS_RAWIO or
> something.  Then your comparison function might still work... maybe?
>=20
> OTOH nobody really wants Linus roaring at them, so we might all just =
do
> absolutely nothing.
>=20
> Also note that FIEMAP still doesn't report devices, so you're still
> playing with fire on multi-device reflink-aware filesystems like XFS.

I've long had a patch to add device printing to FIEMAP/filefrag, but =
IIRC
the last time I tried to submit it upstream it was rejected.  Maybe =
times
have changed and there is a chance to get it included.

Cheers, Andreas





