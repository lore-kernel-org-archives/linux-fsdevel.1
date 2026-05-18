Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E101738B7B3
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779133787; cv=none; b=kp3C3xSbMmIDknJ4G2C/UP4DnyHZQBIbDeH7ichOjYTN7cm/P8MQ64eQRVXosRtKhkVwqKSOfwB1jKoGrdwkx5cahzS+4WI/HP9lWs/POLFaEygbT233SFYg12CtctWbcONdIRZJudlRsbocHihEBN8lhLWw7DlTiffIno2eO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779133787; c=relaxed/simple;
	bh=j9kmxjMEOPhqwMBlreKKTmZ9079fBm/XA7Zn+8z7jp4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iORX68TwIU6m/FxS1cgKx9xefUtvM32nmRZ6TomNXDsSVXAdETtoF5l958dgFe1PURiRQj1HOQ3IPeUBQCSeLapfSFiQcEDDyMhyi/mrdESsf3kTuqhZ+jB8ZB8zQI0pUPmu/2FzGF6n3xV4S2lLJNgDfLfcFipK5uTPaJcgMls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b=KY1xDIx6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b="KY1xDIx6"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-366139223e4so1431422a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 12:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1779133785; x=1779738585; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXkEizAZd7wRFvVTMvMDw5R0J5iwG2vTUc9MlXWdewk=;
        b=KY1xDIx6CtgEhr/7KLO33NfbrdTcLWk0LBh98DY4twMALrGCX+qiUQv2Lpssn1erkr
         KxLe1VuHkzX+favCDG4l5ISAWuUNfEdVq4uHOciyl6vMgdipdoY9JWDWIl/0ZvJzBe85
         Zd8Cydv569KzijxWSXGznDboroZkgIkzikDjJxF08CK/P+/HVZ3bzj647OEBvVHXJkkt
         xMzleGcgTNcwiGfrya1meg1zAz3cfteR31ZeQukZBzHNXrIvMzVdJ3k7rden/VgAcSSE
         XhDb347nddw3p0lIA0AfOHEB/9qTLdsP3WU8FfFP/i2tciLzt6+7/My58kB4iTNpW4ln
         HFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779133785; x=1779738585;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXkEizAZd7wRFvVTMvMDw5R0J5iwG2vTUc9MlXWdewk=;
        b=o0v1Jc0Z2NZLYeE4C506Wg/fRT1WD+pUpsI+m7/oagFVWwjePfJiExd3DxwtKqofim
         5rI34/hKwoFlllWjCxJxZ6q9fF6mocwr1Zc4pUJZgZV7+UJwUQnflu33wRuBP0dRddAl
         3dAOiPbyaxam6TYlhF7S+MDRNhce3aY9efbinLheY9z07F0fXuWJeen5J/YUj9+FAZuf
         4YtrrprH1dxdbb5uX0x8LKpvOPKoZZfWZ43p8tdPjtdAIqM3L4RBgofOauKWeqHkAIiS
         mQiNlGUiAZWWkUaGoR2opKar7TTlQebLamKNF+kePLq+NlfWHabm33I1+RPM8DlDqWVq
         NLBw==
X-Forwarded-Encrypted: i=1; AFNElJ8l67thY8LLHk2IoIMbx/rBDwuQq0vLcN1kv/Ap2gNISR4ZFMuzbnYS1XD5f3OG1cf/lJdwTIl2kLqxz91x@vger.kernel.org
X-Gm-Message-State: AOJu0YyRlWAP9sOS1S6tH91Z0JhoYblEzL68BV30k7FfetYCEFyh+Xkn
	wwZwJMvZ7pybpt/WT9QHleO2LNNMZ/UBQKMq/k7bxJP5VYG9+eYsU1AGfZN6Othr/hc=
X-Gm-Gg: Acq92OFfvvhgg4FmDAb4rtKmsMtDr160lhfd1Je2VVWiCfqjFbtSLUPhMC+VwZChxV6
	Qo3t1hAANjtAXHxSLc3IqeHYj6XCS7ohCEQuZc/3eUnErpw2e6lyua0mJusIWbosN5dlCmsrPu0
	Q1wu79RW1Z45Go+nGCtj4LtnXZ01QUAQDX+XeL3IJN77I0haUDjs0eEJpVzfmAcBKJcxRltKyPw
	Dw07VjBVlDtL3ZkCgpXjiM8wiSzvzpPU7DBBKwIOhx18pp0DaMsrAlkDNt5DxQyOzpX6Kn9R+OO
	kNrBgDkUmxCbt16DXntQ6e57B3BARIHQektoVU9Z7pT+hzSpqej61CDH+8YV3L0lLOWL3D9MCvR
	HE6anwOIECAWW7JbEnCn48oeY4ejSZARngxw06nb9iBcwtmUY5kqYZSkiMdC0l24UmKxiTRS3nj
	EoTTfz0vYufbjdF9sx4ewmM2pguNqCUF83kQhLVcwbJhSFHd+dS25aAf8fOfK8Hr7SyYt+7s+dO
	N1ApDBzDMxCQTCvJacBrV08dg==
