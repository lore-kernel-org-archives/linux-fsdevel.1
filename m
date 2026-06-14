Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99F42475CB
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781476796; cv=none; b=PfG61sWr338lw3SOhbBeevG/DHKREJQcc0CBCC1Ptkue1jUjl6a7dQmXGblm4HjsCF50tZi9OPoyrlE9WunC/WvzzWlQgY1OLSBzmRKemDr8UAMsJjh3A5PJHoXESLEBPbH+jzfOm+BZkMHBnpQqkYJ02z5N89B8gldrDDQHeVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781476796; c=relaxed/simple;
	bh=LHAKYYM1xVijMsvSNDk87D/R+u3FiI+rN75wyczMNKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJ/6YGymxkrLOLB6DOxV/T64ow7FPibQeUCraw9TyVMUeo4VOzNlDBvd2TayFOF3R+w4BhlNK08MK2ZoCJafi/4dgb8IrzVKys24335wkqPFZ1T8PGHZcx9KApOPyM8NNAdc/miZW64IGOPt1mI+4s03q3b9yGyNLglpEmUMAtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fB66VUDQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fB66VUDQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n18/42iMIi2lFQO6seulz9lDjme5Fx7rj/+cBuAoiw4=; b=fB66VUDQ/srh3bF5pabUcgP5d4
	5w6JtxDmvY+NKxKtSP/n+173rVLKmmOqyrByw7q0CFhB1yN9jei+BS6qkDMzUjgMIVLse6XhcTrgW
	3P9GOVLCuC8v2T9fUCNytidivNJQXdBuT/Ekj7qJLu9VEkWQ+dfz3d1POnA+L2M+22n07Zw9Yp7zt
	3z7CLkvk1QV5DAZXWj2dMd6X92bgafaK4eoIh/B2tvv+jOyLIRqnziPLUfbtlb50mjaLYqihrSOua
	oigxT3eBJSK2ykgnK6GROBHKzbzpukqDdxGXiRBuPyVPXhKz1qIS4ayKYK5FJfV49ktpLdQq5QVEw
	cbxaYDxw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wYtUd-00000006fJY-2o57;
	Sun, 14 Jun 2026 22:39:52 +0000
Date: Sun, 14 Jun 2026 23:39:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] configfs cleanups and fixes
Message-ID: <20260614223951.GS2636677@ZenIV>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
 <20260614223625.GR2636677@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614223625.GR2636677@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Jun 14, 2026 at 11:36:25PM +0100, Al Viro wrote:
> The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:
> 
>   Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-configfs
> 
> for you to fetch changes up to 45a62661733904e09b55afd078c815aed6f159a6:

Arrrghh....  Wrong branch tagged.  My apologies - will tag the right one
and resend the right pull request in a few
