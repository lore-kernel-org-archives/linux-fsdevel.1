Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375393B4E8A
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957048; cv=pass; b=SnFEGiPYl3fqnIUPSrjZKrBgXDFF9KgU6OntlFnTsT2F4ECs/jZbkT+g9zAjJh4ZC6DD3GpQFDM+ybEPPooYxupggUsknqeBor23dTZjNe4aQF13JrQLqrUYtHCPgPKxI7bAPntjJQtPyF15Q55DmpUJ1hpc2/iMVcqzZCUxo7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957048; c=relaxed/simple;
	bh=pVSuzw/E7fveoiaa+h3iaBbysNiWwOpb+fg+OQxk6WA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIIzWZVSnmsjp8jqnI9430dR+V83vtBPHuhIzh0B3Ct66GYmsnUcrph81xKyJZ/2d7Alo7aA28rRfkdX0yUPbaRHrJZ0x8+2SDF6jhfP7EVG1G90m8w9P18HzI/Z8qXUnCUfj/gqvBKrdyjY/RU+JVMoorbx7nXDAo7CGG18Rrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p73LZUcz; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p73LZUcz"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66a851e62c6so5793354a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 04:37:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774957045; cv=none;
        d=google.com; s=arc-20240605;
        b=RZ8pfM48lbvSMQAeIXNWlq7tKx3FIEFQ2hQpDfkATw98+hi9PuwD2Z6ihobTVsUSIN
         ll8yL4PWT8PUrDSNnsGvEoexzTPne8hwE9t8wV6gKx3AoCYxemmXVOw+LGTJnm3HKBS8
         iRRuGjrffi/nytyxPtuYh3o/361PQsXhXI03YB8uqv0RlsXkLxFCDbjYG7t1qakcIWes
         p6nLT2IhvM3thQBsS8htspk9X7tCWIboV2KGAMUgt1n6V2uN5nhzxEjbpKSXlk1MgeQ8
         5lDJna+RMHdiVtkaftT3BeJRpFRc7NKIsUQPaWaGeH7vXIZTrs0l+D1BJwiG7wJ/alsZ
         RQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WxbBVSsNBgjfTq5tWvk/OiO1Ug9ualT5PG5lP8YG6Eg=;
        fh=cTczWqjg9xKnv2M7bv2zNsAhCJ3uIOpoKHvWpDiQmZU=;
        b=aw5x0QGaMW5PsId7AadjzRlOS35046fjbHL4diTl15WFC/GAZWGUJqxqB7vxhLba88
         qyZYh9leAwFvJtqD9GcB7FQrlV0DLAp+acLZQ7PUi7ZXsw532WM1CiDWe4U2eSfnmjb2
         QuoiAwvKlu2Yv/5MKBF2NM7UY/biBfexincYfAuF7J4rqGYIpqdH3k4fVWXgM2AD8LJ/
         ch/Wm3kQUk3j9jTmDqdLa+LDTOb9fdGrY/TErI+fx9VYRdvCiOSMXsFS46m3MKc7sZ1i
         myRHqzpz6FOL1jZl7fznGlUsQgWTnWmkZHzYKjEmIJjZkGqgx0qQQqYfr95reFNNqkM+
         dS5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774957045; x=1775561845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxbBVSsNBgjfTq5tWvk/OiO1Ug9ualT5PG5lP8YG6Eg=;
        b=p73LZUczxF0ZyKhVEp4SLOXsC/viqDu+qZtFV2w1bIR7nassXg20hk+R/DhVe+/J85
         8zRghG30Fxp86OixucYJlVR4StMbCs68qQYVtY6ADU17DNN7DQoEGMJsJ75sFnIm+Cvb
         iO4TBQ7DNqtx62BbAbpbfOYS7r4GyurTtPNut0JbCHv7gjr1+vhRxiqoOAZaZPZsrzy7
         PkaZ6HuAXnKNzVe43fdjhaxWXhqoAX9sqhlXE5qIezDP8+bm27mQ4AMQLThZSRmIcIR3
         8mhBvR2hrDiAR3NwDxg+uwSGK91utAmBVy1gpJW1DNAoGiQM/mIG0DJHKKvQT0l1dwYF
         jO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774957045; x=1775561845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WxbBVSsNBgjfTq5tWvk/OiO1Ug9ualT5PG5lP8YG6Eg=;
        b=GBSeBecslDq8OythMvkTasdLuK9HbJzHaR/tSwIYtSkD/mcneubTGvZos3fvjupM9E
         PhGwNoQkf72ONUucaWyalu6jtYncjE9asqdJBsxLjcCNRLsUIzFAw5U7Eu16s0Hj27g6
         M3zC6KG8Z38vvv06PRQZtsLd737R7ryrB8d3dgd5uZrdZqyS48vOU6uIp8dwig/gQt3D
         Z0f701mLpmM7utfGr7xZawRq0mxlPlcUanEfnpXa00MycWDm2pW2Ux7PBv1KwAfkRWQe
         yvdn9KpRvI6laydA+i6IQv9C44PZjY/miUmKyFcMTVxt1v4mAbThTXuZn/YkTmfLOGPi
         fvDg==
