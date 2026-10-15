Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F752E266C
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075399; cv=pass; b=A+2lyb/+3YYvzSohPI7TcngkWA149h0TN4x/Gyms1Mc7lRhAst87A5noRZXaiKEN8kLIxHLzsOFcT7RJYnYI/sjGurOiflnq4KlfG0ZrTcyRYiNJGvmDjhCcCU3j2vICSI6pJBS8pyN/GkYpvYLsrzWJr37hY/HkPjCefoBA6Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075399; c=relaxed/simple;
	bh=eng6+0Md5D0FOkJtXhDsvOqd1+PGGpT33CAgmrVpnRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uP/0RwZ1vhNsjIigH0ulHYvqtNJ09ji4nLHVxFpyHbzJY8qPCByGzDaLBSzKG7D8GNtmXvpIxXdR/VMVNKhHNze/i9pvHHqQgVwgOZXGKrHUrKIfOSOOz/FH1yeSmh9Imefzd8howoEo8wcih6IpzS2EO/ubsGwEZ+QxsYj3BZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rsashCpt; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsashCpt"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c34bff61551so740820766b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792075397; cv=none;
        d=google.com; s=arc-20260327;
        b=RGGAW3v4zpyHAcPPnYCFx5mz3wGy6cL/EOqFRGct1pv4gA00y+dwblRCpR7HKcbVfg
         ukihBNrY5qFkNwkNogY2LJCsYbATV+/ElE0FlIX/RBxmdrsnQa2b1Fk2Jivc72fDnmKJ
         nEGdrVgjh0V2ObGKQ9SBzVS9M8HOOX3btnZeAGOoTMrNpKNzWDw2rHkJ1YV6NEMe3fUk
         pb43YLkby1XR6SoGfsBcXKvEz5gI4q2+FejfkGRA+hPOxNvCHFT3FghrxpUyhSYLls0T
         unfyF8D8+YXKnbjd82CirISep+1bKLLcNXEXyl1RgCLEh013uwdTDAKd+HJ0oc8CBGZv
         VI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eng6+0Md5D0FOkJtXhDsvOqd1+PGGpT33CAgmrVpnRU=;
        fh=lRi2ZakJwSUImRhRQE5nh+jx4f+fgnRXDqBu9hGd8SI=;
        b=UAEY6AW1kNckaHuHMFL9wE+NeI5PJ7LD39pZnbqJRop9LQQA9Ka3TXe9QDCgnQxEpk
         JDZ8CQCwgY9XhCYnhVJKTEy2U77Wg42UP5qHRu9NFHu6N4bsEziAXihQrTcgPBWEzxvC
         4L5LpflblHI76eu9vNeypZrJFHl93/oLmA8DR4K8EzuLqWM+eET5iM3PWVcLyYlse02l
         22scFnIgXp+QMGaTnv8YApKbjRLBOdnC21sFm6ou5OzQitxqW67jQHN923cqFURtH0ap
         ZxLZOyl1/36CLIJiSDJD1NnbU0/xylJypWfDWfjYLhcoldHgmvg6NWSIPVav1cdjV2Uo
         sg6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792075397; x=1792680197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eng6+0Md5D0FOkJtXhDsvOqd1+PGGpT33CAgmrVpnRU=;
        b=rsashCptm8spvtoeAq7T1AXWG/LCNnzt4F7ALhQ1SjVRH1QxDDLPcAwOm3CUIzNVNz
         vg7kaFwhKhFQNAnNzT408TtheCqOF09ho8rxdEXtkHIa0uq7Sx04eNExukOdkL7kL5Pa
         hRa0Y2XUg/P3z/U0Fd279GKuZ7ffmLtANSDlq02+HiW/uU3WxGEx3Q716EO4JeuiVQ7a
         7Df6jM/cbOxDQnUMn5tCc+BnMDikK5AkG15jVi4eJiIYMO2yGs6pPBHYFqwj0SLhSy/2
         u+5lHXZ8jHXpzhW8rg3AA614uLX8I5lyojnk1POEq00OPRdF3YKmEvBcAz5yHUjk8yES
         XUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075397; x=1792680197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eng6+0Md5D0FOkJtXhDsvOqd1+PGGpT33CAgmrVpnRU=;
        b=zMeddYoroXKq/cU96l7agdgM3v4/EPTGcEBCH/HvO7V4Nia6HFLT2CHOoSDqqaTcTV
         k/odBY12exu497FQANG0TcrHu6fDqKHZY3xEzZbFKlnv6mdBMz4pw4ObdRLdLYor4jz0
         p33v7WT50cYR2ngWHt1FUcRpBbZNHh7kizkTuOtR+nVhlPCRjWMymUwfCG4Gt3FNYu0l
         Clim5vD73xm+81d2H9FZgzLXrmSwIVTrn8FmfJYKORXtMxUCIprECTRVRykhbbs/wMe2
         q1F8l1mrmmBBFaRbQd6iPvAt0mmYSmvwaoU9HfsmHlxxkaOGBgApblPUBowl/354RCq4
         eoSg==
