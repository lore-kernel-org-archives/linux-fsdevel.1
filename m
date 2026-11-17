Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933564;
	b=PE8gVKH3C1Jny7DLFsXLrCKfVqPfCUOq6ihKtIdVlGnfGnhkurTzu0TYHIwhtLpuL13G
	 sk7mdF1JM3TMSR4/Ziu6qy4PEE4lFDHud1R3BdL0OsMI5IwALyVtq94iMc6pRlwCPXHo1
	 x6zUx+M9djq5Y1hXyGdpt7p6XxKTnbRvtwUnWuAHNkDt+azmM0/u9Ukyk6ePsL+NZXglc
	 gJaWNLVEXrUWZGmooo2oVVjVvyHolvYtGIqMnrEL4438lu3TrcwjVRJtn2vdhT3H2EXCz
	 uQAnGUcXNh6/cIbRuQC4EpNf8RhJkVGI6GLYU8u8dJWAVQqzhXx/DutqOWq6puWfofw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=1yMLSDxkDlgkYE94GCll9k9idUAgyt2V1MICT6ujyig=;
	b=A7aHLowlpp/XSi/TmdYJ44Ew/wd/2UewsiXHs9ii+1y7VpDrwmiAdAhQCGnc471/IK0m
	 GuOTJ3OEIxPekxU7dwir3+wVTM0oFV4kUFCkuYUhk1h7eggiiezSwLD17n8KAAufgAE2L
	 8KlnBeJo9yChMpGvQjyr21gkzp/sboRSqjBoB/yXMgtfJZFcYZpXK145DK2eCNIFXWLBO
	 Fibrs3DQDlss63bqQlKAaipQSkpwVRy+j6wkLuGAJWvxAH2eKLxgqy6mglsP/JI8Ewaeo
	 OAkZXyUtGjsgw7Y00LQu/RFELl4paFRCrL0zv3QsQOJdQUAKRKSIJh3XwJueKm4Ixxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fTE72B86;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9360606A89A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 16:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9360606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fTE72B86
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so4369695f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 08:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794933562; x=1795538362; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1yMLSDxkDlgkYE94GCll9k9idUAgyt2V1MICT6ujyig=;
        b=fTE72B86Z5rEBpDKAc4NHne/GnXGff3y7H6Jsc0ARGDiGlXWQffN+vDa57pln4ARyL
         +1G26BfEIl+HbVOj8TA3zSW1iNP9Exo768h3A9fSHxf1A+G4JzKjyZmNEbRVK3OkKcg2
         ZEYnzKWCZf2SHWcITYJs9lOAqrrzZPxMt6krNLkAMsJlTuduP0x2y7nYx9OSgn5tmOQc
         3GQldmEymfObWSixuhNM6I5Mvd8VHZwvi+nOGLSVWlk5ZzEm+E3HJN1gWAo3zwQFeuvx
         9iNDKhUwBHSxIZWVigOWMhavG6aeEqqoqaTE87khyMl0FdFXi08urXs13qAdOls/ZlVA
         Zdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794933562; x=1795538362;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1yMLSDxkDlgkYE94GCll9k9idUAgyt2V1MICT6ujyig=;
        b=qjxkDE1QrV7vqXKBT3OF0oaU0NETEudgcEriVKG94beL8DG0O+e4clYAezb8XkKfhv
         R+nETiijhTW5YVGDNBS+tQt0MlMlFRePaqSNlrqqTq56jCvLDG4uTS1wsHqxz4AkV1m+
         g1USRDu0vQt9Ft+OiMeMRPIH2FJdTYXkpabwZ9AOHndjMUsqw4HrWHcPwZLFTZhD4Le/
         VGmB3119AbasyH8YRmVe2LS1wXHZEgvI1HYddO6HdkLueAnWr/lWiTYBUn7KvsuuQsAA
         yIGklkY6Lqfd5VBLXGCWjpxGm5fLwx4GPKQ3OcsBCUVSuuxpixlzxARoeb9Pkk8CYb4R
         9+ag==
X-Forwarded-Encrypted: i=1; AL+hErEDITxWhqDQYeIk2kJUQpFwmablk7kfVVmZaUAFroZFzgX1iL+B4mKbdo2j60mMb6kzzczzYoHj/Q/MkDl5@vger.kernel.org
X-Gm-Message-State: APuU4Z+Tqj3cIhURRjqW3CclXVLT2Cj4yQ4Cv8aT6u8cLm2VRmf8NoYC
	kgTRzuOH0GajeF4JaltIAP71WVqiVTHPoZLkmUJ9qYBD823klB90IxZBr7uBrHZSIXB7
