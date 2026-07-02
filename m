Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924A5413D69
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979958; cv=none; b=ZrRIMX6J5GdqHX65fGPY0+Kit0uuSc855nNMpgxTf4GDW1sW3woGm06zG29YX3Ab8Oh9Sfy7uMWnsikgrdz5o704suFiL8meWIVuHPrNzkuhZZKZNugp1T2jIZtGlpaHKvtcX738mnsSV1LplmAnkNJh46w00Yq3RsbqHsCsIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979958; c=relaxed/simple;
	bh=b7S2WtKCuyL2SY4ChUbBkrjwDmwLzR5+Q+azfdS//ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aw8ywVJaaQ3qrmIhDh64dqAclvTGI0TCTbjybOkrGh+76qfW8KuuxD3VIOJnag7a3pMnM2EqJXIHZC3cwVYtIrLKzs/J2/5hkbLCJF3ougdBjRmDbtVvXkjniWwz+iZ4LdNcfnZdXY2ZWXRCCYOOENNwJ7prtNi6xT8uJ7qXRFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=uSQcwH7Y; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="uSQcwH7Y"
X-KPN-MessageId: c3eeeb4d-75ed-11f1-a055-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c3eeeb4d-75ed-11f1-a055-005056abad63;
	Thu, 02 Jul 2026 10:12:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=b7S2WtKCuyL2SY4ChUbBkrjwDmwLzR5+Q+azfdS//ns=;
	b=uSQcwH7Y6U+UIvmWHRGBKbgfnlX0kg6+VyBs1qgszOnOJVtY6TFscBrcpAh/PBIIAO9u0nRbNpOoY
	 xYQ9wPL/XSxUi/jmhDEm4cv2jzinuGCqVHRXge/u1TxAx9jVOh7mL6AZ83SQsu0cNyMZizFqzbuUjz
	 te+Katmr7Jazc3qnLS7cffzmW0FWOjMvDo5fhgJb7DfO1MTkm21OoP3wFsV1yEpakNe53oL6OB79lW
	 ifyT3KZK8gRRePd+cFpys2zRBPxk+FUsYz0Av+sRfJ3hSfsTtn5Y5LosphpHgh/PMU1YR9orK6hUDd
	 lnZm1jEuYiwuQuVTQAfFKoeSitMZ4CQ==
X-KPN-MID: 33|fGYeMdDgb81bwI7av/4nPvIK/sksPhYSrieixk58bIFNcx/ZsH5ZKWuSDwKiVms
 E2SqGv//Cy+Y5aNFx3dXNpy9QwWjNsXxVAhU9oR00fpc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|o/mo+Fglpk8M3lg+1zS0b+FAKSbM93lmJALGh8ieaoJgfTmZtyVdornSCGgW24k
 66Ada7NCfjSYuanJ71cMpYQ==
Received: from localhost (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id c3858243-75ed-11f1-91c6-005056ab1411;
	Thu, 02 Jul 2026 10:12:27 +0200 (CEST)
Date: Thu, 2 Jul 2026 10:12:21 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	David Hildenbrand <david@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <akYasD1ckWcH1C0g@lt-jori.localdomain>
Mail-Followup-To: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	David Hildenbrand <david@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>

Ah, I still reigniting this discussion again :)

What about a combination of what David and Jeff say? The whole point
seems to me that the salient information is not that an LLM was used (or
are we going to tag Sashiko as well or any other LLM-based code review
tool?), but what is was used to do. This information may be relevant for
how the review is approached. The latter should perhaps only be in the
cover letter and then we can drop the assisted-by tags altogether.

The question about enforcement remains.
