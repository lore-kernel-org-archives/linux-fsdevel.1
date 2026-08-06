Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264263DA7EC
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050762; cv=pass; b=YPsjP+atPlgvVpRDWZ3G5gG94AHzjPa6px71huZm+z1HIvQkDRji6Wtitnx91T7g65kLk3cJbEzD9tXzyHtirAURAgReSMdPD7CxHd7XZCRkAsrlsAuhLS4nhv50Co9AgMlAoeZpzhi0PNLjqRPyRUQv9kGSF87s6ha4DLcVWkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050762; c=relaxed/simple;
	bh=O2nXCqD4o4f5F4Q2WJbaQxzYFvLIe2CbH7K3L5QM6zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YA2nAIX0Rt1FgtfTGD6l+vPV9dxXl8zHP5EJjS7EhfNK/QSDD8Lcib/SiozQoQ8ZrcZ0VEmTcEu2PcljyM6gjSzSskkONEAYmVQhV/fvQylJ4myWj5YWYFUnm2Yrc/tCjP2fMxopqbS7TEDadJDNtNjD+rDYv5zQ4ie1O4OV8Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWSiDaEj; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWSiDaEj"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f7872abb6so1306491f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 14:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050759; cv=none;
        d=google.com; s=arc-20260327;
        b=mpMGGrMJpd0zd9KzbGR294eG/b6nnEElew3Ir8NmMvYU9dlempLjGrOOcVDA6PDSal
         6Q0lSs+yZh6CS6uf6C/Qi1/HKGT95BcnsyAIkRNo4Uid/gpf+n74zexelv1UrOOC+LSc
         st93i0F6ghDoksztdCjZwcTS2kwf+xxM4QRcoelKlFRw99AYhQFAB1U1taw40hylYOaQ
         Ar+nEeuVNNUOPD6QRU91UEKH/v5zdCYRskHqcZVy5iMf7Tp6WkLU8whsyn4Kj+b5DLvi
         Cgdfh8fXV2/uL36W6edBIGTSK2ty/qB+1w7As2R4T5eRsQJM0UaBxAWUGtSi2QfL2Cxu
         bVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O2nXCqD4o4f5F4Q2WJbaQxzYFvLIe2CbH7K3L5QM6zE=;
        fh=mECkPx84LSUyFYzMNld5EqH2yf7OUSjaEC6KWHMo1fI=;
        b=ZQKoSK4a9eCJYbSbXfJzktz4QUTJ5KRgNzZSclMEEv+RUfK1qI6ZJCERMUTVjgfTdc
         cDjt/f5u0iClYp4HsH7WdFgHUr1FF9gjzX8+YA13VuI1zm+HdObmbM8tJsMapcHLgBuv
         ckMKq9KnFCu0pcvaFEMJp5zn+eGwozh8GaXG/gBB2IKnQLrxz3oTR7SUU7TjpTRO1cWi
         2q5ZhS3yk9sDSruWXx1D04qqIR6o6f3a6rb3CZNQfSFKSa18zGFxAgoMDW7UZKOpZBIx
         +oyFySTXYYJyMspMYUnSoyfaMQ1SiqrdOWfwdFquvX7TZIYHd31wPdv51M2eAkH/Sr8m
         iyWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786050759; x=1786655559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O2nXCqD4o4f5F4Q2WJbaQxzYFvLIe2CbH7K3L5QM6zE=;
        b=MWSiDaEje+zgNjbbgl8YXgfzKrlmEiybwk/ZCe57OjFU8PiEpLmNEq6ksPxCPWTK9s
         N34+Rn0TodRmWp9REy6zkVZMbElz98OR3en/0NKjR2zaxtPX3q9dAZiTdDtCJYY12jBp
         Ze80Y3gOVBVnldjPfcYJY5YRWTwoke+LdHsZmcIq5f781f+hEIDCEdtnJLZ0ao0OvuuX
         cG6Sl59VogNBeXnICtArSPAovXAageHGulOXz5AKK+3Brhn86XwZr3wxH4YXw9XnBRex
         AFYlT66/LGm1zlIAJC3o7P8P1Tj5YHKHytwXBsVlbB+3GYpyFnNgMOeucRIkeO6L8PXp
         ZvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786050759; x=1786655559;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O2nXCqD4o4f5F4Q2WJbaQxzYFvLIe2CbH7K3L5QM6zE=;
        b=J9Bf3lSKom4jTkw0CPYQOvUdX4OqbvVuEExpLugUo3+1/5fBFvPYhL3eZ9B8A4xI80
         KoiTJREBmLKJQiAfR/xFgWurbfc2ihGo/Haiqj/4GbIPTzXCBAuevOZtt1Raaczjhov8
         vpnWWMOP7DRHcguzH9/+itfH3FEJ+W9pn0b4Du2WNMnMHgVZ56RFJC9/PqsYptOX9dMl
         Z8R9mSwpqMp5AQNHjvwjF5qf6jo0zhc0MckwW+psLunVO3FEgxvR4rUkCFGlCbxwt50F
         RSEZaN/+7YTSx/ZiORpTZKy73psZBUkfwV7zMnr4cufGXSyK/p17ya1YyNxDNj2p45Zy
         BduA==
