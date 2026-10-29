Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286190;
	b=URNYW8eTJpGxtfSu9nSPq40oP2LTc2ArmfH1mWqoxf8xi9zeOdC4vD/5ZXaF0HbzcQcN
	 +rjsOXm0o6K3V77RwZwi4Da+QQVu4+ag9zra5GqSiUJfgRhAfUUwFwop/Ps5UuYpJtNBl
	 P+kY4Q5yxqqRA7S4v+x8biLddJpgkP/DKtQ+dxv2lnTG+2JfnOmPaDoUriB8aoAT9oRkx
	 X7LGN0nJ17zqoV5QcQSe9W6Zo9Mjv1GrppsDan/7IgNWyIkNEM0YYgiHpA6dWAR1Vn4ff
	 Ot+8uvVx262x39XcH52xtuyFYLTGJqCd9YEIQoU88rvhRqgTy9DQQIXfRQNq1T/VgFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286190;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fVWr3OM+U06uicRq1p/6iVn+dk2JPaOEC0k0vVXrOLs=;
	b=e1CU6iBfFqzm9XoRCk/cI5ER/n/u5sAYIW/UewFRC6/LzDx4gAjhzxxv8B5QMOcifZTq
	 BybVSn0IZo/5mVrgilHgKDATuFq2MXvpmUyY6ijju16I0lJyHzXToFuoPArOOfK3seCag
	 lm2cZZQROEiH1MuRBz4S+n4t2bsSDyg40xuvmntg1u/RxEyl/3eLyr6g9Txv+0fuwhXdQ
	 JDl7JW4PAUZcXViQm5jJB+wKMKtyptsUyYLxe1kIA0ltIvxnwyIxDQ4ufF5ZrTQqKGtf+
	 O2C7NTS8bSj196uyVh4xL05XS3zhYeopUUHv2xr5np7Xu8LgcMbyfIer77RXKzZndWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzfuVvTM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779E606A31C;
	Thu, 29 Oct 2026 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzfuVvTM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD771F01825;
	Thu, 29 Oct 2026 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286189;
	bh=fVWr3OM+U06uicRq1p/6iVn+dk2JPaOEC0k0vVXrOLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bzfuVvTM0M0f9XhXZZmeaUL6iJWrBO311hwhO58zgryd3MMm9nEJtRn+vvU7KPewF
	 wnINkxYdbteeY3zjAR2b0AizoGxarq4nm0pWaJaF9nt+DLKDePDhsGOBwx7azSTkis
	 1nMIyHi09/qboB2C708ArhYuEfReIZByBl8tjy+uFfWYm2CsFUM+pycTusgMEgjDLW
	 l/vRoArv7v7ddEuqiyQmf8qIONCMTw4ITtgH0HBfB1cUfO+uIdAdhpSQGIOIQFvLPU
	 GU0aLSYdoQYjzj7RHkqtklMHzxRZsVdMJmQSIva9X1u3FagbnYt1InkKvJ+ZioZm5P
	 VrmUsnC+6q4Ew==
Date: Thu, 29 Oct 2026 15:03:05 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xarray: clear the new head's parent before freeing
 the old head
Message-ID: <auNdNjH4zo7OYbe-@gremlin>
References: <attzI4sj2Pagmvkd@casper.infradead.org>
 <20261027192014.844878-1-nickolai@csail.mit.edu>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027192014.844878-1-nickolai@csail.mit.edu>

Nickolai,

It's pretty 101, but please don't send new revisions in-reply-to older
revisions or feedback [0]. Also, if somebody replies to
you, reply back. You, not your LLM.

Also, you are flooding the kernel with patches, 5 series across 5
subsystems over 2 hrs:

https://lore.kernel.org/all/?q=f%3Anickolai%40csail.mit.edu

I already asked you once to stop doing this [1]. You've carried on.

This is not how to engage with the community. Please contact maintainers
ahead of time and ask 'do you mind if I spam you with slop?'.

Only if they say yes, carry on. Yes we want bug reports. No we don't want
people like you running scripts without permission and sending out dozens
of patches all over the place.

I'm sure you're acting in good faith, so can I please ask you to engage
with maintainers instead of ignoring us and treating our time as valueless?
Thanks.

--
Cheers, Lorenzo

[0]:https://docs.kernel.org/process/submitting-patches.html#explicit-in-reply-to-headers
[1]:https://lore.kernel.org/all/atYQW_lfJdRZnU_n@gremlin/
