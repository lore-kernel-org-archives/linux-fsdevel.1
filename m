Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471275;
	b=V2WHq/k18siJBlSnk0zr31Y8khBFVzEVurcWf3L3UqEa8f/pz9hEaPAHit9LOUH/wdY1
	 Z2u81NBDlDRx1WkEOPK1RD86EPV4hwGEBlNJKD0u5cml1HrMd9Ml6D+eapeQwEArsh6GZ
	 z931TbBpzHOrDI7VHcFaVc1gAev+7/I0odFiYmim+3gFs3kuXQO/SEbZmkKL74+yUhTSl
	 QAhKJtG8M3nYJfPSIIdzboPtpeO99sLfKqVtREeWsxnM0BSNqa41npG4Kw6E2EzvqGNm8
	 Wuk/H5bU9js2g3+CsaIaX9CzQms8zn7E0REBTZtJdgaIJaFak2VCzc6lkpO1qATsx5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=SY2nTkEuXdqViHbemrvX2XFpBsW22sioIJ8+3WgQFdc=;
	b=LKADzSI1ZCPEzQfmhbHsWJysDIsQ8F0FXc1fPEnQvUqr/JSIcegl2KQzejq8wGPMTBgr
	 okxkMecHY/WpXBPrMBpXB+9fI3GJ7RGDb6Xw3RpOYBeoVjS8vKfI+LyIcQ28dpuh3fIsR
	 vojbRh0lIPmSSIAY7zz776lT+dUXHMxOvM8a/woupyepUljaCGBAQdQkjEMjLQIBQaeu5
	 VPSroY4z9+g9ekk/GLqQ1liiEWufBRL0cb6p7V2JuwcdIrOes2EnucJ5FbF3AAfjHIm4Z
	 6sEMJdstNYCP7lvKMlgvkP0JgWhSJdA0THUKGZPEKYzyh59PR7+V74+zeyVAwDS87Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="Bjymhk/X";
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001AF606A326
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 22:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 001AF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bjymhk/X
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b0d126f631so32132417b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 14:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795471274; x=1796076074; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SY2nTkEuXdqViHbemrvX2XFpBsW22sioIJ8+3WgQFdc=;
        b=Bjymhk/XyQG8bsm48Y7+wfvDjWkCY98pWPAZSUnFcA3N6aaY9bt5zIoD5Z6JC5r9Nd
         Uj+GhpoE/N2z69u9PySpmkGM+w5umihHmjJFidGfk8qLS3XlJxv8o9uaGo55R8QIrPRZ
         FzGErHW+hNC0oFCVgfSzTUN8fSq5zHIHP5Gm8Q6z4s/F+SMlQQYTbNPQqcIacLKfhIC/
         ywHvdXsFj1RhUu488x22yRo6ZcBI8KhqVu6V/6E9EJphPnQNBhL0Q9fVuLgc9sRvpMVz
         Hs6wz5A2l8j93874y+qBJalJrKFUH/LD5ucG8j6Pocx8d2sKciPJlBQBciuW5eXDoa/8
         EeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471274; x=1796076074;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SY2nTkEuXdqViHbemrvX2XFpBsW22sioIJ8+3WgQFdc=;
        b=VnPXPhFOMqjxBUxgMMOaoighiQpapKIt2GSZ3al2v/O0j+QJOGLM9A7xa9r8cEubVV
         wn15sIXB4382WxTLokvB9F9673hEth73CUtE76d3g0U9k5VlEXFcwvuKcJT3f7rmqPOZ
         iruSvJ2rUE4z7X8IXjEKLxhAnCZw7OmIMPi02YgXryaHQmOlqcwwdgnqBAJe5OH38egV
         vk88kERNFzXGBopL77r/xlmxYGIjUFAw6RRkaKe+OkmXsxq0yf44Zqiy+ZiJ7rTqPw+2
         AabEiHwnraxxhrQ7pvX8Q5iLX/03qfH41E1CPxJXXdpGQi2YE37uOT0K6dENoN8N0WsY
         Wceg==
X-Gm-Message-State: APuU4Z+BrTyp2iTgMCaBG7W480ItbwBwqTvXfK2NwSWIYCRupPLtGaCY
	KG+IGlp+h60swKHLk7JL77wq13xV5+1B821PSfsXY8oLj4dEtIbjd286B6PDXTdKLck=
