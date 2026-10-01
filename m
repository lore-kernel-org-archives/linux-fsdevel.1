Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C54FC344
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860903; cv=pass; b=uKric5AOd+0MLEiLO4NNGCts5H8Ai/L26hcj+0b2Edz0ZtXsH7E49dpsuuVvzHKUfhhPN24TMEQ6NmMUrWWE5pLMP6yDMVA2YPsSQ1HlGIuUI0/Eh/7uKBwE9MdVNDZOONYxPAPf/d3lSXEOAzhkbbrvCRkygY2AyJafc6H5874=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860903; c=relaxed/simple;
	bh=5CzgSrGsZ4Gj7IVYhmOuvePzlhKlt4zynM1RYMllPuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkhuxydmTYqrIBDGeTF2fIxpvIhfJhK7zQQy+UOxknKoFHi/EEjjFzR+wK1l7y0/yfkOmiac4bFj9Wh7kquwQ6rgYFaQERPJJ2DzvB4cVsu1YL0akQ5nkmFn1+rv4+WQV5ZhFhBrA5AN1ZJ1d/23ZgW9md+0Ppo8OvEpOvpq8OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ucs54T7s; arc=pass smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ucs54T7s"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-53320dc09f3so52697601cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 06:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790860897; cv=none;
        d=google.com; s=arc-20260327;
        b=q05FsIQIiTHZ3jGs/glnK4GyCiEsgLyo55w+ppx5hXyiT7ILRsG5+8DphLX8mughyv
         oVWaJ8bNDY22l49aB6dsXb3w7knEwTNU1UKluFOyipfEl9no8AV7TwiLFmFJQLzz999K
         en4PkCIISlptFKUBZKREZ6GONX0o1TX+82+6nrmUhlBV+4WsdMRXTU3D9NevEaSRJgXM
         1lw5UUsKyHTfdL7a3qXojFFWZI9MOtmAt74gP3CuqeHkQxjLo9Tdd6h2URt0mTZMs+Eg
         yMXVjaNGGC+sKqvgjR49UEcDsWkXYfCtiKn4YvcdGoWpFipn2PRFtJpc6gTWbgRns6pV
         8lVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5CzgSrGsZ4Gj7IVYhmOuvePzlhKlt4zynM1RYMllPuE=;
        fh=XGP6e8PaYK1VpQWWCR7NKKmKluhMRZpRcfZi1NY1Rho=;
        b=e4VvH3foZ1cJ+358MqZLrJp+s8nMsmciej962ldQ1caI2t+aRsBdqnPU16xrWsGQBn
         YtFZYo5rc4hLDgc3KvvaaA2MfCZuGmoY4Fg7Z2Jt2PydGY9cM6mvyRExiA7So6P/2wRh
         guiys/fvwg9HPhOF+P8Aybm/mqHws7XjzAmX8SxwB5QfEw+vtuoLZy6DwGo6CcPJ4GLK
         TpecsEv4gDVzHibazb1Wduhtun5jjHJa7Lzu/TXbqqKOR/hQ1Q5AYtoo2s8MlVZfhNmL
         t9E6G+L2C3gId2No9ZSbBCZPYS6SprIpSQqzvXGclX0sI41d5OIgT1tiDiLs4SoyOV0a
         TYzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790860897; x=1791465697; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5CzgSrGsZ4Gj7IVYhmOuvePzlhKlt4zynM1RYMllPuE=;
        b=Ucs54T7sSCY222mim1H2LFqjQRGOegBtfmRgAtnJ9NZvMhIPkRM6XHNsolY8UOCZJG
         1Ko3ReIq4cWUiJk3SfJ2lSbXT9qLsKC7mp/+QV5XXuMdFxyv/otOAWmNr9xEKCcVfX3b
         vRbLVMU4bg2ISVGSh4n+jTiEvGOdbOJUDdGdkVfcqMSzpscYJQkpNgQv/cQ/1aCvbBzn
         iY3+xGH5ga2quL1MDeSvSRCQ3ltx5TUe+5UyOPEGVdHWVYhE1l0manpG4T+Q1+AAtg6C
         k//DYqSUeWm5om+uCPGTz/iL/Y0ztreIi7afb1jHUh/l43wtVsNlduYVT9JRwIaXH8wi
         u64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790860897; x=1791465697;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5CzgSrGsZ4Gj7IVYhmOuvePzlhKlt4zynM1RYMllPuE=;
        b=wp1KXCZRJ1vv8bBSRs2BJ6kEFhotnp3/e1PoYwKE6Gvwt2QphGXGMeQkf2Z5jNaPLp
         3iuiBBH3io7rYP/kjRSasQBwYqKzvVZJPYjAWNIdTfuhwP9IDD0JoGh/52o0Ura88XWO
         tp0ib3apDccvcLWvTKsqVQJGZ3yVTz/DChiw+JiZn5CEu5K+/wvkzvq4OYoEO2VEIDeX
         JAnELL8/xxaCsO+Ec+oVbBrq+LA/h4Ap9ARp1u0Sv21ZEwwL+9q7R/zd+3Sv++bsNCip
         GJ6ki2zM1o/XBP8+jjc5z6H10RwJnAhHDoGwa7Yiz2qUqZ7H6tO4QERSOpBNJGn81Pkn
         se5A==
