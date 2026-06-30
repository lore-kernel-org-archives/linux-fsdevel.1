Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AA046AF06
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836349; cv=pass; b=k77K5SU75C4q1zCKMrETrTcHCVk8Xv5woGrOy36Ng4HhFSY/uItBg61ITiJbwZdmQ46XT4571CYqYDKOSVrc6GYIYUK/t3O3zqpTP9GRBz+7DWvhLpMyNdzETuBKeqRMZJ81+eFwnSJ1uV8T5Yx824uvbUn0z/TEsh7o+LFT3uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836349; c=relaxed/simple;
	bh=f/+MyDfnaeuI7CogaxN3dIMBY5/0RM7R9hdpQjkqoaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBHii226PfvLpE2B/t4ju0+3Gbv0y741rXCAeBscsF/Wb70w809UzRnCuUAZI3Ousn/KCJJnEJnQ+og2dP4gsNEV3uH1+Elber05ylrH3CHhfZiw4W9BKp3xdgr2t+beoM50gUb6iK/qoTgCT9+vvNZS9a65rops0jDMp1y5Kr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdH3oFZa; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdH3oFZa"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-139a5f4ca15so5747789c88.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 09:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782836347; cv=none;
        d=google.com; s=arc-20260327;
        b=hMDb12ch+SKALDeGI9cp/DVsI5Ks4LIBIX/+tfph82ljMhDN1LMJFUmhofYmqVuw91
         /bisQaS3t3HNTCT+0o9YBhhVw7ox2IiywjWoPN5U0y9Qjo4C7TEWy3tvHqKlQEkVy/5+
         civJHKuBWLDKMIVX7BrTqxskN9pQrzbEUxbWceJTSuyTVeRXy07d++iLhDZseI9cPVp2
         pJ447dwAWY3vu/1gm/GYzE/QamKRSyXDdVY42h7gqLYjuEXUyBoprLjyK2aJXNaIH2lv
         YNJpq3y9K4xOjCi5wAQQY9jK8tgcT8ThFEujzll2FPyHGOv/FdjfT2woZyw/16AmDhYE
         h0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FmnZQ0z2vLXoLibFoyOKx5KfiNn7WrdOlM9j302Dwv0=;
        fh=J3i+vzqijYHZ/UOwj8DCT2aKiEqq4woUUIH3Qc9OQNA=;
        b=JVRqZA10Ee9PTNVcHjw/W5NDxX57Bak/8yV3mP1z7HKdp7Z0qXTeCiU6qQ4891FtRg
         av/RVJRnWn0430xtlB4arhIWHjvmjSYu8Zh6ENO3K7XxXd30QyA0FIYGbjhhcBuog788
         rqN14klEWDk0tacj3oX6cYkTJ6USYFunntUPevaMv2eaTVccRe+OtXzm4s0WphzQvvsQ
         irAlpybO5T3YIshko9ww+wXsRBLcScUYiOrby8EdREBQgGFYC3mpOrofSvCJ5Ju+ObxG
         VasVS3Bv3tD2tYp4UmCLURiRbmKNXYyL1zJi3j7NuL/Da9g8oJx9FuBq0bii+1090c+q
         zcdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782836347; x=1783441147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmnZQ0z2vLXoLibFoyOKx5KfiNn7WrdOlM9j302Dwv0=;
        b=hdH3oFZadb5aVCZDHspdVB+floXDVazdlU/UzwLYjKTeMiOnvmRlgz43APilz52RQ6
         eS77Y7kcZRwS8MX5qTPLHEb+gMFiORfx+zfEKWghJlQ+Jxl3kQkQYMlWV8igxGJBcu6j
         Qzd6OU3lUrVB9PbyvALD6notCzMNaZKuFKCjtVqwunhRf6IkhT16PeF2gUXjdHHd+lKY
         DG2IGpjQ595fdmV7KyRajXJy82GVA1skoxOOl6kqjmdvw/8nyr+iMshVpuKGKV4j3NNJ
         7S0qZEROoHwVCA8vLi6YEGo3X5XLjXtz2DukymP7NE1IYXepfA6NjLjPgCiUTfUJIlyp
         tTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782836347; x=1783441147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FmnZQ0z2vLXoLibFoyOKx5KfiNn7WrdOlM9j302Dwv0=;
        b=KjHTEEaoUsJVYkoFNkpG/ZbcYJI6hNF0BcVHG7ot/I6R8GWfHWgVY9hH/F9wWzlv8q
         Kp47tSJhFRJi8G9zXqATqLhPT7TH6ofFABpsCh405Pf0U/45uGWr6MQOoXrsDOj+lArS
         2oWKg+mnY3yn0VrtfUNWz0/hq+As5uZSjaKPOdvPQdHMd4cDtV7k93+YhfL6ZamCRuC+
         6T98hRZUhAmSdmfAoANr6Cq706ttcbtLnf/iT99UuiM2yjfqKW7rhcEODhQC7i3R1FR5
         k3nODBE7FuhaOsErJkooSAPipnRyQgNUotMSMckch8bgvD21MdK4RyeWVMSEPDfDQtBK
         qE3A==
