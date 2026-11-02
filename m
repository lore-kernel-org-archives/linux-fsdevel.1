Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793625221;
	b=dn5+b75GbmPh6EPeAd3lUCHkvY0+ZCWthVxlgK2ei6/mkQ+U9OClMKWDR4hw6m7HTmfL
	 FOcs/YbYJXsGeE2YT3D+6j2tO20f67LJgP8EvXSmF09iG/9wEmxqjE0kQ4VItB8uFMxxF
	 IFoWPaKazEZcE+YuOqf2cFK8FsJzBMae5BsILU1d1wYpn1BbcqR/nWQz+JYklDkGig0oC
	 WZnwJs0d1xYFXQA1P/0etDsyABBE8XsE9j4b0D7sElXc51VduL/k604qOr7TDg+Tg1Lf4
	 6vFw17HC4WS5Z504XNe+nOLdu274vq5jU3aamKip44gkgt8UnbMPGIAQCQGC21H3W/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rC8xVMt0ftVC1MA0/AxMx0dm+YERO32RQqLOxWhbSdM=;
	b=HNhqt2nzy6NKknhy1naY5WIfa95+zT2FKDXUbyx1fwHKEiyV5/EBXEeqiO/q7T2ACTjw
	 1gSVIx0Xhb+Gc4gZm13uRPhq4DxVVhuI3z8csJbR1sZnPsM9hLPNWGInrXd7HBF+JG2n0
	 Ov9RMGH6BISSOOuy1u2+vAHzmGDg4LaBya6FuaRG1s75vpKyhA/aFEvbsJUQzbhPVrq+C
	 FbVEI/yrdzWdOCLLIi/IlsCykuBliZN5OZ7l9p0vWUWIAU1i9U3CO2dhnGXFHACE+b3As
	 tYubhvAZdtyRzhh2AC7M+i+vKMoATZoGhiBJN5WOz0dxU1V/jpyQSrRDdjWUlr9ZfDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9Bv0lrt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450FA606A32C
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 13:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 450FA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9Bv0lrt
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15ea896ddc8so5071089c88.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 05:13:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793625220; cv=none;
        d=google.com; s=arc-20260327;
        b=QPR0cF+jcGycaIx/tZHLy1b5//GYgmUNJd2ZG/4+mQ80JDNGnmYGZyF9T9vMMWm0i+
         1qCS3xGY5XmKnVZAq72XuuxBqE3t5bQR5ISGCmvdbovwQJgxbQ4xUbZYfpJNrecktcG6
         EgR/kiXkIEslYu/oxKhnXMSPO9pb6zIjbb+unk8GarMuseLvzdUvM6E0auIDQZY9iEYs
         3Hect9hocP5RDknuVRgBNFVPjYMdbr3ykiu6LxKDTwzSc2VBbnOR/Nwey/e/wHcFHVvZ
         ZW0aDENnJYrLqyMS+IkNswdPGVxS8Znk97qYGAyz75PmDGWBhPANoyyDRskwUn37p2/b
         kVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rC8xVMt0ftVC1MA0/AxMx0dm+YERO32RQqLOxWhbSdM=;
        fh=bh4PbDTgCP4cruuLpHo8ObJjDwMDroSPnaKAPd2XO00=;
        b=TLtmA67YXoR270sF8OMSvfnKM4AWtpFzPr8bx6JfHN2owbruy0mdAwpE1FttX3+x9e
         db+BlMp9Q6Nr9o+GT7qw2d5lU6uieSKOfGqtaF6xnS3mBphdlkgm2pbbbzXYGcCtusht
         Te/KxqzSJoG6kZRIOk7GaFSXcZX9A1H17WdHmcYKf/YGfE4EZOf8OEHi9b9TSegcSs0U
         E+6TKRW6q7Bk1tT4Uz80F5BiA3zZ5yT/4m8nRVq0bSirIhxIpi2dI2I4OWOi5HKz4Dwv
         WlsICzglMohA8XpR07gUtu+wvP/FfygqNaIASsdaQUHXGl/g2EMGKyTTfJcshh+nyJxH
         1nwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793625220; x=1794230020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rC8xVMt0ftVC1MA0/AxMx0dm+YERO32RQqLOxWhbSdM=;
        b=o9Bv0lrtHh2cwTJJVMUH4k06fPh+ZUF1Xl51YCyt5LSal/HMFyjV6eP5ndcJg+7iVj
         WTAY3phbzSA8x/6rfLnLvb4bDnZ8Y4PG1EA0o2RPOfRyLwq6jcyjm/QiNRIf9j5AQQsJ
         l2LCkDlG//3sWy/odK1wwz5yKvgETNvSW47fduZrW/zlPZQm2Hr6OF9occ90dnwda9pH
         15peHnhylM0gwl1DeCkmpBva8CbqeJR2lmvPc9gUGtCRkIGAVwQC32c4UK+T3jOODMWv
         8UTKrgc631symoPetFblG9qRPrnzh0NbDQA57q01cYj3VhCGGF8OfpP+shjngzwAm22m
         UCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793625220; x=1794230020;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rC8xVMt0ftVC1MA0/AxMx0dm+YERO32RQqLOxWhbSdM=;
        b=Ap3GSIQHKmsy8iqYqbSHIzcvPPPxAWDTUEnkzOy65HX5uWpJZzINIQDoUnja4jEy1L
         DWFwyr8Zw5zAPPHMsSyaSyQ+luI5D4HEZ3+9CruJXziKUtm3azI5zJXyIDyc/2GME+X+
         hDLaYJtEUZxnBBWJTQo9iEE6oum+h42V/jevdRPvYbjE7LNiJDTP1J4yGylyBx1K/Lh4
         2c/l+2n/A305wRxrTG8Md8z4xv5i6wAVgimOw5tobHWSKrfVJqfV5hW7VRniq5Fzi+dZ
         J/qoy36SZ9cbAUubuXaTsq+iCX0FuacSukQh8WqJ93j8QUm3Y/LEczh9QEQYoh1HKPnq
         zkWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjggaWPC/WCuCG4TgfojdKmkB+72zR0xIWzloZ9f8B1YLxp+t433WwmYCleYOFWe+7rqwRXBlaG5unz1zE@vger.kernel.org
