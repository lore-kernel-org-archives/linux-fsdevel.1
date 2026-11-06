Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973827;
	b=uU0wQq8GW2J4qnYK+3CmSsIUALUBTDCX1Cb2XL+NAbrq6ZUxk82PHMXr0sOqZN8lwJUy
	 DEOwd4e1BiJMw0EGfnFbhPvws6xWbc0zol8ANF7v2g4A5odwVnl11b9HekvQucV2BVQsx
	 nw10vxEQhDS9XhUCbqVG6WEn9M4P73MsnMOAsjS2p29+4QDpwrptAtyxjJFKO67D92/ot
	 3GQsa4vm9iXQNUCLtn8abpQw7t2q66dULPfaVKbDJDKiPNaVaqHh0ZyNwSAsBXClXF04l
	 oBoPAxmyW16Zc6GM+acDxK3eIDKCvgLAKkt8w6xHOu8S7LOrcAZTWnDlu8Oc7MpTHSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973827;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=r01AnCB1g7MdmpYPg0ZnBJs0g80mYMTlVMkCnqdRvfc=;
	b=vmD6Ahvd8S/eqjzQAaqo9zqqyVt0DM2R44Y22MFxcgpTtF9nWGnh9jpoBCTyhV3cESkp
	 8yh9cDGQs+Ug2au4X7DzpkYO66ktOj/+vQ2IU5bagYInmBgtZqltXHoLH5dpKl1qCHPUk
	 HjwlrSq29mmKPq8JFHzP1F9xegclb6OQvOhGWI9yLwj5Zgomym2LwZrBVSIAeUGe/WH9j
	 3j3zK0SwmIlhK+DVciXYKDgy6t5vH7aJNPGyTOeyitOXfF6tv5Xv2YlRguS37v4V3jJ1w
	 W2EuY1yRMCodUEUf4JIcYp7zLMYKInqXfEk7fmprozmspJMFsGo24FLq/LmiqMJrm4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ey0xCQQz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BAC606A32C;
	Fri,  6 Nov 2026 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ey0xCQQz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4490D1F0089F;
	Fri,  6 Nov 2026 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793973826;
	bh=r01AnCB1g7MdmpYPg0ZnBJs0g80mYMTlVMkCnqdRvfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ey0xCQQzmimr7ba0JYJlGpx2fGJlo/8MmgXhnKTxSKdYGHSPrzhliVcJ7zZEHJMIi
	 qPyJxdCoc+z9xN3eQbNBqVX1HdgnT0WY+43NFERrh9w0wzEy+aQpjrrnV2lViFw/Hg
	 kkF0rq8gUAnWwz7WhL9DYMmjQ4AyL7THYL0SNwD2Hn7lPcRRkfdPkIvU6km4uD29/U
	 QdrHx64JpEEkNI0ugLrSYn4ZBw116X5q0YKkb0zgTrfI8GfdtVtC3epHoTJPfoDyU9
	 jn1A0scaHVmJpvfy+Fq7dd0Q4Ju72ltRsF20lUybB5+dRyE5sxADArHCCLotIbxcWa
	 8nwyYxPwP0IrA==
Date: Fri, 6 Nov 2026 15:03:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Takashi Iwai <tiwai@suse.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/7] proc: move procfs to what kernfs does
Message-ID: <20261106-melodie-wettstreit-abmildern-69eed7bf3178@brauner>
References: <20261102-defizit-jobaussicht-kurios-7016c6e67442@brauner>
 <464ef986eab97abf226791c7e19ad111.josef@toxicpanda.com>
 <20261105-erbrechen-unecht-bauformen-0794d3cfb679@brauner>
 <87ld77sf9n.wl-tiwai@suse.de>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ld77sf9n.wl-tiwai@suse.de>

On Thu, 05 Nov 2026 12:12:52 +0100, Takashi Iwai wrote:
> Indeed it's a real bug (regression by the commit).  Also your fixes
> for old issues should be taken sooner.  Would it make sense to pick up
> those for 7.4-rc, then rebase your rest series for 7.5?

Yeah, I plan to send the fixes portion for v7.4 unless Linus has
objections.
