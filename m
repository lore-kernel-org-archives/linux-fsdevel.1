Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BAA33A70F
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933431; cv=pass; b=D9q27ysh9dvMsrs4bDS4YvI3kjzngL3OmaIYgsC9I54DFXZEau6izMVpdOImWrCuJ33krPX2aTPT8wts6X/1AZX8Kf3txyzABSIP4PRjeI4oh4Bibp2juxgTsrvYeBYXZX6DOfB/fl3Qh1ugGfKmDn5FOefIO0sB3KDonLYprls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933431; c=relaxed/simple;
	bh=LNsO1uYwbZ4YYu1nCvJmCZN9gsNpZqr3IZ/OrlPN7h8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h58uOyco2I7a2tmA2BFMX7PJjIu4VF+k82xmqfPtMm9Y6hlX7TBR2as+9Osa47wUXCKSS20SeR8lRjKmsFqjH/Vk5TuiWDdS1l8OoekI0bUCtvfP5xaCqZB1SLceNvxbIOpFT0PgDF1Bx2c/dAMrzdaZvNZPjMaJ+V+fvBfGbpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kq3WrHD0; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kq3WrHD0"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68d22476e88so30008a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 08:43:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780933428; cv=none;
        d=google.com; s=arc-20240605;
        b=k5AtLmE2yuNtAdy+RLdrDOxlVPR6fodJUMJhmoIDEmAlo0NLLHpiHqwMj99BOeslQX
         7t1ujF267oJLzMQQGB8ZiSbsy1D3HZyT25++nDI2m+NwW/YUfdt0OYKFBdJneCX/aWYm
         QWY2J5YcaLGEdBSg+R7hJZbf8+C/oBD4YYKkhyTOzFODvMangSGJUc5ejcpQXuvctYfC
         EPE6L9PJiXG/1Z1tPMaNnzA4iFyxIgeLfpkXxSUVBWXPMh+cF/L/nUksBlQY8B/j2+EN
         sngYwCVRq5e8auEdAtW+4nSO2+23PP84Wnv3LHIaC3N8Fc0bsnWywQkRWNZ6PJnY9t2O
         PzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LNsO1uYwbZ4YYu1nCvJmCZN9gsNpZqr3IZ/OrlPN7h8=;
        fh=0o0Njse7hKFFqYNhc/Jp0aodrXa7Yb8c4Ci8pjOHwEA=;
        b=Mieoh4UkjwhFZ1UvMIG80zVSzuLQ3XsHbhEV4AiD16skPHOP4O+nAgMy8tCsT4ZROn
         fuIXWwRWK0+trYuzIU5BRz0vjNFW/oush8NjdAh2xLFq4RK+frB0A+xSf2dQPpl9qnf3
         KRG8vrAYlrEFTIamxUSRqTItgKzMATjK3sRReF7xO7sbmGgfsTgcz1MY/+h5fUP527JB
         zESqiAP34//muHODU+Eo3D3K+leAvG7SRhuq51uptB79ZIsC4qtxQBKaixI4hmyWmMix
         XLyxlnG//FRSb+hMlhhc00SdoFmd712MmS9qVhp3c+ksWAZ71S8ZkCF2/MEzOVML8S6G
         10nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780933428; x=1781538228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNsO1uYwbZ4YYu1nCvJmCZN9gsNpZqr3IZ/OrlPN7h8=;
        b=kq3WrHD01Iv0x4YP8tRxBkMowUx7oFDCR9UxJOuUXNqpcIYPuckEj7+y/OEja2OsuS
         OY6fk+oTFN9OYy62MWUD6MX8MDM4ThHAJmPnlWONh8lAbHUARDdWbJi6g/fgnWUiXcAh
         p/7M55/I4C5NaL4jt1wTGLjJimDqdDwEvUVSC47Kc9KfIzKEVlie5kpuuphCiDYUl2Fi
         evleeUAoEeD8ZZucPxlHZ2DmD8zJKZ0ZUkLNb7U6reiw4xQ4MWHsuZaM1NXW4/QvekUr
         Z7ZJU42oDwfLzJ3Fg5r5nJmiysLVP0cg4ZfGy1odxcyhhg0HKNjC7yuLr0aHDqy+rbEl
         JbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933428; x=1781538228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LNsO1uYwbZ4YYu1nCvJmCZN9gsNpZqr3IZ/OrlPN7h8=;
        b=Vd4RFYhY2hpXAS8rkGvQBTVYDhHlnOHj7w9FQxm0rLtvDFeieog8ply41Qygxxd3yO
         WA+/ZvblNpz2jmbsIEuAMA+LiMwq9FKCNwjUOIBWcEOcJNhvpmis71tSCVmIIizeiyk0
         PMjdW6nojKjpmLUyfWfDh1sz5Lt12VZ+9A03c3V+C2mYYGTGdgQJ45AfIM/Qjbad6YP/
         QtjbYze896VRKy19khpfMHB1mvYLSTFjRJQ5mLDW2chbFL4xMXtU2D0HSPF9LDws/nlC
         bcdrJrcx/DTxkcngp5/L+KFaz9eRAl10CfPcJ8Meeu3oTzQSKmrFoVdWxASVCVrCDQGp
         E4sA==
