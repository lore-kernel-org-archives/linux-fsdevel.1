Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2973F3264FF
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775803904; cv=pass; b=B0YtB0w0Wj4yscwOSr8ooDVlfMW/EonlPHw304HkQPvBnpFQQRncYWRXTNuhuXOaWoLLkddWvZwqkMn9nPL+TtGeJl0lb8/UEDaUrxtqnUHnzA3QwM7O5qBXbuf8VxiTaJXj/YWrc22to55iZv40BfJt8btG2KQ+tcq2fEEr3nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775803904; c=relaxed/simple;
	bh=S5ecvBhpda9ioV3CZUSK6c06l0wj2C9Zw3R8v4d6gvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Nlq1K+W+bhZAPX5pirMjz7nC1NrWv7tVnDn4VhzciAEbTWAU7ZUvCx/tIu0DolAy1cpkzyEl2pc2iYxi8EZu+WEkdlWdTlJHckv0KpJO+tcfqDsupm8hWzk2DfKENnAJkN1+gK7htgZIqtHcR7ZeoOPMN9mxCTcucynI7bIZesg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOmga7zm; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOmga7zm"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38de18126e7so18419621fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 23:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775803901; cv=none;
        d=google.com; s=arc-20240605;
        b=bnPTEsEz9dJx33FIMDhLnxAq8UAD1LHNLAgngzfbiYN9CDrg/0tox80UNdO3Y6CeE4
         L9U41scvPBPRdU7hLriZrbgHjhlKcc8GbTogF8iiE4zasIguhmfJFghQvp0UTqUgP107
         bda91+SHLUBtGgjxUPLECjIOKCChON4e8MDSVaJuWSm5eTdOa8LEu0XNOZ9ea2MBJ7wY
         uKLwkH3u/s/pwvKepA4v/MgcKpzmeqNEuHDY2UxkZVmYz2V7qhChWF5ohM/WQ3huHm1i
         X/ZmIYaG/iC1Sm+Bwf3fc7BDBlj1gG72ZLCxCzJjcz8jFPQUd2kjcIeB+csIPoWDcuhl
         3yBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S5ecvBhpda9ioV3CZUSK6c06l0wj2C9Zw3R8v4d6gvQ=;
        fh=ZHAJKCNgiNfLXnvALl6njZ9Lxe0O1lJoIuGH16Rqj1I=;
        b=MDdd01MCRMmJrUoLU7/jVTFGT97nZtyU3CEPR2xUYOjlPdmRzOwc7W+cvWutoQ+/8P
         2zvkacMGuND790CZ6jnLkcrTB8NSIc6PswmlovEzlQf2UJxQGw0OFNo/pF4SMPuoDRvI
         x8XgqstLjEVVoXDk66+JEfpFFb+5jBdsk+kciJ3c/EPW9SSl1Mpt1htJG0Bw7HYQNVM/
         CIg+hhokgL6GoRM1A+F6x/gpJ1Tz4SIseB7YP4jAMRbfrXRjLmnLyjTPfGeqcVn8arsi
         ZlpywTZG29UYdtNd33rc0DFZi46hG0pBpx5zxiTSEpeEw3Bko9Uv5UZLWTFo9S8gbz3D
         5YzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775803901; x=1776408701; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5ecvBhpda9ioV3CZUSK6c06l0wj2C9Zw3R8v4d6gvQ=;
        b=fOmga7zmQiGibSRMABPeprbkYW56YiDmJjqgIjSCt/huxpPy5JQ+k1hpohEvJL79Fd
         KQaZgPNQixDxcsPFhjnjBYgPeXKo2L51FxkCIw0HuTxxHZC7QRgQH+nrn4/31y2xr7V/
         kUEU4BBYNpXv/Qge95jAhk/IKqb6w05rI1EuwsQTdqoPBmzpjHhGaW8EqD/F3oNZr1e8
         Fb3cjcl1SYxj9SYyKHw6miCQXo3NehIKzlEOK70nzpeY6NQJvCy+G/1z/mXevqn6VGSv
         alBUU+Niq4UX43evxKhFSOsAxM98g0dt0elNGeZte5Cxuasknqs5goeSgO4saQc6inEM
         aSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775803901; x=1776408701;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S5ecvBhpda9ioV3CZUSK6c06l0wj2C9Zw3R8v4d6gvQ=;
        b=d8rFryh7JxzY27EidpbcPJC0ncJ1CKQzC5LmYcFa8gRMumZZ2fnTQNwqUJEbzLsBv4
         S4+xGe2se+sF5tnEkvgvDy2brB6qNBK/a9pAhBu6BVnceeQbr5lhsugaz8spVYPDDcDH
         nnjAYm9m06TnOJnmjdL5H4UWBuaNTLPwv/dqg77JzB6xnydnK5Kwgo0WIK2Litpq37k7
         vVqYKfKE9TiZLePyaFevTGkNDMFoNakDWRkgak7oCzCiDU6blCEYpctEbzRsBajXsROE
         RrFmjFJ9b/bMEShhOEsrRVb5I8s2UPzNADsgE96HQ2l7UibI4XpmV0KbxNm8U0FxV9DZ
         PIUg==
