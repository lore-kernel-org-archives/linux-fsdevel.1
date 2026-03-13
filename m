Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C6A35F5E6
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417090; cv=none; b=M6Gd97kJbYmJiRu9eRr0J9l+FXRRMh27W7xQEaPvH2H1Hhgz3AuFCwIUJvdNW0o48F+UyHH9yW+/FkeDiyKjFhjVzz3dAy7Lh2LI9qpp202V9kqSFs3ouEQsxDXdcckfBzIAFiwfnPks/WIxC1+EoCZzlM65GhknubhYEOrvsFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417090; c=relaxed/simple;
	bh=sIMg3XQR8uw1uh+SEDyvp3GjZOl4pi5tFZ8Bu1+rQ+I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Gi+m+GYWcy+dPiHOP4x6cJOPALVXSdmcswMNR9yGKlF4zeH0+LcGy6x2iME16cHYSFTY+Xi5fBUQQOVhvcb2gpTKc14rIZFNKbJthWIwkwN9ZE+e2lydtG2oXPmxf8mnQdh7Jf3FKz4KjGcyCPm//uRar/zqEkL9UaUk+rtkU9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asCCqjjv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asCCqjjv"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso20475875e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773417086; x=1774021886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIMg3XQR8uw1uh+SEDyvp3GjZOl4pi5tFZ8Bu1+rQ+I=;
        b=asCCqjjvPpJHSiJwK5+xvQMoeXCs8F1Hr8rlODbw0kEPQBrxrmVlBQFLcWXItHhIo3
         4+nSS5tMuJRGDzzJLORYp1mmvKCyKSjaCNbvb3wgMqOlAlZMHzj7Dn0/9gRrNeiA9A3W
         A3WWio+uS5vINaDZtuxZVET7oVXAvWGFI8l2VJ0mNbZlTs7dpehyZIt2hW92CkM3OzQS
         fehdqvMmockBP7pwN2be9b2D0zrrNyVvvE/RLw0E6ObqBGffgpbhdL5E669Pc3J5FAgj
         9PqaYVqnUfXyINDre+ZnvnCDuKg5v70QluFTDvTAnL6m6+MPrtlPykEbjj+4eSsUlrmI
         W6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773417086; x=1774021886;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIMg3XQR8uw1uh+SEDyvp3GjZOl4pi5tFZ8Bu1+rQ+I=;
        b=QjdZ/fYR3iDDrz7mBXU+tQGoa+i7sDEuzH40CgNQRHlVkCEn2Adq586vrbx4OPTzpL
         Yz+s5+r4vIdczNnV6c3iDGrYZ51bcxlE245EK6FzU5YgVcVEfR3AcsOE5Wjv8Qf5CYY4
         00IzK/5IVFUNT3c0hkoOo7xxVggcA0/uSCm45l1h7oHU9e7B0FDjn71FVszeZrLesu75
         ArJUURJBJ9FdPs4CDLlgaRuaPTlhe9E20Sd68YDE/MHzW68Qjo1h7R2KkQewn5FKyBgf
         i08gV327jT7fy5gSWottkdnRKCSJ7OzUqXhdJT55zGe3TjvTR7HaWrtojsRbFJJE5ROl
         9cYA==
X-Forwarded-Encrypted: i=1; AJvYcCX6ffdU6/rcama3QqnJDvSrZLIHV+j3OSxTs98Xmmei/0IqRqMXlBVPJws7JM2Ksrua69lP4yjrP9D3G/rM@vger.kernel.org
X-Gm-Message-State: AOJu0YxZb77hYeCYrbu11ooUNK7OU4tJZM8txjZC+tHiljqBA+Zoe9QV
	rWGvq4sk5aq2k9Bxs8WUHM+SFrnL0/9JKbL3PHKdj4nur8tsWJ8q+mtB
X-Gm-Gg: ATEYQzysSGuvkDXikj995m5uzgjyoCEmkzv0A6MisZDpa00EVs7A0HGmbcHwLT3z9cD
	sTF0VwIiid/mWCA/nwL9GdI5DzKl8yHWFL/iDTPpei4gWVaZm5vNY6NITHMUXde3PjaAp99p1YK
	FlqnPhzZTB/uwCBPeCU77KjK+5Eo48Wwu3M0fl/xvEbfxeteef6y8Vnw26tfUF9reBuwtZoQlFn
	rcNqp+cZMQFzJktUv5vqaN3DZXydtH+ajZgpax9oxyPlJC+m4N1ao5yl0oahPDniiV43+41WKhN
	fisgkN6eRsgrBNQd6fDYNFlrlzH9dAbdIr8TLqXTF7ZPvVlG/2IAEQ/ZTwQLYxS3taUhsW+D64Z
	bCcf7C3jQ2xqQurMP/nN028nQcjOJcgeRUl9/AQkPyTgu/ljenVH8ehdmZ0ryCmyUwCUIKO/+nm
	PAiSqi/rcLxIsIEe3e