X-Forwarded-Encrypted: i=1; AFNElJ+1nI58a1h+Lzkzt/5o/pOoO35OvrUXos037EQpRZxRuNcAIRaL8TiXR9ZTn/Bz6nPrZ7JFwfHe8BQ1TMdc@vger.kernel.org
X-Gm-Message-State: AOJu0YxocXbgyPRVKeaZTmrTHcUpl1VNsXj5UrsfJCGlNalXY5ccAOmj
	PVJ2OvsmrOWM55eJVDxvQlVlJhPeCDYCxx+Ip43txIN+2nUWaecQPNoCVdx9eh3pBMAIW5PBdL4
	32/ZCkW4ksmslw9iuJSnEjCo5E3kcm42mNUWt3Dj/
X-Gm-Gg: Acq92OH2d9mM+WEgR5iTln+g9aJdfI/OcMSVQTtyJ2ips5rkNqkkiLYDLSAp0bmOdD5
	Qqs69/Oy75cCJmQTXZ5uwuoHEpqClGOklvD0lBdodXsLYhgtGvDQpV08NWxL61fMOt6lQPiUh+2
	m8HarywWJdverl4h1yNEL5jpaI4xdKjE+Kq65rANGqVt92q3SGtJK5TXmhgl8GHKokfC5VovrZN
	rcccxTSb/BazZSu8QwwYH/KnL4gW0ApCLCv7kZ9pHvOXdRrZKvfIPFKLmgSp017Em596zKp0Q53
	6xi+94f/VF9rPK0R
X-Received: by 2002:a05:6402:50f:b0:68f:d41d:ca60 with SMTP id
 4fb4d7f45d1cf-68fe9289b95mr168955a12.14.1780933427834; Mon, 08 Jun 2026
 08:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606015729.1837935-1-surenb@google.com> <20260606015729.1837935-2-surenb@google.com>
 <aiPWD6xZLg6g4DTO@lucifer> <CAJuCfpH74gRmgm2tgwB7SHzL9DrU3Yc4LyS8XLa0tR7fJqaw_A@mail.gmail.com>
 <aiZ5qFTc6XDMsqB9@lucifer>
In-Reply-To: <aiZ5qFTc6XDMsqB9@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 8 Jun 2026 08:43:33 -0700
X-Gm-Features: AVVi8CcIo-LdW6RRulcqTsqgvVlgvcZ5udrZhHCkpCEXNwWz6fYGFce0NkIqXT8
Message-ID: <CAJuCfpE_LnwyKKtbFGN4hz_VyRkVh_yf=kQEkUXHdSUwHMuF9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs/proc/task_mmu: read proc/pid/smaps_rollup under
 per-vma lock
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:14=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> wro=
te:
>
> On Sun, Jun 07, 2026 at 12:45:23PM -0700, Suren Baghdasaryan wrote:
> > On Sat, Jun 6, 2026 at 1:12=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org>=
 wrote:
> > >
> > > (Will review separately)
> > >
> > > Sorry to be a pain :) and I know it's a petty thing, but even for a 2=
 patch
> > > series it's easier to handle if sent with patches in-reply-to a cover
> > > letter :>) also makes it easier to track overall updates in cover let=
ter
> > > changelog.
> >
> > Yeah but the first patch is a simple cleanup of about 10 lines, and
> > writing a cover-letter for a single patch seemed excessive. Andrew
> > would have folded it in with this patch anyway, I think.
>
> Makes sense, sorry to nag but I want to be consistent in nagging everybod=
y
> the same :P no matter how well I know them or otherwise ;)
>
> I will take a look through the patches properly in a bit, I meant to
> actually do that on Sat but got distracted...!

Thanks!

>
> >
> >
> > >
> > > Thanks, Lorenzo
>
> Cheers, Lorenzo
