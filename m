Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97138E8B4;
	Thu,  2 Jul 2026 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976288; cv=none; b=KUJvPnJSvIraOwzwrWUkcn+a4Oq/IHy7zBC9LFWxeKyWlWFS0z4byPOdWC21W5W1+00MprwLagHpeGvMiC7fmz0TwyxVxjow9Ocb88OLs/vOw+92yUPh+sYa4xSi6yPXzpesvTmRuwQFZ/25uiBi0ZgElIe+5UbtWYbVkTK3Hx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976288; c=relaxed/simple;
	bh=YIi/QSAUjm/q1pwNgA4nVWGG2XMbe3JhOmGEJieb5qo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=EtAgKBkwtgcfX82nzOA7keTRo/RZWbcSeCoPGyn+oM95Gnoefyb4XLH4mnK25pM6eVdqOX5s1yG4GgGFRGdFzs7MNZZ6EFaFAthjXxqqCCO62zQv3r/xYI+FtpdbjjOiLiCu0ilAGzGTZAN5P8gy6ch4SMMlgA4dKSaDswPA/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaHbBzKW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaHbBzKW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4B61F000E9;
	Thu,  2 Jul 2026 07:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782976287;
	bh=YIi/QSAUjm/q1pwNgA4nVWGG2XMbe3JhOmGEJieb5qo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=BaHbBzKWCRPjqkON8kQgcxMCe2TGTKGud0EvA3+b7smGe/XicNOgA0UDGrS4TGBXB
	 Nq/Rww2tAAO4gm/NIbVRoaONW6qwybAUkNBy5mHd24MDhD2LIA+03TcuVu20A+H8b8
	 wZV2PAA0/V+RJFx+G2JP/cRNQcipQghWHTfu3m5SpX+DVdHHpPcgvlCwz5Tr6QoSm2
	 DeSnC9X7jWyPjRt3vV2zwbX+r2OWrmI9T9+Kt9t94BgSDhkEMoZ4b0AlCreyp5yQAF
	 9JagULmuA99HwlMjnbr3Co48lhJhv+CpaVUSziowjpByluxzh7U91n/34F1ButkWnD
	 2jebOnRFRnIwg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
From: Christian Brauner <brauner@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Christian Brauner <brauner@kernel.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jens Axboe <axboe@kernel.dk>, David Hildenbrand <david@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <87jyreofpw.fsf@trenco.lwn.net>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <87jyreofpw.fsf@trenco.lwn.net>
Date: Thu, 02 Jul 2026 09:11:22 +0200
Message-Id: <20260702-wehgetan-efeubewachsen-faltblatt-bbd600122df8@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=59; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YIi/QSAUjm/q1pwNgA4nVWGG2XMbe3JhOmGEJieb5qo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS58ctE6AgermxM0Vxx6961JQul+vYs2FLNsknhM6vFg
 UbLGC7ujlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk87mZkmFY8oTryl8ytz1/K
 NO61MnconjkSOfN/aJKSSkLZa4bPEQz/FP77F/48e9SA4a2n6GqJS1GPT+icnv078L8gE3+Mzi5
 ddgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> disclosure rule, or we should just drop it.

I agree.

