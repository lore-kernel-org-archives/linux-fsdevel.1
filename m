Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573510;
	b=2arN/YAIoQrv4qqlNUl2kGxeOpmfZWSg+5I8Qwp0yqEokjlpyj+rQOck/SlnwR553zb3
	 JnNr9fxYVDW0jviaNDnZ58hs4AKsK1ic3TJb0u/G4Gxo+PZt7VMHLHJExMU5vjcVfaNoR
	 OMWa3xk3QNehpjGSkVf5l+E7OXCbAxbfWM9ku1S+SxkeKTZF01RWJcS4BqCgPGvBpO4JK
	 W9cEYKhbSGoc2SwTuEu8EPAsp8VjbJ9fi1fMruo+H6ZSink8f7tK5Y5pC6J70j4h4mQoG
	 MdO8MImHJVvMTggCzS7/7mZZs7wyPZ10vHQJDSKMeKDy/9WbdykwWTiiPGywx207bLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
	b=FyiIrTKFS2g9whXZ34d+DyzbuRksh+4rHyXiXBTY6km9wPYZBI44caStPFVXxm2UZ8PY
	 FI4HKLG8V3w2II0Q3Dl4MPOFz5JGY3EhyhO4kJO9bDLWRTMIfNrz0g8bFARauoyC4Cbpn
	 mg1vGBHui5VdBv1zXDUo+RuZTNILARHH3YxcsUEXV1Sbr5O49NTLuC7rP+w71TU/zZ7/4
	 cc7a1Q5X5l/aY6demXaqnwHvcesHjdF70D4qR7lc1byVqIVpllyFZfdgkP2/u16/QHgEU
	 zjwpqpjt3d6DETnuiReT5kHvSnmo5+11xNh73oIy22lWyMyrKJlWRrv5KcMuB2WmcLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bz2+TnPI;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A5E606A327
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 12:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2A5E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bz2+TnPI
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so3649045e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 04:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794573508; x=1795178308; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=Bz2+TnPIApHKvsf08kyiSuJZ5AWViHONwTwuNXVAuo2u8JGXjKnEoxSd3hG/r/h3b1
         tdsUEBtaZSOWfU3+mD3LjyqvBKt9Vc6RBsvkZZTD05u5eCDGhnWto1Wbu/C0r64DVVdd
         h2TGnt6meedDH7Iwjf2Hw2JxWOY8jwAvEAcAC10FURsf5jjp4p/KJzFYjzuPwuYFNKea
         Iij0h8HoPs5opXKf2XwMBJpd5hsYSV0+BHP/DvKdCCgwNFtbeIFAwqDf2ag0NBOCbqs2
         OXWiZmXbdGCixyOlqQBMgrkFkrhg1VmbSdmvvBdeQ4Vz+QMvhYl+k9AO6FJ5UW1pg6b2
         DVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573508; x=1795178308;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=PucwQZzHlCkCekPo7YP0JdgETWdDRFP8yowbCPnKxNJwso+OTGpYfElXzbBjjI8rUP
         udOR8fH2Coo8nVlU2tE5OA0+NfSFuwEPp3ykUJH2s8kav6OWGxe/PjtCxLFytCJwmOdX
         xrDMbvRHcN5QbmIQ17OFoGRPTlW8nqJ420z2A5katAs4lBB/V4VgIkjF4hEXDTOsZs7M
         r+9o6+hCrBJ7IM/6HvHV5hltwmjk/I1qHW8L3J5lmuIZGjN0mvZMtZ78VqVI4F58hCwn
         qp240LUSTJHby6DwzSwMRlsyQ6e/KffE4IogtW6ykv125e0YTZD6PD0a4++7tSmrA/6U
         yebQ==
X-Forwarded-Encrypted: i=1; AL+hErFX3SjNM3HEkkF5z+YPhZ8BAdNf8cuMGWkQZsEGZ6XnIEKhESuwreDNNu4R6yhII2O+tCnaweTm2lXig2u2@vger.kernel.org
X-Gm-Message-State: APuU4Z9Cuq7uTwtANQhm5OOpENR+PBy5T30YIlR/dogiM7c85w1BEx0r
	vQ2XzHs87zmPZPsAxtdQ/TK1jIDTshyb8B3m8dyNNILxCid6KzfeuMP/VeGDKsGDiug8
X-Gm-Gg: AYBFou1W+VnJdKEiTTaOGoOe6/+DvQcFAP0q9zyIVSvYZhFOPOkA6PYOaOQB8Sjlgse
	ssi2rFD+Yb7tgu+Ob3W2tkwdgAZWRyBLGORIYrf7dtsjoZc3oNypamacgHs0CDKvEaZ9K833aSi
	IpXOmlWiHJ/QXstYb9eXpjy+E9K3DX3iSVDun6rkfefUdGRpEs1Efxymx8reTq7b6wUfTKAHVuG
	RcWuuUeJdoigeUAAooeKRmjXpaZyqOJXCqWt6Kakd8zbbP/TMe1I47CA4fjWYM2mAmoc4IJG02i
	gm2lnmExb3nWoDURxRtiuVRaRHMt1Tce0djonPWNRfLDtnvlRzNIA9umbfaXHFq6QeSCQjaZm1d
	u0FjNgiksT5zsXjFyRxNEe5R562FR3FXSQXTaqoXrbyPgqRUl7dKeoPWYEYZxVYgjjRVaG0EEFJ
	QGcZ7twVYPjXQYR6sv/AxaRPxP9VfLhqqRJQPPmaofXgFijxP6GefJvuncebwkEG/C/+lLGtvqS
	BwWSZeIDb0vzNQJYVVs2CqfyzKFez6opIsC0UnJ3nqv2PcuRLsFTWSsIkFH3eYCkDnuAm0aXWlM
	ioSNy26Pbs415vogKxXG53KeEvFM/8ntFOvoZxXyLAV1zhFRhA5OAtFTUdLSCuI=
X-Received: by 2002:a05:600c:a596:b0:4b5:d95c:2380 with SMTP id 5b1f17b1804b1-4bb55a86fb2mr24790785e9.11.1794573508217;
        Fri, 13 Nov 2026 04:38:28 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571cfa2esm48348475e9.2.2026.11.13.04.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:38:27 -0800 (PST)
Message-ID: <28a33fa649dcaae2eadcc934ec49fa591ec1c283.camel@amutable.com>
Subject: Re: [PATCH RFC 20/41] apparmor: use fc_init_pseudo() for apparmorfs
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 13:38:25 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
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

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize apparmorfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. apparmorfs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/apparmor/apparmorfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/apparmor/apparmorfs.c
> b/security/apparmor/apparmorfs.c
> index a99366467217..351ea3a7120e 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/rcupdate.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/poll.h>
> =C2=A0#include <linux/zstd.h>
> =C2=A0#include <linux/string.h>
> @@ -263,6 +264,7 @@ static const struct fs_context_operations
> apparmorfs_context_ops =3D {
> =C2=A0
> =C2=A0static int apparmorfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &apparmorfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
