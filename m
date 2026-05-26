Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE9C3D6CCF
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788156; cv=none; b=puFJ+GeDwd26X7reIrfoLt18Tygpj2vAj2R3Q0y4NiXt5dhRd5YmEnin9Vzta3viWrathJgF5IA1IaKBr5/uQTs/8TAOPl4ZHrPvm/kJIG65xJCjfFHBO8xDorExTbqPJFbErz4zgwGxB36OdmuHUwJVsyHVLBmkki8A2vb4OdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788156; c=relaxed/simple;
	bh=sjU7RHyInlH9mxFug2LKz+GK48Ojh7vR1sjgQ2TiRGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtDAhr0et50KorfErspu91sdhMlhMo9R7jmjw0AzIGyNGVota2EtmDkfHZhaeB0l2rsanjdIyBMi9VpSXu0SJvHmA2nzq6QNJ1qxpuSDqrNAJ5SnCzrO/63WmTFHRKOXrRQKCUokbSGvw3YY7raLo/GByCvpVTH47GyxHtsv9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=seiq+CXn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seiq+CXn"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44a14580111so7735274f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 02:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779788154; x=1780392954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bHfAVXmh3q3FWdhM0EExqsSxnDVRJkOcr0NBrLZ8n4=;
        b=seiq+CXni9aIGbLGM0VXkKywgsa47MjhfAeycLy7TY/OhjQlRKHdvx00QtlkzFePb0
         94cFvPmHHU26vJWePAZj2+oA9GlBflkrO2GbNq1VpcTR9q7MzohCl2Dd1X6Ng7rQil8y
         HdVIbj3NgV4BzluSo9r4qPLEaCSRDsKBiEkYgwXEJJdERZJsBJDWjY3UA7NIhDpqnege
         QtFQRzkX7QvdA9XHnI+h01j8LEiDgfS4JPMni7ZC4le0GIdAHwnucmFIdvGFq9b/9vZV
         EsuUHym5brztgaVyeivqdcarrbd8S4BvVUFDB/IExFltz22m1SxB6Dwhzw0ror8XE253
         I70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779788154; x=1780392954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2bHfAVXmh3q3FWdhM0EExqsSxnDVRJkOcr0NBrLZ8n4=;
        b=tAhXQqXjBZEvEVEm88KAlhEAjW5NDPDS7x40a0E9We04D+t1anYHO9yCylw/FFVBep
         TMb6xqGoaxD8P6VnFbbo/njEfkGb6bYNDuTdYCO0TdT18AQlZzAGjV9PtnAjdq06Phlx
         AStKCQ/rhZPC0N8j1DqCklBiGLwIBO/uKxgNrUQJz5esr94R8ybL3YH/ttheQ6I8rsS/
         f+Fe+w/l3aPzW1eMjgWtm9cBnJazpkHP8X8i3DipaMB2xYf1gLtf5PLe1EZwtHjI8i8B
         4/gap8H0bdxIpw8VKbzF5wz0x0rO6uTvvZOfiTHs7oTyhGTU3BfsGN+Da+CQoRKDEdYz
         HWDw==
X-Forwarded-Encrypted: i=1; AFNElJ/7pc4vF9sXogTC7Gkbg9Ykj//BeXWp5XZ2YZhOs6Jt7AZbKFsDUCyXgblxOFHf0L1J34IMBeWjw6IityMv@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2s1bZtiOhk9lnhPVqP7NNEHagihrC3OMoW0bK87Bzo8C/+OA
	4pvWL3rpuKv+Jh4Qz+t7hy0PUbaFoqQGX+obxTbhSePgGRMD5zJS1ASO
X-Gm-Gg: Acq92OE2OaBPIBBcC3cRf913zyUXAG8S+SHWEaknWH33RKicpJG54qh/Nb7zNEuhbhO
	sVfnLQWpdTpNLM6Zc9bGY6klcRhja1+mz0TwPF6qua+aEbXXpASaelwoyrAEUmgQLCE35x4n6LW
	HQS/bgGuo8Lik8k8Y9kfkXomO37qYP3guPrzjjcc9pGk7dRDI+kgaN9awUyH3W/YgrFq8X9NyHV
	jXEMl24ra0r2WuiDT3yOONLVYvs1r4c0TmakhOHZXBC0Cxm9O9bj8N6z8q1rqRMXwYU1advLoZd
	fb4dC/uRerWfbEtnl3hMZTg3IX2Sj1gIcb2yBdvz9yHrmTP9LU9PnfYb3RvdSWjZQrbZzqJXKEg
	CO3guTBbOZORk8WpS9Q2CLQ8unErs4sMvJsLcRZCclPBq2AyJiEwB6Gkyz7SZBKAvbvJkAJzqxl
	Y19H01IKkDcj9Djw0bT081M1SpuGuApVJ4xe44teA5M/Wy+evYGXQDQRl7JfcTsO9nw+ghDRhkw
	VI=
X-Received: by 2002:a05:6000:4b07:b0:43c:cf25:f29a with SMTP id ffacd0b85a97d-45eb3689049mr28173297f8f.8.1779788153530;
        Tue, 26 May 2026 02:35:53 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d64eb1sm38023448f8f.32.2026.05.26.02.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 02:35:53 -0700 (PDT)
Date: Tue, 26 May 2026 10:35:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker
 <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Ryusuke
 Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
 <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, Theodore
 Ts'o <tytso@mit.edu>, Miklos Szeredi <miklos@szeredi.hu>, Andreas Hindborg
 <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, Kees Cook
 <kees@kernel.org>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, linux-nilfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 10/17] jbd2: replace __get_free_pages() with kmalloc()
Message-ID: <20260526103551.0a05ec07@pumpkin>
In-Reply-To: <ahSNFmwAA17pMy6o@casper.infradead.org>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
	<20260523-b4-fs-v1-10-275e36a83f0e@kernel.org>
	<2omm5gmnv2khshoxkrag5rusd3qzrsqyjgsef2syxgryrtg6vq@ao7oabqwebgo>
	<20260525182134.04045610@pumpkin>
	<ahSNFmwAA17pMy6o@casper.infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 18:55:34 +0100
Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, May 25, 2026 at 06:21:34PM +0100, David Laight wrote:
> > Would kvalloc() be more appropriate here?  
> 
> no
> 
> > Does __get_free_pages() return physically contiguous memory?  
> 
> yes
> 

Thankyou