X-Gm-Gg: AZFdTZfa4U91ZjU56OIuRdvWeqRMsdXuJSXKIUKKhYhtB3m1xNibfwPZlmt9p+Su3Xp
	l4164c+SUzoJcSAfG6+b1WeYUjrHXB21upyPVDMPc01OCbGirm6yAtCqBkG9aQSxGmirstKgL/E
	ltKbkURy+1GmaQCVhTZr5RO/BeLfcnDcx5danvklC5ChKora31hs+glXz710Tz4miRo2bnDWPuY
	7ckWoS/t92gZgJuZ25e0NmC1UJ0KAsHVNxTRs0FRWmvR11pS6UWjQ9sRqBrulenSdmx7v+b8wqX
	3JHXBdUGvvWxg4rUn+nYZhIihofpv4KueVFuYHsyF3dgSA8COhZco4WqXJl5eYOTR1vIRH2JpIG
	7oQhE1XNPcJFuSVK9C9DGsCvRNOiwNjUvNj7dr2ermToKEtKaq+HacFwxBvopqUktT7omZ90IvZ
	Nk5YYEA/OJEWQB+ryTDWEzOqvNITGqRC/FtQonvndFG4/YA1jB43RCGIa1F/w0eUlShV1PDDaw4
	QsHMmAMgFphjt/gARCocuPaL4Z9+CWhZ+hkGO2rOXUbydvyPgR5Lli74EavlY0W9sNcy42c2bS0
	ctenPNcIPs6xjmm7jH9CA0Y+k+C8sgu34+T59kNG+E32V2piSrF9dPKFGw4VnQojnDftuFDxCcL
	G0eCV54zF4dBNf0D7gXPdUftZmBo/aBJlAePyYZ82SDhJD3YJoyjonrJd
X-Received: by 2002:a05:6000:15d7:b0:48e:e98:8b6a with SMTP id ffacd0b85a97d-4a6332bcccfmr19985f8f.4.1794933562080;
        Tue, 17 Nov 2026 08:39:22 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:dd2a:c8cf:5d96:bf5b? (p200300cf572c2800dd2ac8cf5d96bf5b.dip0.t-ipconnect.de. [2003:cf:572c:2800:dd2a:c8cf:5d96:bf5b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a43d41ec38sm4564311f8f.19.2026.11.17.08.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:39:21 -0800 (PST)
Message-ID: <a0f9a7e10bee8b5d328de14e1bbdbf74f5712d43.camel@amutable.com>
Subject: Re: [PATCH net 1/2] net: don't leak pidfds through a short
 SO_PEERPIDFD optlen
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,  Sashiko
 <sashiko-bot@kernel.org>
Date: Tue, 17 Nov 2026 17:39:20 +0100
In-Reply-To: <20261117-work-net-peerpidfd_short_optlen-v1-1-a93f56288501@kernel.org>
References: 
	<20261117-work-net-peerpidfd_short_optlen-v1-0-a93f56288501@kernel.org>
	 <20261117-work-net-peerpidfd_short_optlen-v1-1-a93f56288501@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-17 at 16:25 +0100, Christian Brauner wrote:
> sk_getsockopt_peerpidfd() caps the caller's optlen at sizeof(int) but
> never checks that it is at least that large. sk_getsockopt() only
> rejects a negative optlen. So with an optlen of 0 to 3 we still
> allocate a pidfd via pidfd_prepare(), copy zero to three bytes of the
> fd number to userspace, write the short optlen back and then
> fd_install() the pidfd anyway.
>=20
> getsockopt() reports success but the caller only got part of the fd
> number or none of it at all. It has no sane way to find out which fd
> it
> has to close and the pidfd stays in its file descriptor table until
> the
> process exits. Calling it in a loop fills up the table.
>=20
> scm_pidfd_recv() deals with the same problem for SCM_PIDFD. Since
> put_cmsg() doesn't fail on truncation it checks the size of the
> control
> buffer itself and sets MSG_CTRUNC before it allocates a pidfd.
>=20
> There's no point in handing out part of a file descriptor number. So
> fail with EINVAL if optlen is smaller than sizeof(int) before we
> prepare a pidfd. Since commit e10899b2a098 ("net: add
> SO_PEERPIDFD_THREAD to get a thread-specific pidfd") SO_PEERPIDFD and
> SO_PEERPIDFD_THREAD share the helper and the latter inherited the
> bug,
> so this fixes both.
>=20
> Fixes: 7b26952a91cf ("net: core: add getsockopt SO_PEERPIDFD")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-205984@kernel.org

Ugh, I wonder how I didn't notice this before... :(

Thanks, Christian!

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0net/core/sock.c | 6 ++++--
> =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/core/sock.c b/net/core/sock.c
> index ad414878dc5ba..74a00a5e2d116 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1746,8 +1746,10 @@ static int sk_getsockopt_peerpidfd(struct sock
> *sk, enum pid_type type,
> =C2=A0	struct pid *peer_pid;
> =C2=A0	int pidfd;
> =C2=A0
> -	if (len > sizeof(pidfd))
> -		len =3D sizeof(pidfd);
> +	/* Userspace can't close a pidfd whose number it didn't get.
> */
> +	if (len < sizeof(pidfd))
> +		return -EINVAL;
> +	len =3D sizeof(pidfd);
> =C2=A0
> =C2=A0	spin_lock(&sk->sk_peer_lock);
> =C2=A0	peer_pid =3D get_pid(sk->sk_peer_pid[type]);