X-Forwarded-Encrypted: i=1; AKwUvBzpWPLtMOeniYfO6uUZ/M03Rja9TC30ioAUyaWnJXa8LG9ymHezqnG/ypoIapyGmqasKg9U4vPwKTmqzeH3@vger.kernel.org
X-Gm-Message-State: AFuF++nFFxjWXhMRugG/9mTzZY3rtzZMLui5RdOJ9Io9kv/NKbbn6GD3
	EPYYYhNvg+/RY2PbD3y578hjwOQr5jZMrDFev+qpfav8DVkjdItiYPgGfpxNViYYwbUOPwrWUdY
	VS+wJo33wyzrtDPgSy3biwfGUoPmHIZA=
X-Gm-Gg: AYBFou0AX4zK4dwtt1POSlIiLUQJ5mT/9Liy51pSWJnyDx3N/BnejWPJk8lqFms2XkH
	qhvOC2zA5ZAtHk3JkmF+iM4AH3iatC2ZZoX3ZMd4TqLxmMaMSg7P0gHnvv+67faHv3dja46R8us
	lUGs7Y5SrYb0PEJn0DBBHW9OhfNv/KxsIfHBLm5djLrmyZTS8uykOrmvyUQyImCXJ4I8Ls7j8xl
	HgYmpsE0vBNwg/2Ha9WfVfTyq3vkgQqwSH6jFowSzjvjxTsTLtcOwUn0Uia8ARE88Z9xbMOkzSM
	RL226p3dPzx/0/ms7Rw70HZHhim33VxGbUdLb4dHNbPxF77AG//WN+KEnN6nvp1q8olVRBMcApi
	kgw2kC9f+E88WMWMkFduHqBagmJ4FsJOnIMWUKXfpJbCJRSc=
X-Received: by 2002:a05:622a:5c0b:b0:533:4346:57fe with SMTP id
 d75a77b69052e-53374dc085fmr90051631cf.58.1790860897104; Thu, 01 Oct 2026
 06:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAE3jtcRQ407P9LTbg=JOwhABQRViSaq2XBefnDdNWiD7PxvUg@mail.gmail.com>
 <1ce9cf3a-15dc-4815-ba29-2e22b05206fb@kernel.org> <art8EKRKMdwSDCkr@gremlin>
 <CAAE3jtftxMkCfWJ77W-xvV2x7jdAN8C8kyofYC3fEivM-Cq6UQ@mail.gmail.com>
 <arz0auULA33fqoWu@gremlin> <arz8Plu6J4YOTi0a@gremlin> <CAAE3jtcanTUrV3xfofwrvYGCFe5o=Vn7gS66bDzuxzeGg6c5=Q@mail.gmail.com>
 <CAAE3jtdHi7aSsJ62TpEjkxvwA-3TBLvr5i1ohCNg2aupND+_XQ@mail.gmail.com>
 <xhrorb6wn2j2j57ydnt226khnu6gv4ut3crrmjwjr4iwj7d6yo@43lugxdthgyi>
 <CAAE3jtexTRdqzAodzCkAy5NtH_s3VhtutXbxMjangf8BtB+-dQ@mail.gmail.com> <ar4WSaLYBs1db1-3@gremlin>
In-Reply-To: <ar4WSaLYBs1db1-3@gremlin>
From: =?UTF-8?B?5aSp54u8?= <rockeet@gmail.com>
Date: Thu, 1 Oct 2026 21:21:25 +0800
X-Gm-Features: AclHuK_01iC1Hv5D_FCIUHeGCNiklU5j67JhEui9tVa5h0HZh1DUCdAFkZ_2faE
Message-ID: <CAAE3jtdYdt4XHkBa9sWNn283f+n=nzDwgxV_xWfPon986NJYhw@mail.gmail.com>
Subject: Re: [RFC] madvise: best-effort deferred writeback for shared file mappings
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Jan Kara <jack@suse.cz>, "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Lorenzo,

Thanks for explaining the shmem approach and for pointing out the
mailing-list etiquette.

> Overall - each objection so far has been to the cost of changing your
> design rather than to the userspace approaches not working.

I agree that userspace workarounds can solve the problem. In fact, our
current workarounds already do. However, they are awkward and much less
elegant than addressing the issue through the kernel interface we are
hoping for.

The underlying interface gap remains: an application knows when writeback
would be useful, but has no per-file way to ask the kernel to defer
age-based periodic writeback.

I believe this is a general issue, rather than something specific to our
design, and that we are unlikely to be the only ones who would welcome
such an interface.

The best-effort hint Jan described seems to address this directly, while
leaving memory-pressure writeback and explicit synchronization available
as usual. I hope we can consider its broader usefulness on that basis.

My proposal is only one possible approach. I would be very happy to see
the kernel provide an even more elegant solution than the one I have in
mind.

Thanks,
Peng
