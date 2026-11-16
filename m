Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794798424;
	b=AJcShA7vHGBcoUw53lkB7/euxgGM5aWD7Fn2znQ1BR3+hAH0SETiUf1ujKNzsTZZ0KMC
	 O+GDsanP9vR5Xaz936uT5KgZriX/QV/9Jv8nApZpoGelb7CGneca97aAMZztI4x4CyjIA
	 kqNWbRaGVrRSzMPY7SOVI0qKrnWcEDONxSu4nanlXrEFo/IEc/vg0h/3bE1Os639AlYjP
	 vksUbPakH5LpN+X08C+/RW47DSTLnjcBy6735w5KXuqfbX42QZX5EBPZFgnpQIAL3lny0
	 Sh6dEd52KHSd0dh3xya5Xv9+5yU9eBj7UWIP7xuuYU4CSl4yCJ6+zAsJGu0aTeq6c+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=DfVzAJ8JYr3tOeyUpGtQ08wEF3tJXXOK1aQTqHdgZsE=;
	b=Pva278K4E/FYYXOtF83EeQiBB1QVSFe+rjTEiu6wFbs+/KztEQD2+4FU10vr57HNP9Yi
	 TODBNdrI1Mt6hxJZsr7D14jYUcCFv8aJg5MOgzRCxYTuzHkdwhtmt7RrZtA3lVqrYMzaj
	 iAaJAKCnYVfxxq6G2VwrlR46mo8BpVkyQQUwbNRMhq288tkX7/bU8uXoLrNlUOFphIL5i
	 KpAH+j/Nf2g7CfcAVdhcYKWPeD9NbQUZwdd5U4U1j35Jxa6rdCZn65dg9eKyPKvuG0Djv
	 akCZkoeVdF4pMIQPIbzFfD5EugAE0a7yJ6pOk8fefPi53NR1fWc/+NDmsac+pBmDZxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kaqr0bjN;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA604606A31F
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 03:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA604606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kaqr0bjN
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso1195370a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 19:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794798423; x=1795403223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DfVzAJ8JYr3tOeyUpGtQ08wEF3tJXXOK1aQTqHdgZsE=;
        b=kaqr0bjN+QHNZOPTQJ2d0gdtYA5vBPiqzZjkPR3gzLC/zAlsFH7Dd5VLunDlMve6mh
         m/+tPJ2oXxfrm6ah/ZOBKfKMB/AK1QyfTjV0SSZQJ6QvP6PAoQ7ndUVzPbCTJhObF+a4
         euxOdqg+nVo3UpwlpWc3+BlSsZW6mzMZpzHzneuntMiQRsYl1thsjuk+t2CNmH1QI2Bp
         w7lj0D6kZ+WCTWUd534xL7Xx8UDAPM6BQ52NDMRIRaJX++lwOUKfwP7hMOYdcQhVYyhv
         4ok84pCIKmUsj8pon+pT70i13BLxPHBMqb8/nGy5CsiKYLoBLesG3FM2cYBXpiicSX+p
         xE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794798423; x=1795403223;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DfVzAJ8JYr3tOeyUpGtQ08wEF3tJXXOK1aQTqHdgZsE=;
        b=z0Qh0aKh6k/sj72/zicQgwM0a/PsUqZiRdv/8zrNSkyWriobfSWSf3vNPLaVepabkK
         Z0cQamUGpok0YcW5SIOvXWC7alqAAut0sX4AylltyTWnb2EFzdcHQe2WirMMME0I2hFv
         61YkLyM3dNWTB5Xk+TrJi1lgJpLflw7RwupKvDHs7Da4NoWyhhpm6l6Y0W+ysaCSnkCn
         ek5c7aADuN5QDbyq2DiNwiPpMWn7jJ9zfgiuBd9OiNBopSOKDLWyzqyDgY8J334Z/4I6
         I4Ksh5EFna0MHN4JqUBovQyfTu/kpk6K4AwZ/xmDTa6J4pBwyisEexkJXvYwxUsnesqI
         PAlQ==
X-Forwarded-Encrypted: i=1; AL+hErFXQCB8xzkdCZKovd8/6Oke7eoxHisi0DAGt+0GiatkIcTxwdwMT5djHp/GEWI7s07J7R/+w/miSH1o8Mde@vger.kernel.org
X-Gm-Message-State: APuU4Z9LVAl0Eodrhot77cqx9IlRmohDBb8PAe50wG5Bm93SrsBr1Lgi
	LHsr/sM5FJ6fH8VgVAi9744jWgaUUc6/ou/fXDBQ20Ei+8c+enTcc8Xw
