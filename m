Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907503AF664
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790724559; cv=none; b=MAZlfyAs2bkBXI8ah6kErAXMogDHbrRqtBF+FVjGaiwbSJKxyfos/WAFbUuJSxuz/IulrLtK/+2m5w6vnq1Rg5SCxmjwXQX3xekDwRbYFzEa8vrmKb1OB3UH28tOyVRV7qC7m/TI8C8j0E9uk+PuZdlw8BI6clZNEIf063NrSy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790724559; c=relaxed/simple;
	bh=NEVRE+VNh4fb0HQhp8MrdEoxzZKRMgUGcTk95yadVPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mFm1hGUqzOLiBDvcrnhVpDrhqinuQrkAhVl6DrnT0ELieDNxfhBJhW2YIN8xuPnDHdu+Ws+eLgWeXweEN0pFSunohg1zOEX0mvN7A+/Wt2g5mNobKMNsZvN4JNY4j9qGNsiq7lpOAW4gsVQioZZ4adheFXzVpe0/bd8513yu3DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=MxpYokDi; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="MxpYokDi"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-675686b026dso499126d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 16:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790724556; x=1791329356; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NEVRE+VNh4fb0HQhp8MrdEoxzZKRMgUGcTk95yadVPU=;
        b=MxpYokDiPrsYK6g/WlOk2rDo/CRKcDzGxmRZLk3q9T9V1W0tgbFCAhLn0TTUYyBWoU
         uF87UsGyW6JkxdyFBjRy01S6XqYjiwKBV5lFsfiw710YFyTc+GlIEWjvqtUcP1R+XPSV
         DlDatLfrre+NhvU2jvth5VB4ClEt6bR/MQQdpRCKjKNNGMRrJMOx+5LOz1tTv5zX9FoV
         J8N4DMVFvcpQgMWglb2RDrRr22fea5AMBgqqGmxCZBzY0I6HAvy8pyYMIFSWmM/4GGJN
         xW3MejKXWsBUPbV13TZJJ9E44mTSRaVFqPwPu/sJzAl/i9y3GGFi77+u8AZixNHFTrII
         vDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790724556; x=1791329356;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NEVRE+VNh4fb0HQhp8MrdEoxzZKRMgUGcTk95yadVPU=;
        b=YA/jFZ02zXcSOFjxTvF7uv4NnVvosWhMlZblGkZ6R4rFbLPzPP0XNzl5o5vXfCld6X
         etWi8+vECrIp18/312h5wLgyOhlC7pXVXllkXn9nIqDY9ZQXOCubrWEJlmiVWg9HOZls
         IrSlLH2l+tQOgaGxC+pWF9M74zyrA5M8vlOKzJSDgzNwunsyY8mbmiVQcE0i+XkXs82x
         SlPaL9DXlcALdUxRB9oQDTEy9To3QO0jsL5XeGhodfuJbu04gelqXSSMk62pUIAvElFG
         +ayMPa8nGQW2tMDtz4j0MOjOIbS9AEWGrSXDX0SWsEr8a/QyMrtJldd3Jab7qHRPCDyD
         2joA==
X-Gm-Message-State: AFq9FYJcNfoTsFrGTGmgg4S/CfPYkbu8xZWhxpZk+rXwCgnNOOITSDqT
	5MUVD24w7U/WMdxIfm53/RWzONxkf/PxeGEUOMWXq/fYnAkOI8W/CFEqiobnyqx2hQbajrQWLGR
	tb4MrZLo=
