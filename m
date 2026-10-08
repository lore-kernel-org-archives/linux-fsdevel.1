Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B0F37C931
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2026 04:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791434225; cv=pass; b=LANpHenRf1Z/yWTxecxOSSTgeezXVDjJmo8AgEkz4oqbYOETxDZ7556T9/g82xInK9Avf5HrBSVK9nTcia3rE//XDw5FQF6WdZmdY2Lp85g+scOUfe0MnILP4cU9XoZQxwXgOA4tyvEOmLYkTCU6A8wM+bAFIgEvQLXQbBKDebw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791434225; c=relaxed/simple;
	bh=783mXuBfH4W513hCsDEM5WtuPocb/VIE+cmR8680wxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLD9azSj/Ep1x20TawliTf5V0MDpmhdzqXU1J0rSixJaXfPHY/55l+GsAynhsvqNSKVz+HxPpKIXUMthI879GyiMd/fMGHgiMX1sO4jojuqYTF71yf7M3gMTU5ld8MIxuzriQTuB+YXfbwuBAMFpFN4g4KcXIQpuNHAU7jSM6I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SPNHWIx7; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SPNHWIx7"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15ea896ddc8so3836349c88.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Oct 2026 21:37:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791434223; cv=none;
        d=google.com; s=arc-20260327;
        b=IcepmSTxwqyIzUd5kOJJQRwYql4dyYy9dKGC2LrsOWXQTqixtpCG5Weo0y5DbjpMIa
         qxldy6yJfOHhTsPDAgcLAXFD3xr/NJjuaJRwDO4nVBjX4eUQ3+F1dP3o2ZaYaVo62a1n
         7X+sNe8S7NqxRxx6jy/Rls3k74knYQZEWVY/4Da3MCTBbfM/syTPHLIdPyNqOPDuDuhb
         TQJHUC4PgUTTBh38/ruT+YM/n+AOdijuZAJClkpYPPzw5g41kGghoGQ762w7kqtL4zs8
         I6M9Yk9XeYvBAhh5vfEHzyYD4VhskVYiV6KxYeNM3iiEDIv11U6qW5Jw5X0gbPNjJCXj
         NHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=783mXuBfH4W513hCsDEM5WtuPocb/VIE+cmR8680wxc=;
        fh=eJ+mMzvs2Ig79xXPiEhxsFftuEwUo9SDGZk55HW3TW0=;
        b=IYCL9iSQwT110pM4YpOIriYlU9qQkEGT1WvRX5/mja1x/9zED/+Pnspwf64tt7MFYO
         FrAPLLHmQHCeHqpkw3PO2s4c5bD6XoxOVuO3O4Lx2Fd4A633HFEC9sktYFjqysFN6N0o
         QFVaUSPR+xehhW8UspaUBIMNtpfxSZYbtlGfdd7ewK6I5W6XJ4GZ6BqnNt5+TYXiI7I+
         E4/s6H1msljTliik6CBbc2dQmRPDiTm8i4wAGYckovh5t1fX/rgWiUxpd+deyh59QaRn
         SFS9EvZSMLNaXqHQ5UfFP253C63kjQ4DtibCmr08AylbqU72678fsMfz/MIpHxHzhl3D
         5sbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791434223; x=1792039023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=783mXuBfH4W513hCsDEM5WtuPocb/VIE+cmR8680wxc=;
        b=SPNHWIx7FQj19D8wuK40Tq4Q+G9QIh7aWlUTR2g4mDgs1sHpGGTWzs19iAjsoBK2sb
         6O7We4dl1Oe6TlOcn70TCRSmzvqz2n42dAK2KrSaFYJBtjNaU+LSNG0mwGY4o2wgiAeg
         fD5DkjDej06c3CAgq06jaG5jwsiGqsnW2HzZbq8eHcVMwG4q4gaLq75wFXPCCm2GFCHZ
         OfxqVL30VYDIE30vNgYuSwtOCpMZD6gxLIc4DeTdI0C5vA7FkUszACDbD1f2aYe6WGFy
         MIGe90DJwUKQuDzt65pOvBFdbnnVfgKHMxJwhzcMqUVVvXG00O8myvPb20QEJ5x8OvSw
         oaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791434223; x=1792039023;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=783mXuBfH4W513hCsDEM5WtuPocb/VIE+cmR8680wxc=;
        b=NA4AmnQ6rq4UsVevVPisfOQumDGxFHtPULbUEL77Fs6eL4djpAxO3ktd/JDn/x3OFN
         jk0+reCD1b5JAtdJ5j9HQ+7ET2SEZaySTRaB07HfbyGNpIOX5CFtJuCTG63nyhW7zAEj
         3mO8lZ0CBzMsEXtJHli49x9fXwj+zzr6gq0YGUge98R6AMJQcg5ilMcGqbdNb34Nj1Ku
         QVFy1bStuMAC9Vx9Nvp2tpw75yvW9AE3BcyGK2XXQnHkVBKPL4e1M275FJtLEcX6gu3v
         UC3zDLzIyWkbKCarU1omNW1p898kYHM9cRspnkh6wcO8+3hcLFX3QKA/L2/FIQKuxnJS
         TMMA==
