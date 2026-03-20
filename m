Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38083C7DEC;
	Fri, 20 Mar 2026 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774021264; cv=none; b=vC5VyghuF77NU879U8JSPOFa0Bd2nr4hYvW3RuF7YWj3n7jVbHkeCTwOHp3cJj0frWJPjOsU9TcJBP28qDeZc/HfbO+foAB6DEb+FvpPyh+DU3WznRnQ55zSBxJb9rULxcTkogrJZWBlf1fdxWUJo8YptaKW+c+wHEF/uzcOk3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774021264; c=relaxed/simple;
	bh=ivdHckKns1yE8Wzy8GAdXBZo5tIp3GC838TvnQSBs74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNE096sjFK5nVzfYnk1ET/NJRAARWDhXUIvb5t4V+tuwFbvvPZx/gVf7CBPRGrf7H+bMvpon5tCVrZo/zLKKuuhhhBMSlU8FpPYFkXtELqN6bwYz4UtbUo6FdSuKVDfIHHTGPJ4+o5I+mlPu1fRyNJVvAWMroUaTI+Kxn5y6A5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x9ZQLe5X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x9ZQLe5X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97017C4CEF7;
	Fri, 20 Mar 2026 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774021263;
	bh=ivdHckKns1yE8Wzy8GAdXBZo5tIp3GC838TvnQSBs74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x9ZQLe5XYbEuA4GfURSOy3XS/bspxgl3Cnp9KU1nPs+PWhyt0jmH95qPzMoxjO+mp
	 qYySfEaEr1KcCgQ36opucFzTEWNXQCJn+LdlV+CVoP9uAuq/XkzAeXR9RS+aHMV69n
	 hOP/v2LPasZ754ySNPvVfXFnsBobdCjX88RjbZPA=
Date: Fri, 20 Mar 2026 16:40:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: paeyz <iwasbaeyz@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] adfs: validate nzones in adfs_read_map()
Message-ID: <2026032039-agility-ferocity-6ee0@gregkh>
References: <2026032021-renewable-control-9c81@gregkh>
 <20260320152131.34551-1-iwasbaeyz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320152131.34551-1-iwasbaeyz@gmail.com>

On Sat, Mar 21, 2026 at 12:21:31AM +0900, paeyz wrote:
> From: Bae Yeonju <iwasbaeyz@gmail.com>
> 
> Hi,
> 
> I tested moving the nzones validation to adfs_validate_bblk() on
> 6.12.36 with KASAN enabled.
> 
> With this change, a crafted image with nzones=0 is rejected during
> validation:
> 
>   ADFS-fs (loop0): error: can't find an ADFS filesystem on dev loop0.
> 
> mount() returns -EINVAL, and no crash or KASAN report is observed.
> 
> So the issue can be prevented by validating nzones earlier in the
> validation path.
> 
> Tested-by: Bae Yeonju <iwasbaeyz@gmail.com>

Great, can you rework your patch to move the check to that location and
send it?

thanks,

greg k-h
