Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C31F3B52ED;
	Wed,  4 Feb 2026 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198143; cv=none; b=EqtRkfHVKf0WCU6lJuDmPHrkrPC22PLc743fICDi4g9eIFQTB+fL8TbdiSSCDQ/Ngk4gdzWoSIXut8pvSN+GdMycJIaaBxsgdJ2KjAPdPfaQWvSFyqdSiH8JtMU57K2goWh04d1jandnExCAPA7eimQD7hEOhOjtWe+x082vwrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198143; c=relaxed/simple;
	bh=ArE/9DUpQ0ZUhR9LVZcX4DwpU0Rm+8M1KNGYkxGnhD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMSd7CVvh0M0vOTsEU9bGSKwJrKDa+GKT5V2eEa6ciYzeF706Qz6Zr0IfCpZzdjKQ9Lx2MUMcxYUBaKjqcq3PDyF/RiqLJI/vyPKt54q9MOApH5TIvu5WgwmDSBUWYlj9JZq+X5jV9tFY4460wbR38dfXr7+TYgxjxjHsPPbJUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC48F68C7B; Wed,  4 Feb 2026 10:42:11 +0100 (CET)
Date: Wed, 4 Feb 2026 10:42:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v7 00/17] ntfs filesystem remake
Message-ID: <20260204094210.GA31939@lst.de>
References: <20260204082931.13915-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204082931.13915-1-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

I could probably nitpick various more things, but I think this
is good enough to get a r/w and fully maintained ntfs implementation,
so:

Acked-by: Christoph Hellwig <hch@lst.de>

for the entire series.

