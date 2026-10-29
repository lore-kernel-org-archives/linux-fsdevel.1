Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.21.23.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268660;
	b=qyyByM+qICLWlxRrO4eFUSHvGQYSi2HpNQIE3n8c450Fa9ne9C2QpUPiSAtXn+oLvnC2
	 Oh5A4yBOrd7WzUEFvjY4HeHFWLMNr10zVYRmi7EEKlVOD25dru2cQ6FV2fpOzfbt0n3Ub
	 ljKySyF+S8J1QK8tH7uW5i3cgx+ylG83VHW8ixaaYycYIQAT5c6Jkoqgu+tpACQ/Unawd
	 Af3GbOGfEYAD7j5OSOamp8HvpS5EM75V+ss9okBxuJXFqLIlIlnTTEl6UeZLKwedyg1h2
	 bm7I7b9Ay47z8C8ho0YyDoBPd+QUZeD6FEZGbRLp4shGFoOVRjzne6HqIGJaaIgCJVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268660;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=0YruPJKxu+BMzlsBXuUHaZVd3BX15hqMY3fWeg/ZuFg=;
	b=v1cVBCA/8yRIhnCfwhvzKjJpc0PJ9538N0BGgdsAXnlv0I+7OyDWFFxCjqZbzvA2nzou
	 8BMUkxZ3PMxkNZYwdX0giOu7kY0qL6F4GuJbhxNAFOzrzR6bWY8/93em8VvC5HxuWrEIj
	 zsYLbRxuW/YGPFpOoQoJcgvkLSX9ICMFBOEy+vOujf6Nt9d3JpbHID04bMQZEr5GaOAU1
	 3IxZ1LW8zDiPLCH9pueQMWoU3d1/dP0bTrqDlyOYYrQrAmglDzZ2e2qofuNkeD9l66kYs
	 hTpIEKn9telWrnnZeffas87QcKmYO6Vo6CxYM75mxyNVJkNgD3Tu4nM3hRZllaPheGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=disroot.org;
	spf=pass smtp.mailfrom=disroot.org;
	dkim=pass header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=jyN2cNby;
	arc=none smtp.remote-ip=178.21.23.139
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D477A606A336;
	Thu, 29 Oct 2026 10:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D477A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=jyN2cNby
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A2E3680689;
	Thu, 29 Oct 2026 11:10:51 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7GYVAaU5N5zr; Thu, 29 Oct 2026 11:10:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1793268651; bh=ZwMYvE4+CEJUVlLurwv9kgt1pSQ0wlA30QERxTrNOzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jyN2cNby6oc3zci1Hk93GHHhM067lFbiQOdxp1o2IVH0G4H6E6si3kuMUI09ywbjQ
	 T3v5bcF+bJSktsqNz7VAEYrDpsjK2CJncrt3vhutcTL9nbmcMdLKGY5QotjeWx71Ts
	 CtITbQaS2fR4hI7Sv5wfhenwWSo0KkrcKvU356StezlKkZIK53k36liZbiPGTVYXuG
	 o7VRf01G7uVIvdvIr8vE+zSUkJUGTVCEEKGlUv4JV7J8KKv5f7vdS7Kw6iojQbHNhF
	 xwte6UOJrbnM1hcB6XfPgw/wJJiHdqpPDi0rPyaKkDCxUU1//h8dFVbf4d7+C2Yyld
	 6vyFb8+R5ly8A==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: shaos <shawnq1@163.com>
Cc: brauner@kernel.org,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nls: fix ISO-8859-14 case folding
Date: Thu, 29 Oct 2026 13:10:41 +0300
Message-ID: <20261029101041.2303300-1-aliamemis@disroot.org>
In-Reply-To: <20261029091443.3531919-1-shawnq1@163.com>
References: <20261029091443.3531919-1-shawnq1@163.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Oct 29, 2026 at 09:14:43AM +0000, shaos wrote:
> Build the kernel from HEAD with the attached config, then build the
> PoC and initramfs:

This and the rest of the reproducer doesn't belong in commit
message, please move it below the --- line.

> -	0xa0, 0xa2, 0xa2, 0xa3, 0xab, 0xab, 0xab, 0xa7, /* 0xa0-0xa7 */
> +	0xa0, 0xa2, 0xa2, 0xa3, 0xa5, 0xa5, 0xab, 0xa7, /* 0xa0-0xa7 */

charset2upper has the same problem (0xa4 and 0xa5 both map to 0xa6
there).  It should be

	0xa4, 0xa4.