X-Forwarded-Encrypted: i=1; AHgh+RpTUMbhVP8pN/EOUvPrbGUG2nHeNutuQa+j/5gqOw7qe5fuz58QZnSMucLBaNWpQTPVIcQyPMNoZlor8vjZ@vger.kernel.org
X-Gm-Message-State: AOJu0YySMFpN1Sd1p20vb3YfVgq0CcOPLYAWX5uEymjNe6HKQeVI2SNj
	VauSh5p8IubE8Vfg29fHKVS893Obqs8nZVfFzxusiWB/2cXmgg9O/+m1srsdlcwarde5C1ELJ8y
	t3DT3sQJoh/Zx47KQv36oee33ivYX1zM=
X-Gm-Gg: AR+sD13ug/8EV12CdWJvuBGoHPWtMog5q5QZA8e0wC+eoNIGfKgicJojMNM3nTJnRtv
	hnYC54ytpesHbVqhE08sZZO3p79ZnaZ5PrslV8pIxYKy/dl3EQJBRsprrHAEYTwzgKRX4pyEhlk
	/+WbdQki/EbXNWXm8rcI5CnNcCGOIGBAZOinaWAqeI8thOr+DSPUuxOTZyHRRuPhCKTndNbzZHe
	wyIssFGfhd72LgwL8qam+DVieBshbU/jqE/ZVLGll+vROhKqgJj8AXMCNfQjms4Fd0ElNF9BUr7
	GmMVYeGbk9zXLUCIF35g28Y2ygUC1jFrSKXHhD25wiGsWMrbaNGjkoVUO5KrrD67OAMbcglT5xE
	yNWlcvAslfvDxO9URLc0+ciux
X-Received: by 2002:adf:e012:0:10b0:47f:762f:32a9 with SMTP id
 ffacd0b85a97d-47ffd2322d0mr5562298f8f.12.1786050759421; Thu, 06 Aug 2026
 14:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1bk66ZhRAS7mojSnD5RBfFS+0ChAPymE3ObRWr0C_udWg@mail.gmail.com>
In-Reply-To: <CAJnrk1bk66ZhRAS7mojSnD5RBfFS+0ChAPymE3ObRWr0C_udWg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 6 Aug 2026 14:12:26 -0700
X-Gm-Features: AUfX_myi8qSsw8YaJ3oXvGriDbREJKOHPf6InLwZIwXLf_s2phZcmAT4WgkHKVs
Message-ID: <CAJnrk1YNZ-mW7VDXtbNYDUbim7g20gSsec1Gxpy8kWKrDEN5_Q@mail.gmail.com>
Subject: Re: memcg stats flushing (WAS "Re: [PATCH] fuse: disable default bdi strictlimiting")
To: Yosry Ahmed <yosry@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.linux.dev>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yunzhao Li <yunzhao@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 2:04=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
>

Sorry, I think I messed up how things got linked when trying to update
the thread title in gmail. This is a continuation of the previous
discussion thread ("PATCH] fuse: disable default bdi strictlimiting")
which is at https://lore.kernel.org/linux-fsdevel/s4kv7qep3jlncs67q72xfhser=
pd66hpbwzkoppiddc5raufyjd@ksuvlfqcrbk2/T/#t.

Thanks,
Joanne
