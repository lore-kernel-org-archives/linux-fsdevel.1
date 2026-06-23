Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EFC3043B2;
	Tue, 23 Jun 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231655; cv=none; b=Wjeuv8mjzi3VYyzGamQIb7pwFzitvuQX+8vjcIok4uzMErevyF8Hb49OBL2nIsFsilzt3TDgj9JFjykjY1ES053KqCXu6GQB7Xjk9rSRWm9rs7ujuKM6Tbgf+15BDnxTT73AoABqJT/0JVXTxyrsoXGTN9EPNhzZ7cjv/L7phHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231655; c=relaxed/simple;
	bh=dZ55We8V2AlLdImK4QlDpC0SSMODAWxnr4+hOXmI0t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=If4HCpw+NIIMJBSqnXPsykU3nKz4OowcSzk9kAaG98qur37TPiXpGvTZtiiOHCwdt+5msK7rpvV0VhCvPqXuOu8UgQsmHVLkIvLfsq6F1aFz2uJqq5tMVTivhFRzcK4LTqU7w5tZKaZDioEiJtazOYD14ThBdhh1KQio34PRaHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ruxKtfbl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ruxKtfbl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8jC507lU2eE1ty0dpUy5PRBINPFOA7u5wQh0veblEuw=; b=ruxKtfbl8yzDk1gkhl3XF55cuI
	0/qFNdhmJEFqDjPox5blEJxesCVQ9d5qkr/DySQxfj+UNM97kxzKEj7XhSil5PO9mflYiMvx03QlU
	KjhitjZBwOdlId0yKfUcAp8SwdxKX81iLW5wt3uHBJQdYH/YsLk4mGyETswgCiMQ8QSV/8gy0MJlK
	4uBfzJrtCfGLZkPR/LN5XkHI/r1QlKWzlvUwKx75/ZJZbGbo+QR3YLlDQxSs7RrEKyH7Snt+r5/+u
	IpMjV2JhGVaWrcarLKkK1rZke8OyOr+U7nVyQS99hAs+/wz8Lyb/irQxOb50iMZoDQ+60LAVVcw0r
	HPPjMlnw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc3rl-00000006RuQ-0nYo;
	Tue, 23 Jun 2026 16:20:49 +0000
Date: Tue, 23 Jun 2026 17:20:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Maxwell Doose <m32285159@gmail.com>, linux-fsdevel@vger.kernel.org,
	Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: efs: Remove unneeded debug prints
Message-ID: <ajqyYQj1E0N2iIje@casper.infradead.org>
References: <20260605035251.89305-2-m32285159@gmail.com>
 <20260623-orten-umgedeutet-laufschuhe-60bedf767742@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623-orten-umgedeutet-laufschuhe-60bedf767742@brauner>

On Tue, Jun 23, 2026 at 12:09:06PM +0200, Christian Brauner wrote:
> On Thu, 04 Jun 2026 22:52:51 -0500, Maxwell Doose wrote:
> > fs: efs: Remove unneeded debug prints
> 
> Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-7.3.misc branch should appear in linux-next soon.

Too late; Andrew already merged this as 89009392c80d

Plus, it'd be better to just delete the whole filesystem.
https://lore.kernel.org/linux-fsdevel/20260618211822.3599089-1-willy@infradead.org/

(now has a slight conflict as this patch has been merged)
