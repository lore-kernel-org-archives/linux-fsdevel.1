Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88061A5B9D
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382994; cv=none; b=nx8O5Yze7fPHOOy/+6V99LnvAodrvz2gYNSfb/riBwPG3tkCbKvReibtFMdUot0AZpzRPWH3/dh0eUUO4VK84P7+DSPh6q0cxnTKGbgl99iwSx9cGEFgshggEWthmdmenxam7LFjbW/h/jk00XSDDS5GwKRY+sAcsybYOdxL7TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382994; c=relaxed/simple;
	bh=PAHpgbRJDUp7zcwCq5Fa93MFKj+yo+jHrJ566KxtLsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwluav6TceRWuH9VCnHVv/wqpW6eJmoiGOYBhqBpp2PKuqtLUoGLH/PW2/q4Xc1812V111LkvzsNCMWyZ/p80BDfqk1+ZHVxVk2FVeaauWqLMhPtTgQYUBaQfwPVvzVVso/Ypk77h7Ny3ZMzRj2pRhGcS1UVHM3afUMFTdrZhPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OIGTd+m7; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OIGTd+m7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ePH6yyHel43J0hxGd4Aukij0+SO0nbPeTrjb6wsV6ek=; b=OIGTd+m7zSE42/Wv41F1OSk+TH
	w1qNXshgk/IEtG708QlbM9/rtGgD6MVVpxNzkXwgjcVQUwIAaphaXJICxGV5qNRa9TL5EAbe5JPGw
	JHgZEO6i1iILyYnvfGlqLRUHHGyn3YYvFeiSiBbu+Ef0sk34+rbp8iBBqwTGPZmmasZJBnJcc1yZE
	QXduWffBv0ioQ1QxYxDYu31swNGZH26wTG0vvLwiI/zqsWKjBQV1IsWfft9CqmxkH9EQm0YlEsRTf
	3LXLXMoUjCLhrVxps4qaXn0TgRg/iHIL2QSSZFQ6pHA1gSVSv48UDxnbbtTWaqBCeyh2G6DdVDF44
	HdgtQRjw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wQ6ne-0041zC-1G;
	Thu, 21 May 2026 17:03:10 +0000
Date: Thu, 21 May 2026 10:03:06 -0700
From: Breno Leitao <leitao@debian.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 03/14] configfs_detach_prep(): pass configfs_dirent
 instead of dentry
Message-ID: <ag86wYeX6ld0aXSz@gmail.com>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-4-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519070633.2025485-4-viro@zeniv.linux.org.uk>
X-Debian-User: leitao

On Tue, May 19, 2026 at 08:06:22AM +0100, Al Viro wrote:
> The only thing it uses the argument for is its ->d_fsdata and
> all callers have that already available.
> 
> Note that in the recursive call we are dealing with a (sub)directory
> configfs_dirent, and for those ->s_dentry->d_fsdata points back
> to configfs_dirent itself.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Breno Leitao <leitao@debian.org>
