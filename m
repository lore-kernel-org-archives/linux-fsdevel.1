Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCF34570CD;
	Fri,  4 Sep 2026 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514917; cv=none; b=jzIXTAvf0/H6BpuK1zWEHiVsXYrwP06aMw6dl1Qt8Im4W7V5qFUpbkYotd91QjPBFD03Y+XfyACUcR8HeP6re18jKwTB/lxQXY5hPWShWL3y9QxV9Y4AslVnqYnqhrdxVjnKCHeNyM2aKTA+GyhP7BZfatmj6BGfaqiMrPQWb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514917; c=relaxed/simple;
	bh=+w05fDpk0HTe2E5dnvfJZJ/g6nk04OvzH7sbQKurVvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sU09u8kh9dOlAZRTXie/wfGKYNEv3mgvte19RhsTSPyVYeerJr6DcCzdWU94cUIQpWwueyn0VMZUMAr9yCCY6oGMkjJ15f0Hts7bMnSF67EaZa0I8ohIKKrejRXLuw5niPrrGaYX3nC3YK4DDxoa/LP0FOhf5k6ryTy4XQEeQAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IURrZusN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IURrZusN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523CB1F00A3D;
	Fri,  4 Sep 2026 09:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788514915;
	bh=+w05fDpk0HTe2E5dnvfJZJ/g6nk04OvzH7sbQKurVvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IURrZusNV58FhHmOddJVhGj/od3+eYykXqPJZAVSU5t6B1Uolp8nvezhKU2Qsm1pz
	 un5CfWIiPIzbfwF5yIPvIVuT1qssdFm93pzlfOT1jbWIcBMizRAccd8jyx32ufY0Jr
	 8CIYlF1AxXLGruVpgeBPjFQEu8IJFpAi+iRQWrTwKkdR2tHJPWMQcmAVJox84Waxnk
	 qrefrSA7G6XCuYq9rKSLC3sCKVIAHPqTyuUpfi1d8wSnPPE6ylwLsYw1eBC6aYifVJ
	 uJNA4iCRFuwFw8KPoLJrf4sLFL2ZPpSsw0RNh4mI9TIU9ZzQ8+84EPZruT8PIOxQKZ
	 ZQhGNeBgUXwlQ==
Date: Fri, 4 Sep 2026 11:41:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Mikhail Rudenko <xyzzy@yandex-team.ru>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] Defer final iputs for dirty-time inodes in
 PF_MEMALLOC context
Message-ID: <20260904-geldwert-indiz-dennoch-0027d3b08da9@brauner>
References: <20260813-deferred-dirtytime-iput-v1-0-ad2fb3ad6bdb@yandex-team.ru>
 <27v2ckdgybmvxog5b55sr3o6ri4bkbzu6ycwtjwckrhzyazxzd@7qruolrsu5t7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27v2ckdgybmvxog5b55sr3o6ri4bkbzu6ycwtjwckrhzyazxzd@7qruolrsu5t7>

> Thanks for your patches. I've actually submitted patches to address this
> problem back at the end of April [1]. In particularly the problem you
> report was addressed somewhat differently by patch 1. We've then discussed
> them at LSF/MM/BPF summit and people mostly agreed with the approach, just
> there were some requests for better parallelization of deferred inode
> reclaim (which I so far failed to implement). But it's currently high on my
> todo list so I should hopefully send v2 of the patches for the next merge
> window.

Thanks for working on this. This is good to hear! :)
