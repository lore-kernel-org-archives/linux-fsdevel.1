Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7B633342C
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861300; cv=none; b=Z+rVjh2DKwAmNur8pEzOFhdlZL5eBZnS0df2pfOoQhxizWFc9TJuzvp6Xo0HedP4jLTICBCPUBl2yEgte8QaxS8SJJyWfCLeaRolbozDpepe4jbKKnFum5SVQTW9n03fQAoNYsYHHPGdd0NBrvE+Noa6t2TSkkAy7y3tBbCrzqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861300; c=relaxed/simple;
	bh=aeLBXKnV2dHXNfm+oFvFCWE5y69u5H2m9bWusIKuNyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKny8IbpEN6k+kQy6FL1ZiTg99qmYQltZwvOtD3w9+LX7TY03gc3iC21sW2c+kjKl7xAGwbiu9la9HjpiDf478XdLMrAt12L2DwTZrYuuePVDzHeFjuB3voemmJZ+uAsqAsY3Vhi9hEmAQcJdHFsGWKaHdU2uKslWBFvbS5KgNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=XZU6WLbw; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="XZU6WLbw"
X-KPN-MessageId: 2f1ce0ea-6bc1-11f1-9e8e-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2f1ce0ea-6bc1-11f1-9e8e-005056999439;
	Fri, 19 Jun 2026 11:28:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=aeLBXKnV2dHXNfm+oFvFCWE5y69u5H2m9bWusIKuNyI=;
	b=XZU6WLbw8lJ38aYybsNQNpHmce0u2i2Y7c/ZgyP4Lh+4LSZPkGqbpY69Q1Uk29otJUwDq13tcNJJE
	 sag+fNsJVzlnWYyx51mPjTfkUHX3IAWHIQXx7/+onMl4tl36maMbcmr0P4UZqJ5oycbsGgofozo5ol
	 QdTI5F4dZ7h7mQAEbnGTEpCH0u/guJWb57YD+vl6IMu6bWUMJDCzOW0754zizQFU+TfYn9S2n/YueS
	 YFuzsjxSKPSlLRAsu9TgiWwyALbU4YFNmeQK5tfvaS9WQy8WMLt/nPT3qVy9mkx5joWgbDgitxNnrA
	 szrX1NuyqwtygmsCP5uQyZagxSsTtUw==
X-KPN-MID: 33|BFW0bJINivO0i0fARjBt5oRLZcB0s/Xbuw3LRw6KBzsHrHLO3X5IRMxeWaD0gTb
 HElwz10/WDqa9rdsh4Uu1hZ6OH6wtooJaEPURUi8Xpuc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|nrd8wH7fjuRagB2/qwTSGw1LpZL0/iPtBg+rBf2m83kXtVLhgfyRoL+Onr/Np5Q
 knx+62RrT7opJsvA47N2SRg==
Received: from localhost (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 2ef976b5-6bc1-11f1-806a-005056998788;
	Fri, 19 Jun 2026 11:28:08 +0200 (CEST)
Date: Fri, 19 Jun 2026 11:28:03 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <christian@brauner.io>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] efs: Remove EFS
Message-ID: <ajUIMvi5Nyjp6t2v@lt-jori.localdomain>
Mail-Followup-To: Jori Koolstra <jkoolstra@xs4all.nl>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christian Brauner <christian@brauner.io>, 
	linux-fsdevel@vger.kernel.org
References: <20260618211822.3599089-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618211822.3599089-1-willy@infradead.org>

This seems like a good idea. A couple of thoughts: should this maybe be
CC-ed to Linus? He has in the past been critical of removing old
filesystems. There is also something arbitrary about removing efs, but
not minix for instance. It would be great if we had some more objective
criteria for removal. I have also been thinking whether there is some
use to keep at least one old simple filesystem maintained and up to date
with modern API. It could function as a reference.

But to come back to the removal; we cannot know if there are users until
we remove support. So if we don't want to keep efs around indefinitely,
there is not really an alternative to just removing it. If it turns out
(very unlikely) that there are users that absolutely need it to be in the
kernel, then we can always move it back in. This would be work, but
recognizing that this chance is *very* small, it seems like a good
proposition.

Acked-by: Jori Koolstra <jkoolstra@xs4all.nl>
