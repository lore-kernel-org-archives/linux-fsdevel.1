Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE103876D1
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 02:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773888792; cv=none; b=FPXsxP31yxwYtIDMfI51FXTjWKrvvwj99JjhJz4VbcVnyXRsKRKieL9CU5NZKT/vhDiIui1UwpVVHpzb8rPRHlwmALntyyhrgsitHYIzmMSyCLyD5PC7VWUy247G+Blf90XYk7m5X8IiasQBI9GV1PlUZawEPRxKE7laiXf0I1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773888792; c=relaxed/simple;
	bh=mk6MGvPBVKS+rY9qAMoAkMsc/ht937nrXMHt6+HHLzo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L5HDx1GSDR4Ekwu3zPiT5Pp7OFMrhmWfYMRbQXPmOEzKJzH12dWf5+r/fUmF7mlGPArg6sn1aL6T9j7jQWsBNngr7g1V96JDY2FaLlcO/GUCW6VopyqPopoC+jpsUVaefDG9XaDS7ySWLJxb5i3+8UQrEsW+6gAGq6nxRteIY2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=LHviwXCM; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="LHviwXCM"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7986e0553bdso5644727b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 19:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773888789; x=1774493589; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mk6MGvPBVKS+rY9qAMoAkMsc/ht937nrXMHt6+HHLzo=;
        b=LHviwXCMxB9YEPxFvri6cMGFxmlGA9270temtJkRppJ+3v21eP8L60/tGlz7HQrD1d
         mDdcJ15irpH4GB3Qb6imY89UdyVwdZhuQggm9+FVXkfQojUOL2osiylOc6BaHi5M7TqC
         l/spzViZsjQmikA73mAjJkHOXQZwAYu6ppxy+HgLv+10X4E69BUZFbHFxJz0V4HHm5fD
         eOp9utxwzeUVLpttoGh7xRned44koCDNcyuLyLIcA6wBPoj2ICzYY8XIQ3rvwHJ6uKrQ
         vOPbKm3wB+qX3CG6++zlY5j2UyRYnY51tIIuGmAZ/UmBArUNWRF8ljDIdHfHctnEBRwp
         1rRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773888789; x=1774493589;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mk6MGvPBVKS+rY9qAMoAkMsc/ht937nrXMHt6+HHLzo=;
        b=MB+VRMSPNRten6TzKMKlucPHVol48KcOcdSg5HjGIwi1FQ/JCDDzUWYzZsgJpuPUfT
         QUWIu5C8OgkMYfze5H+oiVHvI6ibIhmFyU7LVGRm7tMmdVSHPAuVYaUz+tx89Bs7L8mg
         PNDFdygFNjKCVkEca94XyP8J8CKxStMn3uIgXZvorpFrPkBbow/Fx9zS04o2zzeXCNbK
         1yo4+tGI3YsTU8MV04yAKDH4e/TaixmIst4pjIZ39UCXxLmUOY2xpmMO8ZuHeyIxsUea
         VKrHhmbbDbBsMtH2hvN2qed+3t24NywITL2fwQkGqYKeTUoFAdhb3BelaFLgnQ0i2Vz8
         qJKw==
X-Forwarded-Encrypted: i=1; AJvYcCUugbVr2B2fYZwpgp1gr35TllHjdQ8Y8QI7vbcbVXZNDolH7ylFRRmM3uKW/K2J9qgXEBFh+eiSdLSL9W2N@vger.kernel.org
X-Gm-Message-State: AOJu0YzWXVSKM2fcXoB5V43Dyv59I881579j08LHsXWWGGNkvTDQYjzw
	ENWIWYX6T3KFekmWNREFp4XPVs27lTkGpsZv9DDgr3OADZgiERxABd9fqIMn13fgIJw=
X-Gm-Gg: ATEYQzxtk0oObh9Pq+V9EE2SKyHBHSPYIvHMsVBIQUq1rn3NYdHUvQpq9Y3nlHn272L
	RsvhXQu6I+/UmqpAFu/NEp5uOzQaWFZxeFu2h9xM+y7q6epWxwQcvvYpONLvG2wxDrj4LZ+v6Zw
	ynLGQ7pXZqVaxXG4CU3CUFzwDNCa1ygtdt2OGMhwbUQrR0KJFobNL6cgZVEEc1APfQ8s50ABjCY
	e21oQI9TMpnYFC7HGok33BAOUAVE1Uz5tJ9jW9j6jXCBpriryLcaZMnx6zduKMT1ZSzNVS6Scx8
	m6ph4Affk/1lZLf+m0S36OuCpZPzHdBFNFjzvKTWcAgb/dBScP65JbisTxj2742PkVAfM6uZLcW
	cunRR1Nqr07yXre0WCb5tDhlu4k2pOmVP5fqVOdshjlmYnTaySQKQQZB0fgpu7DPpsJHbl2q4OO
	N1X4ytem+5s0riVFkMjoWI6hsnOQtcQAKBQwVbpf+lOzhR7gt4zqbbMClT2g+rTFMD8SPMGkZyl
	mk2l3Et3k9nvJ7kckxevEJwVbDvaZrMaIDF0S27oKzV4XrdZSP1nUot3Sej0TjnNJ6Fs4FH3A==
X-Received: by 2002:a05:690c:13:b0:79a:53b8:820d with SMTP id 00721157ae682-79a71acb389mr55986507b3.35.1773888789286;
        Wed, 18 Mar 2026 19:53:09 -0700 (PDT)
Received: from pop-os.attlocal.net (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a7158aaefsm29015897b3.27.2026.03.18.19.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 19:53:08 -0700 (PDT)
Message-ID: <d7f70081b872136808a6da0263508703aa0d501e.camel@dubeyko.com>
Subject: Re: [PATCH v6] hfsplus: fix uninit-value by validating catalog
 record size
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>, Viacheslav Dubeyko
	 <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, 
 "frank.li@vivo.com"
	 <frank.li@vivo.com>, "charmitro@posteo.net" <charmitro@posteo.net>, 
 "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, 
 "syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com"
	 <syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Date: Wed, 18 Mar 2026 19:52:44 -0700
In-Reply-To: <CADhLXY7Cmtm+=_7Bvz2XkvFsPtL4bVVwvuMjHZVj3G6r5aXoTw@mail.gmail.com>
References: <20260307010302.41547-1-kartikey406@gmail.com>
	 <9924e9d1519afbbce87321988e0f4b95005f6381.camel@ibm.com>
	 <CADhLXY7Cmtm+=_7Bvz2XkvFsPtL4bVVwvuMjHZVj3G6r5aXoTw@mail.gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-19 at 06:57 +0530, Deepanshu Kartikey wrote:
> On Mon, Mar 9, 2026 at 10:49=E2=80=AFPM Viacheslav Dubeyko
> <Slava.Dubeyko@ibm.com> wrote:
> >=20
> >=20
> > Applied on HFS/HFS+ git tree. Thanks for the nice fix. :)
> >=20
>=20
> Gentle ping on this patch. Just wanted to know if this is pushed to
> linux-next ?
>=20
>=20

Patch is in for-next branch of HFS/HFS+ git tree.

Thanks,
Slava.
