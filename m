Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9841C2EF
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198774; cv=pass; b=Csn+4qKAcJNXYbFAS/l8WQIsZPAz8zqWAU3MzvEwfDNdJNJZY8ffSxiEP13Qc21UxPFW3PDteLdAb2Eegq0ZHC1IHUjRbr3XY+sDgwOp02Ac0ajZlUGWr2I/y+HpP1PCqqnhxLU0EE/LYIQrxezez43dLsmWuLN/Xe2jgReyA4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198774; c=relaxed/simple;
	bh=5B+bH+DXqXDn3cGw1hPdVqrNtnhREmSz2LrL9KD0zIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6q9yB52NDTZhHThqGlsSX4pf7Gib+60VYDoCNjOi86t/4PLbwQsJb0n6s462RKeA1AB9srH+mptThz22ZHP36mNojWbELWmXOaJWx7o1ObwNMSrn0oTjZI7/GcdJmjvVYHiVnDU3o5NSUhdrxpD+qko17mTZtjYsZ6mVswq3Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oahDsLEo; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oahDsLEo"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68cec9f4c6cso149744a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 10:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781198764; cv=none;
        d=google.com; s=arc-20240605;
        b=SBvk4kCoHmdtNbTsoWpMctSvhTucAbnYCT5bkm2PFxzKWu3p58ToYx9/RlXT5fMgjB
         pNZQlFy3pjagvmXG8bL8Zi6TTL/yGpdmu0WOPf9AuVg/NKh1A5mx+XolKiyhq0eBrHMx
         mh9WJ9IklEznnn3GXaz9xTtw8RFi3/wTouvA6fbf714y2ehpWAb/HbPwnY9fvjl/e6qw
         fp8ymgBc4loxA6D8e/varmzeon0nyLO0QWyoJByWAwEyqFpEzvRlcml5K79eEFzwM+Bh
         m0Bzuc4LbeEyhX7jwtlf5NFeasPMaZ3Ph3xprl3goe6bOMnd7QsqkcTh5Z77LMbVKc5R
         26Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5B+bH+DXqXDn3cGw1hPdVqrNtnhREmSz2LrL9KD0zIc=;
        fh=CoxKu29wWQtK/wRN4fSk8Pu94SSKTJyDWtvz5ZQf830=;
        b=MIjt1mtK0ClZQdW3L1xlHpbemg+Nr5w8M1i/pA7+M9hWtmjbMJ8BGSAvGfk2asHKIZ
         093v/LWFt2deEcQ2W3NtUmToL6SzqYu5+cAaNrAJgDfxW0mqvCcnYoaNfPxknxPQPZA/
         LFN5y9pb2WaFBxGiR9ENRy+znsOV01oRbVRf3KTzqceVU+Gd/R09OgbxnegEhO3j2hCz
         cOPecCT85yvQ8aXSdm4YxlVGHV9V3s0RSb76Z0fHgQuLVNNfvAWZbGf+od0qfCbVhlJb
         fgn2D3gn2BN4g6V8e9cHPvnB0v2DC1Gw4lieCQaFC3lqm6BCvkIBhqFJqBKEM5ImQdvY
         bTFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781198764; x=1781803564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5B+bH+DXqXDn3cGw1hPdVqrNtnhREmSz2LrL9KD0zIc=;
        b=oahDsLEo6OU4MdXshXIZaaXP2eR2ShMCgNG/ulecc4ak9hIeC63SnHvTB5Jkn2D+pN
         nSzPZrntqOBdIj6yyT5lgqmiCVyPL1VXb6NOjSGeu+abeQsC8BRg4LJ4wfp/EsCyuxRS
         fFn3Ee8Ls2LDNbjYnAmmk17uB8uGlvK+7iM8gjYXsM4lo0CIFlBKtJrHjlwAoOFcJTIF
         +jh9VkHiRL1sipD5LvcblK+Tlmr89xYIrutlDu53M0StKgwRCKYRYdVQ5V0Heyk/sM2t
         5D2e+PBYs61sR3k7xPaQ5f5+AtV9B1Z9n5zQvA1VwuahdIz/sMt/HJVrN6iMN6J7TcBQ
         z6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198764; x=1781803564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5B+bH+DXqXDn3cGw1hPdVqrNtnhREmSz2LrL9KD0zIc=;
        b=d4lQ3F6WUCpm+9nUHEKepBUtXmxNqt4VEu4GtSXuN8ULmqCnue8cTTYLclXpXXJhLM
         4pLqS/qetdAyc1YmzawEziQfIfqIBTZkU3rmlvP64kmPMf8xqKk/5QLJUyCMyXLlRSs0
         EprhswHLvtku+cigP2tGGahjOIUTrHNI9eB/4tbknqN80O5+C8vcs2b4xz10l49dGmbi
         LXNf71noJPjcBm9QWzu3cmPtqmx0UVj1/QvQwDqe8yvBXRnspEl71Q1VI5Y2QqVXxaSd
         CxREvbf47UAqIQU8HxclfE55rgoBq5bpejK8ZpggYZhsFoRIKG80aVnALoMw5sU6cZgD
         Jiow==
