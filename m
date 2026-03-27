Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEBA17B418
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627172; cv=pass; b=ekopPJABigdxStnTXkt8F67mXMQh0gkUWtbxJUptTlAlmf0GshGzsEky9XOEjqZEGE53C4B/V5WWm/WKIW8Lh5MdJCp3NpQYdfUXQ9z74c4VaZJiE0zxIaeZZkoSfb+G7HPdTP1ZoFxuFuuTUEUpVB3VlqTmjO5cFCfQfCpralU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627172; c=relaxed/simple;
	bh=LhZwKKs0sf5VOiERE9wtFVUhEEfkDjhE98UKl54LL98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rh/kKHspD2Yrlc5Xbfyja1ek/LyfV85R6VVTmhNZb5Zx4ks/qqKbffLejNLaizmK4bdOfZwdSJ4Nmc3ty3QKD1ibxPvcXytDhMx0L/QG9MJYA12Hd9vXEM8eC539q0PsDFbu1aU7qfciEqW5l8BOaO6xfPLKevoVzbRJONIWLtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB3Df9DM; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB3Df9DM"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso23698175e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 08:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774627169; cv=none;
        d=google.com; s=arc-20240605;
        b=OB9V+wTk/ZeoMI2Ntimu0AZxy8Y/8xVO+G8OrtAP5d2YxPEzffYN4Y/XKq0S3c/0kp
         C5yKx0UVPB7CPHAd/49+WfkjVmoBngMoj6fMuqee08ItbtAWDlTMpcdU5D/AITLp9miq
         adacnUpTBIc9gyN9aItIvnFd/P9/N+WOJZ3+Jr1jxEHLZ+tNxt9/OlElHY/lqqyWu2e3
         d7B8MhMw4DJsYrSHjIqEL0UPTPdThiDI+nVMQ8/amOdHZwLJfxSUnpr7hG+6WNnhnecZ
         ZkNr+O5OhhdxCEeMG/NS7tpWZOhNfRh2qO74AFI8PfffHVH/F/xVi4BEVxG4rmbtU36m
         Yd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LhZwKKs0sf5VOiERE9wtFVUhEEfkDjhE98UKl54LL98=;
        fh=i7wmZpCcTMYgqbjLJsuFT6aJco7Jrfs3XpCOEOlsYbs=;
        b=VeJDHHBi+/e2j+ELMZdZPhy4ghBJBFsE5cEFv+ShYXzWEAE6xOSclvIRYe0pG6KeLR
         4E9WQYcfLQovib4WWSSaDnm9+UzdjAeWsx8ue1loUVsynQOD6b5Go+r4wyzyT1PH+ka3
         BBYRqxnBGLgftgFFOQbo7IZDwDD72AMJloLqV6Now5ugyYKVHFsOLpgdUwKL2SHddNEM
         +YZ7/IsTGtoZArJ2fitwnJVjzlQNdIK7RSxXwkIZNC1jVpl8U+YASmL2yKJ5j1rs+HXb
         pguvJSIPamjWEye7p3HnMbYMqnwJKT0EDsj0Lz+kjGwzblGQcbV4qjlay+yGGUuFcMTd
         KAXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774627169; x=1775231969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhZwKKs0sf5VOiERE9wtFVUhEEfkDjhE98UKl54LL98=;
        b=GB3Df9DM3mnnThsHJmx8PbkRFaXYgRJWuhX+wq5nzLGKGl2Pesv8D4gJLwHwgxsv3C
         kfWrkIrkwlLvYRAH6BbCAqSNde2Za+T8PIpu/nlMGONiygEQUoX6+4gpxHKx/BzQx8BR
         NYtEDt/g1yrgEr4r9I0oXnqibdh7sCaTtelLUB12RrxrU4D8boWKmbla/FKKEj8VOvut
         mPnT5yAp9uf9qizngDZD2OaX343AgOhBMcJDRJF5W6/JsOrl5c9v74hgMfo35biyCo2d
         6H+YPadODat3gsTUATY3H6x443mL2btUIS0MbiytYj8mTDtWkvpKU0qA64cxxAnzmjQg
         OKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774627169; x=1775231969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LhZwKKs0sf5VOiERE9wtFVUhEEfkDjhE98UKl54LL98=;
        b=pAB8TsKG2Meu2eEx7SYCuAiyahk6FTJPWJfOzk19WItlrts3cFjbAruHvKWaaPoU6K
         mbevMlUFGWd1Q6xhP+5RTJPdCeDG7+M9fzmK8IzqN1mY2SVtmpFdnRMEOhKl4Fc1QUtq
         MV9NbrqNklGLkQbaX0UvUdTPd5DjGHhV3e+fmZzrWsulIQa1PZ3MVDeB+ZLL/snXfRZT
         iKvgTYlg9Q2bztBDpeDBPLW9XEPjHGyvz4YH9OVXcNjJ9uwy+ixnyGDgHEes5cx5GN5s
         ZKEnDCU5hj/PjD9qn/mPrshhnBG5IR2uwrSHHd8mgt/iONTy25KO92ndPaCXd7rdv9jy
         dysw==
