Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410459;
	b=yOjpqOQgGpqUP4yW45ZzLoOpqOc3lvcouIpxi/8Z9qyR6xP+f52RTFE/tqYuaybCYjkW
	 3JnUlxKaN+Gaaiu1EApAy/kGlZiDD4hprCBlifCEfSVkxZ9t6kU9cXS/mFZL7Obc+SBsz
	 nOoyyvL/5DO5sbgFOMsyUphWwG+tfZRRSZNFjPTXtkXZpmDkYaAcOlHDWH49t31jRegI2
	 jJyp3aea1I6jGdD+oM1Ga6JD6kuiy/Yp1PHoysxc6AJDVpZ7uOS0FyPwe021DQXeuPAsQ
	 fESssa8vMqIwngN5hw81qFM69uPdGHoL9HE1va+qtMEJkDA5GcRULRB5G9C0tWpcBTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410459;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=xeomFtF5ULTOX/cEQEkULokKBWG88XrO+zu5llmaN/Y=;
	b=N2eXRQ3bE70yMNH3O8lhWqm6xSt59b0+vNMgokKAgzo5WaEStEhdN3PNR7TI1Y+55ZS3
	 /pFd/XX5j9vyZuZUfYsUlE1pDbINxL+Z19VHG20H2/F95d/ushgQ9KpNARkEs/uPynjOZ
	 dNlM6A19pH2NxrSPFnv6p5xAooQcgmRzNfhnr0KpRYPiuaL+DvGGWcp/mHhHV+qck04zi
	 GKXQM/TkS8AvguPfcAoyMYNyjKg20RSbkhl+X/mrpaLY431+el6zGtyGg85DI1W9PUsqv
	 q1S7vWXe/p8c8LOzuIvjIAGny9yTIBX0jNYDbA50kd+F3ftPXNuQqw51vHDQF7M8hGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94669606A32A;
	Wed, 11 Nov 2026 15:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94669606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ACBF668D17; Wed, 11 Nov 2026 16:20:54 +0100 (CET)
Date: Wed, 11 Nov 2026 16:20:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH] fs: constify inode argument of inode_state_read_once()
Message-ID: <20261111152054.GA12397@lst.de>
References: <20261111100148.3665035-2-aalbersh@kernel.org>
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
In-Reply-To: <20261111100148.3665035-2-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 11, 2026 at 11:01:49AM +0100, Andrey Albershteyn wrote:
> Constify inode parameter so that callers can pass const inode. Callers
> do not need a change.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> Notes:
>     I will have a user with const inode in fsverity
>     https://lore.kernel.org/fsverity/20261105115532.613467-3-aalbersh@kernel.org/

You probably want to include this patch in that series to reduce
the amount of dependency tracking you have to do..