X-Forwarded-Encrypted: i=1; AFNElJ8cZ0Ah1OX02+fq4suI3+jf7/RMWMz4xER29+8tJIiTWirhS+ebDE4gLLnyig/saWN6ktNmpAXQyg/82jH0@vger.kernel.org
X-Gm-Message-State: AOJu0YzJGiLrYALEvdHag87cFcw4FjigqRWSdfPAFR6tnvaG0MoZBchK
	qUI+d6klzcPO6abGUYLwNPTNuprJ5+XC+tCgM51xTVNfWdceBoDcEbedEeNsJhQpjhGzzJeqakp
	qQdA+cfusS0MWx0Hi5lP+Yi/vPShnPRN6dwiz1dTV
X-Gm-Gg: AfdE7clFZDLBbTjqiOFsQIKEMKfHnDcDupoecEa22wvtczW6sNKKHEB487oNy65jxeX
	54c45rJN2aceOXKLl8idmwsY61sKPYUdxhGr1Z2qs63uVsDuDrOYF7hwvzMdaG66OAZ45+iNAoe
	SPKTAY1aAbHLzrDJo2MQLINN3Za3LI+WN30uqEFfrd/n9DB62DKDBQw2HXw/RGB8+fOne9PpU5K
	Yab1Nw51cwzM1luHF0jArVT13INR8ExPjiJo8OMKVvXdqKnxuidbCsK2YX8o4ppXL3vSRMqPbXV
	xfus5nB4hdVyw751RZ+5sw7RYeWSz9WgxwrtcgXr3sLVxOP9+zYEDhoy8xVFSe+1ClxTfzAegXj
	Fjmk9wVxsan09srxxR8ahMRmPdF8rmMdTO1n5iQ==
X-Received: by 2002:a05:7022:4595:b0:139:ed59:4b86 with SMTP id
 a92af1059eb24-13b2a1bf1bbmr2364497c88.42.1782836346356; Tue, 30 Jun 2026
 09:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl> <20260629194327.2270798-5-jkoolstra@xs4all.nl>
In-Reply-To: <20260629194327.2270798-5-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 30 Jun 2026 09:18:55 -0700
X-Gm-Features: AVVi8CfwyMBPNQ0tPm3h1L9ozwd_nr1YcpkmcBZ_aBP6o8OPTJkBnWkD5vIy6-A
Message-ID: <CAAVpQUBFFzVvsdJ+JytvUukRinN29+J0uZQKZbxLy01m7VeeKg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/5] net: af_unix: replace copy_from_sockptr()
 with copy_safe_from_sockptr()
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 12:42=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl=
> wrote:
>
> Replace deprecated call to copy_from_sockptr() with
> copy_safe_from_sockptr().
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  net/unix/af_unix.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 83274ce18e06..07a0b07cd65f 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -933,6 +933,7 @@ static int unix_setsockopt(struct socket *sock, int l=
evel, int optname,
>  {
>         struct unix_sock *u =3D unix_sk(sock->sk);
>         struct sock *sk =3D sock->sk;
> +       int error;
>         int val;
>
>         if (level !=3D SOL_SOCKET)
> @@ -941,11 +942,9 @@ static int unix_setsockopt(struct socket *sock, int =
level, int optname,
>         if (!unix_custom_sockopt(optname))
>                 return sock_setsockopt(sock, level, optname, optval, optl=
en);
>
> -       if (optlen !=3D sizeof(int))
> -               return -EINVAL;
> -
> -       if (copy_from_sockptr(&val, optval, sizeof(val)))
> -               return -EFAULT;
> +       error =3D copy_safe_from_sockptr(&val, sizeof(val), optval, optle=
n);

Currently, only int is allowed, but this change unnecessarily loosens
the validation.

Please keep copy_from_sockptr() as is.


> +       if (error)
> +               return error;
>
>         switch (optname) {
>         case SO_INQ:
> --
> 2.54.0
>
