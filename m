Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356CA3E3DA7;
	Tue, 31 Mar 2026 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969861; cv=none; b=Q24GfUM8vgO+wO8L5XqYS2mSPvp7XXUQKt14KqMnsnRvDe6qzVVODql40jGQQ4FvgiJuFom9Sq+OHroTOK2H8r31E2uPBWE55jAZ1bDmE5W4xu5B0u4cdsRGU24NOJ0/O9DiaJSnm6s0COaA/uDzBx6QB4fJVJRSbJRVtuLxqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969861; c=relaxed/simple;
	bh=PQk7auhe2XPRZb6j3X1id1bcHKC4AzaRE0LBUjrAuqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW2OupElx/9MFBIKHk/mNNGEWSOcYh3RdDnqEHSh3PVkyUQiDZ4C0CeM+H36G3FPTrTwYf1NuchvaIfRZGIQmLjuEZqbpChKKmbwxFtFpdH4JbNJWhJ8ynCPR5c1bADtptW6ShEG8B80PS7l1Ya7ZNbGfPmG2+/LxpUGK7jG17Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zG2o8T4I; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zG2o8T4I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PQk7auhe2XPRZb6j3X1id1bcHKC4AzaRE0LBUjrAuqg=; b=zG2o8T4IiyAzpg3DMOvrZXnBFK
	o8n80BbfGSrfyygkutxsDa7BrEvis+qquQSQqwY0NYAby0fDbGaUcy5Ko62V5VV3ou9NC0aDfbOJN
	uccRRmQ5r06NaBgXEsi7ZAsH5ORkFUjWneyJqKkW9M5rhpmMRnyr1Dyug8yB0r2iEfqssrwNyfTra
	bKI7XYu2WLVkCm4zG7WITyWCQf6BRqLBM/6WA8FsZYEmzMboqkbKWYmA3NdbjAdV9k4dSd3NZmNGU
	MvNdHSDDqEi8/ffZM9thH7f/evVocIaugD8nOpWC/J1S82mAHrBwHXkirfm9Y9lxfqQ5YwD/Zl7NK
	z+JimOAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7ak6-0000000D9Od-1cwO;
	Tue, 31 Mar 2026 15:10:58 +0000
Date: Tue, 31 Mar 2026 08:10:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com,
	axboe@kernel.dk
Subject: Re: [PATCH] splice: prevent deadlock when splicing a file to itself
Message-ID: <acvkAuq4_cWmegC7@infradead.org>
References: <20260320130615.1109449-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320130615.1109449-1-kartikey406@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Mar 20, 2026 at 06:36:15PM +0530, Deepanshu Kartikey wrote:
> Fix this by checking if the input and output files share the
> same inode before proceeding, returning -EINVAL if they do.
> This mirrors the existing check in do_splice() for the
> pipe-to-pipe case where ipipe == opipe.

While restricting splice to be between difference inodes sounds like a
nice simplification, I'm not sure we can add it 20 years after the
syscall was added.

