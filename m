Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795299464;
	b=kDvmvu+tWmeYp8BSe5cQ2UxchhS5//qdT4lfVznQoD3xpeyLOSMrLqASIuN+BW94m58g
	 AUWhnMK6zJXv5KCKu4HT1qvtlyTWUfWxDQbvAN+PJbtLrOfb+FDRWPpWbEmxDTsM6xVqS
	 LPGUYkh3Ho+VSERIKjQlBNC9q0Prgow9RBWAPonPLdq7oOhvs1xmWg0N6w3hMGEq1NiIv
	 mRJthRfRzVO+JcLIut7nYlKi6Ru9b4YKckuP6NFh1/kFrpVwHJODrW/G7XovX8lGHT+ss
	 E5jqpHc3tukFwIDQ5759PVDWC4XCi72QZciRIOksV7BquvXQooDskcsk4jNhCxCiF2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795299464;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=oiD3WvpkfFMaq9WZc8IXp+MSoKnMtJjpSc0XfXung4Q=;
	b=5dn5BHxTjQQBYB7NzdKDsOSJYkc2EYQCIS4uxLfKcd4WZha0po+mwETVTCivpYezytjS
	 nxZJ2/OtQOsDLG91IH4RZcHcA3cMmnBmZ4I0+BvLPgh775jETe7CMpL2TzdAzOkNX2kWP
	 /YgOxirTR0QaPZ2U3cfe0DmlaKlEv3rfjQR2/9TTG19SZXkojuuOTM+sMf2RMEvemeUY6
	 htl2e/k8fxG3EMuEviF0k9WagsywDiL+U7zY/cz6vYGAXeTgtXEQ1vr40GDP/Uc03o36G
	 BXp2D/b9Txzjsllj5JC1NgzhXDtUD1n108Dc++OKHUGSgQyhB1NPDY0X/J6KPiuJnjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=RQh1F6vZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A0D606A320;
	Sat, 21 Nov 2026 22:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=RQh1F6vZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4253E1F000C4;
	Sat, 21 Nov 2026 22:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795299464;
	bh=oiD3WvpkfFMaq9WZc8IXp+MSoKnMtJjpSc0XfXung4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RQh1F6vZjbnStpK46EKSIanIFeen7xkryaaTx7ipWHGuG5j9IGFeuFiBYe471g7KR
	 IncpZ/RUzrMb6AV3t7vIc5yvDHdvCYGitSKPIWJdKWhDlPA/shrxv1OC9UmrhQ9kSL
	 jXC36Ynl1SpAms60l4bJBy0IPnecGqRG9F4lnmnY=
Date: Sat, 21 Nov 2026 14:17:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Baoli Zhang
 <baoli.zhang@intel.com>
Subject: Re: [PATCH v2] xarray: initialise the offset of a new root node
Message-Id: <20261121141743.6f1095f5355fcdb4519ed979@linux-foundation.org>
In-Reply-To: <20261024014344.830116-1-nickolai@csail.mit.edu>
References: <20261012181107.772545-1-nickolai@csail.mit.edu>
	<20261024014344.830116-1-nickolai@csail.mit.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 21:43:44 -0400 Nickolai Zeldovich <nickolai@csail.mit.edu> wrote:

> An RCU walker such as xas_find() that climbs out of the root while
> xas_expand() adds a level above it can resume in the new root at the
> wrong slot and return an entry with the wrong index.
> 
> xas_alloc() sets node->offset only for a node with a parent, so a new
> root keeps the offset its slab object had before.  xas_expand() stores
> 0 to the old root's offset just before linking it below the new root,
> and a walker can load the stale offset before that store and the new
> parent pointer after it.
> 
> Set the offset of a node allocated without a parent to 0.  The store in
> xas_expand() then writes the value the old root already has, so remove
> it.

Thanks.

I turned this into a 2-patch series.  The first adds the test to
test_xarray and the second fixes the lib/xarray.c issue.

Which is arguably the wrong order - I have just created history's least
important bisection hole.  But it's convenient for before-and-after
testing.  I did that before-and-after testing and it all checks out.

I'll send this 2-patch series out for review.

