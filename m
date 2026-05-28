Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FFE23394E
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981166; cv=none; b=k3j6Yk4gr2LqSF9RIW7ysypOeGfGi2E+0olJN7hKxtRKvxt3ZyUux3mkD/19yAeL8h8PwUMPA5m04zn3C2itC/EVWdAXYK2Tmvb0t5QLwRmByiODbbGxqPpw5KgD7uGP5EQGTkcboV7M9lVJ4l/bsnMuth5+AixPN+JlcCl86bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981166; c=relaxed/simple;
	bh=9IW9q+QJo1xWW1EkMEJW1Kw/dxW/KMLRSXuYt65xbIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWspkzQDWxfV5rZPXq+oUq3QIo6ZnJJJgKHKGQ6/zmz91GOdXvCMyZsTHe2COT5Q+z8JpNUjpRqJ9TrmPit90xzaYulm4t4Oll86MCXwlnKtqN7UEwBofICJFHOTh348dUI7ciwo7AjzWQtEgVJcuRTmYJA9SqIXs/h1S59jKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=JJCT96hL; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="JJCT96hL"
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net [73.9.28.129])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 64SF9ssm024158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1779980998; bh=LRcw8YhN4yjVuz2F1k8EsMXfLtwp5Y8grP6VHxjmQ88=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=JJCT96hLuWsuIqd5fNeTyg3tokZeaZ316c2NrmJY0if/2/uu5IEkmCKm/TxC3e/b7
	 9g+cTs0V4biX7aelP/YDh6L/g7wKZFTfwiZXL9zo8G2StUUywv5yl39r6Y3jyayO3v
	 s33a5m9TOuRNrFV+9omlhH/mPFydJDaPORW5XcHi1eewtT1i9xfaovgS1wADch8sL8
	 LMMsqFb8Ko9f3tFpUeQSvHsu+ljEtZnIHXR4ZeNJpj58iMqo0LQLxqKBw65Ut2Cj9O
	 AqHWwxwwYc0uOSIjecDaN4Y7vlCYMvNZCDgtFqKf7H4u/V6Aye3pp/oedw+uGrZRkF
	 zCc/6RVEGk+Mw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id AE9BE6B6C4F2; Thu, 28 May 2026 10:09:53 -0500 (CDT)
Date: Thu, 28 May 2026 10:09:53 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 15/34] ext4: Convert ext4_commit_super() to bh_submit()
Message-ID: <suezpvpgo36ngzhokcqz3m72iznx2xjjumdle6ol6dcukf6zh7@otxor6377u7t>
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-16-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525171931.4144395-16-willy@infradead.org>

On Mon, May 25, 2026 at 06:19:08PM +0100, Matthew Wilcox (Oracle) wrote:
> Avoid an extra indirect function call by using bh_submit() instead of
> submit_bh().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: linux-ext4@vger.kernel.org

Acked-by: Theodore Ts'o <tytso@mit.edu>
