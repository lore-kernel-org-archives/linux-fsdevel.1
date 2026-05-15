Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B213D7D69;
	Fri, 15 May 2026 04:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778820641; cv=none; b=ly6cVEJEjhwtbuOR/MxMVMSNKoPtVwdVDcdGfOw6dG2jsZdN31mm8dFmz+URRn2ryGtJ0T3h4ik+Y5LHxbzV1Rdmn/i1l2q0v6bGl7cLxhbIhOS8whXU/egBDs0nSq8yDNW0kdoVgbjDdPGlhsA0Vur6XK4p4Uev9nvQo/XcpZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778820641; c=relaxed/simple;
	bh=H45o2miK1PXMiBfksS2sJI7NpaRjfBfdKbC5TDb/Vrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXVGdhnzc25CP7hX6S/BDjcZE+q2VK8pYT88s3fpwHj+j+dQ2qVaxqdvAfYh3Py8dHTInDRjkfpsIrKtWvcR5/FkjGj5GcH3P5cVmCAvv5b+c3Ln2MtKzEKoMiEquSs7EY1j8QiuUtqX42DDKKeDwxCcS2tDuKDbBJ6zCHrjit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 14B5E68BEB; Fri, 15 May 2026 06:50:36 +0200 (CEST)
Date: Fri, 15 May 2026 06:50:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org,
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn,
	chizhiling@163.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/11] exfat: convert to iomap
Message-ID: <20260515045035.GB4059@lst.de>
References: <20260513112156.9122-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513112156.9122-1-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

The whole series looks good to me with the minor suggested changes:

Acked-by: Christoph Hellwig <hch@lst.de>

