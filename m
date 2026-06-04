Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD13C1974;
	Thu,  4 Jun 2026 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602546; cv=none; b=Eqzb8bX2AmeXcNPFj2PBhz0BjpmLHrVZM3ifinWENRI56w2tcE9WaVHdkjJENllLtIORFEyDuSM9cNn+HftbZBik11NnzcZUr4XB9BynOcehpKSb8KLtA3bUVPd3iYdUBUb3RnVzhq/89sIudyrG9wleJwP49smHRCslajoaYsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602546; c=relaxed/simple;
	bh=95hgKfjMszOODLBl4b5BWs5yYW/PDnGj21k3EiOKjUw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mqRUiSppuN9QfrrJiPD7MPFdy0NAGH/IyCGnAeOQWxu3+qdWTUtR120E5kPvczznkRRIt6lNTgrKJJ69xsdkRIHA+MOkG1oYipNPfJEWGxxl8euyf4xxOnFjUnuR6uXaZYt5qMaGbswlfzWNUfE9QB+n4VmviLmTbf9PAno5VG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kSKT9GUN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z1LZyYBx; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kSKT9GUN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z1LZyYBx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDF0F1400128;
	Thu,  4 Jun 2026 15:49:03 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Thu, 04 Jun 2026 15:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780602543;
	 x=1780688943; bh=pdkLrvzWndG9KI1O9t/BO1slV9taKxOlS4jkBc5YjYM=; b=
	kSKT9GUNypJ5Y1S9eoyKbpUlCbxgHnoB03x0E3VipnIKd2aYmKOopmoONS+qmM3x
	gN7CGay51uLoQJnwqqfOKw1+3wf7kBbjo+kO0640sF9e72U2eNTz/utr5ockzMNR
	0qg2dred6WhWIUOnhayEylNbmXQ34cq2XCxtfJkcefTZ6SOSMyy4+guVu9yAKvJG
	CoD0o4UuJULBNAgEezYcXX8/qrGTe27tMwZ48XQ9p4dPEpXxEwKXzUeVz8s7HBKz
	seFzVQh+zK/H0+5M4HNQT8tGS2IPtLgAb1gV7UndnCl3On4LE8Ud1MJZrZHN7eQh
	cdbvvrzvORfpdIuwPMGOsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780602543; x=
	1780688943; bh=pdkLrvzWndG9KI1O9t/BO1slV9taKxOlS4jkBc5YjYM=; b=Z
	1LZyYBxXC4Iy8lw4wxgQKHG01Dz5k+j5PCXRwz1n5YCa0rYY7SNahbEDRwJNQGFr
	jNAdLL8OATnEkRhRsi7740Z9nHSRyQVDaKBTzwv8syg48fNmjIdJvE2pa8mEOUtH
	vdvopl69zekdOoh8XSQbyWBmLs2kKZPQsAPeuQgXxZTplVKayWWkpkjtGIDJfryW
	sFc68sW/OrtgQIwoTKBP0CzrCDtqf2d+p+RSHXL8Yeh/KDXoyZWvk0vVFElTcFNg
	y8HVgqZRz8Nn4p6KAZ+r485RKrmQXTSHX3BRIADBrBprMscYQG2KrJYRGhwh5l2z
	/31u3dYV45IxglsTUC/nw==
X-ME-Sender: <xms:r9YhavDpPGmbt57grrJkEyGvvIzu1bKEt3xCC0WnCCQxXwMFoJxsjA>
    <xme:r9YhagUP7C03_V29DTKq46X95zCefBgEG_3OtGJFtILyRBoO8Rl3t7gvyNyucZpiq
    Yskzd3HRLj6lF_Ai3b3KVzYX7Z3_qA7ZOo4tkgVwnjK-WTFBZ0URudA>
X-ME-Proxy-Cause: dmFkZTFmN8WY/CY0LArc598Jh7Tv9t0DRK6pMOpAPY2yHPvMe5kyLK5oy9tLXccRcwVy96
    tcpzp8SKZvkADM7nfqj8TlEpdC7E3vZJKfFbsTJjxoSGmp+UueR9R0EfkhACPdqFCB3RNG
    1kBw4VrBMFzo3l8hs7442iGGTfn38HyTBDtTho2oVlwYq6PE8Ajh3/mym+MAIa087c43ha
    imaZT51sjdvAVUPaDrTSTGD44Gef3XrmP7u2rr6Jo4TeXpdLzNKIUD/7tqhoxFVFRDB0yW
    QGg47oneQr2fGml05wgnC7PMrUl1CFMFnKVrU2bV5RgiBXxxHIrJfb1TogKuU4pTEY1ULe
    3FWHY+q4L9RSVP6Jahb3cyvTMyLPK0SM1TfPUoAHU+nmS4T3QFLhkhQ1qe1Bvlmq/pN2Ow
    88l8BJ+pQ3IU5sGddDuIW7JEisyW6kN98BPl9FbvTfdO8JemGyN1i2aHwJnEZHjznqgLZ8
    mpm4YKvrcleyya5filG+PH4iyGRKJ67Lc5kxFuUe4Y/eKX+3Li9xMWbbgPuagwiUiEnjlN
    zwHiwtYZuTR1qgKCLwHWlkuyzGp6sYtO/KXOsDBdwFR5uCBg+yN8TKK0XHIciRJMRLKhgW
    K7r6Fip/R4tNzvNLXsl8TpwvMSXnzdoAkXqgtJqk3tI0N9wMAzUoQzSUJlOQ