X-Gm-Gg: AYBFou3vnCfU4yHMGV0aNobPSLqqc2RHhxOnWKJuRh34IrrkBn+8CtqrGvwTHniZq3s
	MQ1rFTjDmkfVpER8XYsBqGIqBQxv0iayrCDzkkWQ8TAMtxqsJ7TsXLFlh6qqvh9NEkJv8CQEpxE
	KE0Zpx8a6W8xbEG7Yp/SQUb44Q9UtbFHNNbtmyRZmN5SbW5G66CJ1WzM0hFRxkXNC2bOKFmz2iz
	92ob5osofilXnfBvw9mLJ8v+ikyDHfFfamPvwlFek6gQx+hEemKKEuYXKVWqTgl8OxXHDkV0Lnp
	4nv3nkiMI/VSv59fRlvdpp6roL3cTPw5wmkyi4PXiHKLamtwcT+TK75/tMuCkprCNiQbx1AxJEZ
	J4063+lUppdikOpzezjrjReoIc4DsQfOvzV9TaboYLCN6BcQnLu6lCYN4GrfcwTS8cxZJwzlLkq
	uLPW/4s2M7MBfteAlqQOe8GEV2YwQfj2IDPo4i5+uTc4ekaQTQz+5/i6SLl0ISrrrcHUBEy09mm
	d3MjPmiSerngJGFoMCJ9At9B8yuNvH5wleBuVXd6nJFN/SLGwjOYeROTpioYOjRIRAlqt8Xs3Wb
	MUHOmgUrvaRF/BmPJrryzH5ku4jBdka1o8TaPW3QZQ+X7uuVyA==
X-Received: by 2002:a17:90b:5627:b0:3ab:189b:6980 with SMTP id 98e67ed59e1d1-3b1b0a37140mr9756701a91.39.1794798422744;
        Sun, 15 Nov 2026 19:07:02 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb18b73sm14150263a91.3.2026.11.15.19.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 19:07:01 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id A907E423BF1B; Mon, 16 Nov 2026 10:06:57 +0700 (WIB)
Date: Mon, 16 Nov 2026 10:06:57 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jan Kara <jack@suse.cz>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fs: porting.rst: use literal string to avoid warning
Message-ID: <avpzSippbZRkaki9@archie.me>
References: <20260924183915.400588-1-rdunlap@infradead.org>
 <hyk4puvpheleitf4kt74aamqex2ytuxpda2iki5bgzoteldf23@pccvy6sdmerx>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2aSM361HPXJ12lPa"
Content-Disposition: inline
In-Reply-To: <hyk4puvpheleitf4kt74aamqex2ytuxpda2iki5bgzoteldf23@pccvy6sdmerx>

--2aSM361HPXJ12lPa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 11:32:43AM +0200, Jan Kara wrote:
> On Thu 24-09-26 11:39:15, Randy Dunlap wrote:
> > Avoid the docutils warning:
> >=20
> > Documentation/filesystems/porting.rst:1417: WARNING: Inline emphasis st=
art-string without end-string. [docutils]
> >=20
> > by quoting the const pointer in literal quotation marks.
> > (Adding a space between the '*' and the '.' also works but it looks odd=
=2E)
> >=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202609231806.ILZP6Fy0-lkp=
@intel.com/
> > Fixes: 025756ee7b47 ("fs: port mnt_idmap() and file_mnt_idmap() to cons=
t mnt_idmap")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>=20
> Thanks! Looks good. Feel free to add:
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>

I still see the warning on current docs-next, though. Has the patch not
been applied yet?

--=20
An old man doll... just what I always wanted! - Clara

--2aSM361HPXJ12lPa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCavpzSgAKCRD2uYlJVVFO
o2fxAP0awLC/NOAhUdn3hqtAYhGUjdvzKU295bC5dTxWWiP9pwD/c/ih5Jvt+/xO
1xbWcqLtQkEpyne9Ow5zvgkmhh7JTQc=
=tb6M
-----END PGP SIGNATURE-----

--2aSM361HPXJ12lPa--
