Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233A1363C4E;
	Mon,  9 Mar 2026 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071138; cv=none; b=BLfuCHmdhQ7xNeiyx8XwKh1Q2gTQRpY+A/x7/Q9ZW11aBmdjqsr0+FAFjuiABqBjlJmKPtpJ+bzrZqVZVoJo5XtP8gvYhNlF2RWAXEE1MxGbTZIY8FxouOABXvGUUqCmABjgmFY0nSy3pibdhbZZ00vhabQjluFADjZ0wi0UgiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071138; c=relaxed/simple;
	bh=CHIABcfp6iFjBK4U5KHO6h46nMUq7NvXYnb1FyFja3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXAag6xBXMRsCYIol0u8oGuyaqt5E/F9ckEILLAdT6xtBo40e8USwepSFvlRhO/a/ChxNRztrNT+LzU2gC6r+ilZ+pYbkh7BmWsmTDz7084cq+00S5Y3TT3oRbA8fy9q0HSXeEJOgbskNNOkOxtf6MD41pfj1rQUon4ZCuTWU78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IcePNSxs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IcePNSxs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741C3C2BC9E;
	Mon,  9 Mar 2026 15:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773071137;
	bh=CHIABcfp6iFjBK4U5KHO6h46nMUq7NvXYnb1FyFja3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcePNSxsXv/P4uBrW6ce/vz7c4D4ccbdz66tz+MxL8JrMG/4+5hs56v1n486TUEYN
	 R8IS+xUO4n2w0LBxOv10Gh1UyY170rfJKKEixHkTsuUfzmoGjw1I5vY86GhP8zoC/k
	 I9tCAirwB/P07pLok6RUrXAA/r8ov/OoRMnfmjaw=
Date: Mon, 9 Mar 2026 16:45:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Johnny Hao <johnny_haocn@sina.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Wenzhi Wang <wenzhi.wang@uwaterloo.ca>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6.1.y 3/3] hfs: fix general protection fault in
 hfs_find_init()
Message-ID: <2026030916-chaperone-twelve-8284@gregkh>
References: <20260309061649.1621436-1-johnny_haocn@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309061649.1621436-1-johnny_haocn@sina.com>

On Mon, Mar 09, 2026 at 02:16:49PM +0800, Johnny Hao wrote:
> From: Viacheslav Dubeyko <slava@dubeyko.com>
> 
> [ Upstream commit 736a0516a16268995f4898eded49bfef077af709 ]
> 
> The hfs_find_init() method can trigger the crash
> if tree pointer is NULL:

Why is this not part of the 1/3 and 2/3 series properly linked together?

thanks,

greg k-h