X-ME-Proxy: <xmx:r9Yhai-n0veJjBVzHumGl3YqqDCV10l3EJlh4-oWKOaHCvI8GUKVYw>
    <xmx:r9YhapHno_p67N0NzPaNywaEESSiDm6gCDvtodyIfFNmVMgSYbe1Lg>
    <xmx:r9YhakQAcq6PbJF5dzpy7jgycIdaJeZ4XMEGexIwYMe5Al_D8NhxUw>
    <xmx:r9YhaoTU5E4fRr7-NQ2TcizYiCVt0gHQHz2A6YTy_vBuq5Gvv0zrGg>
    <xmx:r9YhajaBLvzQ_oLIM4t_un8QS5MX9FFk7N5c9Tblfm9RHYnC5gXkZZLZ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 59F37182007E; Thu,  4 Jun 2026 15:49:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqrEF5vWDDS-
Date: Thu, 04 Jun 2026 21:48:43 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Richard Fung" <richardfung@google.com>
Cc: "Eric Biggers" <ebiggers@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <65434490-978a-412d-b88e-3dff3bc75164@app.fastmail.com>
In-Reply-To: <aiG4suLcgILS8Hha@black.igk.intel.com>
References: <20240730142802.1082627-1-arnd@kernel.org>
 <20240801010953.GA1835661@google.com>
 <CAGndiTNdCGuHRmnp+G-=_PzTaLXnUZpuXAT8dK-wdoG7Mpwt4A@mail.gmail.com>
 <aiG4suLcgILS8Hha@black.igk.intel.com>
Subject: Re: [PATCH] fuse: fs-verity: aoid out-of-range comparison
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jun 4, 2026, at 19:41, Andy Shevchenko wrote:
> On Thu, Aug 01, 2024 at 10:45:01AM -0700, Richard Fung wrote:
>> > I think this was just defensive coding to ensure that the assignment to
>> > iov_len can't overflow regardless of the type of digest_size
>> 
>> I agree with this. Removing it sounds good to me
>
> Where we are with this? I have just stumbled over this issue yesterday when
> tried to have `make W=1` clean build of fs/.

I have nine of these in my randconfig build tree tree at the moment, and
with my patches I get a clean build with the warning enabled, I sent
these patches when I first came across them, usually after a code change,
though some of them may be old:

    drivers/block/rbd.c:6079:17: error: result of comparison of constant 2305843009213693948 with expression of type 'u32' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]

    net/ipv4/tcp_output.c:188:3: error: result of comparison of constant -1 with expression of type 'u8' (aka 'unsigned char') is always false [-Werror,-Wtautological-constant-out-of-range-compare]

    drivers/infiniband/core/uverbs_ioctl.c:90:39: error: result of comparison of constant 65536 with expression of type 'u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]

    drivers/clk/actions/owl-pll.c:182:2: error: result of comparison of constant 2000 with expression of type 'u8' (aka 'unsi
gned char') is always false [-Werror,-Wtautological-constant-out-of-range-compare]

    arch/arm/mach-omap2/wd_timer.c:89:3: error: result of comparison of constant 2000 with expression of type 'u8' (aka 'unsi
gned char') is always false [-Werror,-Wtautological-constant-out-of-range-compare]

    fs/fuse/ioctl.c:130:18: error: result of comparison of constant 18446744073709551611 with expression of type '__u16' (aka
 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]

    drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1630:32: error: result of comparison of constant 65536 with expression of type '
u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]

    arch/riscv/errata/sifive/errata.c:29:14: error: result of comparison of constant 9223372036854775815 with expression of t
ype 'unsigned long' is always true [-Werror,-Wtautological-constant-out-of-range-compare]
    arch/riscv/errata/sifive/errata.c:42:14: error: result of comparison of constant 9223372036854775815 with expression of t
ype 'unsigned long' is always true [-Werror,-Wtautological-constant-out-of-range-compare]

    drivers/gpu/drm/nouveau/nvkm/subdev/fb/gb202.c:17:37: error: result of comparison of constant 4503599627370495 with expre
ssion of type 'dma_addr_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]

If you think there is a chance to enable it by default soon, I can
try to see which ones are still required and send them again.

       Arnd