X-Forwarded-Encrypted: i=1; AFNElJ9LFVXIO4v6GN/xpT1/7L/7+U8enNGkuB2KrB3/OFTeE0nvaFA4mkX5GLutZGUmFMIeydesf4rsb6CIdu14@vger.kernel.org
X-Gm-Message-State: AOJu0YzqMReseE3vd9On0+TtprRFSirnOwWIa/xD7bNju++guqqI39uA
	4mCPd8SOYDzfuW8Hi6JPtkSVHv0IyPbh1xKoHiAZvOu7Ub43zJYoxG/VQzG5237aDEpq7XFlgL4
	5ogiYdjhGtllDDLSkpVcm7CvAJGnBk98=
X-Gm-Gg: Acq92OF6ngLvfLGdurTcNqk7Wx7wnVztfdXe4iLzS9D/GJMmryUfxIUYKlsOdr4G470
	beX8sWVyqUXOkqPdPH9BXHOpA5WrwJD1WbUL2yGyfA83ZzoyRTLBnCGvV5Tieir06MsO7DAZOL+
	lqRLiPmtkFOyjb5sJq2D2vB0DqVikL2d1LthtB7iJc7Rzz9KJMzJuSukmTcu+43mbdZ9lNrvpy3
	caADFNsPUmmI/r2PBRmMPzZJs4BUEDmkzzia3uQzehTEwZCDji3IIoH2Lsv8w2X+djc4+f9cdb7
	bs9gplSmwRWXUrqqS0PsM858f/i1lZrZo3qg0ym8yw==
X-Received: by 2002:a05:6402:2b93:b0:691:ad29:ea20 with SMTP id
 4fb4d7f45d1cf-6930e2b71fcmr1948306a12.14.1781198764050; Thu, 11 Jun 2026
 10:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402104407.11495-1-liwang@kylinos.cn> <CAJfpegs8v6a9D1zWsNY7pX_Zx1wgjGvoEFS6hkk+qE2iDQptZw@mail.gmail.com>
In-Reply-To: <CAJfpegs8v6a9D1zWsNY7pX_Zx1wgjGvoEFS6hkk+qE2iDQptZw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 11 Jun 2026 13:25:50 -0400
X-Gm-Features: AVVi8Cd6zdOVZpbHEWQyWnBShqshMgnprxexMPewUECxtADluKfoRYeJ9YdUNLI
Message-ID: <CAJSP0QWURGD_XCaLCTfFPg84rCbDAHMecfzTpo6Nw3Jp_2gB_A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] virtiofs: hiprio FORGET robustness and no-reply
 request completion
To: German Maglione <gmaglione@redhat.com>
Cc: Li Wang <liwang@kylinos.cn>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 5:34=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 2 Apr 2026 at 12:45, Li Wang <liwang@kylinos.cn> wrote:
> >
> > This series fixes virtiofs completion for FUSE requests that do not use=
 a
> > reply descriptor, tightens hiprio FORGET handling when virtqueue submis=
sion
> > fails transiently, and prevents the hiprio worker from stalling when on=
e
> > FORGET must be dropped after an unrecoverable error.
>
> Can someone from the virtiofs team please review this?

German: Are you available to review this? I am can review patches as a
fallback but would prefer for you to handle them most of the time
since I haven't been actively involved in virtiofs for some time.

Thanks,
Stefan
