Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE4C29D27A
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Aug 2026 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128221; cv=none; b=TceCvFjaWz75VQA3QTtLvH+jpmGbGGEZFJYVxk7HdO8II3dyFoByhzi+SFSOw+/mBwlzeFAh3z1o1eIUZyM8GUMqaS99aK5IsCJPgsWd9Vf+C8cz2z1r2elmp8dUJHsUyhdIOlh0ICkGxk2D7g6qZC8/e+i/3C57pzpMnhF4NpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128221; c=relaxed/simple;
	bh=jKLlkm6kw1LPhPZxslOZulEfGWW7qk9o02DufvTyoRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaEVvUJ9zhKv10B9LMUD3jIpHvLywBQ/Nf0xHXLmKAVlZDXR1D1B8A08jjZNCMZvmkbml/T/oYZgO6EVKBgGynB52xkXcNKkE0ggpFdYfidz+L09Do+rxGy6dbFucI1lhuO3EDpZGE1Nc1G+imBSBimpfHtzxb7qBQNdDUD0FYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qA39JntU; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qA39JntU"
Message-ID: <eee1e63d-45c0-488b-bdd5-85cb5dfa8075@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786128207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVz/RLqzS51pxRAg32haf52JTDgmoYK7lN17WA5ZNGg=;
	b=qA39JntUOUHszCpks8xIF/iOKZgdmg4Urp/5kvkQbkaVpuhErWrt7TBMHhdBxmXM5kgHmp
	bX0ReZKyd99nyZXQMEYjNpbL7W7ThdWD+ln/KcPmw5cLMTNJO/RcAlpYpZ8xUJ42XMOhek
	XOP0FDCJZA/EmdsqsjdBDy9FNTR4ATY=
Date: Fri, 7 Aug 2026 19:43:23 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] squashfs: avoid thundering-herd cache wakeups
To: Phillip Lougher <phillip@squashfs.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 jlayton@kernel.org, boris@bur.io, riel@surriel.com, kernel-team@meta.com
References: <20260724190556.1950693-1-usama.arif@linux.dev>
 <7d92d30a-c92e-451b-907e-74c91562d4ae@squashfs.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <7d92d30a-c92e-451b-907e-74c91562d4ae@squashfs.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 07/08/2026 17:01, Phillip Lougher wrote:

> For info about base-commit: tags see
> 
> https://people.kernel.org/monsieuricon/all-patches-must-include-base-commit-info
> 
> I'm going to resend my patch with a base-commit: tag to see if it makes
> a difference to Sashiko.
> 

Thanks Philip! I have sent a v2 with the base-commit at [1], hopefully it helps!

[1] https://lore.kernel.org/all/20260807172421.3875982-1-usama.arif@linux.dev/


> Phillip
> 
> 