X-Gm-Gg: AZFdTZeZ5ZdGATQWfkLHVcClIFhc4/joB6nUdEBz+zKXd+d5pEuhXcbFI5cVBhUY/l5
	dOxprsJ8pu27VO7qXpkjY4XrA/Fpok1vmotzKpaoPJgRhP1fcqE7cdEPyOVyvA3EfeicRW7dqyt
	I0UBosIN2WSQkAEdqfXxco0UlyRhWRs5r05EVpynrHqsSGCVMQk26ZhbDA+7pkk2PKf9OSaX+/O
	h/n2UM7vPj/8l6cjRqH+aPI3sgL1Zcbt/SsTI4o7xJRt9AO+NidHsBRyH34pe3JrbSmmPVOzyzl
	0kJhfBiSlP/NIxsAEv+JiwCOu5vKtEXT96mHTYooJIwmDFMaO6JjpEvL5O14S6SpLChNo9pb/8U
	hVsUMTqH+plDkl8dTPetbfv5v0POQ/9RSpOLR27IEHDogkNrRnmypVBnY2Jg7BoY1x9O78VrwIc
	X553PNHBH/t47STNQkSwlJZn7ePan2uPDokaZma+5SuFOJ2N00WLtI17zwx5knTomBZbmgdbSoR
	o2ZBtDzbpQlUgbFcW5zwhcj2CYqUlr67E5WaEABD/O3QZTnV5oKvTkcz5KIUdcwwsj4rYkYKi+y
	bPb2IeRaiAHxeTztRIBPANk8f08CiDcN0S0GeHkrOsnii7ZWG6Vf+86tkbx6M9ZJgmPeuyIr4e7
	2U83YtcIUUXSJVKGsJgL6A7Te5MNSXsq2cczQIIyQ8nOmsxACKSrOKE8kCijUA2M9FN43YSluTL
	6wQnefjiXsgUSW8eViH+PAitmQhPWfY+TStm8eZ7d9
X-Received: by 2002:a05:690c:9a8f:b0:8b4:d6ad:563e with SMTP id 00721157ae682-8b5204ebe2cmr53631047b3.52.1795471273779;
        Mon, 23 Nov 2026 14:01:13 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:83a2:1030:d4d1:10b8? ([2600:1700:6476:1430:83a2:1030:d4d1:10b8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202b085bsm51850237b3.16.2026.11.23.14.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:01:13 -0800 (PST)
Message-ID: <901ef6fa26b3a5a876ec7328a3ce801572bec200.camel@dubeyko.com>
Subject: Re: hfsplus: mount loops forever on an HFS wrapper whose embedded
 volume points back at itself
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Aymen T <atijari00@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org
Date: Mon, 23 Nov 2026 14:01:12 -0800
In-Reply-To: <45bfa4d7-e9e2-45f2-9e12-a794defae64a@gmail.com>
References: <45bfa4d7-e9e2-45f2-9e12-a794defae64a@gmail.com>
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

On Sat, 2026-11-21 at 19:17 +0100, Aymen T wrote:
> Hi,
>=20
> hfsplus_read_wrapper() follows an HFS wrapper to the embedded HFS+
> volume and re-reads the volume header there:
>=20
> =C2=A0=C2=A0=C2=A0 case cpu_to_be16(HFSP_WRAP_MAGIC):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!h=
fsplus_read_mdb(sbi->s_vhdr, &wd))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_free_backup_vhdr;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wd.abl=
k_size >>=3D HFSPLUS_SECTOR_SHIFT;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part_s=
tart +=3D (sector_t)wd.ablk_start +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (sector_t)wd.embed_start * wd.ablk_size;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part_s=
ize =3D (sector_t)wd.embed_count * wd.ablk_size;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto r=
eread;
>=20
> hfsplus_read_mdb() only checks the embedded signature, two attribute
> bits and that ablk_size is a non-zero multiple of 512. With
> drAlBlSt =3D 0 and the embedded extent's start block =3D 0, part_start
> doesn't move, the next read returns the same wrapper MDB, and the
> mount spins on that sector for as long as the device answers. There
> is no iteration limit and no fatal_signal_pending() check, so the
> mount(2) caller can't be killed. The default: branch can loop the
> same way: hfs_parse_new_pmap() adds pmPyPartStart without checking
> it, so an Apple_HFS entry with pmPyPartStart =3D 0 sends it back to
> reread at the same place. I only reproduced the wrapper case.
>=20
> On mainline (65e4fd942f72, 7.4.0-rc3) in QEMU, with the image
> attached
> as a USB mass-storage device (qemu-xhci + usb-storage) and mounted
> with
> flags 0x18e (NOSUID|NODEV|NOEXEC|DIRSYNC|NOSYMFOLLOW): mount never
> returned, and the device saw 62,680 READs of sector 2 before the
> 120 s run was killed. The same image with
> ablk_start =3D 8, embed_start =3D 1 fails the mount with -EINVAL after 5
> reads.
>=20
> Fix: refuse a wrapper whose computed part_start doesn't advance (or
> limit the number of wrapper/partition hops to a small number), and
> return -EINVAL.

Would you like to send the formal patch with the fix?

Thanks,
Slava.

>=20
> Attached: mkhfs.py (python3 mkhfs.py wrap_loop loop.img makes the
> image; wrap_once makes the control, which needs mkfs.hfsplus).
>=20
> Thanks,
> Aymen