X-Forwarded-Encrypted: i=1; AKwUvByAXzn0a907BSoccEJq1Lot0+Rl+cRp55TZDd0gySMTKoDIxRz0Pw+WVqe4GMXPHPKNvuRpbQ+17t7oi/0S@vger.kernel.org
X-Gm-Message-State: AFq9FYIZi4xRmdpP2Y5wfW0WDZSXAnSMo1UQIETDKNEU0ayoyEkMR0eq
	d718TmizZN8UtMG1LW8syv8MmnUihccVTMvG8fBm41BHpNwx2HtJ3oGVC9STALncTlTEpmpISSI
	xLPP4l6h1X8DuV8vSOcAt/nHM2NB/xZxoh8j2UNU=
X-Gm-Gg: AYBFou0sbHKKIi/dx7kAeybLAybWUOXIr7yrhPWgeONIEo/5hDJ22aSF3M/B1Z2wThk
	ragZeP7cYdZhb0flwNQZiYiYX3/PT3rRCJ+aJhlHIznTqel+C3OMSZ1C3sq78s/l94yK895UoZ8
	xIKqBZgqxf7CsrGadXxALMyfgAIDWn14WV3V3leU0y0Zhs9yVEDb/gV/WqTY8YjD/DHtA2keVTf
	M4zyPqDiFu31c9p36eljMkG6m8NGjJlvJb36fiXPi99zjp0N2S1Llor3ozeAFSKgID7mzoyHmlT
	RD+nqFMoLgvKJcErZ1nCL5SucoLLjcQnS9LDYZuHr2t3MQy4a60laZ6AzYR0UWkqFxY=
X-Received: by 2002:a17:907:9720:b0:c2d:f050:ad4a with SMTP id
 a640c23a62f3a-c31a9a33cb3mr1713751566b.5.1792075396612; Thu, 15 Oct 2026
 07:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424170503.2096847-1-amir73il@gmail.com> <20260424170503.2096847-8-amir73il@gmail.com>
 <ulal5iiolonkeccun5lyzkuf73odidgbkmabzupbwtawwjhhlz@tneaqqtlody6>
 <CAOQ4uxjO+Q_Z0OF4XquO7o4GVF2b3akRDrLYadtUNpZzi8nEsQ@mail.gmail.com>
 <cz26vtfw5xq3hi7lv6guec75untdqrtqx5violro7ymefxduqy@ajieh3qai7xr>
 <CAOQ4uxi93n7beP20Lt865hGotZA-=2Kvuc=rMA+H+gwbQaWOAg@mail.gmail.com>
 <u4wnn46chae6helb5yuqw2eqjxux6plmyffxilisxnuiuyhyyh@mq7rahg3g5fq>
 <CAOQ4uxi4x+K7LNS07Z9raB6u5toYUXap22UFNDnz-yw9mRC7QA@mail.gmail.com> <qhtr7zgiqo5wjfd3mrnnezmoeeqsvtax7526mrowzaufe3uvem@ijxhtvopilul>
In-Reply-To: <qhtr7zgiqo5wjfd3mrnnezmoeeqsvtax7526mrowzaufe3uvem@ijxhtvopilul>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Oct 2026 16:43:05 +0200
X-Gm-Features: AclHuK-OK2-WyebNxKwJtQPrVS5k_DEgSyp9RPegtKZ5pdARvPczfL67oIvh6l8
Message-ID: <CAOQ4uxhWoDBbOMf3_CpWsB=--tx=Phd8g-RPP8_C_bKU5YG+9A@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] fanotify: gate fs events checks in
 fanotify_mark() by group type
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 2:25=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 12-10-26 11:19:59, Amir Goldstein wrote:
> > > > Anyway, with no end users to nag me and summer vacation getting clo=
se
> > > > it may take me some time to post v3, so if you think of any new ide=
as
> > > > there is still time to bring them up.
> > >
> > > Sure :) Thanks for working on this!
> >
> > I pushed the tested poc to github [1] so you can take a look when you h=
ave time.
> > I will post the patches for proper review, but first I wanted to know
> > if you are fine
> > with the semantics I came up with.
>
> I've glanced through the series in github and it looks good to me. I didn=
't
> find any problem with the design. So feel free to post it :).

Ok posted.

Btw, I fixed the ULL uapi constants in fanotify.h, but forgot to fix
patch "[13/14] selftests/fanotify: update the uapi tools header copy"
which still carries the old UL constants before posting.

This is fixed now on my github branch.

Thanks,
Amir.
