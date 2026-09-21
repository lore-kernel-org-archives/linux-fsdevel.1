Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853F8472552
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011276; cv=none; b=ZPvjWDZWrkdn/k1if9M22t5B1zr7nYvSooW++lb2gdQ0Fs/oqIC6aSMgYUx0Sl4oAgDJfQhfX2YlxIOA0N4AY2Sfpf26lGXAt5MahmGONF8eA0g8vy8SsFXp4uN6fVyEIdc07dztx3di7vSXM/0SyPaphPYe9eDeVHpLoAuT8Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011276; c=relaxed/simple;
	bh=Uv0eeKd3R2D4y6Rl9kBc6B5RCJGTlD1u4KnKOcSJQZ4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrY97iU2gWlQN27NWK5JWvDtSPH6GF4KcpfyYyd7pB9PMsylCqF94WX6yRHBuUaq4bZ6XptLKToFfTKlo/YIe5afOVFIFIp8haQEs9SgHIF+gh4S8Cqtgxb4mbQJtVjUyITbJuQksYAbxCGRLjXadFE7yd4/cz7Dezgr7wgZbeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OOS3uq//; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OOS3uq//"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=fh2yy5twsngxzavak2slksus6i.protonmail; t=1790011270; x=1790270470;
	bh=2qLzXrp017LtSYCFpuPchYznFD5Li67tAD86jKPOLSw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OOS3uq//oMKu3dpJ8a29uZz4Xgz3+2CwEoK55Tx+FRE3SUXOnMFRuU5ElZ2YKUjTj
	 TroGPndHrvJ5/Nyz5qXTTWiZgv5LrIBSNDIP03P0yl/5uOZQyB+bKxHvKHuvesQBeJ
	 mWP42OJe8ZtG4OEK7Ke2CW45BbApYY9GcpKC8FIchppDEMWcQvd2eovic1a6L52rd5
	 OThQ7/nQYdLU1jAIT//XyXrRF1PjsDa+omFdweIptO578i+pABdDHukQIKA5e/PjUc
	 yDetJS/zyxcPabt9lZmS78iVk5JhFoRdrYJL4q4DuuSsO05TNyIvZGZ9ftC54v59Pc
	 xEFmfs3c1tbSw==
Date: Mon, 21 Sep 2026 17:21:06 +0000
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
From: Paolo De Donato <dedo.paolo.24@proton.me>
Cc: "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: R: Information about bind mounts and simultaneous access to /dev/ptmx and /dev/pts/ptmx
Message-ID: <u0blsUQK3V0VROdoD27_YvnNNzSTvaNeV2j31wJtxqZYCUQyH9Mqg0_djDpXqqhJhJWUm4w5fakh-0whJsG3zhibJsc9C_E5tQUzQNBkYIM=@proton.me>
In-Reply-To: <OL6NOlULLLkBGa0xCeh8WaHQwIqYDyatnuI7X2kfZRVGNtRGHbaarbdGEC9QUCfrYoEtX-k7B1gVRUg1iN4WJE2ES7QU1cgnRMuz9J5KdXo=@proton.me>
References: <QyCOf8W8P-XlVQEK451kiApqyxPqPQzth8sY0CNnbkUKXoTzkY-jbKI10jr6bjP_8IfsvYqkHnhmGTlL12HQgfzZ4CiVakdps9kiNuH6rTM=@proton.me> <OL6NOlULLLkBGa0xCeh8WaHQwIqYDyatnuI7X2kfZRVGNtRGHbaarbdGEC9QUCfrYoEtX-k7B1gVRUg1iN4WJE2ES7QU1cgnRMuz9J5KdXo=@proton.me>
Feedback-ID: 61544309:user:proton
X-Pm-Message-ID: 30fb6ca93baa3092ad0fb1b703ee15207e678e03
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Up

>=20
> Dear Alexander Viro,
>=20
> I have noticed that trying to open /dev/ptmx device file through a bind m=
ount will always fail. More precisely, calling
>=20
>     open("/dev/ptmx", O_RDWR)
>=20
> usually succeeds, however it will always fail if you previously launched =
the following command:
>=20
>    # mount --bind /dev/ptmx /dev/ptmx
>=20
> I think the root cause of this is the relationship between /dev/ptmx and =
the devpts virtual filesystem, usually mounted at /dev/pts since all operat=
ions on /dev/ptmx are forwarded to /dev/pts/ptmx. This issue makes unfeasib=
le to share access to /dev/ptmx through a mount namespace, however bind mou=
nts work as expected with /dev/pts/ptmx (if devpts has been mounted with th=
e option ptmxmode=3D0666).
>=20
> My question is if it is safe to give full access to both /dev/ptmx and /d=
ev/pts/ptmx (through ptmxmode=3D0666) at the same time, or if there are som=
e racing conditions that would make simultaneous access insecure. Documenta=
tion at https://docs.kernel.org/filesystems/devpts.html and man 4 pts say n=
othing about this scenario, but I think this information will be very helpf=
ul for all people that needs having pseudoterminal access inside a mount na=
mespace.
>=20
> Bests,
> Paolo
