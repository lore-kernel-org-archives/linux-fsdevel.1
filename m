Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021C224FA;
	Fri, 24 Apr 2026 03:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777000855; cv=none; b=EjIHWlCpXI9mKW2aNKnbfpmgGesfD9tphvjgPKw47lSrjwH02vvgosKOJ/V//a5nKFZ+zY6pbFIFu96sQrSdeaK+hdTH3KfvkSv07JFwwEpXBlQSqTXT6o36G/roj3SP15LL+azfj0un2lQVFAMc/EO6/hH3zeHx/LEb4yllK34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777000855; c=relaxed/simple;
	bh=HnbcZuJRm5gwp5waDh2UgtplEn2VXuo2oozw9jzfTd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8q9uwBrgY1GNjrdyuzpniia9ftxlMqm5zkH8hu3BYEcvHetHkUEk5KHqmw5aBOIjhzK8xu2qVHYwfDfVeg0JKIpHdEPjCXIPKay37f0vpq/orzp5RuvYMz78ZapJNRd7k9GoXck7lWAxH+0cMUJAnn0wuB9+F8rLGraFlVoVVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KgS2rpB5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KgS2rpB5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vF1AU0LXlnhIfmJBF/DVKC/jdqA8hAJ+qqGd+yTOFkg=; b=KgS2rpB5V/NgcXiZBzBut1nFMM
	VXy6TDHg2uPCUyKs50GnvU925GmHjYdme9k93ETpkPAcMi4yGAcHfoloHON5royLGcfk8+E08UqPw
	naQHxuP1Ae5cpfKVxnSmm3CrrlOmlG8Z5N2UpAfZUhfEQhojGoZ1YG4o9AYgbK/XNG1c7lR+QYFLS
	uZVbeirmfMjaa+0naIO+FQir+qgxIig2+vN0cuJ+zvrC9eX/Dm2LJuul3conDsK9cZNJW92dW6eV7
	C0LLBztiFOrzhZhwKq+Gv6w/0pBl7kmGRUdJhEs2thWxRXXuAoCXgq+y1/NEw8Tua6QB7h3wlsfUh
	e8zCrlEg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG75r-0000000EUjd-3o1v;
	Fri, 24 Apr 2026 03:20:40 +0000
Date: Fri, 24 Apr 2026 04:20:39 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yibin Liu <liuyibin@hygon.cn>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"mjguzik@gmail.com" <mjguzik@gmail.com>,
	Jianyong Wu <wujianyong@hygon.cn>, Huangsj <huangsj@hygon.cn>,
	Yuan Zhong <zhongyuan@hygon.cn>, "jack@suse.cz" <jack@suse.cz>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"alex.aring@gmail.com" <alex.aring@gmail.com>,
	"vbabka@kernel.org" <vbabka@kernel.org>,
	"jannh@google.com" <jannh@google.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRD?=
 =?utf-8?B?SF0gbW06IEFk?= =?utf-8?Q?d?= RWH_RMAP_EXCLUDE flag to exclude
 files from rmap sharing
Message-ID: <aerhh_tzSs5XapUz@casper.infradead.org>
References: <20260421020932.3212532-1-liuyibin@hygon.cn>
 <aeikm2e5Gh5reJ30@lucifer>
 <bc514883d6154420b3cfde4ab25a20c7@hygon.cn>
 <aejzSsiXZBK1emv7@lucifer>
 <a96c20b74b874248bc0cdc2b926a43fe@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a96c20b74b874248bc0cdc2b926a43fe@hygon.cn>

On Fri, Apr 24, 2026 at 01:08:35AM +0000, Yibin Liu wrote:
> On an Intel Emerald Rapids server (112 cores), run the execl benchmark from
> UnixBench with the command: ./Run -c 220 execl
> Then perf top shows:
> 
>   91.53%  [kernel]                    [k] osq_lock
>    0.50%  [kernel]                    [k] rwsem_spin_on_owner

OK, but does this represent a realistic workload?  It's pretty easy to
construct workloads that hammer on particular locks; the question is
whether it's a relevant performance bottleneck that customers care about.