X-Gm-Message-State: AFq9FYJFy+7ACqBAAVSp/AkUndLyesgHaQ8i3UJWH9HhCa89DqBI6I6d
	YdW37+ABoV+8AaLsfNJ5otpf9bBkcTtmRkB7B9IBu6c2VNzK6QuvBmQOj52jr8o50cSEfkw7oIa
	9x6L5ChSmlaZOghthY09RXI9eAfqUTw4=
X-Gm-Gg: AYBFou3T5VYqRZzi/R8eXQpS7Ef9FG/gHpfJ9srVsRcLGfZ6SI2Q2Tu1EcrCJjkP22d
	TbALZwdvRBWjh5H2ijgNGrQL2t5qAAqsYbTAILE5ltpMgT3uYROlEwZbNpBQpx/i9QCOLBUIfK2
	4vJXbjzxvR4WqMh8Sb+iE6zw0HyZUE8NmbkSgyBYV5MSMUnZAelcjMB3+AGxe3jKG0M2HWK5COo
	fREzx03OXa0VCp9u7eTQ/nCUpRqZ5isHYGQ1i6IEVDkUCJsROEYCqEOon82pKlQSJPrGzOaX2hM
	bXZ5QaEDJBEGQcotGcd7ZFAj14iOYe3HMDZ+vmN12eRo0HkLD1EvIWeWDsFKGWdO0OpBRodh56U
	dIMNpfbSHvcIrZS3Trg1U6lfdMWvo+ceHNShF/HIWc//Rta560Cx0fHsFJTQzfoInUH7M
X-Received: by 2002:a05:701b:230e:b0:14a:8cff:fbb8 with SMTP id
 a92af1059eb24-1ac5bbb5053mr14722111c88.28.1793625220279; Mon, 02 Nov 2026
 05:13:40 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102130540.252894-1-omosnacek@gmail.com>
