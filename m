Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C91346AFB
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264540; cv=none; b=UynO2AjPQkixQlZe68+buxLWczC4t44rlTDisq/yQZHjgyWH6llnPYIL+FnWL29W6BaFcFt4rSN2EV7thMdg3bqhYNKXDG79Yvru8QhvF93b/AIbmWWd3AXpSX75ONqLven2IMUYKYaE9r/H0jgmEQlwL2NU9NP0LpgghTaB8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264540; c=relaxed/simple;
	bh=TZ2rjMDvbYb0Wwm5w+OOA0I+5751rFJbPJIRxMLyqLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdCJooqFXeCNTxTmold+6dKA6i6HuyTBP39bXy/sspCxAKhX9VJuL4SGFm0kXmaOwAA9uILyUp1yA++JzxZEa9wGtarDpH4MzD5oXn2NAxIvjisFgfgML189mndV1oTjqEvmgiqWO3A1NsGGSNNWmwP+OXOOxRu9VzWzblPWALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=G2nVIilv; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="G2nVIilv"
Received: from macsyma.thunk.org (pool-173-48-114-3.bstnma.fios.verizon.net [173.48.114.3])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 63FEmNYA014717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 10:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1776264506; bh=nQ9glAGkVLTsHcEX6jYMIwYpN+dE9n1KzADOVYBlM3M=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=G2nVIilv8Iol8KbQOdellaDmC/Jej42z8Kb42pHV3smGimTOn3EB++isjiGYAOlRB
	 kTSF2Z7yTmmVIh3nV2wI+dyBrErhQjhcXljgpH32lnv4vislr9r3xRTqS72994AJ6/
	 fmhamq6xA91V1JfFtQgny4WRfaVfOlgPCj0DgpHQ2n51Qu1ALXNay4LtU7FnOQOLyf
	 YiiG77iyVi1RsPX+eYvkX2D+oUJ29wjg0n4SAuK5bgW1H93lFi8bksxsTDsPc61Z3l
	 EE3r2wznCBMZbye46qjc893WV+L9qUyS+nR7yot2CoQp8rFw3ETt3yG5DwMrnXlnh8
	 XIpfwLyELc+oA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id CCEBE631AF6B; Wed, 15 Apr 2026 10:47:22 -0400 (EDT)
Date: Wed, 15 Apr 2026 10:47:22 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Jeff Layton <jlayton@kernel.org>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        linux-sh <linux-sh@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Should we make inode->i_ino a u64?
Message-ID: <20260415144722.GB74178@macsyma-wired.lan>
References: <08f8444c7237566ffb4ba8c9eb0ab4b4a5f14440.camel@kernel.org>
 <1b340c4e635dcab3bed8c52d6381b4c341c0741a.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b340c4e635dcab3bed8c52d6381b4c341c0741a.camel@physik.fu-berlin.de>

On Wed, Apr 15, 2026 at 11:11:32AM +0200, John Paul Adrian Glaubitz wrote:
>
> So, this went just over Phoronix [1] and as someone who is still invested
> in 32-bit architectures, I'm only notified about the performance impact on
> these systems now as the pull request has already been sent to Linus.
> 
> I'm frustrated by this poor communication style. If your change
> affects certain users negatively, it should be openly communicated
> to them on the appropriate mailing lists so that they at least get
> to raise concerns. Disclosing these news to a limited set of mailing
> lists only is not okay.

Adrian,

I note that you are a Debian Maintainer.  Like Debian, the Linux
kernel development community is very much a do-ocracy --- only more
so.  If the 32-bit community really cares about Linux support, they
need to be providing volunteer labor to kernel development, instead of
demanding that everyone else pay the overhead tax of supporting 32-bit
platforms which are rapidly disappearing.  I will note that Debian
itself has made the decision to stop supporting the Debian Installer
for i386 and the 32-bit armel platform in Debian Trixie.

Best regards,

					- Ted
