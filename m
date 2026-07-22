Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC83938F94C
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784722027; cv=none; b=qSp6NJMCY9OXmfMbjwvuaRvOmBUQ/Hxilud/OQC07WpX7eumZGG95AWrCfQ/RMwfjziQh//De8rtR3SBwQyS3Y3yQjN2AIspNHSmi/bXRGZEdi6BUsb4Qcve8MzsgfzSeti9dyiMMm7vhD6kTiFm0GDaN+LcxlChZCSb5LDkyi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784722027; c=relaxed/simple;
	bh=R46DEMWMQEaZZkLe+FVII/+UdM5otdQlMDoMnSV9mPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFLPI5PkvDkGdWuTE2JKsryNPugsoXJ3mpv5QFtpNVCIXykzng0UH8PTjsIQ5IK7pV4UlpeweNRpuH4mCk+UaDOTZHPCR8JOW3vevrTUHg/EykYnrgHzndA4uHilTw9i9CRn4bP9ji+LVscoFDzMLZxir41B2wid5po49fRxov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A83AE68D1F; Wed, 22 Jul 2026 14:06:59 +0200 (CEST)
Date: Wed, 22 Jul 2026 14:06:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, hch@lst.de,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, changfengnan@bytedance.com,
	kbusch@kernel.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>, Dan Williams <djbw@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 02/20] iomap: add ->iomap_next()
Message-ID: <20260722120659.GB11920@lst.de>
References: <20260720210202.1163861-1-joannelkoong@gmail.com> <20260720210202.1163861-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720210202.1163861-3-joannelkoong@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

As mentioned in the coverletter not a fan of the simple dio part
of this, but I'll post a version of my patch for that that slots
in before this.  For the core iomap bits:

Reviewed-by: Christoph Hellwig <hch@lst.de>