In-Reply-To: <20261102130540.252894-1-omosnacek@gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Mon, 2 Nov 2026 14:13:28 +0100
X-Gm-Features: AclHuK9Lk_3jmZnqSr1tjOillycrUr-WcgCLTZN6r2TRwhWtp1BoaHKbHJvYD28
Message-ID: <CAAUqJDvsDi5ceO3ri5cJP4WJbZeUdpJe9F4cv8OU4=wBzVeBAw@mail.gmail.com>
Subject: Re: [RFC PATCH] af_unix: introduce MSG_CMSG_SEALED
To: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Nov 2026 at 14:05, Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com=
> wrote:
>
> Currently, when a process receives a file through AF_UNIX's SCM_RIGHTS
> mechanism, the security_file_receive() LSM hook is calledto allow LSMs
> like SELinux to validate the receiver's access to the received file
> (similarly to a process inheriting file descriptors through execve(2)).
>
> However, there are cases (such as dbus daemon/dbus-broker) where the
> receiver doesn't intend to access the received file and merely wants to
> forward it to a third process. In this case the forwarding process would
> need to have the appropriate r/w access to the file in order to receive
> it, even though it will never actually acess it. That leads to the
> security policy having to grant the forwarder access to a potentially
> wide range of files (in case of dbus-broker basically all files), which
> is not ideal.
>
> This patch adds a new CMSG flag MSG_CMSG_SEALED that, when passed to
> recvmsg(2), wraps any received files into an opaque anonymous inode with
> the name "[envelope]", skipping the security_file_receive() LSM check.
> The returned "[envelope]" file descriptor can't be used in any
> meaningful way other than being passed forward via sendmsg(2) with the
> MSG_CMSG_SEALED flag. In that case the original file is unwrapped and
> sent via SCM_RIGHTS to the receiver. The receiver can then either
> receive the file as normal (subject to the LSM check) or again "sealed"
> in the "[envelope]" anon inode for further forwarding.
>
> Note that sending the "[envelope]" file is only allowed with the
> MSG_CMSG_SEALED flag set, to make the unsealing explicit and avoid
> unexpected behavior. Attempting to send it without this flag will fail
> with an error. This also avoids recursive nesting of "[envelope]" files,
> which would only make this feature harder to audit for possible issues.
>
> This patch also adds a simple read-only sockopt for UNIX sockets that
> allows userspace to determine if this feature is present (passing
> unknown CMSG flags unfortunately doesn't lead to an error currently).
> The minimal code to do so can look like this:
>
>     #ifndef SO_RIGHTS_SEALED_SUPPORTED
>     #define SO_RIGHTS_SEALED_SUPPORTED 88
>     #endif
>
>     #include <sys/socket.h>
>     #include <unistd.h>
>     #include <stdbool.h>
>
>     bool MSG_CMSG_SEALED_supported(void)
>     {
>         int sock, ret;
>         socklen_t optlen =3D 0;
>
>         sock =3D socket(AF_UNIX, SOCK_STREAM, 0);
>         if (sock < 0) {
>             /* handle error */
>             /* ... */
>         }
>
>         ret =3D getsockopt(sock, SOL_SOCKET, SO_RIGHTS_SEALED_SUPPORTED,
>                          NULL, &optlen);
>         close(sock);
>
>         return ret =3D=3D 0;
>     }
>
> Related: https://github.com/fedora-selinux/selinux-policy/issues/3286
> Related: https://github.com/fedora-selinux/selinux-policy/issues/3287
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> ---
>  arch/alpha/include/uapi/asm/socket.h    |  2 +
>  arch/mips/include/uapi/asm/socket.h     |  2 +
>  arch/parisc/include/uapi/asm/socket.h   |  2 +
>  arch/sparc/include/uapi/asm/socket.h    |  2 +
>  include/linux/socket.h                  |  4 +-
>  include/net/scm.h                       |  2 +-
>  include/uapi/asm-generic/socket.h       |  2 +
>  io_uring/net.c                          |  2 +-
>  net/compat.c                            |  3 +-
>  net/core/scm.c                          | 81 +++++++++++++++++++++----
>  net/core/sock.c                         |  9 +++
>  net/socket.c                            |  2 +-
>  tools/include/uapi/asm-generic/socket.h |  2 +
>  13 files changed, 97 insertions(+), 18 deletions(-)

See also this RFC patch for selinux-testsuite
(https://github.com/SELinuxProject/selinux-testsuite) that I used to
test this patch:
https://lore.kernel.org/selinux/20261102130834.253605-1-omosnacek@gmail.com=
/
