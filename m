Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0E214900E;
	Fri, 18 Sep 2026 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718673; cv=none; b=TWC0Y4Q97DXHh5kMUXJ35rFXEBwBEK0CGYLwAVQeoBoZXFav9UgTdBwvN2qetGXZbiEzwXbgZp1Bu9y7+4RSIbKdiFS32QwAoplvg5hdQFNA2UrPbI8SnYx/fWD7TWCca1ZNr4CtQ0CsXajUFDvPakT9mQDXMfnYhzHO39psb0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718673; c=relaxed/simple;
	bh=W8Y2Iiptzh3PAirfHIu0IxFbxBTCwpPhLsDfQ9KpzS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvpB4bzFoRw/kcbvq2it3Sej9mxg0Ah51/SKJ8ViMnybDrR47kvzl6qC/3TJxQOTkQCcnYtczpa/Vx2+OjJmbwnO1KRYieJ3CYN2LRYxYbSM7Cma5TB3q1Ifvbz7GF1MW8/KfxkHIxOHOBo1qglO3c0vzwo1LiCZPk3E+DANPY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tkgip5Y0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tkgip5Y0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B311F000FF;
	Fri, 18 Sep 2026 08:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789718672;
	bh=JoolW+mpYeOiDJYYvBVHlQXWnPeM+HLuLahZJB6MWMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tkgip5Y0AG8Yuz10dSf3/M6N0t0qft3H3KkUfbRoBy9xLwB2cHZSsTNsic4x945dk
	 XQZ+PNX0jE83j3LXc9cTbLig7eSUSCImnjRr7v14K+n5ax5fB+qHuulrkxO/ozZ6Kl
	 u9cmiSDsOf6x/DnnXI3NxxQKK38M2QUJjb9cK9zUcsZulzNDPuvxNiCAscXQti01vA
	 xcs9Je22Ee3OmpKZWcwBGjgjcY6NCA8AcswnZSjrUDySKcFaBGfBecQ+WioDDpCUY9
	 VHNNcGiN1lUS9BBtg4Yxz8k6Mhaezlkki7AhSBFJooNvWbsTQ57ua5uo4hgXbhaC1J
	 Gt4HNQQTOJ6VA==
Date: Fri, 18 Sep 2026 10:04:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/12] vfs: change ->create/->mkdir operations
 unavailable errno
Message-ID: <20260918-kargheit-reibung-meinung-b0030a0b063e@brauner>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
 <20260913185016.523376-9-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260913185016.523376-9-jkoolstra@xs4all.nl>

On Sun, Sep 13, 2026 at 08:50:12PM +0200, Jori Koolstra wrote:
> Currently filesystems return -EACCES for missing ->create and -EPERM for
> missing ->mkdir in vfs_create/vfs_mkdir. Instead of duplicating these
> dubious and inconsistent error codes to lookup_open(), change all to
> -EOPNOTSUPP.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---

I suspect that still has regression potential but we can try.
