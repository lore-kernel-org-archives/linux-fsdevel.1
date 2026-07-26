Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA0189F43
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785098735; cv=none; b=bq9ao9vd1fUqH+AK5H2GN0AASf2S7IB9X20wTnixf0u34U51IpnRjP59lKvMk48vK3/60J2lxJnCaR30wbEiTsmTCNidZ3ugUoMC6SZWvVLdCVmtIIDFIz5t9Hag+2/0cl8GDz3UUGU13P9dL+StGL4ikDWqkx1z+b/VQISPQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785098735; c=relaxed/simple;
	bh=ZTR4dChSqyWkaTKOGoXx4DkHLO+2ch+C057vXjK0Y1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CySQfyhmZ7lbW6HDEpg8ZjBU+jjdy3no1TYvxznkhCgomwZ2AgJNL1xyW2GgkfSwMOwr9efa64YPYlvbiny5XDbqTS4/fSnu7AUZDcnMmWUoh5sCFJEEIsxpPdk7Ldzrcd4hiHpqL/R2ha/HLrCY/XFcT2l875X1zfTp82EajUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nCqPrhxd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nCqPrhxd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rjWT6qiO6ggBSQGZubmM357sF9FoyHaCsfRJL+Ag5QE=; b=nCqPrhxdI+Hyqu6WK7yTBlZE1/
	rwQaRtRVHMnTYho9FMc7Fn/7XRoCptybDAIfCduNvFs4gOd3uU5VqVjwcUHVZb5oyPTiVn5J3fhG7
	sBb5GtnYKdsdwya+94zrhJ6DpWdV8keF/w7ykiePeX56TD1dYMgW0AcoabQY3oPX3Z0hFN1QsZikG
	ma9QeW34EAAfMIaizuY4M79Jn8C3nMi8H95TKqEwvMmwceGQdOlw+OZVWW7T7onH6yVKa49jz968t
	p9msyhe5i9AOr8lizlMDG8VbUKk02wSY2RZXdNd9ollz+06fJPk9gvAlxEUNR8yuDxoKGpq3edmo8
	0g3s7vaw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wo5iq-000000098ra-09Km;
	Sun, 26 Jul 2026 20:45:21 +0000
Date: Sun, 26 Jul 2026 21:45:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Akhmad <akhmad100913@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
	dhowells@redhat.com
Subject: Re: [PATCH 1/6] fs/cachefiles: replace simple_strtoul with kstrtoul
 in fcull
Message-ID: <amZx352Xsh54Lxf2@casper.infradead.org>
References: <20260726182540.40891-1-Akhmad100913@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726182540.40891-1-Akhmad100913@gmail.com>

On Sun, Jul 26, 2026 at 09:25:35PM +0300, Akhmad wrote:
>  {
> -	unsigned long frun;
> +        unsigned long frun;

You've changed all the tabs to spaces.  Please don't do this.
