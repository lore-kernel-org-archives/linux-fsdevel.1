Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB33B2FE4
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073778; cv=pass; b=Hw6HhhTu5mIUFwZqRIlgskWZ1DZ/lVI2UGLWa8W7DEYcWwHFDMG0KAKPVaqj+bqW6ivR1U63JEiYP0mrEZLe0weDMlz4uN0lps+EIuOfgfDwT/1M4XftB9QWV/VMLbpU1sm7LJo5H5UPsmAWZYxHc1cyZ7Xzr9P4u+waite1imo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073778; c=relaxed/simple;
	bh=Jiq8G8AEdsoqKwh5PjPO0CAmrRjM7cAFmwSPqfT90Ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1L1OmshtgL1pxtRINSgZQyykubcZUp5KpQN/6nZMwuZe+6BGz8ZQeXlk2Dbjb26iA/1Rl/t9bQuGZJ5VCrYHhEB0FvuV7weDElspRN7hloEwdBQzmoVE0Z4vDV4ztgC9/gALoxo7MA9Qv+rytdmimGKkSULOuSVTc8O90tzDh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=En8RjWTn; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="En8RjWTn"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50d75bfb259so28308441cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 02:49:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776073775; cv=none;
        d=google.com; s=arc-20240605;
        b=TvkxvL5v1GyCzgPCpxoPe3d6bF/WMjaOsXYSJvJ5qyIaNCyHYu3pYTX0hi5K7JiRPQ
         rnSDUjpO3QtKmyk2wtY4Cg4Z9soSGv9zT8tRaSGVlX8J3CoFZHIj5ot0fO1T5E14fgX+
         Y/vP18gVAQlmXJMHYPf1Lijw16Nc95WFWAXcI3qiS4yduu8q0R83ezvBIFo11kusHPm7
         alaKEPpY7Zrot23k1e+Vr6vMdmKjVIUHeJRbS7JaOS5M6p3pqN8YQAlHqs4aun6xXxZp
         XmGC0o4HEJWn2y8bgrn6Z7153Nl7DbC1gbV6+JRbhcnI5lndNXeCnRiwxF/DPHz/KkBk
         PWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Jiq8G8AEdsoqKwh5PjPO0CAmrRjM7cAFmwSPqfT90Ss=;
        fh=HmY3ZDk2xe5aHYC1geX2bWyxyY0uJOyROR4sSleGj2I=;
        b=hQjtTcEpZrTERrXkSOXsnI5vP5eygSwPqd4dRVAIREf7TUu6dbcl2l1G6qBAAI/HfW
         86RisOgLBBw2QEXNVWcvspHjanBWbqX8piJAHkuQA/qFm0PtFGARhdMw496q+rSeZiAT
         vkR/m/Ii3jD2t0k3MJQMfQFGpimOFVbZtI+QC3yHLKJQOqNXOmGBa34Ie6yNjqxLg5xm
         lUqmMpDYurluQNXpgr8UnHIK5U4nUumKGE4v+x5qJ+gcv5ilrxmSSZky7EAzxbkzh/Al
         c/kBq5gMONMJYfn3mSPw9easPJH52cPKwIYd05Du2DgwwvRhyMStQn3Iip9mmkBAbRDC
         nuqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776073775; x=1776678575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jiq8G8AEdsoqKwh5PjPO0CAmrRjM7cAFmwSPqfT90Ss=;
        b=En8RjWTn8FjJCMz7FFf9qdNpGOeCx9NxWnoCX1zRQezfKNklAnfYtInRaiqr1iBmP3
         fxzKY6TRBMbmi0bSXKqSi/rnJMun+o2NP5R9/9azMsIbsIyGh0sRnZAZ9OdYh6gD/TC3
         Z5PuUkPCE61aHWO/MMJabKZu69kcyxpT1NML4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776073775; x=1776678575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jiq8G8AEdsoqKwh5PjPO0CAmrRjM7cAFmwSPqfT90Ss=;
        b=plq93jaj/pdt8nkHY4cZxERkgZho2JUyYv81L1NCj1KeEC9Wcfa0R1mrM9q2rG3kCi
         3BT09gR4ZAAULtAlY2nvINWMdtkP/MoRHMJJ6oh4MxUPBUjje4xSPq5ADANs2oyk3kWP
         HX1gVgREqeAnpdZd2n5H60+L4ryxJ5qSK1n1ob1Hz5FLmEPMLUmdjqqVv/ekR47G1OM7
         BCNaW6upSUaJ7/w7bhIH4+zSNWMJTGLoey8DAx/EMulF76bjpdWxouP6RcaqbmPVd715
         YyHVlW5O+avz8g/04PNNdAhdDsMNwLR1KvZhillG5145xTcdphIf1mpUsBG/JFeFcicU
         CMiA==
