Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F0C3570CC;
	Tue,  3 Feb 2026 05:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770097091; cv=none; b=MycMWEGcsn5B2S1RSbS3vF09uoNLl9VsS4u3h8XnjkzVdh9pQqGTGix9lJRTT2EXViVEH+ERz5WzskZnS2iAlx41tBavDovklZHn3cZ5vn7klRG1t2ZtCfE/oSobNOeoyZBTNyCm+0aeK/Pf9S/RlpEFZxLrq62f6KSSBbxC+7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770097091; c=relaxed/simple;
	bh=NKzpR3GFmqOh+Kv6INipr2JnSV+K2dFiZWMcX5Gc6gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJg69CAFleXR4o5KFAphZtU2roKPTrk/ie+lAli6uIRgR/SuCCLFnN7YpMz/NEwlKfhV1U++Fj3LLsDNComYMq3tle00ZnQ5H9Aq0g/H9bcQZYVlEz3hlD5kw8oKjeoBA8vjQC3Ej1UpPKEN6Ah+AzM9xxpU/rgynF4yR9HWFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 960D668AFE; Tue,  3 Feb 2026 06:38:05 +0100 (CET)
Date: Tue, 3 Feb 2026 06:38:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@lst.de, tytso@mit.edu, willy@infradead.org,
	jack@suse.cz, josef@toxicpanda.com, sandeen@sandeen.net,
	rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com,
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Subject: Re: [PATCH v6 03/16] fs: add generic FS_IOC_SHUTDOWN definitions
Message-ID: <20260203053805.GA16249@lst.de>
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-4-linkinjeon@kernel.org> <20260202223657.GB1535390@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202223657.GB1535390@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 02, 2026 at 02:36:57PM -0800, Darrick J. Wong wrote:
> Christian: any chance we could get this api cleanup queued for 7.0 even
> though we're past -rc8?

I assume the new ntrfs code is still aimed at 7.0, so it would be best
to just merge it with that.

Reviewed-by: Christoph Hellwig <hch@lst.de>

