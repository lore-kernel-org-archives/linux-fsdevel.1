Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6342189A
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023814; cv=none; b=QrX54KLt7eoskKoiP8KFiOq6XAhdsTP09wL7h+i2kqaAdD4c86jxgdMc16aruzEddJXH5Qh3nC5jHFJJrjrmMxCI962tUA/mvAh7+/TPWuWXCSldFtdSQqnfQFbmZ2oaKzGssbSVOvVpdPowXC/IkW1AiQR644446yuzkecxjLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023814; c=relaxed/simple;
	bh=X3K9qdh7Tf9RDZCtV5EdqxBRQS46K7s5k0giJtc0++k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFByvnaaU7gLstLqQHIzaiMCs00OKkfal4JvsqT4m9ApdPp4tD9ZhPG0EoXkiZe8+ZpwMZ4UsowSk6TwqaMCtVygIANHgo30Xk1II/0BUIvd+Q2+9G7vNknfhmIrLo84QPIm1h0OesjqpBLT4r/Cw46kEutAQb/Ql4Ww5FxJ1OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=lyYrPvcw; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="lyYrPvcw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=489; t=1781023386;
	x=1781628186; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Autocrypt:Organization:
	Disposition-Notification-To:In-Reply-To:Content-Type:
	Content-Transfer-Encoding; z=Received:=20from=20[IPV6=3A2603=3A7
	002=3A100=3A8400=3A69ce=3A112=3Ae466=3Abece]=20by=20auristor.com
	=20(IPv6=3A2001=3A470=3A1f07=3Af77=3Affff=3A=3A312)=20(MDaemon=2
	0PRO=20v26.0.3b)=20=0D=0A=09with=20ESMTPSA=20id=20md500100535393
	6.msg=3B=20Tue,=2009=20Jun=202026=2012=3A43=3A06=20-0400|Message
	-ID:=20<eccd8c0d-b484-4365-90ec-f5f677f276ec@auristor.com>|Date:
	=20Tue,=209=20Jun=202026=2012=3A43=3A34=20-0400|MIME-Version:=20
	1.0|User-Agent:=20Mozilla=20Thunderbird|Subject:=20Re=3A=20[PATC
	H=206/7]=20afs=3A=20Remove=20erroneous=20seq=20=7C=3D=201=20in=2
	0volume=20lookup=20loop|To:=20David=20Howells=20<dhowells@redhat
	.com>,=20Oleg=20Nesterov=20<oleg@redhat.com>|Cc:=20Christian=20B
	rauner=20<christian@brauner.io>,=0D=0A=20Marc=20Dionne=20<marc.d
	ionne@auristor.com>,=20linux-afs@lists.infradead.org,=0D=0A=20li
	nux-fsdevel@vger.kernel.org,=20linux-kernel@vger.kernel.org,=0D=
	0A=20Li=20RongQing=20<lirongqing@baidu.com>|References:=20<aifae
	Kvz3KemfzaS@redhat.com>=0D=0A=20<20260609081738.770127-1-dhowell
	s@redhat.com>=0D=0A=20<20260609081738.770127-7-dhowells@redhat.c
	om>=0D=0A=20<872443.1781020385@warthog.procyon.org.uk>|Content-L
	anguage:=20en-US|From:=20Jeffrey=20E=20Altman=20<jaltman@auristo
	r.com>|Autocrypt:=20addr=3Djaltman@auristor.com=3B=20keydata=3D=
	0D=0A=20xsFNBEwLlO0BEACu6yWFkd1+qwsGg8ZzgslSkcAKhSegWt5j86DpaRL0
	W8fxg6YjxwEPvwoH=0D=0A=20BGa/rpSdBd1gkmzeYxD3hVZdj75r6nVS9f/mxNQ
	zW+o1sW4vaeSxKgZSQz5RqHmwPDcqQP66=0D=0A=20+ZSnjV+G88MKwZ9DIzA9Aw
	pJhNAAlAlj3OvsQVsxd1ipc6C4/U3qjHL7Ih22UbPBM71ltIZx=0D=0A=20kqcrA
	lXPnUTeraJXtfzYbq4mJFJ9JC6/o1NRSjsBvRD+ADxlG50+KccZN4SS5xxdGuh1t
	A9U=0D=0A=20TydYBQB3YtJbq7CYau2kIYt/3HnyLYGo1s6Ti6cuAJJ/40iIE1xk
	qhvMiIz/Q+1ztmksJbLQ=0D=0A=20aCtW8kF42nF8MpPdIPTSPr2uGvpRtCjRbh4
	lgMXgyNUx1wpCEY0X11xce++H8HySmFwryE2y=0D=0A=20kkxUQeMUjaaXZDHYUS
	yQz7riChFiZ9ax9dmX0wUY/A05v0qcualglpk4wJ2kcsGKUEGkLvnV=0D=0A=20w
	wvya8zifPwKOw5JlGPvzX8t2m7jB2GXKzvVAsImqOqnDBTKUXWQQZCW9Rqt7acdE
	8bQ2vqr=0D=0A=20vP+3Ykf4SrPwcuNCDt6QSgjVbhc3hA3hCtE1iW/HhuBAzKiu
	zJ9era+q9QjTtLPIkQDHRpcC=0D=0A=20MMWvK0Y1uQ34Ql1BfKRA4gc8A7CuVUY
	6+Ga7PuJWd+FSglvmKQARAQABzTZKZWZmcmV5IEFs=0D=0A=20dG1hbiAoQXVyaV
	N0b3IsIEluYy4pIDxqYWx0bWFuQGF1cmlzdG9yLmNvbT7CwXkEEwECACMF=0D=0A
	=20AlY2YwgCGyMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRD3enNVkraaB
	DdzD/0XQUDW=0D=0A=20UWXrpapHdvZaHzPHc3xobRi4PABWfLW1jfMK5Xy4DP/x
	7x3I2qAqTD6vv/OPFMx8gG6+Xeod=0D=0A=20Mj5vE7+7ZRd+J76J4DJH2qoaXX8
	qnUEABUJHZYDhw2/Ij5AQ6ZsuSwXuURGEMi0vu1ihBbP6=0D=0A=203bt4LRIa+F
	60ebDvCl9po+UB7TrjQCs+YV1r1YeCSv9hEHBly/W0u1OrnNCMWRcq7dmTCbZ0=0
	D=0A=20R5w6VJ/+QEio+T6paGGMjJmrNw2qUeuK+SxOOxOWS8lgdqzjcK3NsfiER
	rVbOWM83ZVy0/GN=0D=0A=20vpusjhI/3Q8lbV/p+IsJk/v1grkRzgU0frES2ANE
	PTpC4j2ggPOSMpsz3BZ8wIOg17rIWnK+=0D=0A=20gNLQe+XN7kvDwGu0jYhTIZO
	10jcVsRSrAJGtgBNrYxOjEUhpnaSJDVcjapRvRPCQumA13Zkl=0D=0A=20nm4AYj
	p7L2oOIeOGcKRZwbrGDakksa5iaSIoywpwECWh2l9V0W3SeynBgPtR4qpt4N8yKC
	cw=0D=0A=20suLCAKfBv9RcL641XZi/Fp9btSuTPUm5Lw3SIGr5U+SyezmhzlwsO
	bIF9W624aorriWoXNf3=0D=0A=20GgH9ZH0Hkc6aS99pIZhh5USWRO/pS+lv5eNk
	Edf9LUBGX9b6ZMan0fpoEayqUejtZw3O2rgs=0D=0A=20zA+pTSA+/HobvtL6L3X
	tlPJ1NXlkgM7BTQRMC5TtARAA88hJdpgcg2RU/uAWfAL46XZHA59c=0D=0A=20Vp
	PNNly1tPWCSbG6+ONH6nOG/NarmNVxX6Mb9YRkEU6wmrZS85inz3otdyz/zlyNSW
	ma8qGN=0D=0A=20UlMbiwFQqfXWVBAPGoRC0a0aJrd4IayLuvv1UqEwx7Otp7y5R
	NHtRv35/kho0Z+UheYVdGm2=0D=0A=20I06xIc+aNKW2LO7R5BNtjpADPIG+NSds
	VIeamhAWPvLrwbf6mUb//eA9pF0w0QixLVrH/cCo=0D=0A=20z+S27gCGJvY6zF2
	2NgdhnkIqNz8E/LKt6S36ZI9Mw/ixpQTozqRmdNzVQNgTHUZClbJj4iq1=0D=0A=
	20EPHB7XqpxOv+awrxSxq2jt8GFD0rU+sAuzW+F7cBoIw434/IrxKYwcPHpHLEVQ
	1tLP7d3ZpZ=0D=0A=20R30p3oqoliGiLsWvHHxyXjuMBF4XJ6MRXmD65/qOhuo2D
	KduHMNlmxzgSzvWgXZeNJq+OcS8=0D=0A=20jQZDt2Na2pMKjWytau7xQu2ndm0F
	wS48ngMrDYRQMxzL1NfnBnT9BCwjiU+/6NBSwcNKIqye=0D=0A=20a9IpTwsVfkF
	4/iui7xD9+LtzqeUkBAe7q5jEJmJMZhAfh7usZGT8TGxXegCaF4Jwz2nxS4Fv=0D
	=0A=207VRza/yUAOJlc0daR11TPeiUNCQWY7PpL1AXO9vaSyjFuOzTnU8vzXvI9f
	GoxIxKGRQpKMU8=0D=0A=20PROIFw0AEQEAAcLBXwQYAQIACQUCTAuU7QIbDAAKC
	RD3enNVkraaBIxXD/4xlaBwW2TLFfMv=0D=0A=20lcY/2XDSm6NO4JaJG2Nzp35x
	aaBVwMVzWvI+GgTgKNSFot9f4jiLBNQdnq3UKoEThR2ORKVL=0D=0A=200ZJS1QY
	R7yyrOo0MteDSy8ofU1FJ6xu4ND3ekOjP20BTrihDpqUdahir2uaRfMkwM+0imOl
	c=0D=0A=20utGMhJNF/LAjrhoDp9SeDMYBXZ1wfrbrEo/EEu0PbkGyzqPyEPqwN1
	iSJkcAnjuIA0rTf1jQ=0D=0A=20tJAaDov7yHsSRwUM+qTGsjOGQAN3wtYwjPpw7
	hI01sE+x0uq0pVeo4qeWTZ2TE4Vtp8FKXFA=0D=0A=20kqnP878q+kNk9Ve+DRs8
	UlRfa9Lgf5ETjXOTVGaT/UGxi9B4oo8k0lzvM/A1txexL/lLw8AU=0D=0A=20LhU
	eGtyS6D2X9vFi6azna+o918R9BV86uXPiDOf1nMwqKchNCxmgH9vd0aQm8TKCrWA
	W4kU1=0D=0A=20Ig6aMNuZiWloVZfKrmWizbgeGKE9rhNPNqxkqBaA4lrJ8L6bdK
	bhAOe3NQjO2vUAXB53Jphl=0D=0A=20F74GwEsh+85i9/yIbvwJVcsFYhdZz7fCA
	UOcnFkGnyrwIgkizQ3xXShPW8mqkgUk4kYMnucC=0D=0A=204kG/E7pI/4lke5X5
	X9vroXRHB7tkpAgT46SqSM/XTwCaseXG9orDgz3duRTUp6K0++S/qsqT=0D=0A=2
	0akGVmjD5917A1HqWfMmiKA=3D=3D|Organization:=20AuriStor,=20Inc.|D
	isposition-Notification-To:=20Jeffrey=20E=20Altman=20<jaltman@au
	ristor.com>|In-Reply-To:=20<872443.1781020385@warthog.procyon.or
	g.uk>|Content-Type:=20text/plain=3B=20charset=3DUTF-8=3B=20forma
	t=3Dflowed|Content-Transfer-Encoding:=207bit; bh=P8vS9ugW9p4ar4J
	BbXaCiHuri8LjBvc23ANLdpJQ3wo=; b=lyYrPvcwtB7oRGc4LPOzQsM03Aj3B22
	OqBSDMIBrGKG8zyEjWjcwJ8W6ymZ8TnKQI3R7ayYcLPFjYb65P9CjpJRd3A6bmhn
	iE38P95iRjrGQ8iDMy39V+Dgfmd1KZhBueYRilEgFhCKAtPbNv8CL6kYsUGL0CRe
	XfhEn8AOY7+U=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Tue, 09 Jun 2026 12:43:06 -0400
