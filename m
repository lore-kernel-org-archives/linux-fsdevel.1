Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02938371899
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497013; cv=none; b=Fo0ZNS/zYlxUo1hIMi8yJU0RlTcZf4HdLTT0VVseBNoib8kyOAB8z4zcHJZw7EcqQgkUCpOdAMHxeZml0RtxoxGZG6jCT9BNVPId2EpjAZnQRy2MIFrl8JsGqPNWb7IbLvnTjUmyYf8x1hgvgB3rc2IsgwvV/VJMkegw2aU/AUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497013; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSWBzK9xsc6G1nG2p00KCbQZhlPWcyluYuEuOoAnKlSN4Um822TBp4bvdMFEFBEf+lksmRKbY8ArL9tc542niekRMiT3Y1vJAF0KhVxvm/lW2L/O1BAPB40z8pynQ8vi7PTRrsPKfa8U3o05J+UzpwV8CL7DN37RF273/bvpuy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D0D1368B05; Wed,  8 Jul 2026 09:49:48 +0200 (CEST)
Date: Wed, 8 Jul 2026 09:49:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, miklos@szeredi.hu,
	willy@infradead.org, linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 1/3] fuse: don't clear folio uptodate on
 writethrough errors
Message-ID: <20260708074948.GA32452@lst.de>
References: <20260707220450.1200943-1-joannelkoong@gmail.com> <20260707220450.1200943-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707220450.1200943-2-joannelkoong@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