X-Received: by 2002:a05:600c:a009:b0:485:3b00:f92e with SMTP id 5b1f17b1804b1-485566c6a8cmr64527765e9.2.1773417086025;
        Fri, 13 Mar 2026 08:51:26 -0700 (PDT)
Received: from [127.0.0.1] ([86.1.69.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4855638cebcsm56339885e9.0.2026.03.13.08.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 08:51:25 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:51:24 +0000
From: Josh Law <hlcj1234567@gmail.com>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Vlastimil Babka <vbabka@suse.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Josh Law <objecting@objecting.org>,
	mm-commits@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	"David Hildenbrand (Arm)" <david@kernel.org>
Message-ID: <28175752-2775-476d-9485-499335a99aea@gmail.com>
In-Reply-To: <01a6bbcc-1442-48c7-be5b-14f07fe655c9@lucifer.local>
References: <20260307221931.2848601-1-objecting@objecting.org> <3cd25de5-3737-49f4-aa8b-eaaee471af50@lucifer.local> <ee644e1b-5759-477f-8aec-35c91a5a938e@suse.com> <20260307222154.2848660-1-objecting@objecting.org> <667b75ad-bce9-4997-8ebf-8077952c2797@gmail.com> <20260313-anvisiert-gemeckert-352414e3d58d@brauner> <20260313-halskette-annahme-94e782eb4ae4@brauner> <01a6bbcc-1442-48c7-be5b-14f07fe655c9@lucifer.local>
Subject: Re: [PATCH] MAINTAINERS: add Josh Law as reviewer for library code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <28175752-2775-476d-9485-499335a99aea@gmail.com>

13 Mar 2026 15:48:32 Lorenzo Stoakes (Oracle) <ljs@kernel.org>:

> +cc David for mention
>
> On Fri, Mar 13, 2026 at 04:33:49PM +0100, Christian Brauner wrote:
>> - first patch Feb 28 under pseudonym "techyguyperplexable", switched to =
"Josh Law" only when Andrew required a real name
>> =C2=A0 in https://lore.kernel.org/all/20260228114939.de7d44de38d907a9b66=
32480@linux-foundation.org
>> - 142+ emails in ~2 weeks =E2=80=94 37 patches in a single day (Mar 1)
>> - All trivial/cosmetic =E2=80=94 SPDX headers, comment grammar, spacing,=
 const qualifiers. Zero bug fixes, zero new functionality
>> - Carpet-bombed multiple subsystems =E2=80=94 lib/, arm64/, staging/, in=
put/, etc.
>> - within 1 week of first-ever patch, submitted MAINTAINERS: add Josh Law=
 as reviewer for library code covering all of lib/ (locking.c, iov_iter.c, =
rhashtable.c, etc.)
>> - Email identity mismatch =E2=80=94 From: hlcj1234567@gmail.com, Signed-=
off-by: objecting@objecting.org
>> - Formatting problems =E2=80=94 top-posting, line length violations, pat=
ches not applying cleanly
>>
>> So I mean, one week to Reviewer. Even if we're being very generous here,
>> we need to do a lot more due diligence going forward. We can't just hand
>> out core components like this and risking our reputation and security
>> posture.
>
> Thanks! Agree absolutely that we need to be careful about this. Jia Tan s=
hould
> be instructive.
>
> Josh - there's nothing personal here to be clear, this is a question of
> procedure and caution.
>
> More broadly I think we should avoid assigning new people to catch-all
> categories anyway unless they are well established enough to be involved =
with
> _everything_ the catch-all covers.
>
> For instance adding people to the mm/* other than perhaps... David ;) wou=
ld be
> crazy.
>
> Also - Andrew - I think for cases where you are the only maintainer but i=
t
> impacts others, you should seek acks proportional to the scope the MAINTA=
INERS
> entry spans - in this case that'd be a _lot_ of people - but that only
> underlines that we shouldn't be updating such entries anyway.
>
> In fact - can we just do away with catch-all's and just make sure MAINTAI=
NERS
> entries are established for everything?
>
> I have ground to stand on for this as I personally did it for mm, althoug=
h we do
> still have a catch-all (not sure if necessary any more?)
>
> In the case of lib/ a quick fix could be to figure out which files are no=
t
> covered by other MAINTAINERS entries and adding them all to what is curre=
ntly
> the catch-all?
>
> Cheers, Lorenzo

Well, it's already been merged into linux-next, I will keep constantly tryi=
ng to prove myself as a trusted figure in the community, and I am learning =
new things every day about the rules, and when you talk about me making "tr=
ivial" patches, I also made some medium sized bug fixes, yeah my start was =
just "janitor" code, but I will try to prove myself,


V/R


Josh Law
