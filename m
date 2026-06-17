Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866283F54BB;
	Wed, 17 Jun 2026 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703682; cv=none; b=iZ6yeIYLlpiGeVl+BQ/IGkvcrqASDEGVVyjHD9KYIoWa3SpgcjCropKGPIkeFwEpoBM/ZRz517135HghnvDqXw4qBKZrkXmMrHjsKgJeawc3ATuUQOouaz68FPAuGUyALBtjonwZzxdaHsknGNm0ximugV3b2U4lNz0VsQVZhDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703682; c=relaxed/simple;
	bh=sqpZUs3wwMulqLiaidKW+LPO0vEhwdu/yryvggIUz/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZjjTE6lgseYVuHISPSJ9eqG9l1EWd3ABIgPrnAv+QHMjdpqgOWnEc27EEIst1YfOvXZO7KZ6Gi0cX5uS/nHHkbv6eGoXuTN4qPw+5XDgUfMINND0WxmfzQ5pGjs88Wyi4O3koxQke1mQUXJfu9rYazVQfjv6dBF6FB4pDM+JA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZyiE3bE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZyiE3bE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF841F000E9;
	Wed, 17 Jun 2026 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781703679;
	bh=sqpZUs3wwMulqLiaidKW+LPO0vEhwdu/yryvggIUz/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NZyiE3bEDjF5os+VaXcnk6+nY395YxHV0LbZ+GdN2P3x/j0d9y1mU+Yn7RAtsSHFv
	 DiW7tVuB7diESzZrI3WQ7o6oNA1f4xqohmkLzMuP5gQkGJ1mGBRijrXydfZ9YkJNez
	 3dT/4RsM1eKT+q3gyicdh5eNUZBJ5jr22Jsz1UV6MN4fN/Gw8Urxejz6nJhxBdS8NX
	 ksqgpRis2uSWAXPFFVbEm1ZL/gMPvcIE/wEec4xhGrSxOZlb9yf0RmR332x2IyLkoc
	 dSogj3vOCH5tOXZDRfZ1afUh/n25ZfKvqt6M77uOjG9b2WwnpKc5jTFKZVXCMv1CJE
	 9fEzwYnOhyAYA==
Date: Wed, 17 Jun 2026 15:41:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] file: add fd_except cleanup class
Message-ID: <20260617-marge-gelehnt-fernreise-758645450688@brauner>
References: <20260607164136.2948550-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260607164136.2948550-1-agruenba@redhat.com>

On Sun, Jun 07, 2026 at 06:41:34PM +0200, Andreas Gruenbacher wrote:
> CLASS(fd_except, f)(fd, mask) allows to specify whether to accept or reject
> O_PATH file descriptors by passing a mode value of 0 or FMODE_PATH rather than
> using a specific cleanup class for each case (CLASS(fd, f)(fd) or CLASS(fd_raw,
> f)(fd)).

My main objection to such patches continues to be that it keeps watering
down the meaning of O_PATH if it continues being usable for performing
ever more actions including write-like operations like setting extended
attributes.
