Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B372D4F4CF3;
	Fri, 18 Sep 2026 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738177; cv=none; b=e1cC30hPYTjkglHmrbn5ENSjZmxQvmpcuUxpB6y91kTJpISgg0guHvOTcwyubfv9RotoohKW7+cU6ttoWcHzmK35QvbxatuPXBiNWk60Z4E+AHTZO4jlh4WP4e8Gy1xgzCywESHHaq7yi0LJyIYikPm/9sHPcGyDtR0+3nEOnuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738177; c=relaxed/simple;
	bh=1umyAol6qJ52sj688B0QitsfoTQEqbkW4R/EnVJiSfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5liH46D1UR1diOw7pv9JnHPwxpJJvkMP8xtp9VAof3lO9Kh/rVJxwwby/SlOq8AeDMzYTzQe4vM8rIcQU5Vvw/oY9+ZgtlxWqHrewoBUpL+xCYyv8wMN780N3uavAjYllqwuy7OWx4kUGFo9iPPyXetZsibrJs8f7tqkYyOlJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E41C68BEB; Fri, 18 Sep 2026 15:29:32 +0200 (CEST)
Date: Fri, 18 Sep 2026 15:29:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com, willy@infradead.org, brauner@kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH v4 2/7] hfsplus: rework hfsplus_get_block() logic
Message-ID: <20260918132932.GB18107@lst.de>
References: <20260914233941.2966421-1-slava@dubeyko.com> <20260914233941.2966421-3-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914233941.2966421-3-slava@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Reviewed-by: Christoph Hellwig <hch@lst.de>

