Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314DF285CB9
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774776668; cv=pass; b=jDhb3eUfFoq1f1i/1HtY6h3zErSiStkUIQ17omWFAhmaTkUd/JgdZRu8iKV/hVIb+MLrU/OQxb0gUavvyIiZxTkoMmD+kAVMSn5bZH1seqXTqypMPF0QGe1cTviqwAgolx9U08tOCRRQuXpFJDHcxTvJgUrAR9LAHKLqNp0T9Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774776668; c=relaxed/simple;
	bh=TNBMBfGJlNaiFl/rXCAibtVADrbjoAOSzphuoXQu4BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEfiAK9VEDznIr0G0J1XYNV5VrOAW+IhGZ/tlD1jMA8cXIRkWiurGMGAtIGn+LJ9iEqlBSxnL+SADBLmejkyP8BQwPKhoNAJk6y5h5MHCuh1tcLxgh8R9GD7FRWeNPnCkMsUaHa4qQ6aSqGZA7fEi87F9hvV5nqlQo2BxE+OIMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gkaxpgo9; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gkaxpgo9"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9910707d82so390216266b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 02:31:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774776665; cv=none;
        d=google.com; s=arc-20240605;
        b=bNVQEQDz1eQtr0TAzKf4vOfcQ7MBNlBR1x39puElaVc7K8Qr7dodWt/lLTiwfxSHnb
         VRZ8Becl6rwGE0PhU+vcpkmg8rZVscBFDdM3NnxqRv7j3rsjtLJSaTuOSm6Z0r+pmyw+
         zoMWdwp9IxmW6DzfB2MH7ruvw3kF/ODhJ9CO6m11I+Nzxh5zt/t02Gv2ZQ8uRAMzKS/U
         Ap3c6qvXe4IYZ1bYsQLjBvMoYydgElzFfQUshZKaroDj4lXKd/IlC4Q/4Rmn9lEwvAqd
         lMa6C08obIJVNPir0yqghcXPZLS694NG4NA3tsiiIwY+PMTTT5SRqfQMhNr+kTuXzprG
         mOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVUmKWILiSQiKsihXpJwE523TTZkCBN7KtwbYpicI5M=;
        fh=HjipCAtdikjyGu8JJg2diXKlOIZ3DuqYwwMYC8gOh0E=;
        b=UqL8QhR1K9wQYesyfmaiTtL+VQMGpvj7EBuqSy1mrlJASr1HdbYDadqR2PMYvYnBxq
         O5oylAnqZNUwgbksaUJtjbv0Vy0DAKm9AQ6MDHuIpQRERuGN4GapnPAFl8DSQEW9eBsO
         ns+Vuq9dHaCWwLyKMJEgcz9hl6DxA6aM0N8V9wvZbGpy3c1JkYv/rjinCPpyZ0B2jTgI
         U1OgohmgqKTtPDUE8L9Kxcn1otblCaZ35iFyUsxHLMQpyspjAPDUlFTbHifPyo6AZr5G
         SUxrXer06X0gEifUF9OKqh73D1yY8vyb7RDGEjh5JM4xX/heWMR/kCphBIF3RfmvYsKm
         4U/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774776665; x=1775381465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVUmKWILiSQiKsihXpJwE523TTZkCBN7KtwbYpicI5M=;
        b=Gkaxpgo9ehCPURtHlRoeIWcC8f1gcybLnj1NOfnZpE2btnil1MXyDg7d910RQUk8H3
         meRfHewXjgICd2prWsgGS13zYc7npwUlUwJWriw9kfkjFNtUwR55g4EryQERFUEQQ3tB
         aW4QYep/BWlo0oaID2Z+XcwIXRbOKg4QNvivgGIoeAw63Nja5LDbbplbuqlun82A3Mdo
         SA2OBp2WDZqvN7vMWKwixLdM5Dhjy7qkvRw6FhK/7SkgzhHY1Slm+i15/pXDShWJCwIl
         R8m2Y0VZzosJTNZ0Tj3A67VhY2we2xBe88225poBnmYOqQYIkpAswttCzNK6YRJUqv+j
         V1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774776665; x=1775381465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eVUmKWILiSQiKsihXpJwE523TTZkCBN7KtwbYpicI5M=;
        b=ftbwiDJJswY5ZKXkLOtXR2kpks7N2VmDNcKXQBRRPaVECsVgJ/93+0ERZN1C239KE+
         Rog+1wE6bI6DS3YwCio1h+HwQur3C09f0clWIGvqMh6bnXbXBSI4Vlpmrfs6jIDr2B9b
         70npfw0A2MGtdl8wjVUaRHlEf0UzPmQOk9pZYMtXshfX4k0ovfRWBUalODpn/4O/iNp9
         qMM+lDz/fXQRdm8qSYx4MHdusw69C0c01C6zjDG4sedjEoohldDzvAPBM5RhIRa3aY5h
         TIjan/I+SzZn1yiNe5lSyHwLOF0+qqqY1uZB+rf4qfQO6vzJsiPkH6AfpjgVxcd/Lhg/
         wumw==
