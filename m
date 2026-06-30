Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D825B0AD;
	Tue, 30 Jun 2026 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844626; cv=none; b=MJ2Nltk9+74u7YV2YfBGHnSt46FFHBZkDBpXJ3QXgDEJ2z6aQf1U1ImxLIxpnYzv7w7+raeSw9q4oi4Um6sdkKkQ77ALbbn1dXBY0Ooox0I39mx0E9DaoR6UBzNhGGSnrhfcsGsLdcc+Sw7GNyzVWuKuT7llVE61DxYMr3SY+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844626; c=relaxed/simple;
	bh=zctrbBcEPpgI+rulkIwrxbKJX1dl4sKytOWcJ44TWOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+M2mS4ZhEA7uWiiiEfjQkuBC7sS0U2Xfng3Vs6UCJQ74x6WYcRVmWIkSblAH9HciCqbnrt5XKu62BsFcPWT7REN4PhmjiQk0gHvr+Mm059J7AIoXPLE7E4EDFXeYwWx+X8xSW/lh6gE6rBYTPB05PITPE6u922M8u+7BEJmkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aN2oOJXH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aN2oOJXH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sxmahw67jvFH8EYoUlnhdZ6NYwIof1KgSy2fQ7/QPiI=; b=aN2oOJXHM1LRftU+o0io32YJhc
	AY/Cy7EQ4WqzgXhobdNspDCNb/4gwDOC9rCIGwzU6DBRUwXI4HmS8ceFSKI/GtX09aLaF4l4InTWi
	m65uufH7LUVdI17APyKm0uyk8NuSlGTJW78mMS1O1vRNRw20eXupIWK1ND14r4JIBI5HjQ+RZWyMl
	xe0wtmmbMTk5ldPHEHc3r5V78LWKCXjP3Q/IKTQP1pG9SzpogXg4DRaADlRxJE/0rXPVJalJTs146
	t7snZRZvZyHJttMttdNVdMtkbpQU67drR3gsDZw8/X58VrSte8T5m/G4WUUenjvkGrGjF6DQmXZvK
	q2Ibxtfw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wedKN-00000005Nc2-1soS;
	Tue, 30 Jun 2026 18:36:59 +0000
Date: Tue, 30 Jun 2026 19:36:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gregg Leventhal <gleventhal@janestreet.com>
Cc: "To: Alexander Viro" <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Cc: Jan Kara" <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Hagberg <ehagberg@janestreet.com>
Subject: Re: Subject: [BUG/RFC] write-open file THP cache purge can discard
 dirty page cache
Message-ID: <akQMy54dxVTVkMJ6@casper.infradead.org>
References: <CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com>

On Tue, Jun 30, 2026 at 01:01:53PM -0400, Gregg Leventhal wrote:
> On an affected 6.12 kernel with CONFIG_READ_ONLY_THP_FOR_FS=y, a file can
> contain read-only file THPs installed by khugepaged / MADV_COLLAPSE. When that
> same file is later opened for write, do_dentry_open() notices
> filemap_nr_thps() and drops the page cache:
[...]
> 
> This is unsafe if the mapping also contains dirty folios.

But there shouldn't be any.  It should not be possible to have
dirty folios and THPs in the same file unless the filesystem
supports large folios natively.

If the file is open for writing, the attempt to create THPs should fail.