X-Forwarded-Encrypted: i=1; AFNElJ/N79re1D4Gh6FcpjP9pcyWZlNQkdl6oUb+GEI2xZHObafSlq106fEo5nSnxVbmXoi5fq2rz0xS8c/E4ORL@vger.kernel.org
X-Gm-Message-State: AOJu0YwzXgbi4wnD2ukhqbb/kSANLchuyjy4XlHFAAjcpJnMAmU/TP0X
	+hzHjHGxRJ11t6r13vT0QynhEHaMtkfs6dS9EGlHtpdsT9Bx/8RhErM6kJNs3sBBRXogcXN13ir
	EVutJjs0MCb5dnfppr4sIlD5BgqWuOnF+Kxy2ogTv+BfeTmEo+beE0aY=
X-Gm-Gg: AeBDietaSLQFrSCyKoZvQDOPDwHK9GsBPyfAI4X4cNaV2EIIScskpiPi+x/KSt3FEJJ
	xHXgqw1fr5Yeh5UdJYLwiwgGhPSlCNGstl4FAv+BBbs8qt7LYwzFVzaFyrbqfz/T55Dzzmrp2gN
	FIIdLzdBjrevh/LpXxECtmobl/SvNU4Lpjql5CztIe/sKIxJk6QQV7m50e9jw1Dtsmgp2oUBb8M
	QL5akcpSwk3X2uL614wifP/ZKAdit13AE/cVOQ12d2Efqkqzawy4TrnweQ7zhKBHfsW4+JdJIWp
	8R8kLHBo46fWNtHBWVUWEQgUWwkV16Mgs6Ld
X-Received: by 2002:a05:622a:5a8d:b0:50b:49b2:7bf with SMTP id
 d75a77b69052e-50dd5a8f9afmr202457341cf.12.1776073774915; Mon, 13 Apr 2026
 02:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ee4992b1-06ce-40f9-b554-bfcadd45cf97@I-love.SAKURA.ne.jp>
In-Reply-To: <ee4992b1-06ce-40f9-b554-bfcadd45cf97@I-love.SAKURA.ne.jp>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 13 Apr 2026 11:49:23 +0200
X-Gm-Features: AQROBzCituvTEJu0VaOFkuGurdag9wnZqN4FN-CpZjpG9Q9w9VDtfMxru7l5pRQ
Message-ID: <CAJfpegs+8pcuQFBNB_0TfDh2Fo3_13pcpVNNzRdR=eZ-tvx35A@mail.gmail.com>
Subject: Re: [linux-next] fuse: wrong usage of no_free_ptr() in cuse_channel_open()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 Apr 2026 at 09:05, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is failing to test linux-next kernels since next-20260403, for
> commit 288de43f7c73 ("fuse: change fud->fc to fud->chan") is causing
> "cat /dev/cuse" to trigger NULL pointer dereference problem.
>
> The problem is that fch is NULL as of calling fuse_dev_alloc_install(), for
> fuse_conn_init() uses no_free_ptr(fch) instead of plain fch; in other words,
> you are calling no_free_ptr() too early.

Thanks, fixed.

Miklos