X-Forwarded-Encrypted: i=1; AJvYcCVBfblzySeNBJN8vaQP8l9rY24qIJNmSmKPYo1NICF+ntqW1OHAiqCScyjC3yqHiY0ssBSkeDIiU4mh9hkx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5wRkArHstqwFerXiwUt423wyWQH1Kk0bOQt4eXM6bhuDeDLDb
	BciJJexf86AhFMioAoIPeT/hHBVgyNqi/JEC3E7dG2ETMTBBJmK1y5a24/2R3C5DGdYOT94cZET
	iT3X06g3Z0nZpY0KJfyNjpviuj22M07I=
X-Gm-Gg: ATEYQzwNb7ZyaQVaokWENx5Yun1R8lsHAF6EtujjBXnQ784batDnBd6P1Xfm9PuNlig
	5AkWELHZmqUUKaBBihf2kKcB4Aj9TxduNCR42sx4tRP3Z5g+X+9isbuPq4N5GzbxEcRZwkgUr67
	iToiIdqhG1Mt3vm4oUraeNeGfg1AxqdlxgCQgN0MxfgRiMQpsB5W/ePAYyX9+aGK1bwxrwpf80X
	Fkvj4riqtt97H+fcPsvfoLLahPHB2CnAO8FkZGQTYFv/y8ege6Y8qudE4I24RFIYrDDIg0G0kxI
	4Jf36Efquzi2gOQGJ2eK/yPUD9cWKw6ORm/OGhg=
X-Received: by 2002:a05:6402:4617:b0:66a:6c0b:9398 with SMTP id
 4fb4d7f45d1cf-66b28a55473mr7658426a12.15.1774957045213; Tue, 31 Mar 2026
 04:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329172002.3557801-1-mjguzik@gmail.com> <20260329172002.3557801-6-mjguzik@gmail.com>
 <20260331-ellbogen-wegrand-e98370e446e3@brauner>
In-Reply-To: <20260331-ellbogen-wegrand-e98370e446e3@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 31 Mar 2026 13:37:13 +0200
X-Gm-Features: AQROBzD1rewFspOAOxCMLrC5I9Wb5YKo1eptDjjZIF6becf7BimcBQ5TkhbBm6w
Message-ID: <CAGudoHHZiBsMKs4c5TEfxyFJGSYk9fDU=ZjoGy+_Xo69xR9u8w@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] fs: handle hypothetical filesystems which use
 I_DONTCACHE and drop the lock in ->drop_inode
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 1:23=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sun, Mar 29, 2026 at 07:20:00PM +0200, Mateusz Guzik wrote:
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 0050eca6d83f..a417abc64822 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1935,20 +1935,29 @@ static void iput_final(struct inode *inode)
> >       else
> >               drop =3D inode_generic_drop(inode);
> >
> > -     if (!drop &&
> > -         !(inode_state_read(inode) & I_DONTCACHE) &&
> > -         (sb->s_flags & SB_ACTIVE)) {
> > +     /*
> > +      * XXXCRAP: there are ->drop_inode hooks playing nasty games rele=
asing the
>
> Let's make that a "Note:" and remove that "XXXCRAP", please. The "nasty
> games" is plenty meta commentary.
>

"FIXME"? Given that v4 is already out, perhaps you can do the honors? :)
