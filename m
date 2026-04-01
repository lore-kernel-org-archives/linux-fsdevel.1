Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18F3346766
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076627; cv=none; b=j37ZHJ99uczomoybdMmicCP0OFF+77myk1UzGiXwVqvorB8Rv6IjYr6x3ScI7Q9dG02nYD+UL6xFazVDhLP48t1VSmgZdrcSceNtHthrPOULoBOXZ4OFTXmUkhPE6A1VqdvwyECtveGq6jxiZbQATxXrueV+WZchBNWArR8tnsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076627; c=relaxed/simple;
	bh=UxYX2hMtqcuAWB5RlFy6fDwCyO5Sq8mv97Ebeml/t9s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=isgM+qyGXIs+Y1FJAGUSNJN/Eq/+8QI4b78qTloSufjLqtKXHaLH4/8YMZ6soSevWas1oFUC0y1f/ZXcCzXT9SeQtFsXkrNZ5K2DpLHgDpT5lbetTcnJjg7f/VSUxLvDwW3KE42VMM3NH4BkSGXl0lOkGbCCO7gF5dll+KuJkng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=JA3R6vzZ; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="JA3R6vzZ"
X-KPN-MessageId: 3f509360-2e0c-11f1-8ff1-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3f509360-2e0c-11f1-8ff1-005056999439;
	Wed, 01 Apr 2026 22:49:16 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 3f4a0ff1-2e0c-11f1-b5d0-0050569981f5;
	Wed, 01 Apr 2026 22:49:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=f3ki8xj5EkThUxzdXA2NV9BxrUJB2o3KdN4Rk7USO3k=;
	b=JA3R6vzZlzCiLjDMl9hv54rjCHogZS1NlFQ0irJLzE7N8vxSgPBfVbFppC4DUpENsJEHYa16xGWjd
	 sjsb6FmM8OzQyrzPUsHBjFpIFxr0QvtKHR/Wxup3x2CxEzQRDCQowkkDCCafqXvrzOhKOfc+7UFW3Y
	 tpRBFAe2y94bCFyWzim7aTPvSq56a40aOGTlqZKtN5EWs1KbbrKrnCx0TFExKRwUb9R60M8nL5BkuW
	 75sliE6pYRO0FBjodR1sd5kGcHOIl+09qMm6l4C92nfYf8M1btWUqkcIOazBaCJ9M34pAqJsgHdHrQ
	 07rYPoMamivu/M52wRp14yhW67pgEWg==
X-KPN-MID: 33|WgdNH6WpjibWQiD0q7BqUXta8PRdpD2JG0HSLm2HgGIJHA90ifK280e8S6j0q2I
 NvgYcRz19Y/KQq2Y2Dn2imC1b5n6vY6h7hrV1lkAT52Q=
X-CMASSUN: 33|HXMSAvOeAupMVeHNJfZFsHo+8VkLF9TMmk3oWYffGEvEvklGmdWB7xOWbn3uzas
 UYIJJ2QmHmnXiBLNvDIF49w==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 3f3f2824-2e0c-11f1-94b1-00505699eff2;
	Wed, 01 Apr 2026 22:49:16 +0200 (CEST)
Date: Wed, 1 Apr 2026 22:49:16 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>,
	Penglei Jiang <superman.xpt@gmail.com>, Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Message-ID: <1674899546.858116.1775076556076@kpc.webmail.kpnmail.nl>
In-Reply-To: <2026-04-01-distant-broke-bonnet-catacomb-cnRW5o@cyphar.com>
References: <20260326182033.1809567-1-jkoolstra@xs4all.nl>
 <20260326182033.1809567-2-jkoolstra@xs4all.nl>
 <ecc86514cde4732995d9f50b9f5071fbb1f675e4.camel@kernel.org>
 <2026-04-01-distant-broke-bonnet-catacomb-cnRW5o@cyphar.com>
Subject: Re: [RFC PATCH v2 1/3] vfs: add support for empty path to
 openat2(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 01-04-2026 14:23 CEST schreef Aleksa Sarai <cyphar@cyphar.com>:
> 
>  
> On 2026-03-30, Jeff Layton <jlayton@kernel.org> wrote:
> > Looks sane to me. Can this be merged apart from the rest of the series?
> > It doesn't seem like the transitive stuff is dependent on this.
> 
> My only comment is that I would like this to be usable in open() as it
> is one of the very few cases of an O_* flag that is actually backwards
> compatible with all of the brokenness of open() and the systemd folks
> would probably want to use it (they can't use openat2() yet).

OK. I'll just wait a bit on what Christian has to say about adding it to
openat(), since he initially rejected that, before I write up the new patch.

> 
> -- 
> Aleksa Sarai
> https://www.cyphar.com/

Thanks,
Jori.