X-Gm-Gg: AYBFou2PuLrrRz5uvheOIpIzb3/6S4lXAzIza45UwnnuYGdqgQSpi4Yux0/3s8i8Ojt
	gsrBRMWpGCF/2u0xdjJe2faDYilOAs3xefxEUoTrpNLNCYRLamD3O+i7sKX9CGs1ndQRG++58dm
	gWdjaEO1xR2mpmr78FpRdrjySIQxA6yK6oX47HZhn9iQoWKYYo2ViJDnLs64JH4mGmxl6wlwwfB
	Jpk+IcRYFvCeCb6yfhiFV0N3VXpQApEm1nrzNJC/GrVeF9mTJTAwAMuLd27JaawEW1+8yELuonF
	lxYIVoAC7U0WwW00NA4JlDIbF9o6Q/Dv4fcl7pgOLLon+JP3GtRxaKKA/6ls97AxSR9N6qOAUBM
	+NK9faSVQsQy9Gntk8Tdm9YHgDzkgDJXo/r+obPYaG6XHEuSgVGwJkpCjqXcRLjiemGV20aZHHQ
	Yqsb41TLgSCnJCmiy0TIVN76zrQRfiDHn6puxkEigjV5VBLLg4t1u1KCovhMDsPNVpwWrsUYTV0
	rI3cEgOivLNTphrulfIQNbPDCFv7AxWSsSjMyl8FqQ6pqbOXIA3P3W60eQeCPAGO/OrCTInBTNy
	xP3LqX99MeqfYw5XvO+my1/L/iVkeM7TJbD2FGzy1voR3CHqaQSE3xXsUacleA==
X-Received: by 2002:a53:a003:0:b0:66f:c1bc:4052 with SMTP id 956f58d0204a3-67644166a76mr219775d50.51.1790724556384;
        Tue, 29 Sep 2026 16:29:16 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:ace4:86e:1afc:3c4e? ([2600:1700:6476:1430:ace4:86e:1afc:3c4e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-676815219e3sm19210d50.12.2026.09.29.16.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 16:29:15 -0700 (PDT)
Message-ID: <6a2706d05c76e71e38aee80746a0ffbff374a561.camel@dubeyko.com>
Subject: Re: [BUG] hfsplus: nls_utf8 refcount underflow after failed mount
 (6.18.53)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To:
 =?UTF-8?Q?=D0=9C=D0=B0=D1=80=D1=82=D1=8B=D0=BD=D0=B5=D0=BD=D0=BA=D0=BE_?=
 =?UTF-8?Q?=D0=90=D1=80=D1=82=D1=91=D0=BC?=	 <amartynenko140@gmail.com>,
 glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org
Date: Tue, 29 Sep 2026 16:29:14 -0700
In-Reply-To: <021B832C-57F7-4A31-9283-FAA5AEB8CD66@gmail.com>
References: <9AD67E49-86E9-4508-BBC0-26919C72FB6A@gmail.com>
	 <debe2b6208864733c943a4d1edb93e54685897c9.camel@dubeyko.com>
	 <021B832C-57F7-4A31-9283-FAA5AEB8CD66@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Artem,

On Tue, 2026-09-29 at 22:43 +0300, =D0=9C=D0=B0=D1=80=D1=82=D1=8B=D0=BD=D0=
=B5=D0=BD=D0=BA=D0=BE =D0=90=D1=80=D1=82=D1=91=D0=BC wrote:
> > HFS/HFS+ code has a long list of issues. Another bug? OK. What's
> > about
> > to fix the issue? ;)
>=20
> Hi Slava,
>=20
> Thanks for the reply. It turns out this is already fixed in mainline
> by
> commit
> ebebb04baefdace1e0dc17f7779e5549063ca592 ("hfsplus: avoid double
> unload_nls() on mount
> failure"), merged for v7.0. That fix is not in the 6.18 stable
> branch,
> and I can still reproduce the problem on 6.18.54.
>=20
> I tested the upstream fix on 6.18.53 (removing one line from the
> upstream patch was needed to make it apply): after a failed
> "mount -t hfsplus", the nls_utf8 refcnt now stays at 0, and vfat
> mounts work afterwards. I will prepare the backport against 6.18.54
> and retest it there.
>=20
> Would you like me to send the backport to stable@vger.kernel.org?
>=20

Sounds great!

Thanks,
Slava.
