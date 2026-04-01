Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A69347DD5B
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069977; cv=pass; b=XCWbqf1HPYq2CPToHa3sqeT9dGrjs5IRVZZzFbmCUMUE8QWi5PxlblYU3lLfGifLWO4b/3BHRMMIPqv3jxHrp8ktox+z4c6ipc1aB2UW+B0ySf9RxAg9w4kJn4JfFl+xVZIWz4Qa9pAyIiUZLNC2yDVYxg52BzSJXMt/TMorUzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069977; c=relaxed/simple;
	bh=eWEBNrp3APQw+bPb3kytz6KmTGblRn0hfxL+2jHU2KY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncmQ8JD9BPlqrSSeVPAlSOV24CXCVdBMYSLt7rLFuY8h19TioOYWnSjwRezCaKiVGJWNiw/zhEx14/ZoH+jlG45C7HZq1T8WDBHK232lcyWfwVpAacCHtRfTo/zMbhC/ehFB9DQBcjxmmunvs/ZhsI958aTlsSS15OOHG9KbvWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXY50khj; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXY50khj"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66bd4f7b2d3so116538a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 11:59:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775069974; cv=none;
        d=google.com; s=arc-20240605;
        b=VpZxYtVaVVX/XHuqKI98I5+TmxIAwPhK/LyivnPZNg4cWUORL8CKMG2o5KB6oF7sk/
         84ilCocsLrR+ZqUZsKyYH1/chlYpWgpsD2ZCCQsdp6AYbAb7Tc0m395G0BedCm9AxDBm
         TPPcGLiWoeU9uv6sLvc+AVR0JvJohQE2ihD+dFDavTUD09i8qUTTKCBKgBDmRwgR6Tle
         1gM0kKcOVYzieqtkGTYzrV4etxntX+W5p7SlTRkgadtg53TrgKAIyAgiYYVhcuB8ggom
         2PRgEjBZhH5+eucF9mJVNrc4eQ5yV3XEVkSNsWXdvbNEglamizc3dtjbqjPmppTUf6mU
         T4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0i9YKqvf28dpGpqbXn02UAG5kadwAQZLMa9CVUhdlMs=;
        fh=AbYI9CLn8tI1auYewz2dR7vk253AilGGcEiwvAPQpFw=;
        b=UrW8JUh14Vm0+LtEE5NmHL3JIZR8sbYe3YGMpNjnR5/N5DDj9nVAvzBYVeJz+9rU/d
         iyv+y7oKaqV8TT40GMNj68YV6VosqN7X16fzQ0/5XCLEadp53dZujL3wf5T9r5X8/p29
         wSo8bQdkrYWNMxCf88Rb6wqqxsQLiaMU9Jni7Jc+rQtAHA1uZwTGIUklADiiA1/b3n9R
         lrU0jRN2xM9X9i/ssy2C/D2zwi+7SWwUCsqD1PwY54g01Ux3W+3D04r9v6OqVsXyKVNx
         Y/+PPcTcKtb2a0KHIYBQC4tB4ATK79ksl+EsMZVpCwi+qYVe3CG5qPeOMYe1okimjwIF
         vYcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775069974; x=1775674774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0i9YKqvf28dpGpqbXn02UAG5kadwAQZLMa9CVUhdlMs=;
        b=mXY50khj7wgYu5rKYkho3fLVSE6aecMVVuGCGbUTIjrqQ1ldLsNwSp8QzqZUDPrr63
         p68H84Tum33GX+pJwRCit3597E3gaGLZDdZyrh546d85tqURQJ+Uq3hv8Stb5E8Q0khH
         rGnkGchNyTV+/ZHLTxy+4FhCRP1PDstfvqC8mzbEdinznHRLbjUSTFdx7N4Vh7hzFtFE
         JJ9W6IlUEWtl6oeS70h/NVDg637ixyXZ9Ultu9Oe5YhXSPNLRlbJ597hcbFpYZQMdnQv
         gTIMGA/c8SS68XxYT+Z3IRza2YOTrStDS97YMNYcNUV1Es5ajhTo7vT0dLMTczqJEty5
         vA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775069974; x=1775674774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0i9YKqvf28dpGpqbXn02UAG5kadwAQZLMa9CVUhdlMs=;
        b=TiwGfxAxRflhcz5K7yrjuqe1PNuW9dgkVhO2jrcHNXTFXK6oGIyXbs+dktljNI75Ka
         F4CdU5Cq2LCXr3WawbcjFRChyvt3fWHVyW1Llnrm6Pa4YyjVq4Wfk4uOq2e1XCy5ojH8
         42AId2yLsTkl8cU5Cf2u8IUaFQRYp//asVFSRJozagG4CFMHv5dzr61GQPMKWlZCrcUb
         ApVHpFvvJp1Qq9V3UHMJrbnuI6kgP3CrgXq7UtxptaimoI8zJ0Icn+uhpqkLopIXpGnt
         0UAfF02F0Tq886TxDTT22R5ci+GJ1RUKgDpIGhVj71a+kQKo8qhsgER1i5XK1qU5loVn
         gUfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc0sI71oDoaNqlynFAeOuZI4P+YkjBWvYluUWVgY6Te2q4/yCygX3ECmDBrXIpkAfYT8eO4r/Zf6RluSS2@vger.kernel.org
