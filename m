Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471715;
	b=VdcR90LJWglebJbuDS8k+wmTiFDyNc5l4QHCKHqAaBFTIASvKmb/DZNBdC/7uBf6lTVc
	 jtwyuY0Gob9FRd8xZKNeAKviDmVqNNeJivoesBgiZ66+ds6iQHj34m1jmH25+I/71hHmw
	 U2bgIqVmGWzX80l4EJKVnWKajXMF33GdwwdInDcP42pHRrhb51CfRvtaMP0SlgkD3QFlP
	 AkrIg2HumM2xV9wof1wV/mhTFTPVgSBUfmTE1cMZIIVBpXmvXlzZI7gOqGhF80v7rsa/B
	 A/RtLdIt5b6GYKUe5OqZr0fsaMcMC+5dMhFwGq084y03b8he25TdyEeDwMLbpkTNFZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=texhqw2pvQKkD9Xg5Q6V731C0QC/tI0cOgwUzIDMtYU=;
	b=c4cgR9bJBYj8b6VP2cm1+UhPfgzIpt/qL3YXK4nAR2H6RQw1KgZrQKV/oqFDP25g+Bm5
	 Qe4aoykJoTdH1zXXh7iRboyJIPcuo+6ITtWoH4gcGUroUZo1pMIiqlVC5fbY5WzdQwzMw
	 MRTCPSV/FuNR2nbdlk4sfMEvdw7+SwaNFAr9ySpmjfoZ8LBpp+7nlNMZZyyANC/TlfP3+
	 w13Q2olH8xfmTnSBSasdg+Bof4m2Hn6JeqtThVGvMbWNX/ursIj8s4fAIwSMQG/CKmtu0
	 WJIKjdK8rhFa46uhp1oC07ePJ3eJcs2xTATckfwEX4vt3wBDxNZSU9OGiOxxBnubb2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OE3jPoD3;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F032606A321
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 22:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F032606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OE3jPoD3
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b502b9b702so43841137b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 14:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795471714; x=1796076514; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=texhqw2pvQKkD9Xg5Q6V731C0QC/tI0cOgwUzIDMtYU=;
        b=OE3jPoD3spWhMvRbeMqnBiUcuvpHgiCIcdYnEHVo93acqTBgn3ar2ZB+IUkSDfnesi
         MvurJBt0bzEEA503YO7H0vRhdda5zHDaf0+oW92cnQyWxuFd2uTLuKz+kiPhJe9TbhEB
         yLa8/rQDmMg/h1hnPe8hLe6+ae3Go3XvCddngcQhY4x7eeuyVPW6PTZyokbzQsRwdij1
         NpdqNSwyU5c5E8/RVhZJWxGtc13NfC6CgPdYmn9Ow40BSBBrWh7J/9i7Qr2+ETyMLB+t
         gu+ZLrLgnwPlMYnYZM0vN8olDIrvaYaPVku8wt5ZHpsYZ0RgvKc2hw2Ucq3AjON9dVaO
         7fMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471714; x=1796076514;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=texhqw2pvQKkD9Xg5Q6V731C0QC/tI0cOgwUzIDMtYU=;
        b=tyPOO9f2+wciiQL0JVE77qJYLxaChp5UZKz8WREObP5JzvjkdfMFhxp44TieBuBUpn
         m9SVrRsj/0sCRgwbv/rq5BJvwnEZnN3L7p2VlHojOhfs1Ttt3tf/ICLI6SMermwSsGEU
         oMRtNhUQEwaxDKCIejn1eWw9osemB7FgU2cRGHfieFZjcCf0pmzSdYRC2bfBEIUMwfv+
         cTnaUQNVBsD2VxvfkMdLDGYP6Hpe5IEO6zXBDcBpJlY9hrWvTwm/GEmfhZBLL9LaNVT8
         630dWd3hAyhR0zV1aRo5tGAmKbqS87ynRIs4O2KfyBE2jcPpDJVp9wZ4dHYGkwApY6df
         Ygkw==
X-Forwarded-Encrypted: i=1; AL+hErG2pg9AUEjeyZG9LJEmjfV+MREUuwi4pGcDc3sAKI5fMvllzVVD8wX4yW4duq5vFvdexM4VKde+m05Xhlj8@vger.kernel.org
X-Gm-Message-State: APuU4Z+6ya8WqkueID3p1HbXf8vwQ/WJ5ayC/hRJBkDz41WQ8rGhoduy
	HamYW/fpk3dMxuQ/qDXmwdjoX3agoFSVs8oV89GsDDCOW9lGDNO7UAo5ebrPtVQrEvY=