X-Forwarded-Encrypted: i=1; AKwUvBxQkIL+tzpIQX7CpHLRvIlX/PMeosf1ojtr5F92k3PmWg/oVn7JdvcoJVlXi0CokTs4ltHpPx+qtzxDe2YT@vger.kernel.org
X-Gm-Message-State: AFuF++mPJn1Zql/DZIRC0XqGVhmRKzpK0GeKjEaYthhYnLGfHi2N0r49
	RUvU1K+rjQ1JSr0bIQY/tTe3RhbHAbvZ+qUrY0v84A+ant+dcbMt4NEEpsaoafD3zV+Tg9m7Ceb
	UsOoNSSF98jCwIyZOpftKgRxaDPzl2n+jFbk3eSmw
X-Gm-Gg: AYBFou07Tdh9Mv4SBFNX1alqVn6/LpD2ZaKcYQjY7JBjwdPtWJxwaL/smZMbDZvO16E
	prFmkhI4+NBIY3lGQyqtZ0meWqbVdpFIUvXDvZ2/WqKSESHz4hXMItdxV5oTi0M/dEK3YTLV/YR
	OoWyOJQsc3Tsayt7IqJA1BRBq/GWoXB7lBLmSEci/gqJWTIwq6IuVlalDQ+uQiPEAcjserxVDgA
	qOkCx2cKAzKFnhUck7fPcDURPazyYqeW2VmgJp5vbfq3dir6m9nlVBX+zKqNQ+r2ozoZ7gHh47F
	OBd+Wwcij82MXTTv7WwummBJJfe2WKr/DpFDgEMVA3+bl6KPuGBDj062WIHlXpL7JTPTi5+TmFM
	WuvCJiuZZHn3PTtsZanhjGquixbRCJovf/WjTnU2iy68rwfHAMsGTrSTKnp1ZvY77hSM0B5VpnV
	bc4xs6sbtlSdETyWm77N8Ibvjewg==
X-Received: by 2002:a05:7022:f502:b0:143:7001:7645 with SMTP id
 a92af1059eb24-16209760be6mr4222902c88.47.1791434221672; Wed, 07 Oct 2026
 21:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com> <20261005-work-unix-passpidfd-v4-3-350183b6e02a@amutable.com>
In-Reply-To: <20261005-work-unix-passpidfd-v4-3-350183b6e02a@amutable.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 7 Oct 2026 21:36:50 -0700
X-Gm-Features: AclHuK87ASE-Zp2KeBO8qmfy6GnvIhawhL-XqcImRlz9HQrRj1dcVhs5k0D0yrU
Message-ID: <CAAVpQUDkBCXRfaFQcjNZg7LgWy_cx0c_eBPZfURdp0zn93dN=Q@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] net: add SO_PASSPIDFD_THREAD to get a
 thread-specific SCM_PIDFD
To: Andrew Halaney <andrew@amutable.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 8:09=E2=80=AFAM Andrew Halaney <andrew@amutable.com>=
 wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> Currently, SCM_PIDFD carries a pidfd for the thread-group leader. A
> broker or the coredump server cannot learn the identity of the specific
> thread that sent a given message. Now that both struct pids are recorded
> a receiver can ask for the specific identity it needs.
>
> So add SO_PASSPIDFD_THREAD as a sibling of SO_PASSPIDFD.
> SO_PASSPIDFD_THREAD delivers an SCM_PIDFD_THREAD, i.e. scoped
> to the specific thread sending. This is completely independent of
> SO_PASSPIDFD, meaning you can use both options and get both cmsgs.
>
> On SOCK_STREAM sockets recvmsg() only stops merging data at a thread
> boundary when the receiver asked for a thread pidfd. For SO_PASSCRED and
> SO_PASSPIDFD receivers all threads of one process remain a single
> writer.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Co-developed-by: Andrew Halaney <andrew@amutable.com>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
