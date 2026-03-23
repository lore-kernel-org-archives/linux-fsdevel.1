Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAF13BD62E;
	Mon, 23 Mar 2026 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280067; cv=none; b=XPNQBy24t+bcaNqttlE2EdTcY2oOyM+NZI07c9O3yTAe+kzIFfd3+LII14jRvzuHxDVRrxLZk6JEHEEq1OJ1pXwA6h6K8iLrBYT3XyyJbNVtY8rwX3LRaKozqiBwevutxcDMjfmD92BE5lLiOu2ugyXQGZUHGAs101uMkgFIx10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280067; c=relaxed/simple;
	bh=n0OfPa6XKPPW4xxeWqXI4dBpUup5U5cxwTjA1PXZeEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JLxCwZUWSAPE+LAGX8iunliij9SZoENdDaZK3hVKCkXmvWkuchbVQ709prIYe/U0woCZ7AFkDOZwkf2n9/Yh+ZqtKza6gmGYgpKi4sK3sJKwjNTnmE0C6/85BL5s6mbWZg99xWYcLFbeRWSdSQVBkNJt4rnsmtMFctAV/QAlj8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=h5z77d6C; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="h5z77d6C"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 4791B581A42;
	Mon, 23 Mar 2026 15:32:05 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8CE4A1F415;
	Mon, 23 Mar 2026 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1774279917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KvEygMjKlE9khPDZV/a6EKUj3mrgVB74aNNJgjEbDQA=;
	b=h5z77d6CE1hpptJYsgjE9EC8c7R5zAtEUNaRJXv/eS51uFDf0Zvq0exULbCaJY/4XeZjPV
	lBsGPsHuh9RSx8qvwFyY/rqNGrgdxFUdCZYkBy2+RqXbkXTgzSzswgiMtY3dvqvEqSoWaA
	JNdpJa/v31iHjICtgKfh+J0vZQjoOWdOB+qYAkG6zUCYVLmr1soFvGks/V1YPXr2ClY9/t
	TD1zlG9yZbHlZNNqYqRh5bm7FIrdw3lMLkrGt4iPYthYi+Uq7BSmmERLSEnJRVf6FcKcnH
	VG4qyF0uyyBQy7bf+732D8ykSRdQHYbVFxy5fUPR5GZPaK+uG0MoWKAloA6L2A==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unicode: utf8-norm: fix comment typo
In-Reply-To: <20260316184935.163597-1-joseph.salisbury@oracle.com> (Joseph
	Salisbury's message of "Mon, 16 Mar 2026 14:49:35 -0400")
References: <20260316184935.163597-1-joseph.salisbury@oracle.com>
Date: Mon, 23 Mar 2026 11:31:54 -0400
Message-ID: <87ldfisgt1.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefirggsrhhivghlucfmrhhishhmrghnuceuvghrthgriihiuceoghgrsghrihgvlheskhhrihhsmhgrnhdrsggvqeenucggtffrrghtthgvrhhnpeffgfevieeuvdfgudeviedvjeevfedvkedvgffhhffhfeethedvveefhfeuudfgteenucfkphepuddtjedrudejuddrudeftddrvdefvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedutdejrddujedurddufedtrddvfedvpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehgrggsrhhivghlsehkrhhishhmrghnrdgsvgdpqhhiugepkeevgfegteduhfegudehpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjohhsvghphhdrshgrlhhishgsuhhrhiesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

Joseph Salisbury <joseph.salisbury@oracle.com> writes:

> The file contains a spelling error in a source comment (succes).
>
> Typos in comments reduce readability and make text searches less reliable
> for developers and maintainers.
>
> Replace 'succes' with 'success' in the affected comment. This is a
> comment-only cleanup and does not change behavior.

These typo-only fixes are way more of an annoyance when backporting real
fixes than adding any real value. Somehow I doubt fixing a single typo
makes the code more readable.

But at least, can you make this a single patch with all the fixes to
fs/unicode/ instead of one patch per typo?

> Fixes: 44594c2fbf42 ("unicode: introduce code for UTF-8 normalization")
> Cc: stable@vger.kernel.org

Please remove this.

> Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
> ---
>  fs/unicode/utf8-norm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
> index 7b998c99c88d..41e884569dbe 100644
> --- a/fs/unicode/utf8-norm.c
> +++ b/fs/unicode/utf8-norm.c
> @@ -444,7 +444,7 @@ int utf8ncursor(struct utf8cursor *u8c, const struct unicode_map *um,
>  /*
>   * Get one byte from the normalized form of the string described by u8c.
>   *
> - * Returns the byte cast to an unsigned char on succes, and -1 on failure.
> + * Returns the byte cast to an unsigned char on success, and -1 on failure.
>   *
>   * The cursor keeps track of the location in the string in u8c->s.
>   * When a character is decomposed, the current location is stored in

-- 
Gabriel Krisman Bertazi