X-Gm-Gg: AZFdTZfp8CYtdGcDAcjv2c17ujuD6wOZbYlZraDWUCSVFfXESh5iz5fAShz2AAxo86C
	NoV0J5tM9wMRwpiGoYW39fpWpLcvHCt5/jDuKZA7D3a/RCtVnHxP+DJ9hI/gJu1LQcJ6tNq0ogs
	8TShP+6XxosqUXKjdkXZPOPdSuu3R35J9vi4ltcIVwFR5iPGg1li3RsxoxOM6U40vO7ah/1gA/p
	Pi8hNH6HMLhPjlT5W6iXYptWoGG+yJ9JSpRpKldAjUxsM1YupPfBWU3MdCVyL4Nf72i/RZtb1mp
	FqssVTeTEinZyhX4K3HpSw1dRVmjYPW4e7L+5Ttag177u5UrKthm+aIL/v8ROkF1olKKUfzF0n+
	l+PW/TAREgF3o5Aph+fUXMTaHwOKrD+vbC8nAXQe1y89wIdTye/iGQRGTLp4TyFL/N1Gcb1CwWn
	+UdRd3s20A5ybaZSUiBbXi+Bo4dD7/+/j03y28li0a0Us2aEIGmipCoK+mO5roi4yBws4FBY87m
	+kga1gpwwGP+/IqLzfMn/p5AO5Lbc4ea9jquJL5N8Hibl9XGW3ibGswhJKKBF1AcMnSwjfQIb7b
	Q4J9v94KbpDRIB+74FKYLzI9KldqsPwTFqlFBAcqWUtq+W5PD8k5m2tkrsrwscf0PwyVbInjqd2
	P69VfNNFrnbagqC024UvsznHrfKUlxS6Al5FZxFHdyn+4V4IjJT0yAgxieuDgO7fA+eeIG5nZTQ
	XsuVQsOJSJga/4gjEKDqQ=
X-Received: by 2002:a05:690c:2a44:b0:8b2:edac:7a4c with SMTP id 00721157ae682-8b52042bedamr45656947b3.10.1795471713793;
        Mon, 23 Nov 2026 14:08:33 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:83a2:1030:d4d1:10b8? ([2600:1700:6476:1430:83a2:1030:d4d1:10b8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52030df7bsm52275487b3.31.2026.11.23.14.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:08:33 -0800 (PST)
Message-ID: <fa6344cbb419012d7deed74d30ae6062eda92fc1.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: avoid reusing occupied CNIDs after deletion
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 23 Nov 2026 14:08:32 -0800
In-Reply-To: <20261121101918.3395879-1-hengyul@cs.unc.edu>
References: <20261112110128.4082071-1-hengyul@cs.unc.edu>
	 <2bbc10eb1dd5ee69329a9307f14fd15b1815b898.camel@dubeyko.com>
	 <20261113194103.3825961-1-hengyul@cs.unc.edu>
	 <f59ea6b2a8c60594361ab596d92bdf98a217dd83.camel@dubeyko.com>
	 <20261121101918.3395879-1-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
 NFdvziOa4FgUBC4X71upsZIoZJeii2V/Jtc3B4g==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, 2026-11-21 at 05:19 -0500, Hengyu Liang wrote:
> Hi Slava,
>=20
> Sorry for the late reply. I have an important deadline in early
> December, so I may be slow to reply until then.

No problem. Take your time.

>=20
> On Mon, 2026-11-16 at 15:21 -0800, Viacheslav Dubeyko wrote:
> > You explained a simple case. :) My worry was about the case when we
> > could delete some number of items between [16, 20]. For example, we
> > delete 17, 18, and 19 at first. And now we delete item with #20.
> > So,
> > leaf A should have 16 as a maximum CNID. And we can use 17 as a
> > next_id. Correct?
>=20
> Correct. I ran this case with the patch on a fresh volume. Creating
> a, c, e, b, d gives CNIDs 16 to 20 in three leaves:
>=20
> =C2=A0 leaf 1: root folder (2), thread of 2, a (16), b (19)=C2=A0=C2=A0 m=
ax 19
> =C2=A0 leaf 2: c (17), d (20), e (18)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max 20
> =C2=A0 leaf 4: threads of 16 to 20=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no file or
> folder
>=20
> =C2=A0 rm c (17), rm e (18): not the newest CNID, next_id stays 21;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaf max=
imums 19 and 20 stay
> =C2=A0 rm b (19):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 leaf 1's maximum has to be recomputed, the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root kee=
ps 20 (from leaf 2)
> =C2=A0 rm d (20):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 leaf 2 is now empty and goes away, the root's
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum =
has to be recomputed: leaf 1 -> 16,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root -> =
16, next_id =3D 17
>=20
> The next new file gets CNID 17. I checked it three ways: with the
> values cached before the deletes, with nothing cached yet, and with a
> remount between the creates and the deletes. A debug build that
> compares every cached value with the records after each insert and
> remove found no mismatch.
>=20
> A larger case: 2000 files created in shuffled name order, so the
> CNIDs are spread over the leaves. Deleting CNIDs 1916..2014 first and
> then 2015 gives next_id 1916, and the next file gets 1916. Without
> the
> patch the same steps end with "File exists". fsck.hfs reports all
> images as OK.
>=20
>=20

OK. Sounds good.

Thanks,
Slava.
