Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EDC3A1CE9
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471282; cv=none; b=gq1UWUWA9QfQFxkjDQ4PSOxUlTb83i8H+RqONW0I3pWUGM9NgqALkV5IejBDN2JMeXWV6F9ana+8VJ9H/xkU1zB5ZUg3sD7mFculO/xEw6ywsW9qeLtx+TBEf0YUeKeLwFdEou/6cxBUzhHm6Eg1dVBfVqcS6trZa2Luqi366hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471282; c=relaxed/simple;
	bh=oaiFZ3DlH46N1XhhAXb3U+qUFDUYzFN8rBL6S4oXlPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+hT6akVPMT7LYJmLfz6QwvUmaIPxFMQ9CGRy4hTYFOR0yWvJlABJKTy7xriHyPwOxqhMoeLjQU+LfTx8/GcLoiKVuclJ6OACM03jUT+UPvoMMrk/fyGtd6GE3LSIOAU/VJC1IEXE3Z+vBJk+/glJEME978wkBukVb9NR2Q3qjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLZ2uGLz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLZ2uGLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38091F00893;
	Wed,  3 Jun 2026 07:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780471280;
	bh=V4AYz0zS4+9vbcv+nkCEYWMc7Xzt+3F+peUgdUdjo6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aLZ2uGLzGHQC63X/6WypopcHQdNDrrt/wR3CtR+OBMN1h5kgSZMO3goJpHnCwmrQF
	 w4q/0rYoY/1afWRNNmNAo/+y1i+LwtYM4qRJHNhG6XblvC1yCouQ1/XmjPl5E9Mnaj
	 Z8Ly1Cn53OplSN2r9zB9PU47NlTW6V3sni2lVf7C6Pm5Ws4Nq74BRIYbD50DOwogMz
	 ciVN35AmcMP0jJukADumEDOaesIz7zwETj58gdI6Ub4ROHfHb+NM5RjjLdbOsxf234
	 HVQYuuJDZfEqbj3Pmgkl+gHKKkFovXgeLN0B2DhpvLQnpsMDwt/eeRlm+zMDTGMZnV
	 LeWUp+nwW890w==
Date: Wed, 3 Jun 2026 09:21:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/3] simple xattr improvements
Message-ID: <20260603-fehlschlag-teamleistung-korpulent-5e0b7fa7f12c@brauner>
References: <20260601162454.2116375-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260601162454.2116375-1-mszeredi@redhat.com>

On Mon, Jun 01, 2026 at 06:24:47PM +0200, Miklos Szeredi wrote:
> v2:
>  - don't use xxhash
>  - fix lazy alloc concurrency
>  - fix rcu freeing on evict
>  - fix rcu walk of per-inode list
>  - don't double account freed space

I've fixed a bunch of that before already but thanks for sending it
again. Fwiw, we now also carry support for bpf xattr in the
vfs-7.2.xattr branch. I'm still applying my kernfs fix on top.
