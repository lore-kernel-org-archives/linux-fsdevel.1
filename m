Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61969346760
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076310; cv=none; b=twyMCZQA/62IJxiNqxYgK1GwIEpJqwjYQtIaiy7HrY4GJXfZlG58a3RPFHABO6QD1HuYvKJOcZxHIiJnvGUvkUG9DVVwZD3w+9xJceJFWWJML1ifiLX17E7x5k5avXhiNa5UohZVfbLy+p59hqCex7a+V/LAewpm1DH01NWRQEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076310; c=relaxed/simple;
	bh=MRan9B0EEcK8gXicfj+D1fSVd5Gt317ZxAZHXGkA7nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mm3j755lAeTkbtQqdKwTV2gXsX0NMPNK669dbws8bC3piIWT/dGV+yBiO2AJX23Ed+oIGz/dbEGauMAmes+Wno+c4xQcpOq82gS+a7831ryDCbwcGCDppql4Avi+CcZD1ikoHIBhxgrJtW12drglXbFior39weSqYi+GFM072bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWf8CMi7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbrG89ng; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWf8CMi7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbrG89ng"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769076307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNqvczIVehNho1K6yzOe7LZ08YqMOyw0NvDlIw+P6AI=;
	b=XWf8CMi72NELo3h9CCYJe6airjNy8gH8lzXJiSPqO2Sh9VCBzFGjLHnMlNPSrhLXWFD72g
	bWbC11vmPKUscRUifPz8mF88PrwdRv5Dp5IvyfeOzjRc9cu2b4fdQkEJkQj3OOlQQWYoBx
	HrZrVhkuGWAoru6QNh5ddV/Fcw7pY0s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-vidkA3krOQmedsk5FvjHMQ-1; Thu, 22 Jan 2026 05:05:05 -0500
X-MC-Unique: vidkA3krOQmedsk5FvjHMQ-1
X-Mimecast-MFC-AGG-ID: vidkA3krOQmedsk5FvjHMQ_1769076305
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so6237415e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 02:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769076305; x=1769681105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNqvczIVehNho1K6yzOe7LZ08YqMOyw0NvDlIw+P6AI=;
        b=IbrG89ng7l/l3NUjGV/5ES+iwxfQt8UmoECllKmxhWrmNndN6b1hILcaWqhtK6fUQw
         QIkpzqQLxVhqESfc4VLG2hq7bxrO96q2tRbXcyyqDwzvTkBkfcYZs0Bs16FkTkgVMK6F
         SAlnKivW4Hnwp8oWPnscdpZeQTXWZ6NmILqAv1Rpq+4IrPS01MPS/nSHgtxJyR/eaHr6
         IfdXxausYBxNoPEwU438EPs/Wwfyc59JTDU0Y4Hex7FUAGsrlv4ZZtqrsHNmZWW0+pYY
         zU0a/TppeL+YyKHB/+qw06ixDBCHoYSOVdZCaeg0lXGOgaOijRvUUVKTjrqXfNMxYGah
         e6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769076305; x=1769681105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNqvczIVehNho1K6yzOe7LZ08YqMOyw0NvDlIw+P6AI=;
        b=HIPp60eLuoYI2jJYSJ/rO3OyaI3Nx6P7e9JfD68J08dvrb+S59fgAl2c2ACL0aqq0O
         ZjCtdjo/i0nGsgxou1iNGSS5t7rhLO9WXFPuCbO8bPMRazMiGvwbd//p6Gg6NaR+dluB
         dvwH56tbQwCcfXZ3HxFaagxpr83NJv/L/mb42mEF0lMRXXW18r6PtYQqOiH4Ty1fkuqj
         SZm9KnKPtilo3oC7kEw01zpJ/2q2N4nIF8mFhiba9drwkDMBnXJRuyfZeWr+XOU6Szap
         yyV6YeaiFEqRhbVi/nHcx+jUbUMWsr/CQbPeFcwaGg+gAWETeeNlk2zMOaoGFhxOqo8o
         s/eA==
X-Forwarded-Encrypted: i=1; AJvYcCU7SK1oDj3wXguZDwftF3Tr5F/ylKD400ngXoDrFgrPJaI79yd6Uo3RL3EuP9NDPyO3tjGar6z18UW3JXl+@vger.kernel.org
X-Gm-Message-State: AOJu0YwxBMUi7/jUH8vroORgYIOsLGRhIZSWEjOpWB5uOOhzpizO0cp8
	qDr0ZrkbgxHmBc+WaxKXvA7s76PNFYhoS1zd2IQ6p8cx/rbIuEilRGi/0AFYLjG48i8aRuJQNVf
	g/A1Sry4gEC2/Q/JDqNQw0IQf6Sox/ZHZ3fVDqVAi3Ymit61v1uJNB13meb7i8UyS9A==
X-Gm-Gg: AZuq6aL3KrfNzmVDbSCMY/3ovLTPJWMEyHOBsDttbRLr7WR+AZkPxURZ3M9eplralD0
	eoFrfoqju9KWC0muWDgLNVXZqiSO0bFnfwvRkQ+emgUltLIzTgZ2wQcl9c5sEPZA/rm3BF1FMyx
	vVdCP+/IYs6gbXugbmCYo7SNgTLaVOaPcrCxJQFJ5XNwWCbfFnNb8zob6nPny4Kzsi2tOF41klG
	mDWw2MIPS4H5igSTrT6fuKYKa98frHALj+frzghfNRB98BIpPEo2evmDXQUkvKQtADZ3yi7sYZu
	f10tP+DgIsto0Rl/wRk8k7iEg7iK/KnWmPYcZ+2ez7iC467/UfUlUf01jKigJNnORPLHat98DdA
	=
X-Received: by 2002:a05:600c:1388:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-480409ca767mr113935895e9.3.1769076304276;
        Thu, 22 Jan 2026 02:05:04 -0800 (PST)
X-Received: by 2002:a05:600c:1388:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-480409ca767mr113935225e9.3.1769076303635;
        Thu, 22 Jan 2026 02:05:03 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804704087asm53174235e9.6.2026.01.22.02.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:05:03 -0800 (PST)
Date: Thu, 22 Jan 2026 11:04:32 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 03/11] fsverity: pass struct file to
 ->write_merkle_tree_block
Message-ID: <2i3y4kybtm2lusa7eoutefawgrkhoqhuyquilu3qvkziyhpbvf@jeyk27glmeyg>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-4-hch@lst.de>

On 2026-01-22 09:21:59, Christoph Hellwig wrote:
> This will make an iomap implementation of the method easier.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

looks good to me
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