X-Gm-Message-State: AOJu0YxNbUJbSMtwY72G03WV5ol42ZgzkAogCAV/gMxg1BtD01RtETOZ
	sGstRaPmtQMHN1VLBRPCOp9JrK0L3YB+SDd4zsbV2u1u99fDnJZlvNealnzNng6pdWVQrB4reRD
	Yarp4Jo2b92SNnIjWEDjX4YhR7mQDOeA=
X-Gm-Gg: ATEYQzx3iL5EzRE0upmDkZ1sYE8dTy16fYJkNLECIqtGwFyJQi9MtBXZbJ2yt3E75qA
	2yhL+vcHtA5W4LRMwB2mNVUyyB6nRHV33TvAje3Bs/522iqB39DuWqH7Sgf4CE+g4E6158+AB4c
	kBty3W/XoAyN90PBozezKb5ymjlnLBjoPm/b15bUPZY54rjrtrtU8yffS7YyBb9v+WgkUfz8jkN
	NXcu33DpyhQvOcb5yLhUBrEq76pLEBFiWMTIWG7ALSLr8BlJE4hWF047YBaZzBXWF+7gGpQZ8fT
	Zt8i4p3cPoVNPA2S7mTuUeh2zOxRJhgio54uXgg=
X-Received: by 2002:a05:6402:34d4:b0:66d:d25e:6588 with SMTP id
 4fb4d7f45d1cf-66dd25e65e0mr2119583a12.13.1775069974477; Wed, 01 Apr 2026
 11:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401131226.4011156-1-mjguzik@gmail.com> <ac1psq0rx_GOWyYi@home.goodmis.org>
 <CAGudoHEe6yYJX_qUsCk4EhWDQQuM_4c9resO5WRJ+yix-6=hPg@mail.gmail.com>
In-Reply-To: <CAGudoHEe6yYJX_qUsCk4EhWDQQuM_4c9resO5WRJ+yix-6=hPg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 1 Apr 2026 20:59:21 +0200
X-Gm-Features: AQROBzAtXRZ_CwFo5re774L0ZeHV8vzCeImo5_ZZnpTqnzZySVPVQvUhmy7njOI
Message-ID: <CAGudoHGattJEBvQNEdcFBEB-Vq1mOMbGSOH_uy4MSSy74aaQPg@mail.gmail.com>
Subject: Re: [PATCH 2/1] execve: only smart people should use vim
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 8:58=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Wed, Apr 1, 2026 at 8:53=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> >
> > From: Steven Rostedt <rostedt@goodmis.org>
> >
> > To keep people from getting stuck in vim and not knowing how to exit it=
.
> > Make running vim a bit more complex.
> >
> > They can go back and use emacs, of course that will fail too, but then
> > they have something to work on.
> >
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >  fs/exec.c                        | 11 +++++++++++
> >  include/uapi/asm-generic/errno.h |  1 +
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 2e954b31e3a2..ecb425388008 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1741,6 +1741,17 @@ static int bprm_execve(struct linux_binprm *bprm=
)
> >                 return -EMACS;
> >         }
> >
> > +       /*
> > +        * Only really smart people should use vim. If they can't figur=
e out
> > +        * how to circumvent this, then they have no right using it!
> > +        */
> > +       if (strstr(bprm->filename, "vim")) {
> > +               /*
> > +                * Learn to code!
> > +                */
> > +               return -NOTEMACS;
> > +       }
> > +
>
> I would consider extending this to nvim, otherwise looks good.

that's of course already covered, my bad!

>
> Reviewed-by: Mateusz Guzik <mjguzik@notobjecting.org>
>
> >         retval =3D prepare_bprm_creds(bprm);
> >         if (retval)
> >                 return retval;
> > diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generi=
c/errno.h
> > index 1a8fda40cd8a..4cc4ae653cec 100644
> > --- a/include/uapi/asm-generic/errno.h
> > +++ b/include/uapi/asm-generic/errno.h
> > @@ -123,5 +123,6 @@
> >  #define EHWPOISON      133     /* Memory page has hardware error */
> >
> >  #define EMACS          134     /* Editor too big */
> > +#define NOTEMACS       135     /* Editor used by smart people */
> >
> >  #endif
> > --
> > 2.51.0
> >
