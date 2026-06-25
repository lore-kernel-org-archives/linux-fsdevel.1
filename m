Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A6233935;
	Thu, 25 Jun 2026 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782413752; cv=none; b=XAt7tB2MWBO14H7jhx0xvQXJaVG0K9TdlgzNsjCC1IBQ9Z7NgJVvtKfMIkycrFsbyiixemf26z8uplYrIXXbx1tMIAz2bWkX3yUufVY7mSO4RK5xR7hwG8FiHclVUrZjDTybuc5a1NO56NF2BXG4OSxBSyG+uaWsoSHa1SYkQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782413752; c=relaxed/simple;
	bh=x13LzNKXfpR0qkDJOPT5Sq14lug7X6SGMbarGJFbsnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwPh1Fg6y6fW0ps9iVdyGVDlGUCWM4dpbd5m6CVc3ZclkjgucTRP4Z8UNopvxQ1z85ofuokW85nhAYeQJG/eFnTylfYtJ1UVciJ83ui1eCiXiB+BY4TDQZbl6s+evbOz3kiFZXbV5UOs0gGjsTGomBxoe3tZygjPQ3kXMazGlWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/gtzR7K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/gtzR7K"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5C4211F000E9;
	Thu, 25 Jun 2026 18:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782413751;
	bh=PgDqrP2i5z8HSzOT/aKgSlQWrnlFl+KLuTndpGk5qrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I/gtzR7KIkvs6WLz8Wdc02OOCanH+bwuIB14GyrkBZ7FwKDIopQuS0WwsGepCWj3O
	 RB4CGx9TJrgqEdRjB141K1Ku4Gmgj2icRTN1rHJjs89JHnaaajDrKYudvqJR4yRRyC
	 cs5PzM6clZpe7aQj++lADeGthgv7mcbD00NBr6T1oOdH886ZzP6/MAj5u0iMg0cZaj
	 M40voR0XtrsMZwsuzmRfRnx7D9YTndr+aVbYj1/BEiblSW99NUjLRZylJu23kKFJLN
	 0u5a1y2fjHTjwhum+p1v7X6MK6eyEDEoVB+DAR2qmLxa8lLNHcXxLrfK2T2mKWyhBl
	 VXooqk4w9YxiQ==
Date: Thu, 25 Jun 2026 11:55:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	willy@infradead.org, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v2 1/2] iomap: add helper to mark folio uptodate
Message-ID: <20260625185551.GT6070@frogsfrogsfrogs>
References: <20260624212925.1668662-1-joannelkoong@gmail.com>
 <20260624212925.1668662-2-joannelkoong@gmail.com>
 <20260625115026.GB18076@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625115026.GB18076@lst.de>

On Thu, Jun 25, 2026 at 01:50:26PM +0200, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

LGTM too
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D
