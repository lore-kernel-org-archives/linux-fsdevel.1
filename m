Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE1B3D1718
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298356; cv=none; b=dEe/ju9CBy6kdZcfU+AeSJDDf1hcKqEn4z+E3Ee8AyDc+8s9NLOlY2TYjC8KxanR+o5sn4+BoUTW10Q4/O35xOHLGNynRXyZ8anMNKlnpLo8BJLDr4TBcPGRTLFDplGxnU5W3dngHjTehNLJwORkZzik0DcmNdvXRcBs/YnAk74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298356; c=relaxed/simple;
	bh=+YzgF6ySN9VTzZvacJUt0H/0kUIXVafLw5DX0bEg834=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgJyT1gyVLTvNaY8mKTmLQyJW0RKfpfGWLHo8ZJf+9d6tShJ6k0EacWSYO6APK4/jrPslEAvKDUIVcgAYPQlUHHlsDoubLCZSjZciltg4dxv08zUtX2bOmimRywQa8Eg3ekHFlj5VqZSSpRUaVbmi+tk4weuHvqKAWv0CTl8wrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KAHomSWO; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KAHomSWO"
Date: Mon, 27 Apr 2026 15:58:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777298342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tjzUh6En1w8P94Pz4L1rvJR5Ts2hAoap8CjLzsNTCIA=;
	b=KAHomSWOi5JJmULstMvgZvs2QE+y9DGf5GxyTz1+PkUOTTzYyO+CEZuMnWyLCKC/vHAoYG
	7yfSOMSOCaXjwB+KnDCb7tsMhK3hY15w3Sd/fWBM5cVdfA/fmewf6N5ALOTvYfALI1rJCi
	8KjhXgawn5Jr8hSD8Lme6lzCsj3SzzQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache: use QSTR() instead of QSTR_INIT()
Message-ID: <ae9rorhAVHKr00TO@linux.dev>
References: <20260422123345.100436-2-thorsten.blum@linux.dev>
 <4pinx2ihfsrbk5wypfhfx46p3g4wd3ko3i6dxqyy64m7fquzqy@dnob2jlgqqt3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4pinx2ihfsrbk5wypfhfx46p3g4wd3ko3i6dxqyy64m7fquzqy@dnob2jlgqqt3>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 22, 2026 at 02:51:19PM +0200, Jan Kara wrote:
> On Wed 22-04-26 14:33:46, Thorsten Blum wrote:
> > Drop the hard-coded length arguments and use the simpler QSTR().
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> Sure. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Hi Jan,

This should probably be dropped as it doesn't compile on architectures
where strlen() cannot be folded to a constant at compile time (e.g.,
arch/sh, arch/arc).

Thanks,
Thorsten