X-Forwarded-Encrypted: i=1; AJvYcCVkEadi7e6IStqz5JniGidikD15B9LBdgWdJseP4PT7fpxarxnZa43X86NjQnw3wx+RqjIFuX9/VARPgZ5i@vger.kernel.org
X-Gm-Message-State: AOJu0YyJu77DSEVW5Tt0RLQXqQpmSsNf/mbMP08rNhz52h/4ilS3q7iR
	ZPrSwreYsgApqJcOvglFS2Z4lzzvJynHAvW8eJ+7nt7ylUfvbGPtNl5p8ueCkX5S2WAuhPUHtWe
	VIBDpx2s14iJXqo0VbFVuRSj1MIhmLJbiq8iy
X-Gm-Gg: ATEYQzw0RoJM+lmMOqWFB/apmAq7lH4zNqzgWCfBv5scQkepldSFpcuxewSxC8BWEi6
	M49jO+MohkdZAW+ws5lJQ7ZItohis4x/DFaSGv+hF+k9ZeRqVUDmCfQDKI02J5Nxqh5RFMGqKxb
	NYFI/XyV971xzuGiHJ8AOkhSWUNdU5HNsL+mPTikj6AfFPtS6pg7Yto1XYzvT9vcWROV7Dochy1
	N53fR/TO4aEXOYgaVyOEQV9Gjv/jOCnvi19ffsgbAjr6Zo3dfra2wUdrOyWF5UC7HmRHSETDcgw
	SJm+cgrf7mJfQFhu0C4fQO81X/ZlQM+fH5qiovTLZA==
X-Received: by 2002:a17:907:7b06:b0:b98:443:6f33 with SMTP id
 a640c23a62f3a-b9b509a1d23mr515627466b.51.1774776665317; Sun, 29 Mar 2026
 02:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329092658.90712-1-amir73il@gmail.com>
In-Reply-To: <20260329092658.90712-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 29 Mar 2026 11:30:54 +0200
X-Gm-Features: AQROBzC6OyJ4EpzvT3lMx9bk3nAPfyuKbn4lCBt69uK2moonOou_6g1OlzHplvY
Message-ID: <CAOQ4uxjjt1idAf9t+QSSGrtfo_TGF6qFD1-FY1JSaN7DzbtOWw@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs fixes for 7.0-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, 
	Chenglong Tang <chenglongtang@google.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 11:26=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> Hi Linus,
>
> Please pull overlayfs fixes for 7.0-rc6 to fix two regressions
> from v6.7 (minor impact) and from v6.12 (major performance impact).
>
> This branch has been sitting in linux-next for a couple of day and
> it has gone through the usual overlayfs test routines.
>
> The branch merges cleanly with master branch of the moment.
>
> Thanks,
> Amir.
>
> ----------------------------------------------------------------
> The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e=
3c:
>
>   Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fix=
es-7.0-rc6
>
> for you to fetch changes up to 1f6ee9be92f8df85a8c9a5a78c20fd39c0c21a95:
>
>   ovl: make fsync after metadata copy-up opt-in mount option (2026-03-27 =
12:48:10 +0100)
>
> ----------------------------------------------------------------
> overlayfs fixes for 7.0-rc6:
>
> - Fix regression in 'xino' feature detection.
>   I clumsily introduced this regression myself when working on another
>   subsystem (fsnotify).  Both the regression and the fix have almost
>   no visible impact on users except for some kmsg prints.
>
> - Fix to performance regression in v6.12.
>   This regression was reported by Google GOC developers.

Oops typo (should be Google COS)
You may want to fix this in your merge commit.

>   It is not uncommon these days for the year-old mature LTS to
>   get adopted by distros and get exposed to many new workloads.
>   We made a sub-smart move of making a behavior change in v6.12
>   which could impact performance, without making it opt-in.
>   Fixing this mistake retroactively, to be picked by LTS.
>
> ----------------------------------------------------------------
> Amir Goldstein (1):
>       ovl: fix wrong detection of 32bit inode numbers
>
> Fei Lv (1):
>       ovl: make fsync after metadata copy-up opt-in mount option
>
>  Documentation/filesystems/overlayfs.rst | 50 +++++++++++++++++++++++++++=
++++++
>  fs/overlayfs/copy_up.c                  |  6 ++--
>  fs/overlayfs/overlayfs.h                | 21 ++++++++++++++
>  fs/overlayfs/ovl_entry.h                |  7 +----
>  fs/overlayfs/params.c                   | 33 ++++++++++++++++++----
>  fs/overlayfs/super.c                    |  2 +-
>  fs/overlayfs/util.c                     |  5 +++-
>  7 files changed, 108 insertions(+), 16 deletions(-)