Received: from [IPV6:2603:7002:100:8400:69ce:112:e466:bece] by auristor.com (IPv6:2001:470:1f07:f77:ffff::312) (MDaemon PRO v26.0.3b) 
	with ESMTPSA id md5001005353936.msg; Tue, 09 Jun 2026 12:43:06 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Tue, 09 Jun 2026 12:43:06 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7002:100:8400:69ce:112:e466:bece
X-MDHelo: [IPV6:2603:7002:100:8400:69ce:112:e466:bece]
X-MDArrival-Date: Tue, 09 Jun 2026 12:43:06 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1620ec93a1=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-fsdevel@vger.kernel.org
Message-ID: <eccd8c0d-b484-4365-90ec-f5f677f276ec@auristor.com>
Date: Tue, 9 Jun 2026 12:43:34 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] afs: Remove erroneous seq |= 1 in volume lookup loop
To: David Howells <dhowells@redhat.com>, Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
 Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Li RongQing <lirongqing@baidu.com>
References: <aifaeKvz3KemfzaS@redhat.com>
 <20260609081738.770127-1-dhowells@redhat.com>
 <20260609081738.770127-7-dhowells@redhat.com>
 <872443.1781020385@warthog.procyon.org.uk>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Autocrypt: addr=jaltman@auristor.com; keydata=
 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
 akGVmjD5917A1HqWfMmiKA==
Organization: AuriStor, Inc.
In-Reply-To: <872443.1781020385@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDCFSigsAdded: auristor.com

On 6/9/2026 11:53 AM, David Howells wrote:
> Oleg Nesterov <oleg@redhat.com> wrote:
>
>> Yes, but now that we have scoped_seqlock_read() we can make another change
>> on top of this fix. afs_lookup_volume_rcu() can just do
> I wonder if that would be better as a separate patch rather than merged into
> this one.
>
> David
IMO, a separate change would be preferred so that this bug fix patch can 
be back-ported
to stable where scoped_seqlock_read() is not present.

Jeffrey


