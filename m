Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710072;
	b=Dz1advSgxgs25zF95ngGtcMMLQODPlv0mNocJPIyjqQ3o4Ljyc9OJ6Aa7Tgs4yh57gLm
	 x4ob1Q4re32sF0hGmnyZlMfwXKkVvOw9anHBUPtZocB0mwcj+8mjXrcUhYNJMhDmE8YME
	 LpcKfzIzKbHsIcSJGNhn783dxCZoSt2fk8XUd3AyGGNa5pc3Nb09aCpeE9RekK7Sf0kZu
	 VgW7e2Y1g07gpjmEXdofMPQ1p/ITKvGO06zdgirJ+9304ATdADq46yNOjFVV3so6BDpPV
	 jYD+OUAbWfDn1Vk3Ai+zen5AuSJm8kd/E9L20hNNsQR5LOli7ds/lDczDMdsmVwPXZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710072;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=Emo6dutnPoXO5HzXksO9O88pxMM2MYBZc0g3SIXyBsM=;
	b=EdXRPoZbGvOINU66milTE4jMxQOCbfWGlGniG6juEDPMo7NzkJCKqlQAZWEZzrnF/zWT
	 4Xe/iXu32nzb1veMiFLDnGery1RLG4yOzwE0mYlxq2rmwA/BMxWGdbeSlatlaefjWVT+2
	 Kb33Hbam5T7Rls92Tnz9Uw6R9RfL6dIuS4q2BHqOX8j6H+/mb8ldcPjgMQqqN4NZ8i3IJ
	 L6wm7JhKTBBJH3UsJcGwzD1d8I6H+2TRw3pSsKBN409V7YjjTbhF9hMiZK9LNp09F0Cvm
	 WqA8cKccu0xPQYaF20R8hWDpgMVpFHP6c/CycVdn10grrPAOxH8e8iAvJJP+Bo/DwfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F83606A327;
	Tue,  3 Nov 2026 12:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02F83606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1176668BEB; Tue,  3 Nov 2026 13:47:47 +0100 (CET)
Date: Tue, 3 Nov 2026 13:47:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] statx: don't leak STATX_ATTR_CHANGE_MONOTONIC in
 stx_attributes_mask
Message-ID: <20261103124746.GA10039@lst.de>
References: <20261103-statx-v2-1-8b09aa8118ab@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-statx-v2-1-8b09aa8118ab@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 03, 2026 at 07:04:00AM -0500, Jeff Layton wrote:
> STATX_ATTR_CHANGE_MONOTONIC is kernel-internal. cp_statx() strips it
> from stx_attributes but copies attributes_mask verbatim, so it leaks to
> userland on filesystems that advertise it (nfs, ceph), e.g.
> stx_attributes_mask = 0x8000000000303000 on NFS.
> 
> Add a new mask constant and apply it to both fields.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