X-Forwarded-Encrypted: i=1; AJvYcCVJi/f4PuuR/1aHUbuE1oVWzsK1EkUUTemhw4ZSF54pY52NwMNlwic42jss6ZwTiE9A3ugQUyTFalv8yFlp@vger.kernel.org
X-Gm-Message-State: AOJu0YwNTrSk173g3nw0I08qiuGoKZSeil0uvc3m8NmQMsfQL3nI9dXa
	ae+pYhNg4lRsGDGuxHNUMRjbAJgwJ+PZg/uJ489fZ7yqJOKItDKNf7iGK6D9IVGGoFRkYnvDvbf
	NtuWfjzzI96GkPYs8PCnkwSV6z38cd1Y=
X-Gm-Gg: AeBDietTUQHnSk/16q+6FN3BZeKzGCGuXTAhnD0u6LSUIJ5ABXY5e/pxwkUHxwJsDKe
	9NRZV5TX3GwDMePk1ufkzw7T8OB0Lf8uWXiSEcj6/qZDISevgSxZ82msa4+4kwLnQlkVoWGUQbO
	8YW8qGGtUTIMwAuV/VRhaEHxyRZ/dC9DcaA14ekqYNjWZw9buiM2+TUnXCOI4inCYCLuk+3ZnzH
	OTroK7O3JSYJQvHOvgdCT354ad6JvRsiHIqGOfr8cxFWth8enotfI0g3JDvsjs/7YrPqYTz1yvv
	V//KBh0=
X-Received: by 2002:a2e:8a8d:0:b0:387:2df:f3ee with SMTP id
 38308e7fff4ca-38e4c02e493mr3910501fa.33.1775803900834; Thu, 09 Apr 2026
 23:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409103345.15044-1-komlomal@gmail.com> <d4xigmgectqbv5q5dxsrlunea3ynexa4ym4nuxy2rokrawsqu6@yfhzm3hl5nya>
 <adfDCpTH9n2lG63n@kernel.org> <CADtiZd0NF8=4YDs9YR6vKYK92SKYOFd0LR1R3w9ZNoZW4cy+jg@mail.gmail.com>
 <jjhjdtdg5o72rlff75hs5oqaqqshmn2m5vfgjuew76dmjd23le@nw3rb2zw52h3>
In-Reply-To: <jjhjdtdg5o72rlff75hs5oqaqqshmn2m5vfgjuew76dmjd23le@nw3rb2zw52h3>
From: "Denis M. Karpov" <komlomal@gmail.com>
Date: Fri, 10 Apr 2026 09:51:28 +0300
X-Gm-Features: AQROBzBbYnfPywRG3Yp0tRYc7KAWWajkBK8MVh_qYfBGHCI1-FaAx9kMSaKpQ04
Message-ID: <CADtiZd1gL6wFD7LYBrFLcgPRitYWe0PuSDMoXw-4THOwVoErxQ@mail.gmail.com>
Subject: Re: [PATCH v2] userfaultfd: allow registration of ranges below mmap_min_addr
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, "Denis M. Karpov" <komlomal@gmail.com>, 
	Mike Rapoport <rppt@kernel.org>, Pedro Falcato <pfalcato@suse.de>, harry@kernel.org, 
	akpm@linux-foundation.org, ljs@kernel.org, vbabka@kernel.org, 
	jannh@google.com, peterx@redhat.com, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	usama.arif@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Liam. Andrew has already picked up the patch and added the stable t=
ag.
I'll make sure to include it from the start next time.

On Thu, Apr 9, 2026 at 11:16=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Denis M. Karpov <komlomal@gmail.com> [260409 11:54]:
> > On Thu, Apr 9, 2026 at 6:17=E2=80=AFPM Mike Rapoport <rppt@kernel.org> =
wrote:
> > > On Thu, Apr 09, 2026 at 01:30:07PM +0100, Pedro Falcato wrote:
> > > > This looks relatively safe. However, I'm not sure if we want this i=
n stable.
> > > > This has been broken for 11 years now, with no complaints.
> > >
> > > I believe Denis has a new usecase that wasn't there for those 11 year=
s :)
> > >
> > > Denis, can you share more details about your usecase for us to better
> > > understand importance of backporting this to stable?
> > Hello Mike.
> > Actually, there is nothing new about the use case. We simply started us=
ing
> > UFFD instead of the classic mprotect approach in the binary translator =
to
> > track application writes. During development, we encountered this bug.
> > The translator cannot control where the translated application chooses
> > to map its
> > memory and if the app requires a low-address area, UFFD fails, whereas
> > mprotect would work just fine. I believe this is a genuine logic bug ra=
ther than
> > an improvement, and I would appreciate including the fix in stable.
>
> Then you should have cc'ed stable (with the tag too).
>
> I'm fine with it backported or not.
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>
