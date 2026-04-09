Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2160D2D0C97
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 02:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703177; cv=none; b=Kd9tHtSTSna5qMhw62+rNtnXPAMxYa6B5/WM+eSowY/ge5ORwLD9xtONO6w5+UmtgOlrrjAVD8s+QywMffwmx1G+6QNBgjDrXpJJBNrArFfqnZRwkdaX5U0QbIvwOOEjgghEDk6Pj7r+lX3T3/JNe0fQDndO/XoCLOBE/gx9ac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703177; c=relaxed/simple;
	bh=4QjqaFHIg/Dy6Jc2O+lz+QefipsXiEqtsyKueInTJ/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8gvdF364XmPz9SnJ8NIpMaCpP3CWk0v4MiPwjWInhYSkziT/XNK0Bk4iKsiT7VOt6l9EQ1rFVMOCZTk0U/MR5kM323DqaW6Z7k9upU/EkrMRLafYJsiSu+eTl4BA5RbPLCDiMJhU7I3cUEUhkI2p8YwqgOoMWuN5GvtJNTENXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GRkLTg2Y; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GRkLTg2Y"
Received: from macsyma.thunk.org (pool-173-48-116-90.bstnma.fios.verizon.net [173.48.116.90])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6392qZDs017818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Apr 2026 22:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1775703158; bh=pRitemWm7oStHMtE/NSYcFZebUdUwyyWgpbueyh1kbc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=GRkLTg2YZM1nkobsvKOOd4bs+yNeo2+bnwcQxFOxx+RpkJ5i22in1Mbkx8Vek3kB+
	 4wwe+Sb+c3P7P88+AXXXvkT8n3YNoNnKWUDP88SxeqjimV1yDkcktAbT/XeqXnJcgt
	 O/97o+7a6ugGW3pNwTbuLB3P/U6rVVTWMbvpsNgbANQeQh0VDTj+rsvUgrsUpJIJV2
	 dVoZS0IzySHkZlJxKHqZ26C3Qpje3zWbpyKmW/m+Mt7e+KaQnOk5UkEDQ694IXqvFd
	 5ra2zqdUG2c+CEb+prE4I/lw+vfJNIRjgsruvX4DMz0ErApXs2pzgHAzgoGlHm9QVC
	 mRspiQafk+x5w==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 9B01162570A1; Wed,  8 Apr 2026 22:51:35 -0400 (EDT)
Date: Wed, 8 Apr 2026 22:51:35 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: Ye Bin <yebin@huaweicloud.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] show orphan file inode detail info
Message-ID: <20260409025135.GB99725@macsyma-wired.lan>
References: <20260403082507.1882703-1-yebin@huaweicloud.com>
 <n4sccudy5avcgnkdhc27rzofzoprxqtwhfrlmsh3yyrj6vbc6d@mmu73gmtawkq>
 <20260407202845.GA38246@macsyma-wired.lan>
 <fdil2jz7kizzrlew7airdlpvnz7qyzigigaw3huktm66455wuh@yyqhacmxe4qk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdil2jz7kizzrlew7airdlpvnz7qyzigigaw3huktm66455wuh@yyqhacmxe4qk>

On Wed, Apr 08, 2026 at 03:36:10PM +0200, Jan Kara wrote:
> > And inodes on the orphan inode list have been unlinked, so we don't want
> > to allow people to be able to open them.
> 
> Why? You can reopen unlinked files using magic links in proc or file
> handles just fine today (just tested this if I'm not missing anything in
> the code). Only once the inode is really deleted you cannot open using the
> handle anymore.

You're right.  I don't know why I thought that would fail, but it does
indeed work.  I think I was thinking of linkat(2) with AT_EMPTY_FLAG.

So yeah, your suggestion of a synthetic fd that returns a list of file
handles sounds good to me.

					- Ted
