Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C534B26B777;
	Wed, 18 Feb 2026 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408173; cv=none; b=ZlGRBgfErf2Gn8EQbLmKGI0IDRSjGT7z+w/jtZidgpQ4fGcbEgOU+fq+d7OIkCTKm+NCC+NdVcL05HLHzHdKp+QhJpB3O8ED9yFQPx+pSaXsDVZ0nmYoY/ag2iROqCjG3xs48o4Go+q+QpA2xIJeZ9DYhYzMvxDGoWxh7LnwiJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408173; c=relaxed/simple;
	bh=y/LC06NZ7wcIvCV01Lkgdatb5fKdK8DygTTS1T4W/io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmrx8eCnuV9qbI4zwUr+Cu9GXELDj7Oh2uTy6A3CHAsV2+WnaVnkhUV/VFe0Mf4omOQxR4nCs1IcccdionZqJ7ufuDv6wuXIeV1LW9suPDf5KC0dts2IhfZ+ULlhvwLogsSYCNgSB6+N0/VHKasJ9nDlwSe7ZAelYQDAfadDAwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4aCgn59; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4aCgn59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA900C19421;
	Wed, 18 Feb 2026 09:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771408173;
	bh=y/LC06NZ7wcIvCV01Lkgdatb5fKdK8DygTTS1T4W/io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4aCgn59YxGBeMO3vU6WlY/UbCNJZhSlsFdnyTnY3ShbsZ9AfpshGtAR3GhDNsTWk
	 4he/BN/E8RifTYQwHoF/aDykAGaHr1Cvh+HGTNp+Ho46rRDmExk45guNP3VvHXSV8H
	 zNWkbjfbKVv+Mkc+GBp0zZs9cLuYVht/99UHE7wPiZJ7Dby38vitnM1zTtqbOcK/Jq
	 7Qa4EHp0ir3fC6yl31JyjPWa9LAaohExZ0HqQBDI6NN5ZKgf2rvfql9THzJiI6viO8
	 MFQCenrVnQ3Yg2FQdeuvDZA+zqLzc9CY2kGEVe30kSYxKwooz5UjmRuuLOPNJcVPp4
	 KaRjJq/7RYJTg==
Date: Wed, 18 Feb 2026 10:49:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Tom Spink <tspink@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] Introduce filesystem type tracking
Message-ID: <20260218-goldrausch-hochmoderne-2b96018fbe5b@brauner>
References: <1211196126-7442-1-git-send-email-tspink@gmail.com>
 <7b9198260805200606u6ebc2681o8af7a8eebc1cb96@mail.gmail.com>
 <20080520134306.GA28946@ZenIV.linux.org.uk>
 <20080520135732.GA30349@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20080520135732.GA30349@infradead.org>

On Tue, May 20, 2008 at 09:57:32AM -0400, Christoph Hellwig wrote:
> On Tue, May 20, 2008 at 02:43:06PM +0100, Al Viro wrote:
> > No, you have not and no, doing that anywhere near that layer is hopeless.
> > 
> > 	a) Instances of filesystem can easily outlive all vfsmounts,
> > let alone their attachment to namespaces.
> > 	b) What should happen if init is done in the middle of exit?
> > 	c) Why do we need to bother, anyway?  
> 
> We had a discussion about filesystems starting threads without an
> active instance.  I suggested tracking instances and add ->init / ->exit
> methods to struct file_system_type for these kinds of instances.

I'm sorry but the infrastructure patches that are advocated here for
this are terrible. I'm really not convinced at all that this is
something we are going to support. We definitely don't need additional
sleeping locks for this in the code.
