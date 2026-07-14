Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1395B42669A
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020788; cv=pass; b=UhvYFzBTkAggwwKVIBdU8ZXKJy56+d8ZViA1N6dsVJXRWsld4W9SKgA3winLOtlNht7VOfLq2xtrhkCgDO/dkCM0jBeSUmAGT/or+1cDZ47XAjmPBWb0y85mZsECkE0SAq3xH3larOMwNtogOlmr0bLljKhIzmR+2qbeU8rJE9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020788; c=relaxed/simple;
	bh=6PmlsKXE0MCYpvR9KItzVmj6YlhEjITKeeccrh9fVoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jI/Qopq+TqMaAhVwurhL6zYqLGhMC+A73TPx4ONB2EUl1lOC33sW6DoFuA3Wz6nAZSDrmegDUv5QJlgImGFF5LzQe9sNSJsvuJEgbSLLWOX7kVvrjbd4Yi3P/eEDFClSO+ALfWdNB1JeP+eMKY6rixbbdLyLXWr/hZUS3Zd+lqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RfGnb3jQ; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RfGnb3jQ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso471271a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 02:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784020786; cv=none;
        d=google.com; s=arc-20260327;
        b=eFf7KoGRE18Kriwlbvad50HvbTbIWLqhwQPMDrnkbv9mEGHCLyzhDgE0g2gkZVo4sr
         OSdj26jm3SVMDiMhBOrZpc89mFvivU/ApVTydvNkDrQJzS/ucLXfPRKqXVyoX/7q5CKV
         eV947MkfVsaYwnoivgg+6IzD0R+mi2UY8QWwm482lTyY5u0eFnvZmsXBRf7PcR/clKCZ
         lYN4qUQED1BzYYipvNoTfiuQXykHsrjUPWcCZ3bBrzPLZrwXbkQxUbvEOnHzJ1cJP8ne
         qfqrEe/emGaYvanM7fk5HSEsF6l99dnlRQy2+bTLp1erVGbuF9ooBUpWZ9LJQTGpx+ul
         9ctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EFy0XaWlzltQegmx5no3GwmXeQ/qKTYkF2N1LW+Ln+E=;
        fh=fYUK9ygD2b0TZA+dxZAB1sly+6fMKNMM4RYGobs5rIY=;
        b=nxK8k7DYMxj87+k51YA+p+lg3da3ejA41ROku3X7ojjSNctF1g5QBz9AQXIP6EZAvr
         DpAn9Nw8pnhgc2wZG7OeAGVaY8cBJMRftyheFeU3444mU6cnH7Gq6xNNe7otqt4fxy/R
         ks84qrX346dDlbsREmNYBMhueUW8ZE7e8BUmWYrhqgWLrQstuiml31USrqLg6jHdWip6
         2/7JP/NbUTNBfvU8iNgfiHGYNVhCZIOPSh+28san2h4v4k1JO1iJgZxrziHfSAvQy0Y1
         Xg1B8Tk0bUPmxySlz+NapQyx+63S/b8O75Q3uRX8W+JvH6lLzyaL3iqL+BaVsodnz/1O
         h6aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784020786; x=1784625586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EFy0XaWlzltQegmx5no3GwmXeQ/qKTYkF2N1LW+Ln+E=;
        b=RfGnb3jQs2u1C3Rtb3uOzdBmouoz4pns2w1G55aCDQotLeEnY1Rt1MJdxBPK79FHQZ
         Eq2gRudGFB0AG2geNG17s7f4LHFiwGrlfplzhc5NhZPy4hvnGXvaSvfbQ4L04imX/FF2
         xY3rea1ElAmxwYJu5mPgvsjpI2xUemPqOedhzfGhU5a7sBKYEHjvzAf0Jp5j0Vqn/HrL
         bhn3eaOQJEgl2vrtm7j5IG4rT4sK4WjscWoey7Dqc2krOdnkQ7uEQqFkqeby6bGFk/mF
         q7Kn1WiPXCjePlt8EnYpumUs7xV9daBxAP6XG8CrkBTEcEsVfgqWk5U9jActlKGHTUlF
         UfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784020786; x=1784625586;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EFy0XaWlzltQegmx5no3GwmXeQ/qKTYkF2N1LW+Ln+E=;
        b=n0d1pS78Mg6tCKySN7qz56QWtXscvGXqhVT266eLHEzIbTapvqYgodzh2lB7vjPqJD
         HemhXCxyyLVGeTi43njaWiU++mjxR6RO8lid+krLGoDBao3Iwu36KeH3fEvsI2zzeA7Q
         A6sy9U7yZdvBBI9bsi2Wd5Fx33TLDRidZ4SeLz0r3nu+gXCRtIkOnnrlefDBWqHJ4ziy
         QT7zQvY1sdDT9AxXEToKjbpX3cA0hnmuwvl0VwafY+1Oi/0gz6bBwEEeFVaAz02cMtLa
         1t58qGfv9BPA+9CyjxsOpAhXXTh9UaMl1UiQl1CkcYt6ivFwrPEQCAgPWl/6zRVfULvL
         vAfw==
