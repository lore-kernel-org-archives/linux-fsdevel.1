Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0475434250D
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775814407; cv=pass; b=YKG84uCj3MZ0JN8djV2a34pbfWnTgD5bcEAncGKM1LoZ8+7P/R90oG4jvZz/a2meL0KolszqtrriV26pv2H+szWpIH/WLcuHYjaEsgVrhn6TPvLKIocA8rrQSa8WyIDwukqL52gtps4N3D3ecA0zYacYIMauu/cxCpJL5Tqhpm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775814407; c=relaxed/simple;
	bh=c8Gav2S1OLg724dKO3Twlqs9ynZ5H2nEESVRlDQHDyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDULMvP/8j9EJXgcdP7XKGgKN+qGQYfTgasT8nlf9XuDb2L0WyGLZv7OV44CJka5y+9nQiNCmsGJc/3gHSOpKm1jiPYTe3ErqjQ20MwFHk9DHNUsIyOgOUOaRH5Y5qzdseoy5SI2s7uMYKJestZt8EUNU0FVg8tHBHMlQCA8gOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKhV0lRo; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKhV0lRo"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9c9d03524cso206514166b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 02:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775814404; cv=none;
        d=google.com; s=arc-20240605;
        b=cObvWJ/b6qyihqdqfKjuh1QLJH9m/aN/251upCA5exut4Z70gW5dtx6bR22S5Gmni+
         EX6TRjfZdAx9j+oBpDl+P62hVx6O/c6uaMAbQ4BbgEiZzpn+xXgVb1N5rIV0tlmmmP4G
         /bu2nT6NBYnATbGGsrM9hhHMCbSKw6+6zZ6aih3JP2CbfieuyAfN38OOU36uTy60plCu
         ls+O3MKEbHxuODxVTABz5w+LWxR+z/t/5ln4U1k2zY8Et5R2F4ecpBxpU3UzdlxOgfUN
         mwCbvgVPGua+PNU5ntJs10GxVUXB9sOWvgeDslIXVkKyOVCU6x2ZEQdF6/mBDfzfcNJx
         kHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c8Gav2S1OLg724dKO3Twlqs9ynZ5H2nEESVRlDQHDyI=;
        fh=54Gmx73mThcYsO7fp+D2Ddd2Fj38Z7lwi5rodnI595o=;
        b=ljellQ1p0sBG8HQ/uao+5/YiB+JrRNxx5TplvFaoYxeShz5BaY4o+f1SNuqbaadqhW
         8USGU0tb3SVbCtDzZE3CvlS53r6LbFt3OiU04416Pmc8dLPqtXrW66uNle2GWx0qhPlS
         yJP3gLQDbRPQezt9u7eAf5bhEc4Xj46U47Q4uQLAiQlg9BQWLmRcCIxcpKky/IfkU4RR
         R1pJVb1na2t3GHE27ZaBwRA7kDLYzWhEdWwbQvX+sxNvJ2savLW1QMH+KDSamOQNGFpD
         Q322UVNu91EqOBLcwH6MJOM0EwTwx/NyOCiKnOBvcC1D0uMqTQA6MCevjfGa5mhjm4af
         owCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775814404; x=1776419204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8Gav2S1OLg724dKO3Twlqs9ynZ5H2nEESVRlDQHDyI=;
        b=ZKhV0lRol8tvDTPB7/fhH55h1Rq5oJ2hNUEBhKDFpQvpMOTE/wjj5fN6uCRz3T7uQA
         rs9E6aaFDez+5GXsz61Dj1jOKDbq0sDaU1mcAd/Ner7eCfSeY8mF8079JcKM9fDKKaUv
         PqmNC71hjUtbxvnT39aplbHzDN761h83ggI1VnqivlTAma7ovtlXW3Q1ncKrkXS3s6It
         PFahELdUMbsMYEPPXSDoZjHxBWWHkqo+zPKgy0KI2/ewGh4zwRwPm44ecGFY2xl8pPZA
         3wn3SkMbjY+w+jX5EFcmwwKk3wD3R6UpGQOjEDPD3/LBPRJaaPhjfMgl5FHKAKkSL/yp
         y/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775814404; x=1776419204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8Gav2S1OLg724dKO3Twlqs9ynZ5H2nEESVRlDQHDyI=;
        b=QP6ZkURT5bwv0nG0Lwqr9avftIPziA81cR4vlMCYZBP+bzs4W9ZDlFs9OS7w11g4rk
         c9MyezP1IfmFRDwVjI52NplVQPHXN6hPYRelB7xz9f7YC5ilzpwqp9Wzw8p8L59ELSyT
         mjBsRwhT1zsUxlX2DAllWq6A7McEQxIBkz524b1HnqUcMVWXsdcDGZRfhwbKfvE11D40
         GZGvXKh9astWsfjMcuZeKI0U+iL4z6q1uKC4KCOmcGEx/T9EX3ZSGQ9L/etCvBmqh84m
         PRsLR5VI6AHNcZGrqGRug2VsbdPBaaZEuxS0coJfv6cP50O9GHlxlAk7O9YXWtAPi5OZ
         VSmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0d+rru2iRPR0atXkpbmfMt/2Ml6jzt1LThxQqb06Gbw7XVqugi76VBA6U7hJ6qLayXYMHSnFOrFNW/mve@vger.kernel.org
