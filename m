Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816689;
	b=zKLiQaYU5+YiijYzgW1+FXp+U9Ra4yo18d9EefDKzVvUBgSDeFFA/wpFpZ57Xd4bao4Z
	 CUg+ZNN+I15vMR7C9QOkp7KiD8LzYsLCFVU3F53ns8UVFBQcXx+7z1kY6HkB33X5/QOEf
	 h6jHWeKBhaHm16B5O1t2XrvxFtYy5X4T/08p0cHS5uThypKrtrt4UXeDoZ2A/PvE/KzNb
	 Mg8mgXLqSyndluhTQoosUj4O5CjvHAlgkcNzXXa6NdG2dbFw7SWyfAd0lKhMQzTVfNVjZ
	 EqLuGUvQ/PAyXYffg05dZTbEMthRqLjsMWBd76RfMsnAqG881LaFWCsFL8zZQK9aERA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=kyRnP5kwtYUNzzZDX5JFK75xNgkANSF11ZGqIG35Fvs=;
	b=OLFCsZPp1i6UZkg0375/FplvOecZnx9zsJ49XzdyPvhGb9c4u6/joM2AOwBvg5rVXknv
	 sO9dNxvUfAzrct416/t/ncRdJRrH9m6x4Gw1O5YoN7T+h+KVTliiZ2IG6VxLJDFTVwFn6
	 hsgVSktr5ySXeNKG6GcYgLZK4qm9DCPFVkIsGega6mFnoVX9JBjoVVFdfl4OzfK8jjRsq
	 a2H59UqjRVODUA7KjzAqF4DgF3twsDakJjbtQYwv2zHwKBDvyZHieCcBzFEReTk/QUxxO
	 HXc2z+tS+eL684+g84esVYD34IP6xM2iKutqoXJfcgt74cir/BbtC9CSZM7khaRfzbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="yp//CuVQ";
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D4B606A88C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 08:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55D4B606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yp//CuVQ
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso1698916a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 00:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794816688; x=1795421488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kyRnP5kwtYUNzzZDX5JFK75xNgkANSF11ZGqIG35Fvs=;
        b=yp//CuVQ6tdrKLYMsacnTGDNeVRcyjdQPnqJDsgEXE5mjxTaLLY2IDkO3w7/4LERF1
         ck7lG4y3JaDaUuNlqPyw2Mw9nWyIr3hTyvIRQGAxPWboDb4jfNOsmx6E0ddI2EvZKXNf
         1EzOJ94n3fEeNM6PndtETCPxRl7lBlNQjikHLpISJLcNFSAbjSYybnM24y/0ZkDvOxM7
         fEsYH31XCbEyXeZUpITz+ilx7YDm40vc5mYDu652koEjNkgebqAu0ci2xgm5lQXExJez
         uDWoyq2mr6ENsOBjoSt/enoPs/pdnn9oYAXO/OjDCyq+Yr1IhOXlKBP6Zs04H8UGUNDP
         8XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794816688; x=1795421488;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kyRnP5kwtYUNzzZDX5JFK75xNgkANSF11ZGqIG35Fvs=;
        b=WAtvEzE3YUQHrVelof3w23z7KUp/312hH7BcN6wvzE89ICO/Hc4PBIh+mg2P4xpgfa
         CCEN2jvK+Y2cL/K+W8XPUJ/TxJgjPE/QMIrgfrAo0BC7QPQ5vpGGLVIUl65b05Mix4wu
         CYk7b5KhHVluAvI5I+GciOa3kRfbzNNumNTR1YVH8nn1TdIDKSow/TMd/8dTmsqbELft
         S5wpwwssmE2nyJTJA88XdfErFkLVXMAv0mM41zjMYg/cSlawOD1A6PS6LhoOKMpzpXPV
         /s6PeEG3qUnMQQvc8DcQ/9G9Tl5zPevogJGX6glBHeTFtelAcIRoo4WgXTm481IGhJOH
         bdjA==
