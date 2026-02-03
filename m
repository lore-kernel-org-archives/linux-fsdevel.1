Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8589D36605F
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 05:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096570; cv=none; b=fGZVf3AJP1ndAa+aac5Dr1fk0dh+AaY3b/5Gn2TozphxZstZ3hZE7cOe+F/vbDL5p4kLabVIwnO7HfsT25YPocB2W4siVVgmhxvXY+OM29etyNv6YulFqErD3teJGHYotbfl+T//OUAFTNxkVhzxToO8Ivy1KN58IPrzMM0vZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096570; c=relaxed/simple;
	bh=dpDjjjOVou/5VGgVN5XA6KbN+UYV3Vd7ojajwbSS/t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB6Yis6AoLXln5uEUR0ypEaQoGnJSz4ga8wGLXrc/+wdbFYULvCKTzTK8CsSmtGMsLMb4HSEmLo2lPvc9mrZ313uuI5d5W3Xj7YnWN/SNs3stwD1Wmzznw7XnGE/svtuqaRKTeBq6RN5eigagfBR/HXw3/p/TCGrQMGWE/XPLtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 962A468AFE; Tue,  3 Feb 2026 06:29:27 +0100 (CET)
Date: Tue, 3 Feb 2026 06:29:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] fsverity: remove inode from fsverity_verification_ctx
Message-ID: <20260203052927.GA15956@lst.de>
References: <20260202213339.143683-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202213339.143683-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 02, 2026 at 01:33:39PM -0800, Eric Biggers wrote:
> This field is no longer used, so remove it.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

