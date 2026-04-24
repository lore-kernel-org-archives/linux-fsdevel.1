Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CE33D6CBB
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037409; cv=none; b=lkROW8M927BzPCIgSRSMXXWWA+qYkgbEDYfPsbCa7MnNM0+liDSuz+zsbcvNV2WpXhyW1Nv7XKj3nzNe2owdMstIKF+Wu0TPkejS/1YscVahc0sGkeqBBszPsw5rWh2RFABEh1gheAMxDEpR4kBcX90K1+qtdDmZT1a5k+CJ8xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037409; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ+EswSYNDefvPjU/ud8lTveZO2xjAsDop0G2cItDIcj03LEisl/fD+xRpcAVEQQAkkTFWORTpTzPgdsM1mmLwJJC7CqnXk2Th8hNaam4qMUHh4xiHieKGOa0/MWSlqNDVqgffThcnjyylYBV5j2Anc860ujJuE0s3JpPEshbvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6316868C4E; Fri, 24 Apr 2026 15:30:02 +0200 (CEST)
Date: Fri, 24 Apr 2026 15:30:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: brauner@kernel.org, djwong@kernel.org, hyc.lee@gmail.com,
	willy@infradead.org, xiang@kernel.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: remove over-strict inline data boundary
 check
Message-ID: <20260424133001.GA16307@lst.de>
References: <20260423213203.5533-1-linkinjeon@kernel.org> <20260423213203.5533-2-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423213203.5533-2-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