X-Forwarded-Encrypted: i=1; AJvYcCWs0C3thNGeVtg2SOZ5/sujnYejqgmbt9XFQgeYOOOJT6hHb6v8JPV7veUV2VIE2JcP8O5I4CdNYd3E9qs+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg2br8WLc7ajtsnPNjCeIhismdfDC9qJD+J0scycvMNqPfpNyN
	tuYpYVec41xNAuJM/zbclmA6p411khpaX2Mckk95lNh3uz7fgindlWH7RLfS0Nrk+h6PBX9f/kN
	gLwX+1BEt6KKAHWJZp8c8Aqftfg+8BCAZWkf0
X-Gm-Gg: ATEYQzxwmV34+l8c+G1BFAK9+vMmJtDi0qp6zPGA2Jn/tvbHlgfYCMyQzTm6oQTujsh
	WKZws+by8cEkl6VMO+1q9X/y/r/FtyQ3xsIThIWJQEvLOSICP9vfoRLhw/kfx5WKuBiWoOhvKqS
	iwJmC9rsP39XopI/6UeCLQnWLYZ9jUzUfuYHa0cz56bShlN1K0Krhe/VsYabjAl8cwg5U+c+9Tm
	1c+XmMX3iphftC6gkoqyq534dzjLwLey3fNYQHb/sEUkrnkf6jenqJzF4wFecIPqkk78dhhKn6r
	kst87A==
X-Received: by 2002:a05:600c:3b24:b0:483:6a8d:b2f9 with SMTP id
 5b1f17b1804b1-48727d5a329mr55071975e9.5.1774627169154; Fri, 27 Mar 2026
 08:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326234629.840938-1-joannelkoong@gmail.com>
 <20260326234629.840938-2-joannelkoong@gmail.com> <20260326174237.0ad75b578219aad36f137e4b@linux-foundation.org>
 <20260326175052.06871e1fe76af965a114bb3d@linux-foundation.org>
In-Reply-To: <20260326175052.06871e1fe76af965a114bb3d@linux-foundation.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 27 Mar 2026 08:59:17 -0700
X-Gm-Features: AQROBzCsIj0J9Y2u5MtJepoRMfzd88OvWi-Y5duJeQ2qQ2Uz805LBD2c8vxY-dA
Message-ID: <CAJnrk1aFauY=ug2UyxttA=hKdsP-Rq7xwYCp_yyYQn2QeKiZVg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mm: start background writeback based on per-wb
 threshold for strictlimit BDIs
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jack@suse.cz, willy@infradead.org, miklos@szeredi.hu, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 5:50=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 26 Mar 2026 17:42:37 -0700 Andrew Morton <akpm@linux-foundation.o=
rg> wrote:
>
> btw, a [0/N] isn't really needed for a singleton patch - best to just
> put everything into the patch's changelog.
>
> Transient info such as "this depends on my other patch" can be placed
> below the singleton patch's "---" separator.

Ah I see, I will do that instead next time, sorry for the confusion.

Thanks,
Joanne
