Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086C1449B30
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591569; cv=none; b=OnMiqLslZyP9caI6ki9jVWRL/AJ4guaFtn3VTtUbX425ZcROiFqHCJuq+MHGZVXayFudl1uaqh9QW1Rx651c7ePkPv2N223O/o+Vakt24qIBXJYCaOQhShG+S92bGEnnGjol4DgImCngDO09uOyfRFEEjLGFOLmP96XY21zALUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591569; c=relaxed/simple;
	bh=ZY0w8cRIBa50K3FgpTT9y+s71TRcLZprMqXdyRf1p+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSspaU2ttG/+FgqQEI7Fsb4YI+gh03V1w1ibvdz6nlVyssgTX9HhkjLemRVS3DEwXMHKAeZCyXbBzLya8X6yTvHyAquMiLTQsYoLEEmr8ksRoZzbufPeB4VKzTMhlGTaODvE0ET0og3Pg+a8E+s70FOtHlXzt40f1fRezDY121s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=im/gjZIG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im/gjZIG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544931F000E9;
	Mon, 20 Jul 2026 23:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784591567;
	bh=gjyBaCmVAW4bd0Kjs/sYJZq05Fc/PXGKnvdXOGrnBbw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=im/gjZIGfc/GkI38oUic4nAtPQdRyIzgEF0wVEv1prj0ro6UFhhNS/NG33RVKr3vI
	 ducDN64qfApgy8BHU1wuzgBhGGwVFCOQ+Zd3s9+6/FqiMBS1UKxBH5YhBmB6HEgNIy
	 +UqADAWYnyyCGuvyElbIEFRvPONPn6b4GOnQRP3X2hsJoMZzNco9SB0Hj/Hb/SAtYo
	 BXe29paL6h/I9mOguvBV9jrXQGeoP49VvmYKz+tgGam1bANpUcOVTC2+4374iL/PXX
	 504MJN2e8PIn3HzW8TvKQAHnDwfnez6vl0MGaJju3GdPhfHw/zWLO2Mqk3GfTYMAXA
	 fxUgynv/pattw==
Message-ID: <d03702d5-be53-45b2-8560-6441d9019d64@kernel.org>
Date: Tue, 21 Jul 2026 08:52:42 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/20] zonefs: convert iomap ops to ->iomap_next()
To: Joanne Koong <joannelkoong@gmail.com>,
 Christian Brauner <brauner@kernel.org>, hch@lst.de,
 "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: changfengnan@bytedance.com, kbusch@kernel.org,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Jonathan Corbet <corbet@lwn.net>, David Sterba <dsterba@suse.com>,
 Dan Williams <djbw@kernel.org>, Gao Xiang <xiang@kernel.org>,
 Namjae Jeon <linkinjeon@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 Hyunchul Lee <hyc.lee@gmail.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Carlos Maiolino <cem@kernel.org>
References: <20260720210202.1163861-1-joannelkoong@gmail.com>
 <20260720210202.1163861-11-joannelkoong@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260720210202.1163861-11-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/26 06:01, Joanne Koong wrote:
> Convert zonefs iomap_ops to the new ->iomap_next() callback. Each
> callback is generated with the DEFINE_IOMAP_ITER_NEXT() macro, which
> wraps the iomap_iter_next() helper to finish the previous mapping if
> needed and produce the next one. No functional changes are intended.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
