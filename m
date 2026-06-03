Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2336B4028EA
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473223; cv=none; b=XyHZwW00GqzQLzMvyaxGyUnXyz/FTD7J/Cjf0/In61fLxoEB2BpXhKGy3Ygrh6MRSvZ7OVi3zj1NQN7CD9vHgwCg/8niXKE5e+YFiNRJ0LCT9jn4M9xy4roZTUMIgS6Tm2Ky3tFjcAlOawk6ld0bBESaNNnrp5ALKtxpAKk1Ofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473223; c=relaxed/simple;
	bh=FzOK8my63pUx5tS4FQ1pmfWbIXKIl9rfXhwwR0KL7pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7AjEo/MH0PEXXnPwpCW9k+6W4Rdeo8weCSAt7uC0pgykYi2TtEIAsYG0Os3r1jQkKRpV41UtFNfzIfzeQQW4vFznbejZYRbEhlE1ZIo60r1yxu7ctNhr54d8GfZh4R3bmIDIRYdXixEdVfCt6n1gqCx4heQABHGLXD7KbbY0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZgCb/Hdu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZgCb/Hdu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SDxCFH4OnDGwpV3iGNKPa9vfUunP28N0abAXNWzKcqo=; b=ZgCb/Hdu19jGZ/DEy/YZaRr0Nf
	WjmC6HrIhiK9AMAgU/QNSNipnOfvB0daFqa8XDt8KjvQlblPKmMqUUsQY+yAdw652phWQmPtK8dL5
	dZ+H3gx0P4DUZVvDVEYTb/b7/w1FRSnOeQmao8psEWCQ00hUCufrHmfEtw8iMbv0aDOLHvY7AZkTs
	IbnlYWJa2+WfiDeufPWM7fep6EsQfxil+CkzHP+fMbiPLaYpL1A3XgkGA/IzEghivyHYOZ2CWq40U
	eHUUS33aTnlj/jCQtN+fQRpfkHSoHN+zGE8OB/nVdJkvWfvoIIyYWyCiP58rVRGO8uyzF5JwHoO13
	GS3NCnoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgQ0-0000000Ckcr-161B;
	Wed, 03 Jun 2026 07:53:40 +0000
Date: Wed, 3 Jun 2026 08:53:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 1/3] get rid of impossible checks in
 detach_attrs()/configfs_detach_item()
Message-ID: <20260603075340.GU2636677@ZenIV>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603074815.3033766-3-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

	Argh...  Please disregard the 1--3/3 part of the thread -
I've missed the stale (and really ancient - it is from back in
2019) files sitting around.  Sorry, should've checked what the glob
had expanded to... ;-/
