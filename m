Received: from melduny.fyrkat.no (melduny.fyrkat.no [217.144.76.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10216F288;
	Fri, 24 Apr 2026 06:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.76.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013167; cv=none; b=KLt2W7jfJp3ZBM5IuwbgltDpuZZilXqAtFR8Wb541w31X86XdYsdF1YHiSb+ZkNJkym9g86cbdN33fPLPKiTYwTJyKjgGXONVN67zHLGFpc6zbku1pHLussWP0I+97fNF5PizlwQCTHLmqxVpyznO3g/4dvSv2Pju3Z2XvCnyes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013167; c=relaxed/simple;
	bh=aAsQrsI8WmUNYzvfNEcf4Z3Ho2f+7TgGzDdBJJPdwAU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qS7J1K1CejCzxmWIIzBxFL9/vqG87XdUnKtaZtdbEXkFYDdo6A3SpPzY3e/hEtbYqQa5XByk+RWM/dXlbhrjtB0vIf/00UDmCpbUKrA1+HGiw3sN0vP7E3/L/AHhUVJt/nCbkzCE8Gno8Mf6ysd7mu3SHCjvrQTWQYNNE5UTtr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kolla.no; spf=pass smtp.mailfrom=kolla.no; arc=none smtp.client-ip=217.144.76.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kolla.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolla.no
Received: by melduny.fyrkat.no (Postfix) with ESMTPSA id 06A0A17119;
	Fri, 24 Apr 2026 06:38:56 +0000 (UTC)
Date: Fri, 24 Apr 2026 08:38:56 +0200 (CEST)
From: =?UTF-8?Q?Kolbj=C3=B8rn_Barmen?= <linux-m68k@kolla.no>
To: Theodore Tso <tytso@mit.edu>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Jeff Layton <jlayton@kernel.org>, lsf-pc@lists.linux-foundation.org, 
    linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
    Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
    Al Viro <viro@zeniv.linux.org.uk>, linux-m68k <linux-m68k@vger.kernel.org>, 
    linux-sh <linux-sh@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Should we make inode->i_ino a u64?
In-Reply-To: <20260415144722.GB74178@macsyma-wired.lan>
Message-ID: <f48c40f6-ae26-d16b-5332-554042cd85fa@kolla.no>
References: <08f8444c7237566ffb4ba8c9eb0ab4b4a5f14440.camel@kernel.org> <1b340c4e635dcab3bed8c52d6381b4c341c0741a.camel@physik.fu-berlin.de> <20260415144722.GB74178@macsyma-wired.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 Apr 2026, Theodore Tso wrote:

> Like Debian, the Linux kernel development community is very much a
> do-ocracy --- only more so.  If the 32-bit community really cares about
> Linux support, they need to be providing volunteer labor to kernel
> development, instead of demanding that everyone else pay the overhead
> tax of supporting 32-bit platforms which are rapidly disappearing.

This tells me that it is time for "the 32-bit community" (wtf) to either
look elsewhere, or start thinking of forking the Linux kernel perhaps
sooner rather than later, so we don't bother "the 64-bit community" so
much.

> I will note that Debian itself has made the decision to stop supporting
> the Debian Installer for i386 and the 32-bit armel platform in Debian Trixie.

Which is why (for example) Raspberry Pi is maintaining their own Raspberry Pi OS,
as they have 32-bit systems that aren't EOL for another 3-4 years.

-- kolla
