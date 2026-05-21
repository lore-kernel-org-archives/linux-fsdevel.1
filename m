Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC9A383993
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382497; cv=none; b=Ho/FE16PPAoZVl87ehjx3EtFbJvc1KG+o2nUcdiqQHipm1QatqJkk+c70zxNrdO5ZQhEWgSbEC8Uu23tEBjX7Evf2fKNuFNtDAS828ppn1FL8SNmkggMw3SUTt50SBPb3N/gyZRgF8wH1c6KMv1Yopgi7hWsg+zSkm/J7A4iayM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382497; c=relaxed/simple;
	bh=rz/px5jdIbWs7i0tcMN7kuFmU7Ua6Yh25Ron6eiOY4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEbMOU4isQeNeRRqYmxyaSV3xZP9U48JlsKwQ9TXNrUVqNhqbaNnmDyXL45t2HRSac41YKNV5ewcqUT0qpDX2/rFfA1F2Kw7npOiRlPGmhbUH/3p7DJF5TlfQfIXL0qBNfpC/XfRG8uA4N4pEmOBZIT9Ui0UTDTaJdLdsXfwyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=easiKOen; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="easiKOen"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GRN9HegqQ0H2ZMcSE8W4Vn1hFvMlfMUXOZYtF2m3qig=; b=easiKOenFsJvfDzMGBX5fFPpZC
	XcPcc7Yn3FSC6kgWMtfVxVbKsrJvnRoMIYuQxFPWOgeNpvO0zoqu09IGJgltvNR5bpEmTb/j7okNM
	O1ZGw0lZae7HZBDZRWn3uWN9FbYnmxLqBe8ueZBIxHP9oCAZWPKrSSl43DeXCpcRbwh2szZEnrEEV
	7nmpUmTsP2kG2kH+/ACXbYQUe4J2r3KtEVHbkqPMqLK8TNkmHFTcs7crQHewmfQLx9e+Xa425tys6
	mRD1wOg8Sm6U6pvX8KFQAjcvF8p7ArcI8ZM4RdX+3fOViRQ/GrwyqHUPOJQtnbV+QYsQhZxP3T66o
	IcnS1v0A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wQ6fd-0041nJ-0c;
	Thu, 21 May 2026 16:54:53 +0000
Date: Thu, 21 May 2026 09:54:48 -0700
From: Breno Leitao <leitao@debian.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 02/14] configfs_mkdir(): use
 take_dentry_name_snapshot()
Message-ID: <ag84zaFsFnBgbJYq@gmail.com>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519070633.2025485-3-viro@zeniv.linux.org.uk>
X-Debian-User: leitao

On Tue, May 19, 2026 at 08:06:21AM +0100, Al Viro wrote:
> Note that neither ->make_group() nor ->make_item() are allowed to modify
> the string passed to them - the argument is const char *.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Breno Leitao <leitao@debian.org>
