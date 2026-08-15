Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D3126B0A9;
	Sat, 15 Aug 2026 05:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786771131; cv=none; b=IAlnoXTV5jrDH+Vr1y8c/7ArfBIQQRyAHhuDGOe+Ck2wWfbJFgIC092GcP9vHFLAoCg8ox4+5zawzIZmT/+Jd96w2FmQAxSRGiZksc+xeWh9IN0daf837ud8RgXRErwPl/zKc0cOjg3IJNkYzEC8IgJYPU5IzwK0jk0NAF2CEmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786771131; c=relaxed/simple;
	bh=NY67c7Aq2Hg6XyoZQP7pISJUnX4Xld/ciEkGCvDz6aE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+FxrsRtiyl73tW9OK/Fjt9N4SOdOhgjmgKAV4+6ShrQgJAO1kCDxoD2Khsjm+D7f2Ub0xIGZ91dN+4q30yCqkxEiqMr37Q26kuggrcry/9cSnCh6FX1oChcQCMXQgVHzBtR9dGeC64z49pze/Ik1CPV0oc1W3CYG78dPDx1Zi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Fn3hxDXW; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Fn3hxDXW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=6ys2wtszrrbnxlbdzzgh34226m.protonmail; t=1786771114; x=1787030314;
	bh=VdcNM4MkfoV9SZH5nNr1NdPvteaO1Z24jVA3+xO3bFc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Fn3hxDXWewmAa+WgiZlKbKr5LZdVkC2TFhawwF1ESY5L6UZGDRsNOOSVUtclUMna2
	 r3q3G/cu7Wxxh1ENWz0aMRKlRJhwreG064OnmjkDU4MFkzfCC8ro1XwhZwLEASqD7U
	 Ru/uBJGbgQgJT8nh8TEotn89671ENWPZu8q1wvNfdIvxALh5qlIjmumlVa5gEdrscI
	 MDKFod72Isaiq4oUrinIpqQg9ZxvYKM8R3rv8lIFpYEYrWOTOwpMzMglnQ/ZTdBiiU
	 UyvVfBGNPtA6ek9qrCd3YciamrmC2s1g2O0clIx9p017vpTIEDq8G8m0xrSkODWoYm
	 nm6NZplLmiPig==
Date: Sat, 15 Aug 2026 05:18:33 +0000
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
From: Paolo De Donato <dedo.paolo.24@proton.me>
Cc: "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Information about bind mounts and simultaneous access to /dev/ptmx and /dev/pts/ptmx
Message-ID: <OL6NOlULLLkBGa0xCeh8WaHQwIqYDyatnuI7X2kfZRVGNtRGHbaarbdGEC9QUCfrYoEtX-k7B1gVRUg1iN4WJE2ES7QU1cgnRMuz9J5KdXo=@proton.me>
In-Reply-To: <QyCOf8W8P-XlVQEK451kiApqyxPqPQzth8sY0CNnbkUKXoTzkY-jbKI10jr6bjP_8IfsvYqkHnhmGTlL12HQgfzZ4CiVakdps9kiNuH6rTM=@proton.me>
References: <QyCOf8W8P-XlVQEK451kiApqyxPqPQzth8sY0CNnbkUKXoTzkY-jbKI10jr6bjP_8IfsvYqkHnhmGTlL12HQgfzZ4CiVakdps9kiNuH6rTM=@proton.me>
Feedback-ID: 61544309:user:proton
X-Pm-Message-ID: e5e5ac57319913b05279cbf3b1586834c648a111
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
