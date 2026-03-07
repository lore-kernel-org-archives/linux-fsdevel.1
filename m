Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E167DA66;
	Sat,  7 Mar 2026 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772861492; cv=none; b=SmOlwEy5+CjO9CmOY66CNi457d4WzUMH2x0a0HTbc5CWLb/xNKjggkw+vYJHVHvAAFdndajNw1t5yOdhKrtCZ6yE1GsIJVIsKhuUHZGa0bwb+FtcamCeK8OxXxFnJtzaVcW048e3iLhcInDhYZK51TwtgOGmO8eW3OxZnaSavTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772861492; c=relaxed/simple;
	bh=wyz3A3AtSLzFVLGjvh+Uab1sFzssX6M7zw5UEBR/3kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gD39heK3Tr3XKtGxLJRpKa+eCKQ+5NNJHSBdZruRXuRfUvZu6UDlCU4Vtim1230TMhbNKglkdh0eG71pHhRcndSbYeZqQDdr94NZvUo6oyiuMwB49BpWxfADyS0EnNVBpkQ4bRoOnomSaciIhpF29TX2AcHxW14GH2upWllHkQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LakIXa3B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LakIXa3B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wOMslJE+QwbHvW4eWMuhh504W4HXL8Jtjk17GpTD7AE=; b=LakIXa3BIfBuqh9GBdTxwxv3iB
	/+hX7c5Ohg4rfiksoQ3rcsDq1AyCUpCvIEWDPaS686crxMAZR8e3vwoKlXEYQjhpUmKBdQpjn0vt3
	sYRKc9InW9Ttqzxw/OSmSwM4iMUsUzog163m4yUhIlJPGCwqiVrLTVjdIlXMUxBfmMRDwoz7l2hrI
	6AYiZquoB4GtDg1ZPbZOgd2jIzU1Y0W3ZCLewEGBIfSRr45faDLCwxiRBM6VUxnpdOFL0HuBq+z4w
	if8abet4mTxM6YFrV1+Qhbm4n7Gjn9TSQfhrMJV/2RyPCbi8lOHshClYLjy7Si91PLZ0rqoEY78Z2
	vhnawvzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vykG4-00000000MYu-2F9k;
	Sat, 07 Mar 2026 05:31:24 +0000
Date: Sat, 7 Mar 2026 05:31:24 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: remove externs from fs.h on functions modified by
 i_ino widening
Message-ID: <aau4LBhdBfnDJAsl@casper.infradead.org>
References: <20260306-iino-u64-v1-1-116b53b5ca42@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-iino-u64-v1-1-116b53b5ca42@kernel.org>

On Fri, Mar 06, 2026 at 08:27:01AM -0500, Jeff Layton wrote:
> @@ -2951,26 +2951,26 @@ struct inode *iget5_locked(struct super_block *, u64,
>  struct inode *iget5_locked_rcu(struct super_block *, u64,
>  			       int (*test)(struct inode *, void *),
>  			       int (*set)(struct inode *, void *), void *);
> -extern struct inode *iget_locked(struct super_block *, u64);
> +struct inode *iget_locked(struct super_block *, u64);

I think plain 'u64' deserves a name.  I know some people get very
upset when they see any unnamed parameter, but I don't think that you
need to put "sb" in the first parameter.  A u64 is non-obvious though;
is it i_ino?  Or hashval?

> -extern struct inode *find_inode_nowait(struct super_block *,
> +struct inode *find_inode_nowait(struct super_block *,
>  				       u64,
>  				       int (*match)(struct inode *,
>  						    u64, void *),
>  				       void *data);

I think these need to be reflowed.  Before they were aligned with the
open bracket, and this demonstrates why that's a stupid convention.
And the u64 needs a name.

(other occurrences snipped)
