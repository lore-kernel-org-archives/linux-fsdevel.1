Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D524035AC09
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 05:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786686349; cv=none; b=qcZiVn/MRiVYjf3I34sBnyN+e/Yibh9Jz2ofTSYzleGjZvEI3HGFNvlz8M7mLUxfRtS52h5r9RLtuxvh0ND9Gs1O/FzqlbwgkdrHF6LD3Vwpy3SjAiJJfUslTL1pI2WzywlmnllvK2zIalDpLk0Z1T1XHCWDi1w6mVd2rTtI4a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786686349; c=relaxed/simple;
	bh=IqJTfn3nxl/wh2BuwF0tiSKaZByXqSGak7Whm3DarVI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JENWZ38RC7EJLSS35NW5PGqdSm2B64ydfXzHWQXKDdMsd8/CB5IfegX5dOjXpeYOj8yO00YIU3RSCZoSDrIuqbs87lsq6G3jd0z51WYKD/wZT7EABhTWcD+z8IOJ4fFsHpy1mk9UU52AD0HwH6lK2SoQyfcZgPMYQUKB5I95bB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NKkojb0F; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NKkojb0F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1786686328; x=1786945528;
	bh=LHEr8JORQf0eFUpUSDFqX7M9wlb2jOaEB5UsvbzUnqI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NKkojb0FrOAHFbMe9rrNRIIRVGJs40l6Iqrbr0Rbj6LRxE/TRDNXBcmTvH5rYAniG
	 LvsW2tzto3ijvR3MuNQeKoIm4Br4WljzsmpFpc5T965etUDZh4K1OZzg2zCQb1Q6Dr
	 SoClf5P0EIwJ5brlFo0LeOcnTt/5CSgGmoh+QAbxJUQls54YG3xXHFmpHTb994ihAE
	 gHzgGRPuDMLabBhiSCMx6rEGUXYMQfS6X5pMfaH9/vC4A96M5fQMvOgkL9oq5ok+/J
	 UkTllNC4AuXY60vECK26srKq9ekt2bnzJEd6hc+uB+HcBA27a2nRGls3jBsiootPQ+
	 kL5jRE60VgjIw==
Date: Fri, 14 Aug 2026 05:45:24 +0000
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
From: Paolo De Donato <dedo.paolo.24@proton.me>
Cc: "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Information about bind mounts and simultaneous access to /dev/ptmx and /dev/pts/ptmx
Message-ID: <QyCOf8W8P-XlVQEK451kiApqyxPqPQzth8sY0CNnbkUKXoTzkY-jbKI10jr6bjP_8IfsvYqkHnhmGTlL12HQgfzZ4CiVakdps9kiNuH6rTM=@proton.me>
Feedback-ID: 61544309:user:proton
X-Pm-Message-ID: 23d80ca16bf849e92065e0e9ca1457bfd9b7396e
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_Ol5r6LukbmmQ08F7RNhKWcQVGKx6zlb4vAYAxmh4"

--b1=_Ol5r6LukbmmQ08F7RNhKWcQVGKx6zlb4vAYAxmh4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Alexander Viro,

I have noticed that trying to open /dev/ptmx device file through a bind mou=
nt will always fail. More precisely, calling

    open("/dev/ptmx", O_RDWR)

usually succeeds, however it will always fail if you previously launched th=
e following command:

   # mount --bind /dev/ptmx /dev/ptmx

I think the root cause of this is the relationship between /dev/ptmx and th=
e devpts virtual filesystem, usually mounted at /dev/pts since all operatio=
ns on /dev/ptmx are forwarded to /dev/pts/ptmx. This issue makes unfeasible=
 to share access to /dev/ptmx through a mount namespace, however bind mount=
s work as expected with /dev/pts/ptmx (if devpts has been mounted with the =
option ptmxmode=3D0666).

My question is if it is safe to give full access to both /dev/ptmx and /dev=
/pts/ptmx (through ptmxmode=3D0666) at the same time, or if there are some =
racing conditions that would make simultaneous access insecure. Documentati=
on at https://docs.kernel.org/filesystems/devpts.html and man 4 pts say not=
hing about this scenario, but I think this information will be very helpful=
 for all people that needs having pseudoterminal access inside a mount name=
space.

Bests,
Paolo
--b1=_Ol5r6LukbmmQ08F7RNhKWcQVGKx6zlb4vAYAxmh4
Content-Type: application/pgp-keys; name="publickey - dedo.paolo.24@proton.me - 0xF470BB6E.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - dedo.paolo.24@proton.me - 0xF470BB6E.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWTNJWjJCWUpLd1lCQkFI
YVJ3OEJBUWRBeUhJclNlOTI3TFg3a3FnWFRpVHRtbnpvTVkxRjBzWSsKdzlVL0NjOXVCTi9OTVdS
bFpHOHVjR0Z2Ykc4dU1qUkFjSEp2ZEc5dUxtMWxJRHhrWldSdkxuQmhiMnh2CkxqSTBRSEJ5YjNS
dmJpNXRaVDdDakFRUUZnb0FQZ1VDWTNJWjJBUUxDUWNJQ1JEbTRHeGptUURJeHdNVgpDQW9FRmdB
Q0FRSVpBUUliQXdJZUFSWWhCUFJ3dTI0Z254UzJrbzd3d2ViZ2JHT1pBTWpIQUFCR2pnRUEKODVp
aUVGUzNQS2tMbHFEaEdTeDM5ZmwzVHluTjFyb3BvMFkxVHhvc2Z3a0EvMzJUTktld0tCSkFXcmpi
CjdOdmFFYm5xb3RGVzhXTFNIai9rWWNMSHA1c096amdFWTNJWjJCSUtLd1lCQkFHWFZRRUZBUUVI
UUgwYgphYlNHMTgxTW14N3pSRXRpd2ZaZU9QTjFxeFJqZVRHdmVRd2MwMWNPQXdFSUI4SjRCQmdX
Q0FBcUJRSmoKY2huWUNSRG00R3hqbVFESXh3SWJEQlloQlBSd3UyNGdueFMya283d3dlYmdiR09a
QU1qSEFBQm0zQUQvCmI2MFZ5c0dHNWdQSzc0U1ljMXQ1SjVCcy9nU0MyL05CUHB0N3ZMYU5wZEVB
LzJLdXJxaXluOXkzQ1d1NwpuMXVSMC9WdTM2N3ZoVWNnYkhaU0YyY3VkK3dFCj1LazYzCi0tLS0t
RU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0K

--b1=_Ol5r6LukbmmQ08F7RNhKWcQVGKx6zlb4vAYAxmh4--

