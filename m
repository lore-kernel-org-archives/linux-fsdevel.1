Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D5D34D4D8;
	Thu, 19 Mar 2026 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946741; cv=none; b=ZJ8OvvYe3u8GDBg4uuxaUqJTpcvwrKRt2xRKPfMkyT/k8rlA1EzAc69tJ2EL/kf7ypIbmxdv3q8mOS3tkagIp2l2QpHV4D1PhUty8zorWOJTk6gTlW+wukE/RtmuZeKC7ZMkoSB4nz8SPFCHZHhvg+maUEmKzXZjHEpZCM+v8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946741; c=relaxed/simple;
	bh=F86S68UTNw42sTF6MH8toeCKTrVFFdwqHbESm7VJXD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHh2a4Xdo//huxI+zqrpleiQDn59M4ey1Oh+LNxag9jshD2r5pSImqDFu3ph/Y6CD3iWgBYFhRa3DXjvK97bW/qeTdQQZCkX8724HGtpNR4OIWuKz4OhaG0rIf4T2ekz3UD84sfJyN944CEtLxMdGhmblxqXLI1ZWXrO76KFBXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=SuFiWS74; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="SuFiWS74"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773946723; x=1774551523; i=ps.report@gmx.net;
	bh=nFMbbi5pmRweaVVmJS24OSvEFUGMWCQ2AIQ0tzhS0UI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SuFiWS742KtnYaVsiWS+WVCyC1pJRPphxKjVq/pHONzRodjdG6ielVuu8aa4c5f/
	 AmGycX3RJFYeJFr1Loslw997v3ynDw6vgGcN5jAqEkW3Uz9EQhuSoadd1o2bZhLI2
	 lnQ/FnZQriiNQCTL6aB8bptq0n+RoJfL6cMmC1wYVO/hUnN09VDTy+39akSMHwyhP
	 JGjgr1cH98SsiZNwLw2f26w4rqBVpkxm4JWbLdVi4dLNanAeDRtaFujGtw/F+/YT2
	 VtdCFLDy1u6y5w3G1AzJiljdndimSc8RG1HfNR+xsHH2jDFoqymdPf55eLwgSQ6Y3
	 nUcwl7dVD9BXt1UF3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5vW-1wGRiV2MjY-00V1gl; Thu, 19
 Mar 2026 19:58:43 +0100
Date: Thu, 19 Mar 2026 19:58:41 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Marc Buerg <buermarc@googlemail.com>
Cc: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Octavian Purdila
 <opurdila@ixiacom.com>, WANG Cong <amwang@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Elias Oezcan
 <elias.rw2@gmail.com>
Subject: Re: [PATCH v2] sysctl: fix check against uninitialized variable in
 proc_do_large_bitmap
Message-ID: <20260319195841.227edf09@pc-1>
In-Reply-To: <20260317-fix-uninitialized-variable-in-proc_do_large_bitmap-v2-1-6dfb1aefa287@googlemail.com>
References: <20260317-fix-uninitialized-variable-in-proc_do_large_bitmap-v2-1-6dfb1aefa287@googlemail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TQ0fM+oAi+mhYltFXXEnGIS3lyZN1C9I8w9ic1NCG9bwAwevpDp
 vu8ytTF+PEzMcdM25LNb1ISlj7aSAtHkafalWbTMfe8PP6Qxz5qo53+U1ksTfL21fXc04II
 3UiYUQgWReT35VwgBzNI9E/Xz4dLShdnOJtvPq5ymT2pLk9Sd9lGdcqHSggb4ayr++OqElS
 aH283roRjRqsU50azdPNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RJ8U7VMSX7k=;Sp3nHEiOg2szPlffflSB51EF1Id
 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

Hello Marc,

thanks for new patch iteration, some minor comments below...

On Tue, 17 Mar 2026 22:39:32 +0100, Marc Buerg <buermarc@googlemail.com> w=
rote:

> proc_do_large_bitmap() does not initialize variable c, which is expected
> to be set to a trailing character by proc_get_long().
>=20
> However, proc_get_long() only sets c when the input buffer contains a
> trailing character after the parsed value.
>=20
> If c is not initialized it may happen to contain a '-'. If this is the
> case proc_do_large_bitmap() expects to be able to parse a second part of
> the input buffer. If there is no second part an unjustified -EINVAL will
> be returned.
>=20
> Add check that left is non-zero before checking c, as proc_get_long()
> ensures that the passed left is non-zero, if a trailing character
> exists.
>=20
> ---

All below this '---' comment marker will be dropped when applied
(specially the 'Fixes:' and 'Signed-off-by:' tags)...

> Fixes: 9f977fb7ae9d ("sysctl: add proc_do_large_bitmap")
> Signed-off-by: Marc Buerg <buermarc@googlemail.com>
> ---
> Changes in v2:
> - Drop initialization of c to 0
> - Include checking that left is non-zero before checking against c
> - Link to v1: https://lore.kernel.org/r/20260312-fix-uninitialized-varia=
ble-in-proc_do_large_bitmap-v1-1-35ad2dddaf21@googlemail.com

I personally found some of the commit message text from v1 very
nice/helpful, specially the part about the writing to
/proc/sys/net/ipv4/ip_local_reserved_ports to trigger/observe the bug and
the maybe condition on CONFIG_INIT_STACK_NONE=3Dy...

Besides that you can add my

Reviewed-by: Peter Seiderer <ps.report@gmx.net>

Regards,
Peter

> ---
>  kernel/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 9d3a666ffde1..dd337a63da41 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1171,7 +1171,7 @@ int proc_do_large_bitmap(const struct ctl_table *t=
able, int dir,
>  				left--;
>  			}
> =20
> -			if (c =3D=3D '-') {
> +			if (left && c =3D=3D '-') {
>  				err =3D proc_get_long(&p, &left, &val_b,
>  						     &neg, tr_b, sizeof(tr_b),
>  						     &c);
>=20
> ---
> base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
> change-id: 20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-3=
0c6ef4ac1c5
>=20
> Best regards,