X-Received: by 2002:a17:90b:5904:b0:368:f179:ba07 with SMTP id 98e67ed59e1d1-36951a1cb7dmr16636204a91.9.1779133785138;
        Mon, 18 May 2026 12:49:45 -0700 (PDT)
Received: from smtpclient.apple (S0106a0ff70715ac6.ek.shawcable.net. [174.0.84.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369515895d2sm11637092a91.8.2026.05.18.12.49.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2026 12:49:44 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [5][RFC] fs/ioctl.c: FIBMAP requires CAP_SYS_RAWIO while FIEMAP
 exposes identical data unprivileged
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <-nQmUF-iBsNFQ1Iz2j_cVui7DxnmpAO7z3X7qH8Xzpr7CYXE8j5x5YeFQ39U1wcMFNuVnuxu1pJf7ooiwJYK8ZFJDpjEtifFaBuWNJIi0ak=@proton.me>
Date: Mon, 18 May 2026 13:49:30 -0600
Cc: "luto@amacapital.net" <luto@amacapital.net>,
 "hch@infradead.org" <hch@infradead.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "tytso@mit.edu" <tytso@mit.edu>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "mark@fasheh.com" <mark@fasheh.com>,
 "moybs027@gmail.com" <moybs027@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7FCF68D7-331B-4E8B-9356-F361440764BB@dilger.ca>
References: <-nQmUF-iBsNFQ1Iz2j_cVui7DxnmpAO7z3X7qH8Xzpr7CYXE8j5x5YeFQ39U1wcMFNuVnuxu1pJf7ooiwJYK8ZFJDpjEtifFaBuWNJIi0ak=@proton.me>
To: Cyber_black <Cyberblackk@proton.me>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

On May 18, 2026, at 11:22, Cyber_black <Cyberblackk@proton.me> wrote:
>=20
> Thank you for raising this important question, Andy. I've been =
following the discussion as a "listening guest" and I have a thought.
>=20
> My idea is this: Instead of forcing FIEMAP to become a root-only =
interface (breaking existing tools), or leaving it as-is (with =
information disclosure), what if we design a new, restricted API that is =
not privileged but also not unprivileged in the traditional sense?

What is the *actual* security risk of showing block numbers to users for =
their own files?

If an attacker can access the underlying device/image, they could =
directly use debugfs
or other filesystem tools to get file->block mappings anyway, and could =
modify the image
arbitrarily.  Restricting FIEMAP to root or obscuring block numbers is =
security through
obscurity and provides no actual safety.

Cheers, Andreas

>=20
> Concretely:
>=20
> 1.  The API would be callable by any user, but it would not expose =
physical block addresses.
>=20
> 2.  It would answer higher-level questions that tools actually need, =
such as:
>=20
>    -   "Are these two file ranges reflinked (shared)?" (for =
deduplication)
>=20
>    -   "Is this file range sparse (holes)?" (without leaking physical =
locations)
>=20
>    -   "What is the allocation status (delayed, unwritten, etc.)?"
>=20
> 3.  The kernel would maintain a capability or permission that is not =
root-equivalent (e.g., a new `CAP_BLOCK_MAP_QUERY`), but the API would =
not require full `CAP_SYS_RAWIO`.
>=20
>=20
> This way:
>=20
> -   Tools like `filefrag`, `cp`, and deduplication utilities can work =
without root.
>=20
> -   Physical block addresses remain hidden from unprivileged users, =
closing the information leak.
>=20
> -   We avoid forcing users to run these tools as root, which would =
open up far more serious risks (e.g., kernel panic, accidental =
corruption).
>=20
>=20
> In short: we don't need to choose between "unprivileged leak" and =
"root-only". We can design a purpose=E2=80=91limited API that answers =
only the necessary questions, with the minimum privilege required.
>=20
> Would this be acceptable? I'd be happy to help draft a more detailed =
proposal or prototype.
>=20
> This idea was developed together with my friend playerofficial19 =
(moybs027@gmail.com) through discussion. We hope it's helpful.
>=20


Cheers, Andreas