X-Gm-Message-State: AOJu0YwXM97A+VolRW+qg1pli1eNGMeWMgc7a2jA5AUw+v97XefNAH6E
	44pICsAGzz4Ar4gZkM7UgXQBPMKiS1q9War82oNBA2158rAd1fmKJWChY5s4Rb9IrqA0AvnhB7t
	00pd6cY4tDxtIGPWQv9ScbqK8K107dMc=
X-Gm-Gg: AeBDieu3Ea5qQMTNGorWsEGJ9fSFnQoTj6EOt46Mbg25cCXbaiJkjiQgAgGpWn5w/zH
	koUN4DcANs7gZ0rhhtWZsNRGPwdCdQ1Y59JyhkN46jO/2dvOSbPJWV3NN9FYdcyFHASJp7d5AzZ
	LxI/gBmfdhbVm3BOFtXOOG6inXmDZzWW8w7pM1K5YwHQNmiytUE5wb3Ucz/7SpbB6TDo+xCHUxA
	LGQYH5VcvmsToX+6H/1nSxsmVe4vL4PPLZ2B915igd9bWlkaeEmEGyZw3O9kVZ3n89q/XIOle6b
	SHS8RkEU60v6oNAKh/0d4JxUroutjeK7/NXHZ9QWag==
X-Received: by 2002:a17:907:c708:b0:b95:6687:4d15 with SMTP id
 a640c23a62f3a-b9d729c0598mr175094666b.42.1775814403740; Fri, 10 Apr 2026
 02:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegsxe=QdrGGPVSUWfJunDKvOXoszy6BnaP0MjHpRS7rHHQ@mail.gmail.com>
In-Reply-To: <CAJfpegsxe=QdrGGPVSUWfJunDKvOXoszy6BnaP0MjHpRS7rHHQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 10 Apr 2026 11:46:31 +0200
X-Gm-Features: AQROBzAvuvXgNVe1WM5foLq1mk3lVdbn_6gBYUXySWDKSwQFbQ-KkhgRyTndCTQ
Message-ID: <CAOQ4uxgjDYihoPGcVZMZPu6S5OCfAJ4StispKUYj=+6Ay_qtkg@mail.gmail.com>
Subject: Re: fsnotify_prepare_user_wait() bug?
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 5:11=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> Hi,
>
> Maybe I'm misreading the code, but shouldn't
> fsnotify_prepare_user_wait() filter out marks that are in different
> groups from the one being acted on?

Well fsnotify_mark_srcu is global, so if we are dropping it, I think
we need to protect all the marks, not just this group's marks.

>
> AFAICS the current code allows failure of a permission event, for
> example, due to an unrelated group being torn down in case the current
> group doesn't have a mark for a certain type, while the lower prio one
> does have a mark with that type.

Maybe we can have an fsnotify_mark_srcu per type, or slightly more
pragmatic, split out fsnotify_inode_mark_srcu for inode and parent types
from the rest, because inode and parent mark can also be set by unpriv user=
s.

Do you think this will improve the situation in practice for real world cas=
es?
I assume that you have observed such cases?

Thanks,
Amir.
