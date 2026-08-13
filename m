Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8473A2472B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628617; cv=none; b=MtjOW+2r/TvJQCBFI7swww3MkIDqHFnXaNl6+XKJsLWqmls2jfj4MeyGU/hxoWXkYkZTJOlArswiiJ3pxr3q+HPNyJTNjlFh5trTxDvXW/qWQrOsIQOgilGZKG3jPATgaPLdqhAxCi1JsCeM1f7kqSr/Bjn6bnYFk/Ac9qdclCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628617; c=relaxed/simple;
	bh=WAHSyVZsm9YXO0RmUNpzPqO0wNYBSTgob7pwAZgh2Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUN7Z9LXSPFKBAugFnKt6niebZUEBukNxtlEvxXPjNrBe2miWlNERcAeuPK9eux02NOuIidYj7D0iRzm5ivefS42H2H6js+En1dEokyiZsfZ3XfqHVm230N8d7kl+c9Xx3h1Vxl9ruTkofwftONXuF1oWdSAzEY4N9QYbnOSBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqFpH2CS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqFpH2CS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C7D1F000E9;
	Thu, 13 Aug 2026 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786628616;
	bh=WAHSyVZsm9YXO0RmUNpzPqO0wNYBSTgob7pwAZgh2Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IqFpH2CSq9p9bZR2i5Y4nqzZOu7/zIMm7Iez7N30zxLzo/UKHOkmIEB92KVNtmyC6
	 LIJxCaR/sgEkr3lEFG/B1ATruQUTEI3JpcV8Wf3YSHjFi68ieH/1ciWkveUnIz457g
	 6zZK5UeOjOZ3BXnJpdG0ofWa6EXcdBUvXZ7wSlzDqtwn6bobxllc0oMqunKMCYD3XP
	 OkLHdQ2hhWrX7wMZdX/8K7oVIT+LtPVwY163C8IALm+c9cbu7UUAhlCY2eJzI116yR
	 +/yMSSC8DfNRa29FAz39Z1APfy0F/8caGDrWDAsZOOMkkZWyi1fcdkTQeJQSE74mHj
	 kxkpqFE72yKxA==
Date: Thu, 13 Aug 2026 14:43:16 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hajime Tazaki <thehajime@gmail.com>, linux-mm@kvack.org, geert@linux-m68k.org, daniel@thingy.jp, 
	Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] mm: nommu: fix an issue on map request to
 /dev/zero
Message-ID: <an3JiUfhRPe_X-kC@lucifer>
References: <20260813063401.1786548-1-thehajime@gmail.com>
 <20260813063401.1786548-4-thehajime@gmail.com>
 <2026081355-remold-sterility-84f9@gregkh>
 <an3E-5BuWLgwzrd-@casper.infradead.org>
 <an3G24JX-ZE9Obbt@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an3G24JX-ZE9Obbt@lucifer>

On Thu, Aug 13, 2026 at 02:32:27PM +0100, Lorenzo Stoakes (ARM) wrote:
> I do agree with Greg however that nommu is something we should get rid of. See
> my other reply here.

Sorry this was an overreach - Greg didn't say that :)

I mean Greg asked if anybody uses nommu, the answer is yes, but the real
question I think is 'is anybody using a very recent kernel who couldn't either
use an older one or maintain a downstream kernel'.

And to that I think the answer is absolutely not.

And if the answer were yes - you must surely be a company with a product
(security concerns on a nommu system is a debatable concept) - and then you need
to put up or shut up IMO.

--
Cheers, Lorenzo
