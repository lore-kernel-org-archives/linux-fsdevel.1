Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561413D5677
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775246313; cv=none; b=hj8GYIbzlJ0t6rE45qvalPloOWz6F/1R1VK+f8+YrM4WarW8pzuiSNY9spHNJqsPeb9beOe4NSEhaUyRdK/2O/N5UKb/BJP1c/FxN0qUijLxrYJWzuALujmH2jWXgN9/p4jE0loHmtJr0NwDxK8DHzl6osUVDmURc4RMMdDX6l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775246313; c=relaxed/simple;
	bh=rIhQ03FJGQL5+tUsX76RHkp0hHWPzwJWUd5CgdJYAHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBSo4ZSMT3R6ts00C9MCjb4aUszYvHdxG4ai7lQAjVrSw8YpYKGcIUHwB+GIG07JN06Szkg0NZyaMCdU7ZG4hKkU3oZhn6mEMwuwzsaZNwNT0i10nd8KkwRcIv+YZdMVs7QefOr0On1PhR9xFdoCHtF/MGxm+WOYSBtbQNwtGCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Rr//zo59; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Rr//zo59"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a6iX9hGtqufb1FVQ7FM8nZny3N0lK870tSyuOYhq4sQ=; b=Rr//zo59Jt+dnhuB1zEpQrJPDX
	da1n2XM2GogXkmjb7t50bjNe46HlKTo5UJpFNQWcIMA9EaIgl+oZlUCXb+LQWpEOwX3tjLMVXAJIy
	BkTyhf+SPfwc2E4crRCXq+Cpqij2MPLie6LOV0v0RFT8DtlS8l4XO2viiG5InWq9pfQDkeA7UEOVb
	bgQKXJqU9hBn0sALJ8nEHk8/W/wl6dCK2YgnJ2P3ja57hnJG9DhgmxHERkAjKV7xoIb9bWPMYkzuF
	IH3OgQM0jrwfe0k3NfIwdxMTxy1CvB+TfsUY7550BsYX54NAiw22LOVgrI/IbeBb/kM/1B38lpeAe
	eGNdncqw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w8kiV-00000009cmv-3CGa;
	Fri, 03 Apr 2026 20:02:07 +0000
Date: Fri, 3 Apr 2026 21:02:07 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Sungjong Seo <sj1557.seo@samsung.com>
Cc: 'Namjae Jeon' <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org,
	sjdev.seo@gmail.com
Subject: Re: [RFC] weird stuff in exfat_lookup()
Message-ID: <20260403200207.GN3836593@ZenIV>
References: <20250227224826.GG2023217@ZenIV>
 <CAKYAXd_-v601SX44WZ970LyZjsCH3L3HFjJXxZH960r1PXo+Bw@mail.gmail.com>
 <CGME20250228160332epcas1p2b177def4195cedc4c122a5f09bb29d2a@epcas1p2.samsung.com>
 <394ca686-a45a-e71c-bc45-33794463b5fc@samsung.com>
 <29a2901db9414$fcacee50$f606caf0$@samsung.com>
 <20260403195408.GM3836593@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403195408.GM3836593@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 03, 2026 at 08:54:08PM +0100, Al Viro wrote:
> +		 * This inode has non anonymous-DCACHE_DISCONNECTED
> +		 * dentry. This means, the user did ->lookup() by an

That phrase probably should be "This inode has a hashed alias dentry
with different name.", while we are at it - DCACHE_DISCONNECTED is
quite irrelevant...