X-Forwarded-Encrypted: i=1; AL+hErEl/ZAZubEc+n+nSAyMQ/+tUVjTtNbl42bRBgalzcvtz56uDGD0Erh79sAf1NudE1Clp5/2UV4lxDfSEjeh@vger.kernel.org
X-Gm-Message-State: APuU4Z8+YNPFb+bjKEUK3mzKncT9hkWHxWtXjlB/0MsorqTxvKrdowQ7
	S/zZ46K9Yq3o4rRXniWsLonIawE3RvVFtytkV/RmEFGeZSyRZMU10mCZ
X-Gm-Gg: AZFdTZcg/XVKssgp5XTQpoyIzkBPL3M85wxMdbkEL4cELSUk60waFNgF0ytouakxquQ
	VXB8SLtW6fFCe+wzLQ4ZbMuDmwbU14fXXVLpIfzifh6vFqEFouXsS8rXSF8L4449pbTsq2h6r70
	kn2W17OVydg7xHn4yDJ4PTBTE7xcemlXlv9FW5IiumfB7RY6Kz+fqv5hWJju0QcOLi4E9PgjoRn
	RTezKKFqSaNH0C6pj959JvSE5QwLgBzrBFYLLKzoc7DVf04AKIfegnUuYt0fP4pcB0XWWWL6+K3
	sfIth4gs5iqaa0pWb9wHnGcf3TMLGJtHQ1udskglcgxVFC9ONnYCPTZWQHUwaOYWKHcUm12QYQm
	zu3oX/AUCoIB8m4jEd7uv8Zs9HYRjB3B9pMiv3VYpfTu7Ct1iaBQKZwflzQFQq2W3mhaEKCx+Rc
	nsD2BoyIEbX72FlHbNeNg83qcjX7kpdJiHPVg8KzBuITEnp7HN25X4dalZ3a51ayHMklJvbwPkC
	+j7eraGPdERQ3n0BJqhwOsGIi7jzmZ26QUGKsea5Abu5ZVij/9V4OUCm9vP46qUJljr+nSR0EcP
	UDrY09DbavtBywYdQiNSvXN8zVA=
X-Received: by 2002:a17:90b:3f8c:b0:39e:59a0:46b5 with SMTP id 98e67ed59e1d1-3b1b0b48069mr13299563a91.24.1794816688457;
        Mon, 16 Nov 2026 00:11:28 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aed76f95sm15087388a91.17.2026.11.16.00.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:11:27 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 8D91E4240780; Mon, 16 Nov 2026 15:11:22 +0700 (WIB)
Date: Mon, 16 Nov 2026 15:11:21 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fs: porting.rst: use literal string to avoid warning
Message-ID: <avq6nOcr_EddfFuz@archie.me>
References: <20260924183915.400588-1-rdunlap@infradead.org>
 <hyk4puvpheleitf4kt74aamqex2ytuxpda2iki5bgzoteldf23@pccvy6sdmerx>
 <avpzSippbZRkaki9@archie.me>
 <2571c5d4-f7c9-43af-b6ef-12f7414d4709@infradead.org>
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
	protocol="application/pgp-signature"; boundary="EWd/PLZe3Dyxq7Kb"
Content-Disposition: inline
In-Reply-To: <2571c5d4-f7c9-43af-b6ef-12f7414d4709@infradead.org>

--EWd/PLZe3Dyxq7Kb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 10:39:24PM -0800, Randy Dunlap wrote:
> Hi Bagas,
>=20
> On 11/15/26 7:06 PM, Bagas Sanjaya wrote:
> > I still see the warning on current docs-next, though. Has the patch not
> > been applied yet?
>=20
> This patch went thru the filesystem tree and was merged into mainline
> today (Sunday) - Linux v7.4-rc3.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--EWd/PLZe3Dyxq7Kb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCavq6nAAKCRD2uYlJVVFO
o7F1AP0SXQPjS8cB1zqpVD7La05w+0/TjhT7iNLWZNRXCiwExgD+MEBax1sxKgvv
9TIo24H31S5uSJmAUUhyTxRhJN2ieAc=
=Qfgg
-----END PGP SIGNATURE-----

--EWd/PLZe3Dyxq7Kb--