X-Forwarded-Encrypted: i=1; AHgh+RrNddULhh2oJ17AgEZAJzr9+hOZO5a+gh6iVO9CRGpmI6TFkq4iOVcJQpJiUSwjauQfG3DbRZ3+HVo2WqRa@vger.kernel.org
X-Gm-Message-State: AOJu0YxwoU/vku2gMhDrPysJxxUsuV9WWhCZeQaNChiOwAjAOgo1eFi5
	QYlKYqw0Ji/5P7qTKXP0ZBuefZ2PB4IV2pNdw1TJntU3JpAw/z0PcBfedNKA9bqh3Kw4Ba6XF2C
	N6W6HdkSQOQLWBGopEz+8g2PYUKv+Oen1ut7yebxx
X-Gm-Gg: AfdE7clTtFLHpKD9pcuBZT4Jd3WFYJ0ZTR7xSzeWBkNGDG1pBZDQfmdTEVQa0+9frda
	dUDeYWFgHdflQpakz/f7enkXVeUGjW1DwwN2gOQSejGdoZN8tBkMxymw1xp6NRxSUzbH2Go8YXh
	OJy5DLNouynCnbl+pWHqOCdSjbH7qYaMBlwkg4A/NMjUmzL9syVJq/lBioTj8FcgpaUPjRjDCdc
	EE/8UtWh0sCXnnPGPpLeXtAFILk4WPJ5oJLYvgugNHxPYx1RF0hHHw3Cse2HNXllK/3b3QD0Xhl
	CIqvb7tfUAiD00V+krZoQBz2WhSb7dobgVnlGZawZ83AHOc0hbeeKPGCu9OggTRLgs5O8DTc9iA
	jr27+NIenhJs=
X-Received: by 2002:a05:6a21:3116:b0:3bf:ab4b:2d34 with SMTP id
 adf61e73a8af0-3c110ad50a7mr13080453637.53.1784020785828; Tue, 14 Jul 2026
 02:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712192958.1631672-1-jkoolstra@xs4all.nl> <20260712192958.1631672-2-jkoolstra@xs4all.nl>
In-Reply-To: <20260712192958.1631672-2-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Jul 2026 11:19:34 +0200
X-Gm-Features: AVVi8CdkdJq4l6QltZm6uQsqemNybzBK7YVO4LUopurosDpikg8UT-W_TW5bYlc
Message-ID: <CAAVpQUCD27YphUQ=aL3PyPtWwTo0tEtaFt-hvyoyCnepGAmYCQ@mail.gmail.com>
Subject: Re: [net-next v5 1/4] net: af_unix: enable custom setsockopt for all
 socket types
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2026 at 9:29=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> unix_setsockopt() and the SOCK_CUSTOM_SOCKOPT flag were only wired up
> for SOCK_STREAM (introduced along with the stream-only SO_INQ).
> Consequently custom AF_UNIX options are unreachable on SOCK_DGRAM and
> SOCK_SEQPACKET: those setsockopt() calls bypass unix_setsockopt() and
> fall through to the generic sock_setsockopt(), failing with
> -ENOPROTOOPT.
>
> Set SOCK_CUSTOM_SOCKOPT for every AF_UNIX socket type in unix_create(), a=
nd
> also for accepted sockets in unix_accept() (reachable for stream and
> seqpacket).
>
> This is a prerequisite for making SO_RIGHTS_NOTRUNC settable on all AF_UN=
IX
> socket types.
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  net/unix/af_unix.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index f7a9d55eee8a..3d256255085b 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -949,7 +949,7 @@ static int unix_setsockopt(struct socket *sock, int l=
evel, int optname,
>         switch (optname) {
>         case SO_INQ:
>                 if (sk->sk_type !=3D SOCK_STREAM)
> -                       return -EINVAL;
> +                       return -ENOPROTOOPT;
>
>                 if (val > 1 || val < 0)
>                         return -EINVAL;
> @@ -1005,6 +1005,7 @@ static const struct proto_ops unix_dgram_ops =3D {
>  #endif
>         .listen =3D       sock_no_listen,
>         .shutdown =3D     unix_shutdown,
> +       .setsockopt =3D   unix_setsockopt,
>         .sendmsg =3D      unix_dgram_sendmsg,
>         .read_skb =3D     unix_read_skb,
>         .recvmsg =3D      unix_dgram_recvmsg,
> @@ -1029,6 +1030,7 @@ static const struct proto_ops unix_seqpacket_ops =
=3D {
>  #endif
>         .listen =3D       unix_listen,
>         .shutdown =3D     unix_shutdown,
> +       .setsockopt =3D   unix_setsockopt,
>         .sendmsg =3D      unix_seqpacket_sendmsg,
>         .recvmsg =3D      unix_seqpacket_recvmsg,
>         .mmap =3D         sock_no_mmap,
> @@ -1142,9 +1144,10 @@ static int unix_create(struct net *net, struct soc=
ket *sock, int protocol,
>         if (protocol && protocol !=3D PF_UNIX)
>                 return -EPROTONOSUPPORT;
>
> +       set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);

Please move this to unix_create1(), then we don't need the chunk below.


> +
>         switch (sock->type) {
>         case SOCK_STREAM:
> -               set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
>                 sock->ops =3D &unix_stream_ops;
>                 break;
>                 /*
> @@ -1864,8 +1867,7 @@ static int unix_accept(struct socket *sock, struct =
socket *newsock,
>         skb_free_datagram(sk, skb);
>         wake_up_interruptible(&unix_sk(sk)->peer_wait);
>
> -       if (tsk->sk_type =3D=3D SOCK_STREAM)
> -               set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
> +       set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
>
>         /* attach accepted sock to socket */
>         unix_state_lock(tsk);
> --
> 2.55.0
>
