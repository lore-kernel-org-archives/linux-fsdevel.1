Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E24A3491E1;
	Tue, 26 May 2026 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835800; cv=none; b=msg1mSoaWNOJHK6tMHaEQu/YuslYEVAXujD2mh22ccNWdCN6YBfO/dR7JOmjLgR+8AgVrLxJcNXAUZksOCMDXi+vU5qmMpoPPIk3utj1p36YOmJBGVuSvJH2GXTri9lQ3ecZYUE+t/HzkXdvI2s0YPzhKmuLLswPcslGBz1J1Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835800; c=relaxed/simple;
	bh=u58TAyKXul1Z1AqDDNXyVD70dRYi2rJAt7lbS7LgS3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF+6e63GmfX5Xfr5QW+Mern3Ql1IYQluSanbzjVrm2Gg5NB07N7Drt5DoOlkS4SYY+OIZJB7D6+TlBYyxSFGW7DE/dCVWIdSeIEeh/0emNkURwaGgaqrOSV1i7PMjg/dL90tmYH9E/bZEoLn7sPdx8EJRKCvxeul2ja2pxH7XiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DyH5H4ws; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DyH5H4ws"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T42tMMEBHPz5B5+gOs1wili2j5ztH7o7xoP78wB5Tlg=; b=DyH5H4wsLU4GRUSNjVc807OFEo
	Eh0uzBbxFoLjU3w912D9H68ZjEK86xKHbhwvlU2X8oFBU0nbF04MaDWf5ec6LQsM2140WrWh6zK4z
	HU84yc11l9G3p+phYjzqhP5AttVX65c6Di+bm9K+Yg563AfVxVxwMeLjPWS6vaDXAHuaAAUvoa12V
	O2eQzM+PDZFqv3+sP5Zj4o72GJMi9F1CCc5KpfecOTOZzw666gqVHn5wIaKMwwBUenPlERTREiLq2
	f9qAUib8AUka64xSZjZpmEHdbYmqzJueaLgFgw+DZvOUUqvOJdL/lMs8gi7tUEBDGfUpb4mxwLf3B
	n/VWypXQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wS0ay-00000008upN-1PV9;
	Tue, 26 May 2026 22:49:56 +0000
Date: Tue, 26 May 2026 23:49:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] ufs: UBSAN shift-out-of-bounds in ufs_fill_super() at
 fs/ufs/super.c:1181
Message-ID: <20260526224956.GF2636677@ZenIV>
References: <CA+0ovCg9e3_2jyM7x67A2rp8E=BR2gLX1FBZHyXdctFAhcG+qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+0ovCg9e3_2jyM7x67A2rp8E=BR2gLX1FBZHyXdctFAhcG+qg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 26, 2026 at 02:47:30PM -0700, Farhad Alemi wrote:
> Hello Al and the linux-fsdevel team,
> 
> I am reporting a UFS crash found by syzkaller. fs/ufs has no named
> M: entry in MAINTAINERS, so I'm routing by commit-history affinity.

Same comment as for your previous report, really.  I'll resurrect
an old patch adding sanity checks to ufs_fill_super() (rejecting the
same things BSD does), will Cc you when it's posted.  Might be a week
or so, though - plenty of shit on my platter at the moment.
