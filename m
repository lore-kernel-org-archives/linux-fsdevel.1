Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859B33B8406
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254752; cv=none; b=IyCIsYVbDppqnh505WIakHRAZLkkS8wSush3at691/K0kiymKFPEonmc1SFiz7diAwAuIV9NGnrKsqOOitzsv18EYddCAJVndmE8rTo5ecej1/Jb5oW92nhJdNRWkTLVuVED7FSws8epTZgWN//xNTFltYA9bart/CqZziWbe94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254752; c=relaxed/simple;
	bh=zchc0BWXlYCiUXRc0IqOWYx4Liiye49pGOJJr9AcmFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHdh50IpYVlBb2D4QOlxQS3w96z25Lb1Nb3LNplVsYd9Jq2cenYVjCooeujHF/9t0jPa65NnR8jdCGcyirwhWMCnkpwG8CZKbsfQZPugjCsFVrrco7ejZnWxdpn2FwHGTj1Y0hn4fn1EBSbn3p0ooveHdKsWTsPArxIzLVJcaJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dqGJIgcH; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dqGJIgcH"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso504490a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 12:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1787254749; x=1787859549; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BnJl/mrA8UVpCuL2G6auzEn+EpzbHrrWVwMbORUl06o=;
        b=dqGJIgcHK2RLT2U/TPXtCrZfeebWA5X65IXNzq8I+BVKkecDvkOMa1mbikFWGbvatH
         jipRq00SV4B7SSFJ3hu8n6OYBB7RtZXMQYrXL26pYpmjTF3DGLaxmvTDT2vgQVw3CUvE
         GJDmKVx1d4TywXi8vnLe8ndWvJuocp1dVZwdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787254749; x=1787859549;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BnJl/mrA8UVpCuL2G6auzEn+EpzbHrrWVwMbORUl06o=;
        b=EsztUhVOOxTQZqo2d4AV2DBUfen+K32EL6zIEdN8aZLAo05am3pMB/Uf7EuHKSzUzv
         ml2C1Er61nakoAoCx4JVdK6reI33268SF+v3nCAkv2xJnUhg1ZmMIyxdpXVhpbEZhfMS
         taieM4wEMKVlJaFZ06O+pHvnVER2t40coJAxKbSwMD+PgUaByTfFAHnapbXOwFawvT8J
         bNQfLqzlMdq1t9cuXBF5dsI1GZueK7rIb9uEAN85MR+loEFGOIlrESt7rVgOAzM0PEgB
         m08xm2OY1ezDNoC1f+iiCvX7bd06uf0RitaqfGd8tFPzNot//LyP4jrRkW0th4qZGUVi
         eHFg==
X-Gm-Message-State: AOJu0Yzjl2B/cvg5az990DEuk9vVlZ2pvstwlZm3aV0MqT7sCYifip2M
	we4+Jk9dRZUi1n1RVyheJBXCbHJUGBkw/brRI1Gl6YxMCYtDD8Hh1QKKEcDKpt7BXWTwzGzd6bv
	7Jb0yaCY=
X-Gm-Gg: AR+sD12Z7sD54AxEC/SfydG3arckUdK1nus6nVCsYAqjF9pUXymsM6VMh+vfnpyzJMB
	/A/Cvsb2ZDE5bDxG9aoCPuBEZK6LctswjV3wCwavNqiojEyhB/KSFjxVI05iYIEaLQnpoT7492C
	Cjd5OmGCpwQ897UEt2TSey5+F0SmwYKb6aaKQXojZUbt7NtwCO6Y/7qkMC7Cwds1QZkn9OSzRiv
	dBBAO4pVQX+dvrYbR0pVTxx+je8dng6wuYJ10K7zi0SK98Om0p1BvSc8ZtYmEKO1/MSE2cWuwA+
	CUmutGOUcN3x7qI0oJ79xH3TH5cr7Kh16s6H82Kwx2FIZWvig75p81qAAwdo4DHF/S4syGf3b2m
	pqiv5MWDNucLBbHskI4U0RJbV+qw9YpMTcoYWFruP8k+H3M8Mq4UxZDwppjlY83vvociFagm5lQ
	W16LR2wT8071cdSMyercPH42jNgp4VqveHl6PRzLO/MwVtOA0bI58BZtFOqbjRPJ3TvdPMZsDn0
	3Y5KZ1MrT0jOuoXu/0t6nJIJLm9DOQstr/dFQ==
X-Received: by 2002:a17:907:9812:b0:c20:fed2:898b with SMTP id a640c23a62f3a-c246b4b6c79mr67635266b.23.1787254748791;
        Thu, 20 Aug 2026 12:39:08 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591df448sm113384566b.43.2026.08.20.12.39.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 12:39:07 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso564121a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 12:39:07 -0700 (PDT)
X-Received: by 2002:a17:907:b04f:10b0:c21:450d:cd7e with SMTP id
 a640c23a62f3a-c246a61742fmr52303966b.9.1787254747516; Thu, 20 Aug 2026
 12:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOg9mST+o6j9A2txJFLtGB+a8eq8W1sZqFiJDM7b48_9jV5_LA@mail.gmail.com>
In-Reply-To: <CAOg9mST+o6j9A2txJFLtGB+a8eq8W1sZqFiJDM7b48_9jV5_LA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Aug 2026 12:38:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6RgT0UFe8PwP+P0Y=nnOCqWhyLRbt8KfiyxQ8RsFg7g@mail.gmail.com>
X-Gm-Features: AcwNN1U1wks5OixLQpxBU3N6ov8wEQLPLQEPzFA_dzLTkgIu7q7o95AUcMQo0_U
Message-ID: <CAHk-=wh6RgT0UFe8PwP+P0Y=nnOCqWhyLRbt8KfiyxQ8RsFg7g@mail.gmail.com>
Subject: Re: [GIT PULL] orangefs changes for 7.3
To: Mike Marshall <hubcap@omnibond.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, devel@lists.orangefs.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Aug 2026 at 09:09, Mike Marshall <hubcap@omnibond.com> wrote:
>
> Fixes:
> orangefs: fix double-free of trailer_buf
[..]

Same request as I had for the ntfs3 pull: please try to write a
summary that is useful as a commit message for people who don't know
the code and want some high-level "what changed" rather than just the
oneliner commit messages.

I've taken it, but that pull does not have a great merge message.

              Linus
