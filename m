Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8147DF95
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578919; cv=none; b=JWiPWje6Ib7+SV9Ru6GIN989ySi3r4eh2CIP/Mz8p11mT16e9YVVkIKB6zJUHkKjFBO8qSv8UUGDk4c8kwJwDMEEfUrW6B+pbxGo85wHKykcYWWvtZWqdMhdjd6kNcbBBIO6tPpMPOfL15x61ta6N3HZh8RFY8CIUusNoydaTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578919; c=relaxed/simple;
	bh=A+U0jlBemz92XWR1C9KXngYLR2hMO+q63YxsFIbVEm8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oiwhFESQzzPHkx66Op5nLHAz4/Jum1sFknOeMBQDbjlPJWx9lq1BD6xkR+n61ku7G+jNW03UjcJk+Y3nCSokSS71D/Q3aNrBrx/QP1zh3K66frffOShhj+TbIb0x6G1UPZVVqP1kOoT4iwpKImcwXbJvYa1v/Wbvz6CpuH+kc+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=mquM40OU; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="mquM40OU"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d4ddd179eso11152757b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789578913; x=1790183713; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A+U0jlBemz92XWR1C9KXngYLR2hMO+q63YxsFIbVEm8=;
        b=mquM40OU8vAERJTo6NESYSUZNFUreyJWW/Pxjin+NDC8g+UTeTgLTdgXqVeUEchKFr
         2mYQT+dQNXgHWfdNglZIgJ4xcqbUGw8AV03WDgDqbDJ1UCedhJCnkFoEKJ1Z6wXVDsRm
         239bx3uThskJlJ6Q2od2sNMsEUrTdp/BhYrTswfv3GFnCQiGVOhFon7HPneO1sQJlwOL
         3Ag/dg8Q3DFkj1Sfgf6wgsy46pQWatsfym5HBEmMSoiT/r0RW01FG9YK8mxQ7PMct6wd
         adZRvFTz/yuWSr0jd9sMQJ8h+aTgVpELrp4LLcACUuIDeFika1C9Jv3dpPk35QuZQ246
         lFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789578913; x=1790183713;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A+U0jlBemz92XWR1C9KXngYLR2hMO+q63YxsFIbVEm8=;
        b=TYzVXY8jfWzIygRphfdbsnT+yXNrtK/425tbz2VR2jCmb4rDB81be3Scze9wF1sf1r
         juyl2AuSJTlB/4M/2FVqIBP6G6F7grYuuPy5EQnNF2wlR2a2pmfwDeuOsQ+GzQ7AsQ4t
         8Sp+nzUql2VQUJ9l3ZjNvKumiII6uXhODqnANiBiVSl2YMDLufuZYoHppLW0atI1JIw6
         OaWU8LbeyMBwtvFsgGvGoPo4hmdzzav9Azg1ovY7wZy0d/g9iP3hib8IBHaHXZZAfOL2
         FHzyrfNFE7BXuKH0a2r+aELFG38keA5LaOGbagooILbtmNG3Ev4sNnvXAQs28VPNpIed
         R3sA==
X-Forwarded-Encrypted: i=1; AKwUvBxYkxnLuMuGq7Tj6sfxl0aN+1xM2qTvbzq3h00KLg8HeIRtuYytJxg7vWeFAb2C127MDKWMvWWbSJU9+G3e@vger.kernel.org
X-Gm-Message-State: AFuF++k56QsqdAluWIa/xq/oFCVX4Q8jDsu+l/QoLl5QjWYw3gCmwSWp
	D9ugWZLd1UxY3lwiJYN8NlTb4P2wtba3tB6EBDhAQepHtJKZvLEfcmVdMHbeSrtYtQ4=
X-Gm-Gg: AYBFou29z1R2tFW/shNoBglOUMFEwDIwi5FqHyNlvKg3jkKlOH/CPy9WuQF3Xzlxwfo
	Qk79Sl7KFb20y0hGZ1VHNRlVpFba1UI8wKOpGN71YdT15JCRb77AntNx7ct0AN5H5DNI7yrxmw8
	X83VmW8uykb2BnuseUwI7Zf82rU2es6eX1a2J5a18XJoAcG4cK7jJ10YOWiFJWYJ+kwrMP7+u8J
	mUI7L2m7/D1HIF7Lyp8W+KIr5jb/zc82a4eUcAwFro7fRuyb5Icnl6LN+JW41TJ10G6xBHhZtIw
	dELNpd79571VoknM783vhwSOWqBCmderuku2x/H0m8LRNdVs7u57U8mlevwph/GN/x/it6ccJtX
	ONNqDJrlN202kMcdCGng9pi51z16Z/PNY6ZOiZk5JjTkvDOF6JAXwNO+zKEATW6pBg2me38bvSi
	U0TGDGw6rUGycrf+ZJ1CcKeYDfHqr+oXrTDuU0Ye7h4c8qUtf4jVx3uO/UTXC74azskbcJ5lzbM
	PM6fOJ7F8PhaVrKDcBAaISuyIBTsgd0UG143/lD/vA/ywf1ZwKTbirHWlY0wk7LSRrX47tp5f58
	edX/uRyNVb37pSIp+rPrz6APRBcKVhkUxOylBfAtH9AEARVcwtjYEGXbGoM9dk8F
X-Received: by 2002:a05:690c:84:b0:86c:c7a8:2ebd with SMTP id 00721157ae682-8922a9fba9bmr14494777b3.34.1789578913520;
        Wed, 16 Sep 2026 10:15:13 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:f547:a2c0:72f7:6671? ([2600:1700:6476:1430:f547:a2c0:72f7:6671])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-891efc0dfcbsm10099737b3.26.2026.09.16.10.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:15:12 -0700 (PDT)
Message-ID: <2f3de27f1a824fed104918fc2756c33663ae978c.camel@dubeyko.com>
Subject: Re: [PATCH v4 2/2] hfsplus: validate b-tree fork extents at mount
 time
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Date: Wed, 16 Sep 2026 10:15:11 -0700
In-Reply-To: <7d1b09519cddf5124def5fdda42a5a3c8ba4ef11.camel@dubeyko.com>
References: <cbc98010b9f6657e162cfcc6ac5ba6032e7b729d.camel@dubeyko.com>
		 <20260915141543.24335-1-ngocthang2710.1999@gmail.com>
	 <7d1b09519cddf5124def5fdda42a5a3c8ba4ef11.camel@dubeyko.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-15 at 16:48 -0700, Viacheslav Dubeyko wrote:
> Hi Nguyen Ngoc,
>=20
> Please, don't move your answers from the code where I left my
> questions. I really cannot follow to your answers and the whole
> discussion is broken. I cannot follow to your answers. I am simply
> rejecting the whole email.
>=20

Could you please send the formal patch v5 and we can re-start the
discussion from this point? It's really hard to continue discussion if
the questions and answers have been moved from the code context. And it
really complicates the review if you mess the discussion and new code
together. Please, send new state of the code as a formal patch but not
the part of the discussion. This mixture blows my mind.

Thanks,
Slava.
