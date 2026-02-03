Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C0636403F;
	Tue,  3 Feb 2026 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770098124; cv=none; b=h6q6EfmqKAkuETwcNWISELSRR5HeLoT6zocXV3RwqEW2+WJnSf/Irpbr0ONUoS8rq/q/e33PJaoYi/MMJDQAjW23GNSlpxx2GenM6ApsFiAQx1P4367+PQxw3l8+8O6zkINjLQvP1767ioDIegmrsS0OaajXzmHn20I5zbjRc34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770098124; c=relaxed/simple;
	bh=hpspauHVkLXlgngOZbWQ4TPVmt+sQ6BryqrjuGmwF/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSgPCZelI1KcmIZBY2GIU+Sts6x/u9UpIQ78MkyXYNqC5WwG4/RLnLMlV5ANEWgOBDDU4oMi1Ftm78+UCW3DaMfqORZb/V9qhkUmmj2gVwvRzK+eOq2dWRV2tS2mTgXuyorslK9lCca8rb2XX0TAlL5w7YAgZoHIHhlu6/8kovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4699E68B05; Tue,  3 Feb 2026 06:55:16 +0100 (CET)
Date: Tue, 3 Feb 2026 06:55:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com
Subject: Re: [PATCH v6 07/16] ntfs: update directory operations
Message-ID: <20260203055515.GD16426@lst.de>
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-8-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202220202.10907-8-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Suggested rewrite for the commit message:

Update the directory and index operations to support full read-write
functionality and use the folio API, including directory modification.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
